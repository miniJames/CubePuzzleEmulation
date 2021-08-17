int up=1;//0x100000;
int left=4;//0x10000;
int down=0;//0x1000;
int right = 2;//0x100;
int front = 3;//0x10;
int back =5;// 0x1;
int equator = 7;
int standing = 6;
int middle = 8;
int notMoving = 0;
int moving = 1;
float angle = 0.0;
String com="";
//
class Cube {
  AlgorithmManager alg;
  boolean rotating = false;
  boolean scrambleMode = false;
  int l, wd, h; 
  ArrayList<Cubie> cub;
  int cubeState = notMoving;
  Cube(int len, int wid, int hei) {
    l=len;
    wd=wid;
    h=hei;
    cub=new ArrayList<Cubie> ();
    w=20;
    alg=new AlgorithmManager();
    int cn=0;
    for (int k=0; k<l; k++) {
      for (int j=0; j<wd; j++) {
        for (int i=0; i<h; i++) {
          //if ((k==0 || k==l-1) || ((k>0 && k<l) && (j==0)||(i==0)|| (k==0)) || ((k>0 && k<l-1) && (j==wd-1)||(i==h-1)|| (k==l-1)) ) {  
          int si =(int)((i*w)-(.5*w)*l);
          int sj =(int)((j*w)-(.5*w)*l);
          int sk =(int)((k*w) -(.5*w)*l);
          //println("START I:" + si + " START J:" + sj + " START K:" + sk + " w:"+w);
          String bt = "";


          if (k==0) {
            bt = bt +"B";
          } else if (k==l-1) {
            bt+="F";
          } else {
            bt+="S";
            //if (k>1 || (k==l-1)) {
            bt+=k;
            //}
          }

          if (j==0) {
            bt+="U";
          } else if (j==wd-1) {
            bt+="D";
          } else {
            bt+="E";
            //if (j>1 || (j==wd-1)) {
            bt+=j;
            //}
          }


          if (i==0) {
            bt+="L";
          } else   if (i==h-1) {
            bt+="R";
          } else {
            bt+="M";       
            //if (i>1 || (i==wd-1)) {
            bt+=i;
            //}
          }
          //println(bt);
          Cubie c=new Cubie(si, sj, sk, w, bt);
          c.locationID = cn;
          //c.locationID = (cn);
          c.ID = cn;
          c.target = c.ID;
          c.tag = bt+ " " + c.locationID;
          //c.tag = ""+c.ID;
          cub.add(c);
          cn++;
          //} else {
          //  cub.add(new Cubie(0,0,0,0," ");  
          //}
        }
      }
    }
  }

  boolean rotateCube(String command) {
    //boolean rtrn = true;
    rotating=true;
    if (command=="X") {

      sendMoves("U'");
      sendMoves("D");
      sendMoves("E'");
      return true;
    } else if ( command=="x") {

      sendMoves("U''");
      sendMoves("D'");
      sendMoves("E''");
      return true;
    } else   if (command=="Y") {

      sendMoves("L'");
      sendMoves("R");
      sendMoves("M'");
      return true;
    } else if (command=="y") {

      sendMoves("L''");
      sendMoves("R'");
      sendMoves("M''");
      return true;
    } else if (command=="Z") {

      sendMoves("F'");
      sendMoves("B");
      sendMoves("S'");
      return true;
    } else if (command=="z") {

      sendMoves("F''");
      sendMoves("B'");
      sendMoves("S''");
      return true;
    }
    return false;
  }

