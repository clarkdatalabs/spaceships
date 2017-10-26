

//x should be consistant with earth, y should be where the first shuttle start increase by a step 
float[] place = {100,100};//need initiate num
float distBetweenShuttle = 0;//need initiate num


//each shuttle should be passed the 4 image states (normal, boost, crashed, decommissioned
public class Shuttle {
  private String name;
  private PImage state_normal = loadImage("Shuttle_PNGs/shuttle-white.png");
  private PImage state_boost = loadImage("Shuttle_PNGs/shuttle-white_boost.png");;
  private PImage state_crashed = loadImage("Shuttle_PNGs/shuttle-gray_crashed.png");
  private PImage state_decommissioned = loadImage("Shuttle_PNGs/shuttle-gray_out_of_service.png");
  private PImage[] state = {state_normal, state_boost, state_crashed, state_decommissioned};
  private int stateNum = 0;
  
  private float cumulativeDist = 0;
  
  
  //constructor
  Shuttle (String _name){
    name = _name;    
  }  
  
  //0 is hasn't, 1 is has
  private int hasItStarted = 0;  
  void start(int numOfStart){
   if(hasItStarted == 0){
    hasItStarted = 1; 
    place[1] += numOfStart * distBetweenShuttle;
   }
  }
  
  void initiatePosition(){
  }

  void setState(int _stateNum){
    stateNum = _stateNum;
  }
  
  // In our case, maybe here we have the list of image files
  color[] stateColor = {#4ECCEA,#EA4E8F, #C1B7BC};
  

  
  void appereance(){
    if (hasItStarted == 1){
      text(name, place[0],place[1]);
      image(state[stateNum], place[0] + cumulativeDist, place[1], 200, 115);
    }
  }
  
  color colorN(int state){
    return stateColor[state];
  }

}