



//each shuttle should be passed the 4 image states (normal, boost, crashed, decommissioned
public class Shuttle {
  private String name;
  private String nameShown;
  private PImage state_normal = loadImage("Shuttle_PNGs/shuttle-white.png");
  private PImage state_boost = loadImage("Shuttle_PNGs/shuttle-white_boost.png");;
  private PImage state_crashed = loadImage("Shuttle_PNGs/shuttle-gray_crashed.png");
  private PImage state_decommissioned = loadImage("Shuttle_PNGs/shuttle-gray_out_of_service.png");
  private PImage[] state = {state_normal, state_boost, state_crashed, state_decommissioned};
  private int stateNum = 0;
  private float cumulativeDistDisplay;
  private float thickness;
  private String unitShown;
  
  //x should be consistant with earth, y should be where the first shuttle start increase by a step 
  float[] place = {180,300};//need initiate num
  float distBetweenShuttle = 65;//need initiate num
  private float cumulativeDist = 0; //for animation of shuttle purposes
  
  private float cumulativeRawDistance = 0; //for display of total miles traveled
  
  
  //constructor
  Shuttle (String _name){
    name = _name;    
  }  
  
  //0 is hasn't, 1 is has
  private int hasItStarted = 0;  
  int start(int numOfShuttle){
   if(hasItStarted == 0){
    hasItStarted = 1; 
    place[1] += numOfShuttle * distBetweenShuttle;
    return numOfShuttle + 1;
   }else{
     return numOfShuttle;
   }
  }
  
  void addToRawDistance(float miles){
    cumulativeRawDistance += miles;
  }
  
  
  //set the current state for shuttles to appear accordingly
  void setState(int _stateNum){
    stateNum = _stateNum;
  }
  
  int getState(){
   return stateNum; 
  }
  
  void move(float speed){
    cumulativeDist += speed;
  }
  
  void appereance(){
    fill(255);
    if (hasItStarted == 1){
      if(stateNum == 0){
       nameShown = name; 
      }
      else if(stateNum == 1){
        nameShown = name + " (on a mission)";
      }
      else if(stateNum == 3){
        nameShown = name + " (retired)";
      }      
      else if(stateNum == 2){
        fill(125);
        nameShown = name + " (crashed)";
      }      
      
      text(nameShown, place[0]+ 30 + cumulativeDist,place[1] + 35);
      image(state[stateNum], place[0] + cumulativeDist, place[1], 50, 25);
      
      // Displays cumulativeRawDistance to 1/10th place along Y axis
      cumulativeDistDisplay = cumulativeDist/distCoef;
      unitShown = "m miles";     
      text(String.format("%.01f", cumulativeDistDisplay) + unitShown, place[0] - 35, place[1] + 18);
      
      // Draws bar graph line from Y axis to immediately behind the Shuttle
      //strokeWeight(15);
      //stroke(#767373,180);     
      //line(place[0]+1, place[1] + 13, place[0] + cumulativeDist + 3, place[1] + 13);
      fill(#767373,180);
      thickness = 14;
      rect(place[0] + 1, place[1] + 13 - thickness/2, cumulativeDist + 2, thickness); 
    }
  }
}