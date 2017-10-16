PImage backgroundImg;
// Initializing global variables to keep track of time
int dayCount;


void setup(){
  size(1440, 800);
  smooth();
  //Set frameRate to 60 frames per second
  frameRate(60);
  //Set monthCount at 0
  dayCount = 0;
  
  // load background image into variable from memory
  backgroundImg = loadImage("img/SampleBackground.jpg");

}
void draw(){
  // draw background image
  background(backgroundImg);
  // every frame (at 60 fps) a day passes, 
  dayCount = dayCount + 1;
  println("A month has passed! This is day", dayCount);
  println("And the framerate is", frameRate);

  
}