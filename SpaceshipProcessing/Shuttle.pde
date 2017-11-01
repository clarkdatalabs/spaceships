



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
  
  void move(float speed){
    cumulativeDist += speed;
  }
  
  void appereance(){
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
        nameShown = name + " (crashed)";
      }
      text(nameShown, place[0]+ 30 + cumulativeDist,place[1] + 35);
      image(state[stateNum], place[0] + cumulativeDist, place[1], 50, 25);
      // Displays cumulativeRawDistance to 1/10th place along Y axis
      text(String.format("%.01f", cumulativeRawDistance) + "m miles", place[0] - 35, place[1] + 18);
      // Draws bar graph line from Y axis to immediately behind the Shuttle
      strokeWeight(15);
      stroke(#767373,180);
      
      line(place[0]+1, place[1] + 13, place[0] + cumulativeDist + 3, place[1] + 13);
    }
  }
}