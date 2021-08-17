
Cubie cloneCubie(Cubie c) {
  Cubie rtrn;//=c;
  //println("clone cubie");
  //println(c);
  rtrn= new Cubie(c.x, c.y, c.z, 20, c.belongsTo);
  rtrn.tag = c.tag;
  rtrn.locationID = c.locationID;
  rtrn.cols = copyArray(c.cols);
  rtrn.ID = c.ID;
  rtrn.target = c.target;

  return rtrn;
}
void swapCubie(Cubie a, Cubie b) {
  Cubie temp;
  //println("swap cubie");
  if (a!=null) {

    temp = cloneCubie(a);
    //println("A");
    if (b!=null) {
      a.locationID= b.locationID;
      //println("A");
      a.belongsTo = b.belongsTo;
      //println("A");       
      a.tag = b.tag;       
      //println("A");

      a.ID = b.ID;       
      //println("A");
      a.x =b.x;       
      //println("A");
      a.y = b.y;       
      //println("A");
      a.z = b.z;       
      //println("A");
    } else { 
      a=null;
      b=new Cubie();
    }
    b.belongsTo = temp.belongsTo;        
    //b.tag = temp.tag;
    b.x = temp.x;
    b.y = temp.y;
    b.z = temp.z;
    b.ID= temp.ID;
    b.locationID = temp.locationID;
  }
}
int[] copyArray(int[] arr1) {
  int[] rtrn = new int[arr1.length];
  for (int i = 0; i<arr1.length; i++) {
    rtrn[i] = arr1[i];
  }
  return rtrn;
}

//boolean isBitON(int num, int bit) {

//  if ((num>>bit)%2==0) {
//    return false;
//  } else {
//    return true;
//  }
//}
