import peasy.*;
Cube c;
HillClimberSolver h;
int w;
int highest;
PeasyCam cam;
HillClimberSolverSmart g;

void setup() {
  c=new Cube(15,15,15);

  //noLoop();
  size(1000, 1000, P3D); 
  //fullScreen(P3D);
  cam = new PeasyCam(this, 150);
}

void keyPressed() {
  if (key=='h') {
    if (h!=null) {
      h=null;
    } else {
      h=new HillClimberSolver(c);
      h.getGoing();
    }
  } else if (key=='g') {
    if (g!=null) {
      g=null;
    } else {
      g=new HillClimberSolverSmart(c);
      g.getGoing();
    }
  } else {
    c.changeMode(key);
  }
}

void draw() {
  background(10);
  //println(frameRate);
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
  if (h!=null) {
    h.getGoing();
  }
  if (g!=null) {
    g.getGoing();
  }
  c.show();
}