  void changeMode(char k) {
    cubeState=moving;

    String command = "";
    if (k=='q') {
      command="l";
    } else if (k=='Q') {
      command="L";
    } else if (k=='w') {
      command="M1";
    } else if (k=='W') {
      command="m1";
    } else if (k=='e') {
      command = "M2";
    } else if (k=='E') {
      command = "m2";
    } else if (k=='r') {
      command = "r";
    } else if (k=='R') {
      command = "R";
    } else if (k=='a') {
      command = "f";
    } else if (k=='A') {
      command = "F";
    } else if (k=='s') {
      command="s2";
    } else if (k=='S') {
      command="S2";
    } else if (k=='d') {
      command="s1";
    } else if (k=='D') {
      command="S1";
    } else if (k=='f') {
      command="b";
    } else if (k=='F') {
      command="B";
    } else if (k=='z') {
      command="u";
    } else if (k=='Z') {
      command="U";
    } else if (k=='x') {
      command = "E1";
    } else if (k=='X') {
      command = "e1";
    } else if (k=='c') {
      command= "e2";
    } else if (k=='C') {
      command= "E2";
    } else if (k=='v') {
      command="d";
    } else if (k=='V') {
      command="D";
    }
    com=command;
    swapCubies(command);
    for (Cubie cubie : getFace(""+command)) {

      rotateCubie(command, cubie);
    }
    //println("JAMES " +k);
    //String s =  k + "";
    rotateCube(command);



    if (k=='q') {
      //scrambleMode = !scrambleMode;
    }
    if (k=='a') {
      //run algorithm.
      //sendMoves("RRLLUUDDFFBB");
      sendMoves("lrbfufbrblufFULBRBFUFBRL");
    } else if (k=='1') {
      sendMoves(alg.decode(alg.algorithms.get("sune")));
    } else if (k=='2') {

      sendMoves(alg.decode(alg.algorithms.get("sunel")));
    } else if (k=='3') {

      sendMoves(alg.decode(alg.algorithms.get("a-sune")));
    } else if (k=='4') {

      sendMoves(alg.decode(alg.algorithms.get("a-sunel")));
    } else if (k=='5') {

      sendMoves(alg.decode(alg.algorithms.get("sexy")));
    } else if (k=='6') {
      sendMoves(alg.decode(alg.algorithms.get("swapcorners")));
    } else if (k=='7') { 
      sendMoves(alg.decode(alg.algorithms.get("swapedges")));
    } else if (k=='8') { 
      sendMoves(alg.decode(alg.algorithms.get("insertcorner")));
    } else if (k=='9') { 
      sendMoves(alg.decode(alg.algorithms.get("inesrtedge")));
    }
  }
  void show() {
    //println("Cube state " + cubeState);
    if (cubeState==moving) {
      // animate until it has rotated to its resting place.

      //get the slice
      String face="F";
      Cubie[]  f = getFace(com);
      if (face=="F") {
      } else if (face=="B") {
      } else if (face=="L") {
      } else if (face=="R") {
      } else if (face=="U") {
      } else if (face=="D") {
      }

      
      angle+=0.01;
      if (angle >= HALF_PI) {
        cubeState=notMoving;
        angle=0;
      }

      //show all other slices.
      int counter =0;
      for (int k=0; k<l; k++) {
        for (int j=0; j<wd; j++) {
          for (int i=0; i<h; i++) {

            boolean found = false;
            if ((k==0 || k==l-1) || ((k>0 && k<l) && (j==0)||(i==0)|| (k==0)) || ((k>0 && k<l-1) && (j==wd-1)||(i==h-1)|| (k==l-1)) ) {

              for (Cubie c : f) {
                if (c==cub.get(counter)) {
                  found=true;
                }
              }
              visuallyRotateThisFace(f, com);
              if (!found)  
                cub.get(counter).show();
            }
            counter++;
          }
        }
      }
    } else {
      int counter =0;
      for (int k=0; k<l; k++) {
        for (int j=0; j<wd; j++) {
          for (int i=0; i<h; i++) {

            if ((k==0 || k==l-1) || ((k>0 && k<l) && (j==0)||(i==0)|| (k==0)) || ((k>0 && k<l-1) && (j==wd-1)||(i==h-1)|| (k==l-1)) ) {

              cub.get(counter).show();
            }
            counter++;
          }
        }
      }
    }
    //for (Cubie cu : cub) {
    //  //cub.get(i).show();

    //  cu.show();
    //}

    if (scrambleMode  ) {
      //for (int cc = 0; cc < 5000; cc++) {
      scramble(1);
    }
  }
  void scramble(int moves) {
    for (int cc = 0; cc < moves; cc++) {
      //String faces[] =new String [] {"U", "U'", "D", "D'", "L", "L'", "R", "R'", "F", "F'", "B", "B'", "X", "X'", "Y", "Y'", "Z", "Z'", "E", "E'", "S", "S'", "M", "M'"};
      char faces[] =new char [] {'U', 'u', 'D', 'd', 'L', 'l', 'R', 'r', 'F', 'f', 'B', 'b', 'X', 'x', 'Y', 'y', 'Z', 'z', 'E', 'e', 'S', 's', 'M', 'm'};
      int face =floor( random(0, faces.length));
      //println("FACE "+face +  " " + faces.length);
      //(faces[face]);
      char fc = (faces[face]);
      //("FC "+fc);
      if (!  rotateCube(""+fc)) {
        //println("DOODAR");
        Cubie faceID[] = getFace(""+fc);
        swapCubies(""+fc);

        for (Cubie f : faceID) {
          rotateCubie(""+fc, f);
        }
      }
      if (isSolved()) {
        c.scrambleMode=false;
      }
    }
  }
  void sendMoves(String moves) {

    for (char c : moves.toCharArray()) {
      swapCubies(""+c);
      for (Cubie cubie : getFace(""+c)) {

        rotateCubie(""+c, cubie);
      }
      rotateCube(""+c);
    }
  }
  Cubie[] getFace(String face) {
    ArrayList<Cubie> rtrn = new ArrayList<Cubie>();
    String fc = "" + face;
    fc= fc.toUpperCase();
    int counter =0, index=0;
    for (index=0; index<cub.size(); index++) {
      Cubie c = cub.get(index);
      if (c.belongsTo.contains(fc)) {
        rtrn.add(c);
      }
    } 
    Cubie[] rtrn1 = new Cubie[rtrn.size()];
    counter =0;
    for (Cubie cccc : rtrn) {
      //println("YES"+cccc.locationID);
      rtrn1[counter]=cccc;
      counter++;
    } 
    bubbleSort(rtrn1);
    return rtrn1;
  }

