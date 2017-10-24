PImage backgroundImg;
// Initializing global variables to keep track of time

int dayCount;
int framePaused;
int framcount_startPause;

//Initializaing table viable to store CSV file
Table missionTableData;
// Create a HashMap of Shuttle objects, each of which will contain a collection of Missions and other information
HashMap<String, Shuttle> allShuttles = new HashMap<String,Shuttle>();
String[] SHUTTLENAMES = {"Columbia", "Challenger", "Discovery", "Atlantis", "Endeavour"};
// Create a HashMap of Missions in relation with the dayCountInt of startDate
HashMap<Integer, Mission> allMissions = new HashMap<Integer, Mission>();

//missionMode of 0 is no mission, 1 is missioning 
int missionMode = 0;
PShape shuttleShape;

void setup(){
  size(1440, 800);
  smooth();
  // Load background image into variable from memory
  backgroundImg = loadImage("img/SampleBackground.jpg");
  
  // Set frameRate to 60 frames per second
  frameRate(60);
  // Set monthCount at 0
  dayCount = 0;  
  framePaused = 0;
  // Iterate through SHUTTLENAMES to to populate allShuttles HashMap with Shuttle objects
  for (String s: SHUTTLENAMES) {
    allShuttles.put(s, new Shuttle(s));
  }
   
  //Load CSV file. 
  missionTableData = loadTable("../spaceshipDummyData.csv", "header");

  // set the data from CSV to Missions
  for(TableRow row: missionTableData.rows()){
   String missionName = row.getString("Mission");
   String shuttleUsed = row.getString("Shuttle");
   String startDayString = row.getString("Mission Date");
   int startYear = row.getInt("Year");
   int distanceTraveled = row.getInt("Miles Flown #");
   int flightTime = row.getInt("Duration Hours");
   int doesItCrash = row.getInt("Crash or Not");
   int isItFinal = row.getInt("Final or Not");
   Mission mission = new Mission(missionName, shuttleUsed, startDayString, startYear, distanceTraveled, flightTime, doesItCrash, isItFinal);
   allMissions.put(mission.getStartDay(), mission);
   println(missionName, " ", mission.getStartDay());
  }
}


void draw(){
  // Draw background image
  background(backgroundImg);
  
  //When there was no mission
  if(missionMode == 0){
    // Every other frame (30 frames/second at 60 fps framerate) a day passes, so: frame/day = 2/1
    if ((frameCount - framePaused) % 2 == 1){
      dayCount = dayCount + 1;
      /*println("this is day", dayCount);
      println("And the framerate is", frameRate);*/
      Mission currentMission = allMissions.get(dayCount);
      
      // If happen to be a mission this day, then switch mode and get the shuttle accordingly
      if (currentMission != null) {        
        missionMode = 1;
        framcount_startPause = frameCount;
        /*println("Day ", dayCount, " is a launch mission!!");*/
        //get shuttle accordingly
        Shuttle currentShuttle = allShuttles.get(currentMission.shuttleUsed);
        //if this shuttle hasn'et be used before, then tell it has been used so it will show up
        currentShuttle.start();
        //set its state to "boosting", so that it will show accordingly
        currentShuttle.setState(1);
      }
    }
    
  }
  
  //When is in a Mission, missionMode == 1;
  else{
    /*If happen to be the end of the mission   
    if(...........){
      missionMode = 0;
      framePaused = frameCount - framcount_startPause;
      
      //setState according to retired_or_not and crashed_or_not
      if(currentMission.doesItCrash == 0){
        if(currentMission.isItFinal == 0){
          //not crash, not final yet, so it goes back to normal for a while
          currentShuttle.setState(0);
        }else{
          currentShuttle.setState(3);
        }
      }else{
        currentShuttle.setState(2);
      }
    }
    */
  }
    
    
    
    // Draw every already-launched shuttle
    for (String name: SHUTTLENAMES){
      Shuttle shuttle_to_draw = allShuttles.get(name);
      if(shuttle_to_draw.hasItStarted == 1){
        //has its shape displayed (x,y,w,h needed to be replaced)
        shape(shuttle_to_draw.getShape(),10 ,15 ,30, 40);
      }
    }
  }
  
  
  
  

  