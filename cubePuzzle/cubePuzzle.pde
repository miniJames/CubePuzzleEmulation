import peasy.*;
Cube c;
AlgorithmManager alg;
int w;
int highest;
PeasyCam cam;


void setup() {
  c=new Cube(3, 3, 3);
  alg=new AlgorithmManager();

  size(1000, 1000, P3D); 

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
  float h=0;// = (c.getHealth());
  if (!c.scrambleMode) {
    highest = 0;
  } else {
    if (c.getHealth()> highest) {
      highest=c.getHealth();
    }
  }


  text("Health " + c.getHealth(), 100, 115);
  text("Highest " + highest, 100, 130);
  if (c.isSolved()) {
    text("SOLVED", 100, 100);
  }
  int index=0;

  cam.endHUD();

  c.show();
}
