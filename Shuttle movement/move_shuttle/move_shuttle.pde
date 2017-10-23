

PImage img;
PShape shuttle;
int gray = 102;
int posX = 10;
int posY = 10;

red = loadImage("shuttle-red_boost.png");
blue = loadImage("shuttle-blue_boost.png");

void setup() {
  size(940, 960);
  smooth();

}

void draw() {
  //swap red shuttle for blue shuttle (change of state)
  if (posX > 150) {
    img = blue;
  }
  else {
    img = red;
  }
  
  image(img, 0, 0);
  background(gray);
  img.resize(100,100);
  move();

  
  image(img, posX, posY);
  //shape(shuttle, 110, 300); //SVG does not work properly

}

void mousePressed() {
  posX += 2;
}

void move(){
  posX += 1;
}