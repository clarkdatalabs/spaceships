PImage backgroundImg;


void setup(){
  size(1440, 800);
  smooth();
  

}
void draw(){
  //set background image
  backgroundImg = loadImage("img/SampleBackground.jpg");
  background(backgroundImg);
  
  //import csv file into processing
  import();
}