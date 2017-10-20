public class Shuttle {
  // properties
  //focus more on drawing
  //add move function [distanceTraveled]
  //import svgs
  //have attributes such as size, position
  //add different states - normal, boost [swap image during animation], broken [doesItCrash], decommissioned [gray it out]
  private String name;
  private int didShuttleCrash;
  private Boolean crashDay;
  private String crashHeadlineText;
  private String crashHeadlineImportance;
  
  //holds current position of shuttle
  private int currentX;
  private int currentY; 
  
  //holds future position of shuttle after new mission object comes in
  private int futureX;
  private int futureY; 
  
  public Shuttle (String name_) {
    name = name_;
  }
  public void addNewMission (Mission newMission){
    //missionHash.put(newMission.getMissionName(), newMission);
    // look for crash and route data appropriately if crashed
  }
}

// Here we need to create a function to load information from CSV files and create an array
// (Or if we want to fancy another class) for each shuttle consisting of each mission flown
// Then, later on in the draw side of things, we can check 