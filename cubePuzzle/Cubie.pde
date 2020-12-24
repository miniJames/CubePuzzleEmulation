class Cubie {
  int x;
  int y;
  int z;
  float s ;
  boolean rotating ;
  float angle =9* TWO_PI/360; 
  int locationID;
  int  ID;
  String tag = "";
  color gn, bl, rd, wh, or, yl;
  color[] cols;
  float offsetX =0;
  float offsetY=0;
  float offsetZ =0;
  int target;
  String belongsTo;
  Cubie() {
  }

  Cubie(int _x, int _y, int _z, float w, String bt) {
    x=_x;
    y=_y;
    s=w;
    z=_z; 
    gn = color(0, 255, 0);
    bl = color(0, 0, 255);
    wh= color(255);
    yl = color(255, 255, 0);
    rd=color(255, 0, 0);
    or=color(255, 180, 25);
    cols = new color[6];
    cols[front] = gn;
    cols[back] = bl;
    cols[left]=or;
    cols[right]=rd;
    cols[up] = yl;
    cols[down]=wh;
    rotating = false;
    belongsTo=bt;
    tag="";
  }





  boolean isCorner() {

    switch (belongsTo.replaceAll("[0-9]", "")) {
    case "FUL" : 
      return true;
    case "FUR" : 
      return true;
    case "FDL" : 
      return true;
    case "FDR" : 
      return true;
    case "BUR" : //
      return true;
    case "BUL" : 
      return true;
    case "BDR" : //
      return true;
    case "BDL" :
      return true;
    }
    return false;
  }

  //boolean isEdge() {
  //  switch (ID) {
  //  case 34 : 
  //    return true;
  //  case 48 : 
  //    return true;
  //  case 36 : 
  //    return true;
  //  case 33 : 
  //    return true;
  //  case 18 : 
  //    return true;
  //  case 6 : 
  //    return true;
  //  case 17 :
  //    return true;
  //  case 5 : 
  //    return true;
  //  case 10 : 
  //    return true;
  //  case 24 : 
  //    return true;
  //  case 12 :
  //    return true;    
  //  case 9 :
  //    return true;
  //  }
  //  return false;
  //}
  boolean isEdge() {

    switch (belongsTo.replaceAll("[0-9]", "")) {
    case "BUM" : 
      return true;
    case "BEL" : 
      return true;
    case "BER" : 
      return true;
    case "BDM" : 
      return true;
    case "SUL" : 
      return true;
    case "SUR" : 
      return true;
    case "SDL" :
      return true;
    case "SDR" : 
      return true;
    case "FUM" : 
      return true;
    case "FEL" : 
      return true;
    case "FER" :
      return true;    
    case "FDM" :
      return true;
    }
    //println("not an edge");
    return false;
  }

  boolean isCenter() {
    switch (belongsTo) {
    case "BEM" : 
      return true;
    case "SDM" : 
      return true;    
    case "FEM": 
      return true;    
    case "SUM" : 
      return true;    
    case "SEL" : 
      return true;    
    case "SER" : 
      return true;
    }
    return false;
  }

  void show() {

    stroke(0)  ;
    strokeWeight(1);      
    //back
    //blue
    pushMatrix(); 
    if (rotating) {
      println("========================");
      rotateX(offsetX);
      rotateY(offsetY);
      rotateZ(offsetZ);
      angle+=.01;
    }
    translate(x, y, z);
    //if (ID==target) {
    //tag="O";
    //} else {
    //tag = "";
    //}
    textSize(3);
    fill(cols[front]);
    square(0, 0, s);
    fill(0);
    text(tag, 0, w-2, -1);
    fill(cols[left]);
    rotateY(-HALF_PI);
    square(0, 0, s);
    fill(0);
    text(tag, 0, w-2, 1);
    fill(cols[up]);
    rotateX(-HALF_PI);
    square(0, 0, s);
    fill(0);
    text(tag, 0, w-2, -1);
    translate(s, s, s);
    fill(cols[down]);
    rotateZ(-PI);
    square(0, 0, s);
    fill(0);
    text(tag, 0, w-2, 1);
    fill(cols[right]);
    rotateX(-HALF_PI);
    square(0, 0, s);
    fill(0);
    text(tag, 0, w-2, -1);    

    fill(cols[back]);
    rotateY(-HALF_PI);
    square(0, 0, s);
    fill(0);
    text(tag, 0, w-2, 1);


    popMatrix();
  }
  void rotateXCubie(boolean dir) {
    //LMR
    println("ROTATEX " + offsetX);
    if (!dir) {
      offsetX-=angle;
      color temp = cols[back];
      cols[back]=cols[up];
      cols[up]=cols[front];
      cols[front]=cols[down];
      cols[down] =temp;
    } else {
      offsetX+=angle;
    
      color temp = cols[back];
      cols[back]=cols[down];
      cols[down]=cols[front];
      cols[front]=cols[up];
      cols[up] =temp;
    }
    if (hitAngle(offsetX)) {
      //rotating = false;
      println("TEST");
    }
  }  
  void rotateYCubie(boolean dir) {
    println("ROTATEY " + dir);
    //UDE
    if (!dir) {      
      color temp = cols[left];
      offsetY-=angle;

      offsetY+=angle;
      cols[left]=cols[front];
      cols[front]=cols[right];
      cols[right]=cols[back];
      cols[back] =temp;

      //println("notME");
    } else {     // println("HERE "+ dir);
      color temp = cols[left];
      //counter-clockwise.
      //clockwise.
      cols[left]=cols[back];
      cols[back]=cols[right];
      cols[right]=cols[front];
      cols[front] =temp;
    }
    if (hitAngle(offsetX)) {
      //rotating = false;
    }
  }  
  void rotateZCubie(boolean dir) {
    //FSB
    println("ROTATEZ " + dir);
    //rotate up, right, down, left
    if (!dir) {      
      offsetZ+=angle;
      color temp = cols[up];
      cols[up]= cols[right];
      cols[right]=cols[down];
      cols[down]=cols[left];
      cols[left] =temp;
      offsetZ-=angle;
    } else {      
      color temp = cols[up];
      cols[up]= cols[left];
      cols[left]=cols[down];
      cols[down]=cols[right];
      cols[right] =temp;
    }
    if (hitAngle(offsetZ)) {
      //rotating = false;
    }
  }
  boolean hitAngle(float ang) {
    boolean rtrn = false;
    ang = abs(ang % TWO_PI);
    ang = (int)(ang);
    //println(ang);
    //if (ang ==round(10*HALF_PI)/10  ||
    //  ang ==round(10*PI)/10  ||
    //  ang ==round(10*(PI+HALF_PI))/10 ||
    //  ang ==round(10*(PI+HALF_PI))/10 
    //  ) {
    //  rtrn = true;
    //}
    if((int)ang==0){
      return true;  
    }

    return rtrn;
  }
}
