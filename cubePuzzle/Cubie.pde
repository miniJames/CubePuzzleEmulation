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

  Cubie() {
  }

  Cubie(int _x, int _y, int _z, float w) {
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
  }

  boolean isCorner() {
    switch (ID) {
    case 50 : 
      return true;
    case 38 : 
      return true;
    case 49 : 
      return true;
    case 37 : 
      return true;
    case 26 : 
      return true;
    case 14 : 
      return true;
    case 25 : 
      return true;
    case 13 :
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
    switch (ID) {
    case 290 : 
      return true;
    case 176 : 
      return true;
    case 164 : 
      return true;
    case 289 : 
      return true;
    case 82 : 
      return true;
    case 70 : 
      return true;
    case 81 :
      return true;
    case 69 : 
      return true;
    case 266 : 
      return true;
    case 152 : 
      return true;
    case 140 :
      return true;    
    case 265 :
      return true;
    }
    //println("not an edge");
    return false;
  }

  boolean isCenter() {
    switch (ID) {
    case 208 : 
      return true;
    case 416 : 
      return true;    
    case 196 : 
      return true;    
    case 392 : 
      return true;    
    case 321 : 
      return true;    
    case 322 : 
      return true;
    }
    return false;
  }
  void show() {

    stroke(0)  ;
    strokeWeight(8);      
    //back
    //blue
    pushMatrix(); 
    //if (rotating) {
    //  //println("========================");
    //  rotateX(offsetX);
    //  rotateY(offsetY);
    //  rotateZ(offsetZ);
    //  //angle+=.01;
    //}
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
    //println("ROTATEX " + dir);
    //rotate up, front, down, back
    //offsetX+=HALF_PI;
    if (!dir) {
      offsetX+=angle;
      color temp = cols[back];
      cols[back]=cols[up];
      cols[up]=cols[front];
      cols[front]=cols[down];
      cols[down] =temp;
    } else {

      offsetX-=angle;

      color temp = cols[back];
      cols[back]=cols[down];
      cols[down]=cols[front];
      cols[front]=cols[up];
      cols[up] =temp;
    }
    if (hitAngle(offsetX)) {
      rotating = false;
      //println("STOPROTATING");
    }
  }  
  void rotateYCubie(boolean dir) {
    //println("ROTATEY " + dir);

    //rotate left, front, right, back
    //top or bottom
    if (!dir) {
      offsetY+=angle;
      color temp = cols[left];
      cols[left]=cols[front];
      cols[front]=cols[right];
      cols[right]=cols[back];
      cols[back] =temp;
      //println("notME");
    } else {     // println("HERE "+ dir);
      color temp = cols[left];
      //counter-clockwise.
      //clockwise.
      offsetY-=angle;
      cols[left]=cols[back];
      cols[back]=cols[right];
      cols[right]=cols[front];
      cols[front] =temp;
    }
    if (hitAngle(offsetX)) {
      rotating = false;
    }
  }  
  void rotateZCubie(boolean dir) {
    //println("ROTATEZ " + dir);
    //rotate up, right, down, left
    if (!dir) {
      offsetZ+=angle;
      color temp = cols[up];
      cols[up]= cols[right];
      cols[right]=cols[down];
      cols[down]=cols[left];
      cols[left] =temp;
    } else {
      offsetZ-=angle;
      color temp = cols[up];
      cols[up]= cols[left];
      cols[left]=cols[down];
      cols[down]=cols[right];
      cols[right] =temp;
    }
    if (hitAngle(offsetZ)) {
      rotating = false;
    }
  }
  boolean hitAngle(float ang) {
    boolean rtrn = false;
    ang = abs(ang % TWO_PI);
    ang = round(10*ang)/10;
    //println(ang);
    if (ang ==round(10*HALF_PI)/10  ||
      ang ==round(10*PI)/10  ||
      ang ==round(10*(PI+HALF_PI))/10 ||
      ang ==round(10*(PI+HALF_PI))/10 
      ) {
      rtrn = true;
    }


    return rtrn;
  }
}
