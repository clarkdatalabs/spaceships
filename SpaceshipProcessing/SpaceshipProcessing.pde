PImage backgroundImg;
// Initializing global variables to keep track of time
int startTime;
int lastDrawTime;
int dayCount;
// Sets as constant the number of milliseconds corresponding to a historical day passing 
final int DAYLENGTH = 30;


void setup(){
  size(1440, 800);
  smooth();
  
  //Set startTime and lastDrawTime to current system time, in milliseconds
  startTime = millis();
  lastDrawTime = millis();
  //Set dayCount at 0
  dayCount = 0;
  

}
void draw(){
  // set background image
  backgroundImg = loadImage("img/SampleBackground.jpg");
  background(backgroundImg);
  //import csv file into processing
  //import();
  
  // Loop that determines current day -- will place into its own module shortly!! zws
  if ((millis() - lastDrawTime) > DAYLENGTH){
    dayCount = dayCount + 1;
    println("A day has passed! This is day", dayCount);
    lastDrawTime = millis();
  }
  
}