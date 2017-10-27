PImage backgroundImg;
PImage nytlogo;
PFont f;
// Initializing global variables to keep track of time
int dayCount;
int missionCount;
String missionCountStr;
int framePaused;
int framcount_startPause;

//Initializaing table viable to store CSV file
Table missionTableData;
// Create a HashMap of Shuttle objects, each of which will contain a collection of Missions and other information
HashMap<String, Shuttle> allShuttles = new HashMap<String,Shuttle>();
String[] SHUTTLENAMES = {"Columbia", "Challenger", "Discovery", "Atlantis", "Endeavour"};
// Create a HashMap of Missions in relation with the dayCountInt of startDate
HashMap<Integer, Mission> allMissions = new HashMap<Integer, Mission>();

//CurrentSituation
  //missionMode of 0 is no mission, 1 is missioning 
int missionMode;
int numOfShuttle;

//what is needed in mission mode
Mission currentMission;
Shuttle currentShuttle;
float missionDist;
float missionTime;
float missionSpeed;
float distCoef;//need a initiatial num in setup(), the unit is px/mile
float timeCoef;//unit is frameCount/hour


void setup(){
  size(1440, 900);
  smooth();
  pixelDensity(2);
  f = createFont("Georgia", 16); //NYTimes font
  // Load background image into variable from memory
  backgroundImg = loadImage("img/SampleBackground2.png");
  nytlogo = loadImage("img/nyt-logo.png");
  
  // Set frameRate to 60 frames per second
  frameRate(240);
  // Set monthCount at 0
  dayCount = 0;  
  missionMode = 0;
  missionCount = 0;
  framePaused = 0;
  numOfShuttle = 0;
  distCoef = 9.6;  //4.8 px/millionMile
  timeCoef = 1;    //a 60-hour mission takes <timeCoef> second, 120-hour mission takes 2*<timeCoef> seconds
  // Iterate through SHUTTLENAMES to to populate allShuttles HashMap with Shuttle objects
  for (String s: SHUTTLENAMES) {
    allShuttles.put(s, new Shuttle(s));
  }
   
  //Load CSV file. 
  missionTableData = loadTable("../Working_Shuttle_Stats_Data_with_Articles.csv", "header");

  // set the data from CSV to Missions
  for(TableRow row: missionTableData.rows()){
   String missionName = row.getString("Mission");
   String shuttleUsed = row.getString("Shuttle");
   String startDayString = row.getString("Mission Date");
   int startYear = row.getInt("Year");
   int distanceTraveled = row.getInt("Miles Flown #");
   int flightTime = row.getInt("Duration Hours");
   int doesItCrash = row.getInt("Crash?");
   int isItFinal = row.getInt("Last Launch?");
   String articleHeader = row.getString("Article Header");
   String articleDate = row.getString("Article Date");
   String articleDateLong = row.getString("Article Date Long");
   Mission mission = new Mission(missionName, shuttleUsed, startDayString, startYear, distanceTraveled, flightTime, doesItCrash, isItFinal, articleHeader, articleDateLong);
   allMissions.put(mission.getStartDay(), mission);
   /*println(missionName, " ", mission.getStartDay());*/
  }
  
  textAlign(CENTER);
}


void draw(){
  // Draw background image
  background(backgroundImg);
  
  //When there was no mission
  if(missionMode == 0){
    // frame/day = 1/1
    if ((frameCount - framePaused) % 1 == 0){
      dayCount = dayCount + 1;
      textSize(15);
      text(dayCount + " days from 04/11/81", width/2, 30);
      currentMission = allMissions.get(dayCount);
      
      // If happen to be a mission this day, then switch mode and get the shuttle accordingly. Otherwise, dayCount goes on
      if (currentMission != null) {        
        missionMode = 1;
        framcount_startPause = frameCount;
        
        //show which mission this is         
        missionCount ++;
        if(missionCount % 10 == 1 && missionCount % 100 != 11){
          missionCountStr = Integer.toString(missionCount) + "st";
        }else if(missionCount % 10 == 2 && missionCount % 100 != 12){
          missionCountStr = Integer.toString(missionCount) + "nd";
        }else if(missionCount % 10 == 3 && missionCount % 100 != 13){
          missionCountStr = Integer.toString(missionCount) + "rd";
        }else{
          missionCountStr = Integer.toString(missionCount) + "th";
        }
        text( currentMission.startDayString + " is the " + missionCountStr + " launch mission: " + currentMission.name, width/2, 60);
        
        //get shuttle accordingly
        currentShuttle = allShuttles.get(currentMission.shuttleUsed);
        //if this shuttle hasn't been used before, then tell it has been used so it will show up
        numOfShuttle = currentShuttle.start(numOfShuttle);
        
        //set its state to "boosting", so that it will show accordingly
        currentShuttle.setState(1);
        
        //set goal dist,time,velocity in this mission
        missionDist = currentMission.distanceTraveled * distCoef; 
        missionTime = currentMission.flightTime * timeCoef; //get how many frameCount it takes
        if(missionTime != 0){
          missionSpeed = missionDist/missionTime; //get how many pxs it moves per frameCount
        }//When missionTime = 0, it is the crashed situation
        else{
          missionTime = 120; //for silence tribute
          missionSpeed = 0;
        }
      }
    }    
  }
  
  //When is in a Mission, missionMode == 1;
  else{
    //know the date and mission name of now
    textSize(15);
    text(dayCount + " days from 04/11/81", width/2, 30);
    text(currentMission.startDayString + " is the " + missionCountStr + " launch mission: " + currentMission.name, width/2, 60);
   
   
    //Create white rect for newspaper area
    fill(240,240,240,230);     
    noStroke();
    rect(50, 600, 1340, 400);
    image(nytlogo, width/2 - 189, 640);
   
   
    //Print headline at the bottom of the screen
    
    fill(0);
    textFont(f);
    textSize(22);
    text(currentMission.articleHeadline, width/2, 750);
    textSize(18);
    text(currentMission.articleDateLong, width/2, 780);
    
    currentShuttle.move(missionSpeed);
    missionTime --;
    //When no time left, mode back to no mission  
    if(missionTime <= 0){
      missionMode = 0;
      framePaused = frameCount - framcount_startPause;
      
      //setState according to retired_or_not and crashed_or_not
      if(currentMission.doesItCrash == 0){
        if(currentMission.isItFinal == 0){
          //not crash, not final yet, so it goes back to normal for a while
          currentShuttle.setState(0);
        }//not crashed but final, so it's decommissioned
          else{
          currentShuttle.setState(3);
        }
      }//crashed
        else{
        currentShuttle.setState(2);
      }
    }
  }
    
    
    
  // Draw every already-launched shuttle
  fill(255,255,255);
  textSize(10);
  for (String name: SHUTTLENAMES){
    Shuttle shuttle_to_draw = allShuttles.get(name);
    //has its shape displayed (x,y,w,h needed to be replaced)
    shuttle_to_draw.appereance();
    }
  }
  
  
  
  

  