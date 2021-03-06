// An experimental demo of embedding moving, current state into a class

//shuttles
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


//each shuttle should be passed the 4 image states (normal, boost, crashed, decommissioned
public class Shuttle {
  
  PImage Color;
  PImage ColorBoost;
  PImage Crashed;
  PImage Decommissioned;
  PImage CurrentState;
  
  Shuttle (PImage shuttleColor, PImage shuttleColorBoost, PImage crashed, PImage outOfService){
    Color = shuttleColor;
    ColorBoost = shuttleColorBoost;
    Crashed = crashed;
    Decommissioned = outOfService;
    CurrentState = Color;
    
  }
  
  float[] place = {100,100};
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
   ellipse(place[0],place[1], 10, 20);
   text("Colombia", place[0],place[1] + 115/2);
   image(getShuttleState(), place[0], place[1], 200, 115);
  }
  
  color colorN(int state){
    return stateColor[state];
  }

}


int dayCount = 0;
int missionCount = 0;
String missionCountStr;
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
  round = new Shuttle(blue, blueBoost, crash, decommissioned);
  
  
  textAlign(CENTER);
}

void draw(){
  background(100,100,100); 
  
  dayCount++;
  
  textSize(20);
  text(dayCount + " days from 04/11/81", width/2, 30);
  
  if(dayCount % 10 == 5){
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
        text("This day is the " + missionCountStr + " launch mission!!", width/2, 60);
  }
  //have even to trigger state change
  if(mousePressed){
    state = 1;
    round.move();
  }else if(keyPressed){
   state = 2; 
   println("brocken");
  }else{
    if(state != 2){
     state = 0;
    }
  }
  
  //update the current state information to display
  textSize(10);
  fill(round.colorN(state));
  round.appereance();
}