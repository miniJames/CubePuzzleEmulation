import peasy.*;
Cube c;

int w;
int highest;
PeasyCam cam;


void setup() {
  c=new Cube(3, 3, 3);

  //noLoop();
  //size(1000, 1000, P3D); 
  fullScreen(P3D);
  cam = new PeasyCam(this, 150);
}

void keyPressed() {
  c.changeMode(key);
}

void draw() {
  background(10);
  //println(c.isSolved());
  cam.beginHUD();
  fill(255);
  textSize(10);  
  text("HealthO " + c.getOrientationHealth(), 100, 145);
  text("HealthP " + c.getPositionHealth(), 100, 115);
  if (c.isSolved()) {
    text("SOLVED", 100, 100);
  }
  cam.endHUD();
  c.show();
}
