PImage backgroundImg;
// Initializing global variables to keep track of time
int dayCount;
// Create a HashMap of Shuttle objects, each of which will contain a collection of Missions and other information
HashMap<String, Shuttle> allShuttles = new HashMap<String,Shuttle>();
String[] SHUTTLENAMES = {"Columbia", "Challenger", "Discovery", "Atlantis", "Endeavour"};


void setup(){
  size(1440, 800);
  smooth();
  //Set frameRate to 60 frames per second
  frameRate(60);
  //Set monthCount at 0
  dayCount = 0;  
  // load background image into variable from memory
  backgroundImg = loadImage("img/SampleBackground.jpg");
  // iterate through SHUTTLENAMES to to populate allShuttles HashMap with Shuttle objects
  for (String s: SHUTTLENAMES) {
    allShuttles.put(s, new Shuttle(s));
  }

}
void draw(){
  // draw background image
  background(backgroundImg);
  // every other frame (30 frames/second at 60 fps framerate) a day passes,
  if (frameCount % 2 == 1)
  {
    dayCount = dayCount + 1;
    println("A month has passed! This is day", dayCount);
  }
  println("And the framerate is", frameRate);

  
}