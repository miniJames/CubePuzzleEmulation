int up=1;//0x100000;
int left=4;//0x10000;
int down=0;//0x1000;
int right = 2;//0x100;
int front = 3;//0x10;
int back =5;// 0x1;

class Cube {
  boolean rotating = false;
  boolean scrambleMode = false;
  int l, wd, h; 
  ArrayList<Cubie> cub;
  //Cubie[] cub;

  Cube(int len, int wid, int hei) {
    l=len;
    wd=wid;
    h=hei;
    cub=new ArrayList<Cubie> ();
    w=20;

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

            c.tag = ""+c.ID;
            cub.add(c);
            cn++;
          }
        }
      }
    }
  }


  void changeMode(char k) {

    for (Cubie cubie : c.getFace(k)) {
      swapCubies(k);
      c.rotateCubie(k, cubie);
    }
    if (k=='s') {
      c.scrambleMode = !c.scrambleMode;
    }
    if (k=='a') {
      //run algorithm.
      //sendMoves("RRLLUUDDFFBB");
      sendMoves("lrbfufbrblufFULBRBFUFBRL");
    } else if (k=='1') {
      //println(alg.algorithms.get("sune"));
      println(alg.decode(alg.algorithms.get("sune")));
      sendMoves(alg.decode(alg.algorithms.get("sune")));
    } else if (k=='2') {

      sendMoves(alg.decode(alg.algorithms.get("sunel")));
    } else if (k=='3') {

      sendMoves(alg.decode(alg.algorithms.get("a-sune")));
    } else if (k=='4') {

      sendMoves(alg.decode(alg.algorithms.get("a-sunel")));
    } else if (k=='5') {

      sendMoves(alg.decode(alg.algorithms.get("sexy")));
    } else if (k=='z') {

      sendMoves(alg.decode(alg.algorithms.get("a-sunel")));
    }
  }
  void show() {

    for (Cubie cu : cub) {
      //cub.get(i).show();
      cu.show();
    }
    if (c.scrambleMode  ) {
      int face =floor( random(0, 12));
      String faces[] =new String [] {"U", "U'", "D", "D'", "L", "L'", "R", "R'", "F", "F'", "B", "B'"};
      char fc = alg.decode(faces[face]).toCharArray()[0];
      Cubie faceID[] = getFace(fc);
      for (Cubie f : faceID) {
        c.rotateCubie(fc, f);
        swapCubies(fc);
      }
      if (isSolved()) {
        c.scrambleMode=false;
      }
    }
  }
  void sendMoves(String moves) {

    for (char c : moves.toCharArray()) {

      for (Cubie cubie : getFace(c)) {
        swapCubies(c);
        rotateCubie(c, cubie);
      }
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
    }  

    //ArrayList<Cubie> rtrn = new ArrayList<Cubie>();
    Cubie rtrn[]=new Cubie[9];
    int counter =0, index=0;
    //for (Cubie c : cub) {
    for (index=0; index<cub.size(); index++) {
      Cubie c = cub.get(index);
      if (isBitON(faceID(c.locationID), fce)) {
        //println(faceID(c.locationID)+":"+c.locationID+":"+face);
        rtrn[counter]=c;
        counter++;
      }
      //index++;
    }

    bubbleSort(rtrn);
    return rtrn;
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

    for (int count=0; count<6; count++) {
      char faces[] =new char [] {'u', 'd', 'l', 'r', 'f', 'b'};
      Cubie[] cubiesIndex = getFace(faces[count]);
      //printArray( getFace(faces[count]));
      Cubie comp;

      comp = (cubiesIndex[0]);
      for (int c = 0; c<cubiesIndex.length; c++) {
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

  void rotateCubie(char face, Cubie cubie) {
    ///println((int)char(face));
    boolean dir = false;
    if ((int)char(face) < 90) {
      dir = true;
    }

    if (face=='u' || face=='d'||face=='U' || face=='D') { //up and down.
      rotateYCubie(cubie, dir);
    } else if (face=='l' || face=='r' ||face=='L' || face=='R') { //left and right
      rotateXCubie(cubie, dir);
    } else if (face=='b' || face=='f' || face=='B' || face=='F') { //up and down
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
  void swapCubies(char face) {
    if (face=='u' || face=='d'||face=='l' || face=='r' || face == 'f' || face == 'b') {
      Cubie cubies[] = getFace(face);
      int idx[] = new int[4];
      idx = getCorners(cubies);
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
    }
  }

  Cubie clone(Cubie c) {
    Cubie rtrn=c;
    rtrn= new Cubie(c.x, c.y, c.z, 20);
    rtrn.locationID = c.locationID;
    rtrn.cols = copyArray(c.cols);
    rtrn.ID = c.ID;
    return rtrn;
  }
  int[] copyArray(int[] arr1) {
    int[] rtrn = new int[arr1.length];
    for (int i = 0; i<arr1.length; i++) {
      rtrn[i] = arr1[i];
    }
    return rtrn;
  }

  int getHealth() {
    int rtrn = 0;
    for (Cubie c : cub) {
      if (c.ID == c.target) {
        rtrn++;
      }
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
  ids.append(34);
  ids.append(38);
  ids.append(48);
  ids.append(32);
  ids.append(36);
  ids.append(49);
  ids.append(33);
  ids.append(37);
  ids.append(18);
  ids.append(2);
  ids.append(6);
  ids.append(16);
  ids.append(4);
  ids.append(17);
  ids.append(1);
  ids.append(5);
  ids.append(26);
  ids.append(10);
  ids.append(14);
  ids.append(24);
  ids.append(8);
  ids.append(12);
  ids.append(25);
  ids.append(9);
  ids.append(13);

  return ids.get(cubeID);
}
