// An experimental demo of embedding moving, current state into a class

//shuttles
String name;
PImage blue;
PImage blueBoost;
PImage red;
PImage redBoost;
PImage yellow;
PImage yellowBoost;
PImage green;
PImage greenBoost;
PImage purple;
PImage purpleBoost;
PImage white;
PImage whiteBoost;
PImage crash;
PImage decommissioned;

//x should be consistant with earth, y should increase by a step 
float[] place = {100,100};


//each shuttle should be passed the 4 image states (normal, boost, crashed, decommissioned
public class Shuttle {
  
  PImage Color;
  PImage ColorBoost;
  PImage Crashed;
  PImage Decommissioned;
  PImage CurrentState;
  
  //0 is hasn't, 1 is has
  private int hasItStarted = 0;
  
  Shuttle (String _name, PImage shuttleColor, PImage shuttleColorBoost, PImage crashed, PImage outOfService){
    name = _name;
    Color = shuttleColor;
    ColorBoost = shuttleColorBoost;
    Crashed = crashed;
    Decommissioned = outOfService;
    CurrentState = Color;
    
  }
  
  
  // In our case, maybe here we have the list of image files
  color[] stateColor = {#4ECCEA,#EA4E8F, #C1B7BC};
  

  void move(){
    place[0]++;
    place[1]++;

  }
  
  
  void setShuttleState(PImage shuttle){
    this.CurrentState = shuttle;
  }
  
  PImage getShuttleState(){
    return CurrentState;
  }

  
  void appereance(){
   text(name, place[0],place[1]);
   image(getShuttleState(), place[0], place[1], 200, 115);
  }
  
  color colorN(int state){
    return stateColor[state];
  }

}




int state;
Shuttle round;

void setup(){
 size(1000,500);
 smooth();
 
  blue = loadImage("../Shuttle_PNGs/shuttle-blue.png");
  blueBoost = loadImage("../Shuttle_PNGs/shuttle-blue_boost.png");
  red = loadImage("../Shuttle_PNGs/shuttle-red.png");
  redBoost = loadImage("../Shuttle_PNGs/shuttle-red_boost.png");
  yellow = loadImage("../Shuttle_PNGs/shuttle-yellow.png");
  yellowBoost = loadImage("../Shuttle_PNGs/shuttle-yellow_boost.png");
  green = loadImage("../Shuttle_PNGs/shuttle-green.png");
  greenBoost = loadImage("../Shuttle_PNGs/shuttle-green_boost.png");
  purple = loadImage("../Shuttle_PNGs/shuttle-purple.png");
  purpleBoost = loadImage("../Shuttle_PNGs/shuttle-purple_boost.png");
  white = loadImage("../Shuttle_PNGs/shuttle-white.png");
  whiteBoost = loadImage("../Shuttle_PNGs/shuttle-white_boost.png");
  crash = loadImage("../Shuttle_PNGs/shuttle-gray_crashed.png");
  decommissioned = loadImage("../Shuttle_PNGs/shuttle-gray_out_of_service.png");
  
  state = 0;
  
}