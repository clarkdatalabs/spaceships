// An experimental demo of embedding moving, current state into a class

class N{
  float[] place = {100,100};
  // In our case, maybe here we have the list of image files
  color[] stateColor = {#4ECCEA,#EA4E8F, #C1B7BC};
  
  void move(){
    place[0]++;
    place[1]++;
  }
  
  void appereance(){
   ellipse(place[0],place[1], 10, 20);
  }
  
  color colorN(int state){
    return stateColor[state];
  }
}




int state = 0;
N round = new N();

void setup(){
 size(1000,500);
 smooth();
}

void draw(){
  background(100,100,100); 
  
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
  fill(round.colorN(state));
  round.appereance();
}