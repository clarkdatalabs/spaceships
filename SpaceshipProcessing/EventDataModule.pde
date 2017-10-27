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
  private int startYear;
  private int distanceTraveled;
  private int flightTime;
  private int doesItCrash;
  private int isItFinal;
  private int startDayInt;
  private String articleHeadline;
  private String articleDateLong;
  
  // constructor
  public Mission(String name_, String shuttleUsed_, String startDayString_, int startYear_, int distanceTraveled_, int flightTime_, int doesItCrash_, int isItFinal_, String articleHeadline_, String articleDateLong_) {
    name = name_;
    shuttleUsed = shuttleUsed_;
    startDayString = startDayString_;
    startYear = startYear_;
    distanceTraveled = distanceTraveled_;
    flightTime = flightTime_;
    doesItCrash = doesItCrash_;
    isItFinal = isItFinal_;
    articleHeadline = articleHeadline_;
    articleDateLong = articleDateLong_;
    
    // takes month/day/year formatted date (e.g. 07/14/1989) and calculates # of days since
    // start of shuttle flight program, which the Shuttle class stores in the dayInterval variable
    String [] dateParts = startDayString.split("/");
    String month = dateParts[0];
    String day = dateParts[1];
    startDayInt = DateFromShuttleProgramStart(startYear, Integer.valueOf(month), Integer.valueOf(day));
    
  }
  // function to calculate # of days since start of space program for year/month/day values
  
  public int DateFromShuttleProgramStart(int endYear_, int endMonth_, int endDay_){
  
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
  public String getMissionName(){
    return (name);
  }
  public Integer getStartDay(){
    return (startDayInt);
  }
  
 
}