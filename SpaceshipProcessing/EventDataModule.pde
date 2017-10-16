//This module should be able to read in Spaceship event data (launches, collisions, etc.)
//Then, depending on what dayCount is passed into these functions from the main draw() loop
//We should update shuttle information and headline/photo information

public class Shuttle {
  
  // properties
  private String name;
  // for simplicity when startDay and endDay are initialized, should be converted to
  // ints where 4/12/81 == day 
  private int startDay;
  private int endDay;
  private int distanceTraveled;
  private boolean doesItCrash;
  
  // constructor
  public Shuttle(String name_, int startDay_, int endDay_, int distanceTraveled_, boolean doesItCrash_) {
    name = name_;
    startDay = startDay_;
    endDay = endDay_;
    distanceTraveled = distanceTraveled_;
    doesItCrash = doesItCrash_;
  }
}