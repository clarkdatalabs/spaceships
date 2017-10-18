PImage backgroundImg;
// Initializing global variables to keep track of time
int dayCount;
//Initializaing table viable to store CSV file
Table shuttleInfo;
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
  shuttleInfo = loadTable("../spaceshipDummyData.csv", "header");
  /*
  Extract data from each cell by:
  shuttleInfo.getInt(row#, columnName) or shuttleInfo.getString(row#, columnName)
  row# starts at the first row under headers as 0.
  shuttleInfo.getInt(0,"Duration Hours") returns 54
  shuttleInfo.getString(0, "Shuttle") returns "Columbia"
  */

  // set the data to Missions
}
void draw(){
  // Draw background image
  background(backgroundImg);
  // Every other frame (30 frames/second at 60 fps framerate) a day passes, so: frame/day = 2/1
  if (frameCount % 2 == 1)
  {
    dayCount = dayCount + 1;
    println("A month has passed! This is day", dayCount);
  }
  println("And the framerate is", frameRate);

  
}