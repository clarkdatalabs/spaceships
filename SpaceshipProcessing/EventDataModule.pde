//This module should be able to read in Spaceship event data (launches, collisions, etc.)
//From the CSV file and then generate Mission objects that can be used for animation
//We can create arrays of Mission objects for each shuttle .

//Note: needed several lines about dates because calculating difference b/t two dates in Java
// is needlessly complicated :-p

import java.time.LocalDate;
import java.util.Date;

// Constants that establish the starting year, month, and day of the space shuttle program (and thus our program!)
// I set it to a day before the first launch for simplicity's sake :)
final int SHUTTLESTARTYEAR = 1981;
final int SHUTTLESTARTMONTH = 4;
final int SHUTTLESTARTDAY = 11;


// Mission class will store key information about each Mission
public class Mission {
  
  // properties
  private String name;
  private String shuttleUsed;
  // for simplicity when startDay and endDay are initialized, should be converted to
  // ints where 4/12/81 == day 
  private String startDayString;
  private String endDayString;
  private int distanceTraveled;
  private boolean doesItCrash;
  private int startDayInt;
  private int endDayInt;
  private int dayInterval;
  
  // constructor
  public Mission(String name_, String shuttleUsed_, String startDayString_, String endDayString_, int distanceTraveled_, boolean doesItCrash_) {
    name = name_;
    shuttleUsed = shuttleUsed_;
    startDayString = startDayString_;
    endDayString = endDayString_;
    distanceTraveled = distanceTraveled_;
    doesItCrash = doesItCrash_;
    
    // takes month/day/year formatted date (e.g. 07/14/1989) and calculates # of days since
    // start of shuttle flight program, which the Shuttle class stores in the dayInterval variable
    String [] dateParts = startDayString.split("/");
    String month = dateParts[0];
    String day = dateParts[1];
    String year = dateParts[2];
    startDayInt = dateFromShuttleProgramStart(Integer.valueOf(year), Integer.valueOf(month), Integer.valueOf(day));
    
    String [] datePartsEnd = endDayString.split("/");
    String monthEnd = datePartsEnd[0];
    String dayEnd = datePartsEnd[1];
    String yearEnd = datePartsEnd[2];
    endDayInt = dateFromShuttleProgramStart(Integer.valueOf(yearEnd), Integer.valueOf(monthEnd), Integer.valueOf(dayEnd));
    
    dayInterval = endDayInt - startDayInt;
    
  }
  // function to calculate # of days since start of space program for year/month/day values
  
  public int dateFromShuttleProgramStart(int endYear_, int endMonth_, int endDay_){
  
    int startYear = SHUTTLESTARTYEAR;
    int startMonth = SHUTTLESTARTMONTH;
    int startDay = SHUTTLESTARTDAY;
    
    int endYear = endYear_;
    int endMonth = endMonth_;
    int endDay = endDay_;
    
    Date startDate = new Date(startYear, startMonth, startDay);
    Date endDate = new Date(endYear, endMonth, endDay);
    int difInDays = (int) ((endDate.getTime() - startDate.getTime())/(1000*60*60*24));
    
    return (difInDays);
  }
}

// Here we need to create a function to load information from CSV files and create an array
// (Or if we want to fancy another class) for each shuttle consisting of each mission flown
// Then, later on in the draw side of things, we can check 