public class Shuttle {
  // properties
  //focus more on drawing
  //add move function [distanceTraveled]
  //DONE//import svgs
  //have attributes such as size, position
  //DONE//add different states - normal, boost [swap image during animation], broken [doesItCrash], decommissioned [gray it out]
  private String name;
  
  //0 is hasn't, 1 is has
  private int hasItStarted = 0;
  
  private Boolean crashDay;
  private String crashHeadlineText;
  private String crashHeadlineImportance;
  
  // shapes of current shuttle's state 0: normal; 1: boost; 2: crashed; 3: retired 
  private int state = 0;
  private PShape shape_0 = loadShape("../images/illustrations/shuttle-white.svg");
  private PShape shape_1 = loadShape("../images/illustrations/shuttle-white_boost.svg");
  private PShape shape_2 = loadShape("../images/illustrations/shuttle-gray_crashed.svg");
  private PShape shape_3 = loadShape("../images/illustrations/shuttle-gray_out_of_service.svg");
  private PShape[] shuttleShapes = {shape_0, shape_1, shape_2, shape_3};
  
  //holds current position of shuttle
  private int currentX;
  private int currentY; 
  
  //holds future position of shuttle after new mission object comes in
  private int futureX;
  private int futureY; 
  
  //Constructor
  public Shuttle (String name_) {
    name = name_;
  }
  
  //switch unused shuttle into used mode, which is from hide to unhide
  public void start(){
   if(hasItStarted == 0){
    hasItStarted = 1; 
   }
  }
  
  public void setState(int stateNum){
    state = stateNum;
  }
  
  public PShape getShape(){
    
    //return shuttleShape[stateNum];
    return shape_1;
  }
  
  public void addNewMission (Mission newMission){
    //missionHash.put(newMission.getMissionName(), newMission);
    // look for crash and route data appropriately if crashed
  }
}

// Here we need to create a function to load information from CSV files and create an array
// (Or if we want to fancy another class) for each shuttle consisting of each mission flown
// Then, later on in the draw side of things, we can check 