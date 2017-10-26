PImage backgroundImg;
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
  size(1440, 800);
  smooth();
  // Load background image into variable from memory
  backgroundImg = loadImage("img/SampleBackground.jpg");
  
  // Set frameRate to 60 frames per second
  frameRate(60);
  // Set monthCount at 0
  dayCount = 0;  
  missionMode = 0;
  missionCount = 0;
  framePaused = 0;
  numOfShuttle = 0;
  //distCoef = ?;
  timeCoef = 2;//which means a 60-hour mission takes 2 second, 120-hour mission takes 4 seconds
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
   Mission mission = new Mission(missionName, shuttleUsed, startDayString, startYear, distanceTraveled, flightTime, doesItCrash, isItFinal, articleHeader, articleDate);
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
    // Every other frame (30 frames/second at 60 fps framerate) a day passes, so: frame/day = 2/1
    if ((frameCount - framePaused) % 2 == 1){
      dayCount = dayCount + 1;
      textSize(20);
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
        currentShuttle.start(numOfShuttle);
        numOfShuttle ++;
        
        //set its state to "boosting", so that it will show accordingly
        currentShuttle.setState(1);
        
        //set goal dist,time,velocity in this mission
        missionDist = currentMission.distanceTraveled * distCoef; 
        missionTime = currentMission.flightTime * timeCoef; //get how many frameCount it takes
        missionSpeed = missionDist/missionTime; //get how many pxs it moves per frameCount
      }
    }    
  }
  
  //When is in a Mission, missionMode == 1;
  else{
    //know the date and mission name of now
    textSize(20);
    text(dayCount + " days from 04/11/81", width/2, 30);
    text(currentMission.startDayString + " is the " + missionCountStr + " launch mission: " + currentMission.name, width/2, 60);
    //Print headline at the bottom of the screen
    textSize(25);
    text(currentMission.articleHeadline, width/2, 700);
    currentShuttle.cumulativeDist += missionSpeed;
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
  textSize(10);
  for (String name: SHUTTLENAMES){
    Shuttle shuttle_to_draw = allShuttles.get(name);
    //has its shape displayed (x,y,w,h needed to be replaced)
    shuttle_to_draw.appereance();
    }
  }
  
  
  
  

  