  void bubbleSort(Cubie arr[])
  {

    int n = arr.length;
    for (int i = 0; i < n-1; i++)
      for (int j = 0; j < n-i-1; j++)
        if (arr[j].locationID > arr[j+1].locationID)
        {
          // swap temp and arr[i]
          Cubie temp = arr[j];
          arr[j] = arr[j+1];
          arr[j+1] = temp;
        }
  }

  boolean isSolved() {
    boolean rtrn = false;
    //char faces[] =new char [] {'U', 'D', 'E'};
    //for (int count=0; count<faces.length; count++) {
    //  //char faces[] =new char [] {'u', 'd', 'l', 'r', 'f', 'b'};
    //  Cubie[] cubiesIndex = getFace(""+faces[count]);
    //  //printArray( getFace(faces[count]));
    //  Cubie comp;

    //  comp = (cubiesIndex[0]);
    //  for (int c =1; c<cubiesIndex.length; c++) {
    //    if (c>0) {
    //      //println(c);
    //      Cubie col2;
    //      //println(cub.size());
    //      //println("L"+cubiesIndex[c]);//);

    //      col2 = (cubiesIndex[c]);
    //      for (int i = 0; i<comp.cols.length; i++) {
    //        if (comp.cols[i] ==col2.cols[i]) {
    //        } else {
    //          return false;
    //        }
    //      }
    //    }
    //  }
    //}

    return rtrn;
  }
  int getPositionHealth() {
    int rtrn = 0;
    for (Cubie c : cub) {
      if (c.ID == c.target && !c.isCenter()) {
        rtrn++;
      }
    }

    return rtrn;
  }

  int getOrientationHealth() {
    int rtrn=0;
    //char faces[] =new char [] {'D', 'U', 'R', 'F', 'L', 'B'};
    //for (int count=0; count<faces.length; count++) {

    //  Cubie[] cubiesIndex = getFace(""+faces[count]);
    //  Cubie center;
    //  center = cubiesIndex[getCenters(cubiesIndex)[0]];
    //  //println(center.ID);

    //  for (int c =0; c<cubiesIndex.length; c++) {
    //    if (!cubiesIndex[c].isCenter()) {
    //      Cubie col2;          
    //      col2 = (cubiesIndex[c]);
    //      boolean match = true;
    //      for (int cc=0; cc<center.cols.length; cc++) {
    //        match = match & (center.cols[cc] ==col2.cols[cc]);
    //      }
    //      if (match) {
    //        rtrn++;
    //      }
    //    }
    //  }
    //}
    return rtrn;
  }
  void rotateCubie(String command, Cubie cubie) {
    ///println((int)char(face));
    //if (!cubie.isCenter()) {
    //println(":"+command+":");
    if (command.length()==0) return;
    boolean dir = false;
    if ((int)char(command.charAt(0)) < 90) {
      dir = true;
    }
    char check = command.charAt(0);
    if (check=='m' || check == 'M' || check == 'S' || check == 'S' || check == 'E' || check == 'e') {
      dir =!dir;
    }

    if ( command=="u" || command=="d"||command=="U" || command=="D" || command=="E1" || command == "e1"|| command=="E2" || command == "e2") { //up and down.
      rotateYCubie(cubie, dir);
    } else if ( command=="l" || command=="r" ||command=="L" || command=="R" || command == "M1" || command == "m1"|| command == "M2" || command == "m2") { //left and right
      rotateXCubie(cubie, dir);
    } else if ( command=="b" || command=="f" || command=="B" || command=="F" || command == "S1" || command == "s1"|| command == "S2" || command == "s2") { //up and down
      rotateZCubie(cubie, dir);
    }
  }

