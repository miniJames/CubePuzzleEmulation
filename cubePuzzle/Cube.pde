int up=1;//0x100000;
int left=4;//0x10000;
int down=0;//0x1000;
int right = 2;//0x100;
int front = 3;//0x10;
int back =5;// 0x1;
int equator = 7;
int standing = 6;
int middle = 8;

class Cube {
  AlgorithmManager alg;
  boolean rotating = false;
  boolean scrambleMode = false;
  int l, wd, h; 
  ArrayList<Cubie> cub;
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
          if ((k==0 || k==l-1) || ((k>0 && k<l) && (j==0)||(i==0)|| (k==0)) || ((k>0 && k<l-1) && (j==wd-1)||(i==h-1)|| (k==l-1)) ) {  
            int si =(int)((i*w)-(.5*w)*l);
            int sj =(int)((j*w)-(.5*w)*l);
            int sk =(int)((k*w) -(.5*w)*l);
            //println("START I:" + si + " START J:" + sj + " START K:" + sk + " w:"+w);
            Cubie c=new Cubie(si, sj, sk, w);
            c.locationID = cn;
            //c.locationID = (cn);
            c.ID = faceID(cn);
            c.target = c.ID;

            //c.tag = ""+c.ID;
            cub.add(c);
            cn++;
          }
        }
      }
    }
  }

  boolean rotateCube(char k) {
    //boolean rtrn = true;
    if (k=='X') {

      sendMoves("U'");
      sendMoves("D");
      sendMoves("E'");
      return true;
    } else if ( k=='x') {

      sendMoves("U''");
      sendMoves("D'");
      sendMoves("E''");
      return true;
    } else   if (k=='Y') {

      sendMoves("L'");
      sendMoves("R");
      sendMoves("M'");
      return true;
    } else if ( k=='y') {

      sendMoves("L''");
      sendMoves("R'");
      sendMoves("M''");
      return true;
    } else if (k=='Z') {

      sendMoves("F'");
      sendMoves("B");
      sendMoves("S'");
      return true;
    } else if ( k=='z') {

      sendMoves("F''");
      sendMoves("B'");
      sendMoves("S''");
      return true;
    }
    return false;
  }

  void changeMode(char k) {
    swapCubies(k);
    for (Cubie cubie : c.getFace(k)) {

      c.rotateCubie(k, cubie);
    }
    //println("JAMES " +k);
    String s =  k + "";
    rotateCube(k);



    if (k=='q') {
      c.scrambleMode = !c.scrambleMode;
    }
    if (k=='a') {
      //run algorithm.
      //sendMoves("RRLLUUDDFFBB");
      sendMoves("lrbfufbrblufFULBRBFUFBRL");
    } else if (k=='1') {
      //println(alg.algorithms.get("sune"));
      //println(alg.decode(alg.algorithms.get("sune")));
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

    for (Cubie cu : cub) {
      //cub.get(i).show();
      cu.show();
    }
    if (c.scrambleMode  ) {
      //for (int cc = 0; cc < 5000; cc++) {
      scramble(1);
      //  int face =floor( random(0, 12));
      //  String faces[] =new String [] {"U", "U'", "D", "D'", "L", "L'", "R", "R'", "F", "F'", "B", "B'"};
      //  char fc = alg.decode(faces[face]).toCharArray()[0];
      //  Cubie faceID[] = getFace(fc);
      //  for (Cubie f : faceID) {
      //    c.rotateCubie(fc, f);
      //    swapCubies(fc);
      //  }
      //  if (isSolved()) {
      //    c.scrambleMode=false;
      //  }
      //}
      //}
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
      if (!  rotateCube(fc)) {
        //println("DOODAR");
        Cubie faceID[] = getFace(fc);
        swapCubies(fc);

        for (Cubie f : faceID) {
          c.rotateCubie(fc, f);
        }
      }
      if (isSolved()) {
        c.scrambleMode=false;
      }
    }
  }
  void sendMoves(String moves) {

    for (char c : moves.toCharArray()) {
      swapCubies(c);
      for (Cubie cubie : getFace(c)) {

        rotateCubie(c, cubie);
      }
      rotateCube(c);
    }
  }
  Cubie[] getFace(char face) {
    int fce = 0;
    if (face=='u' || face=='U') {
      fce=up;
    } else  if (face=='d' || face=='D') {
      fce=down;
    } else  if (face=='l'|| face=='L') {
      fce=left;
    } else  if (face=='r'|| face=='R') {
      fce=right;
    } else  if (face=='f'|| face=='F') {
      fce=front;
    } else  if (face=='b'|| face=='B') {
      fce=back;
    } else if (face=='e' || face =='E') {
      fce=equator;
    } else if (face=='s' || face =='S') {
      fce=standing;
    } else if (face=='m' || face =='M') {
      fce=middle;
    }
    //println(face);
    ArrayList<Cubie> rtrn = new ArrayList<Cubie>();
    int counter =0, index=0;
    for (index=0; index<cub.size(); index++) {
      Cubie c = cub.get(index);
      if (fce==up) {
      }
      if (isBitON(faceID(c.locationID), fce)) {
        if (fce==up) {
        }
        rtrn.add(c);

        counter++;
      } else {
        if (fce==up) {
        }
      }
    }

    Cubie[] rtrn1 = new Cubie[rtrn.size()];
    counter =0;
    for (Cubie cccc : rtrn) {
      rtrn1[counter]=cccc;
      counter ++;
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
    boolean rtrn = true;
    char faces[] =new char [] {'u', 'd', 'e'};
    for (int count=0; count<faces.length; count++) {
      //char faces[] =new char [] {'u', 'd', 'l', 'r', 'f', 'b'};
      Cubie[] cubiesIndex = getFace(faces[count]);
      //printArray( getFace(faces[count]));
      Cubie comp;

      comp = (cubiesIndex[0]);
      for (int c =1; c<cubiesIndex.length; c++) {
        if (c>0) {
          //println(c);
          Cubie col2;
          //println(cub.size());
          //println("L"+cubiesIndex[c]);//);

          col2 = (cubiesIndex[c]);
          for (int i = 0; i<comp.cols.length; i++) {
            if (comp.cols[i] ==col2.cols[i]) {
            } else {
              return false;
            }
          }
        }
      }
    }

    return rtrn;
  }
  int getPositionHealth() {
    int rtrn = 0;
    for (Cubie c : cub) {
      if (c.ID == c.target) {
        rtrn++;
      }
    }

    return rtrn;
  }

  int getOrientationHealth() {
    int rtrn=0;
    char faces[] =new char [] {'u', 'l', 'd', 'r', 'f', 'b'};

    IntList checked;
    checked=new IntList();

    for (int count=0; count<faces.length; count++) {

      Cubie[] cubiesIndex = getFace(faces[count]);
      //printArray( getFace(faces[count]));
      Cubie comp;

      comp = (cubiesIndex[0]);
      println(comp.ID);

      for (int c =0; c<cubiesIndex.length; c++) {
        Cubie col2;          
        col2 = (cubiesIndex[c]);
        if (checked.hasValue(col2.ID)) {
        } else {
          checked.append(comp.ID);
          boolean match = true;
          for (int i = 0; i<comp.cols.length; i++) {
            match = match & (comp.cols[i] ==col2.cols[i]);
          }
          if (match) {
            rtrn++;
          }
        }
      }
    }
    return rtrn;
  }
  void rotateCubie(char face, Cubie cubie) {
    ///println((int)char(face));
    boolean dir = false;
    if ((int)char(face) < 90) {
      dir = true;
    }

    if (face=='u' || face=='d'||face=='U' || face=='D' || face=='E' || face == 'e') { //up and down.
      rotateYCubie(cubie, dir);
    } else if (face=='l' || face=='r' ||face=='L' || face=='R' || face == 'M' || face == 'm') { //left and right
      rotateXCubie(cubie, dir);
    } else if (face=='b' || face=='f' || face=='B' || face=='F' || face == 'S' || face == 's') { //up and down
      rotateZCubie(cubie, dir);
    }
  }
  void swapCubie(Cubie a, Cubie b) {
    a.locationID= b.locationID;
    a.ID = b.ID;
    a.x =b.x;
    a.y = b.y;
    a.z = b.z;
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
    int[] rtrn = new int[4];
    int counter = 0;
    int index = 0;
    for (Cubie cubie : c) {
      //println("CubieID:"+cubie.locationID);
      if (cubie.isCenter()) {
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
  void swapCubies(char face) {
    //println("swap");
    if (face=='u' || face=='d'||face=='l' || face=='r' || face == 'f' || face == 'b') {
      Cubie cubies[] = getFace(face);
      int idx[] = new int[4];
      idx = getCorners(cubies);
      //println(idx);
      Cubie temp1 = clone(cubies[idx[0]]);
      swapCubie(cubies[idx[0]], cubies[idx[2]]);
      swapCubie(cubies[idx[2]], cubies[idx[3]]);
      swapCubie(cubies[idx[3]], cubies[idx[1]]);
      swapCubie(cubies[idx[1]], temp1);
      idx =  getEdges(cubies);
      Cubie temp2 =  clone( cubies[idx[0]]);
      swapCubie(cubies[idx[0]], cubies[idx[1]]);
      swapCubie(cubies[idx[1]], cubies[idx[3]]);
      swapCubie(cubies[idx[3]], cubies[idx[2]]);
      swapCubie(cubies[idx[2]], temp2);
    } else if (face=='U' || face=='D'||face=='L' || face=='R'|| face == 'F' || face == 'B') {
      Cubie cubies[] = getFace(face);
      int idx[] = new int[4];
      idx = getCorners(cubies);
      Cubie temp1 = clone(cubies[idx[0]]);
      swapCubie(cubies[idx[0]], cubies[idx[1]]);
      swapCubie(cubies[idx[1]], cubies[idx[3]]);
      swapCubie(cubies[idx[3]], cubies[idx[2]]);
      swapCubie(cubies[idx[2]], temp1);
      idx =  getEdges(cubies);
      Cubie temp2 =  clone( cubies[idx[0]]);
      swapCubie(cubies[idx[0]], cubies[idx[2]]);
      swapCubie(cubies[idx[2]], cubies[idx[3]]);
      swapCubie(cubies[idx[3]], cubies[idx[1]]);
      swapCubie(cubies[idx[1]], temp2);
    } else if (face=='e' || face == 's' || face == 'm' ) {  

      //println("JAMES");
      Cubie cubies[] = getFace(face);     
      int idx[] = new int[4];
      idx =  getEdges(cubies);
      //(idx);
      Cubie temp2 =  clone( cubies[idx[0]]);
      swapCubie(cubies[idx[0]], cubies[idx[2]]);
      swapCubie(cubies[idx[2]], cubies[idx[3]]);
      swapCubie(cubies[idx[3]], cubies[idx[1]]);
      swapCubie(cubies[idx[1]], temp2);
      //println(idx);
      //swap centers.
      idx =  getCenters(cubies);
      temp2 =  clone( cubies[idx[0]]);
      swapCubie(cubies[idx[0]], cubies[idx[1]]);
      swapCubie(cubies[idx[1]], cubies[idx[3]]);
      swapCubie(cubies[idx[3]], cubies[idx[2]]);
      swapCubie(cubies[idx[2]], temp2);
    } else if (face == 'E' || face == 'S' || face == 'M') {

      Cubie cubies[] = getFace(face);     
      int idx[] = new int[4];
      idx =  getEdges(cubies);
      //println(idx);
      Cubie temp2 =  clone( cubies[idx[0]]);
      swapCubie(cubies[idx[0]], cubies[idx[1]]);
      swapCubie(cubies[idx[1]], cubies[idx[3]]);
      swapCubie(cubies[idx[3]], cubies[idx[2]]);
      swapCubie(cubies[idx[2]], temp2);
      //println(idx);
      //swap centers.
      idx =  getCenters(cubies);
      temp2 =  clone( cubies[idx[0]]);
      swapCubie(cubies[idx[0]], cubies[idx[2]]);
      swapCubie(cubies[idx[2]], cubies[idx[3]]);
      swapCubie(cubies[idx[3]], cubies[idx[1]]);
      swapCubie(cubies[idx[1]], temp2);
    }
  }

  Cubie clone(Cubie c) {
    Cubie rtrn=c;
    rtrn= new Cubie(c.x, c.y, c.z, 20);
    rtrn.locationID = c.locationID;
    rtrn.cols = copyArray(c.cols);
    rtrn.ID = c.ID;
    rtrn.target = c.target;
    return rtrn;
  }
  int[] copyArray(int[] arr1) {
    int[] rtrn = new int[arr1.length];
    for (int i = 0; i<arr1.length; i++) {
      rtrn[i] = arr1[i];
    }
    return rtrn;
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

  boolean isBitON(int num, int bit) {

    if ((num>>bit)%2==0) {
      return false;
    } else {
      return true;
    }
  }

  int faceID(int cubeID) {
    IntList ids = new IntList();
    ids.append(50);
    ids.append(290);
    ids.append(38);
    ids.append(176);
    ids.append(416);
    ids.append(164);
    ids.append(49);
    ids.append(289);
    ids.append(37);
    ids.append(82);
    ids.append(322);
    ids.append(70);
    ids.append(208);
    ids.append(196);
    ids.append(81);
    ids.append(321);
    ids.append(69);
    ids.append(26);
    ids.append(266);
    ids.append(14);
    ids.append(152);
    ids.append(392);
    ids.append(140);
    ids.append(25);
    ids.append(265);
    ids.append(13);

    return ids.get(cubeID);
  }
}
