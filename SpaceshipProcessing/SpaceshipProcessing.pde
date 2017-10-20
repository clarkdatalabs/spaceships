PImage backgroundImg;
// Initializing global variables to keep track of time

int dayCount;
//Initializaing table viable to store CSV file
Table missionTableData;
// Create a HashMap of Shuttle objects, each of which will contain a collection of Missions and other information
HashMap<String, Shuttle> allShuttles = new HashMap<String,Shuttle>();
String[] SHUTTLENAMES = {"Columbia", "Challenger", "Discovery", "Atlantis", "Endeavour"};
// Create a HashMap of Missions in relation with the dayCountInt of startDate
HashMap<Integer, Mission> allMissions = new HashMap<Integer, Mission>();

void setup(){
  size(1440, 800);
  smooth();
  // Load background image into variable from memory
  backgroundImg = loadImage("img/SampleBackground.jpg");
  
  // Set frameRate to 60 frames per second
  frameRate(60);
  // Set monthCount at 0
  dayCount = 0;  
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
   int distanceTraveled = row.getInt("Miles Flown #");
   int flightTime = row.getInt("Duration Hours");
   int doesItCrash = row.getInt("Crash or Not");
   Mission mission = new Mission(missionName, shuttleUsed, startDayString, distanceTraveled, flightTime, doesItCrash);
   allMissions.put(mission.getStartDay(), mission);
   println(missionName, " ", mission.getStartDay());
   
  }
}
void draw(){
  // Draw background image
  background(backgroundImg);
  // Every other frame (30 frames/second at 60 fps framerate) a day passes, so: frame/day = 2/1
  if (frameCount % 2 == 1)
  {
    dayCount = dayCount + 1;
    //println("his is day", dayCount);
  }
  //println("And the framerate is", frameRate);
  Mission currentMissionIfToday = allMissions.get(dayCount);
  if (currentMissionIfToday != null) {
    println("Day ", dayCount, " is a launch mission!!");
  }
  
  
  

  
}