  Cubie getCubieID(int id) {
    for (Cubie c : cub) {
      if (c.ID == id) {
        return c;
      }
    }
    return null;
  }
  Cubie getCubie(int index) {
    return cub.get(index);
  }
  int[] getCorners(Cubie[] c) {
    int[] rtrn = new int[4];
    int index = 0;
    int counter = 0;
    for (Cubie cubie : c) {
      //println("CubieID:"+cubie.ID);
      if (cubie.isCorner()) {
        //println(cubie.locationID);
        rtrn[counter]=(index);//+ cubie.offset) % 4;

        counter +=1;
        if (counter==4) {
          return rtrn;
        }
      }
      index++;
    }

    return rtrn;
  }
  int[] getEdges(Cubie[] c) {
    int[] rtrn = new int[4];
    int counter = 0;
    int index = 0;
    for (Cubie cubie : c) {
      //println("CubieID:"+cubie.locationID);
      if (cubie.isEdge()) {
        //println("EDGE");
        rtrn[counter]=(index);//+ cubie.offset) % 4;
        counter +=1;
        if (counter==4) {
          return rtrn;
        }
      }      
      index++;
    }

    return rtrn;
  }
  int[] getCenters(Cubie[] c) {

    IntList rtrn = new IntList();// = new int[4];
    int index = 0;
    for (Cubie cubie : c) {
      //println("CubieID:"+cubie.locationID);
      if (cubie.isCenter()) {
        rtrn.append(index);//+ cubie.offset) % 4;
      }      
      index++;
    }

    return rtrn.values();
  }
  void swapCubies(String command) {
    //println("swap");
    if (command=="U" || command=="D"||command=="L" || command=="R" || command == "F" || command == "B") {
      Cubie cubies[] = getFace( command);
      applyRotation(cubies);
      applyRotation(cubies);
      applyRotation(cubies);
      //Cubie temp0, temp1;
      //temp0=cloneCubie(cubies[0]);
      //temp1=cloneCubie(cubies[1]);
      //swapCubie(cubies[0],cubies[2]);
      //swapCubie(cubies[1],cubies[5]);
      //swapCubie(cubies[2],cubies[8]);
      //swapCubie(cubies[5],cubies[7]);
      //swapCubie(cubies[8],cubies[6]);
      //swapCubie(cubies[7],cubies[3]);
      //swapCubie(cubies[6],temp0);
      //swapCubie(cubies[3],temp1);
    } else if (command=="u" || command=="d"||command=="l" || command=="r"|| command == "f" || command == "b") {
      Cubie cubies[] = getFace( command);    
      applyRotation(cubies);

      //Cubie temp0, temp1;
      //temp0=cloneCubie(cubies[0]);
      //temp1=cloneCubie(cubies[3]);
      //swapCubie(cubies[0], cubies[6]);
      //swapCubie(cubies[3], cubies[7]);
      //swapCubie(cubies[6], cubies[8]);
      //swapCubie(cubies[7], cubies[5]);
      //swapCubie(cubies[8], cubies[2]);
      //swapCubie(cubies[5], cubies[1]);
      //swapCubie(cubies[2], temp0);
      //swapCubie(cubies[1], temp1);
    } else if (command=="e1" || command == "s1" || command == "m1" ) {  
      Cubie cubies[] = getFace(command);      
      //Cubie temp0, temp1;
      //temp0=cloneCubie(cubies[0]);
      //temp1=cloneCubie(cubies[3]);
      //swapCubie(cubies[0], cubies[5]);
      //swapCubie(cubies[3], cubies[6]);
      //swapCubie(cubies[5], cubies[7]);
      //swapCubie(cubies[6], cubies[4]);
      //swapCubie(cubies[7], cubies[2]);
      //swapCubie(cubies[4], cubies[1]);
      //swapCubie(cubies[2], temp0);
      //swapCubie(cubies[1], temp1);

      applyRotation(cubies);
      applyRotation(cubies);
      applyRotation(cubies);
    } else if (command == "E1" || command == "S1" || command == "M1") {
      Cubie cubies[] = getFace(command);      

      applyRotation(cubies);

      //Cubie temp0, temp1;
      //temp0=cloneCubie(cubies[0]);
      //temp1=cloneCubie(cubies[1]);
      //swapCubie(cubies[0], cubies[2]);
      //swapCubie(cubies[1], cubies[4]);
      //swapCubie(cubies[2], cubies[7]);
      //swapCubie(cubies[4], cubies[6]);
      //swapCubie(cubies[7], cubies[5]);
      //swapCubie(cubies[6], cubies[3]);
      //swapCubie(cubies[5], temp0);
      //swapCubie(cubies[3], temp1);
    } else if (command=="e2" || command == "s2" || command == "m2" ) {  
      Cubie cubies[] = getFace(command);      
      //Cubie temp0, temp1;
      //temp0=cloneCubie(cubies[0]);
      //temp1=cloneCubie(cubies[3]);
      //swapCubie(cubies[0], cubies[5]);
      //swapCubie(cubies[3], cubies[6]);
      //swapCubie(cubies[5], cubies[7]);
      //swapCubie(cubies[6], cubies[4]);
      //swapCubie(cubies[7], cubies[2]);
      //swapCubie(cubies[4], cubies[1]);
      //swapCubie(cubies[2], temp0);
      //swapCubie(cubies[1], temp1);

      applyRotation(cubies);
      applyRotation(cubies);
      applyRotation(cubies);
    } else if (command == "E2" || command == "S2" || command == "M2") {
      Cubie cubies[] = getFace(command);      

      applyRotation(cubies);

      //Cubie temp0, temp1;
      //temp0=cloneCubie(cubies[0]);
      //temp1=cloneCubie(cubies[1]);
      //swapCubie(cubies[0], cubies[2]);
      //swapCubie(cubies[1], cubies[4]);
      //swapCubie(cubies[2], cubies[7]);
      //swapCubie(cubies[4], cubies[6]);
      //swapCubie(cubies[7], cubies[5]);
      //swapCubie(cubies[6], cubies[3]);
      //swapCubie(cubies[5], temp0);
      //swapCubie(cubies[3], temp1);
    }
  }
  void applyRotation(Cubie[] face ) {

    int wd=(int)(sqrt(face.length));
    Cubie[] temp=new Cubie[face.length];
    //printArray(face);
    //printArray(rtrn);
    for (int i=0; i<temp.length; i++) {
      //println("HERE"+i);
      if (face[i]!=null) {
        temp[i]=cloneCubie(face[i]);
      } else {
        temp[i]=null;
      }
    }
    //Cubie[] temp2 =  new Cubie[wd*wd];

    for (int x=0; x<wd; x++) {
      for (int y=0; y<wd; y++) {
        //if (r==0) {
        int t=(wd*(wd-1));
        //println("T:"+t);
        //println("x:" + x + " y:"+y);
        int i=(t+y)-(x*wd);
        //println("i:"+i + " " + (y*wd+x));
        swapCubie(face[y*wd+x], temp[i]);
      }
    }
  }
  void rotateYCubie(Cubie cubie, boolean dir) {
    cubie.rotateYCubie(dir);
  }
  void rotateXCubie(Cubie cubie, boolean dir) {
    cubie.rotateXCubie(dir);
  }
  void rotateZCubie(Cubie cubie, boolean dir) {
    cubie.rotateZCubie(dir);
  }


  void visuallyRotateThisFace(Cubie[] face, String command) {
       boolean dir = false;
    if ((int)char(command.charAt(0)) < 90) {
      dir = true;
    }
    for(Cubie c : face){
      c.show(angle,command, dir);    
    }
    
  }
}
