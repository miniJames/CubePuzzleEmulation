class AlgorithmManager {

  StringDict algorithms;

  AlgorithmManager() {
    algorithms = new StringDict();
    algorithms.set("sune", "R U R' U R U2 R'");
    algorithms.set("sunel", "L' U' L U' L' U2 L");
    algorithms.set("a-sune", "R U2 R' U' R U' R'");
    algorithms.set("a-sunel","L' U2 L U L' U L");
    algorithms.set("sexy","R U R' U'");
    
}

  String decode(String alg) {
    String rtrn;
    rtrn= "";
    for (String c : alg.split(" ")) {
      //println(c);
      switch(c) {
      case "R" :
        rtrn +="R";
        break;
      case "R'" :
        rtrn +="r";
        break;
      case "R2" :
        rtrn +="RR";
        break;
      case "r2" : 
        rtrn = rtrn + "RR";
        break;
        
      case "L" :
        rtrn +="l";
        break;
      case "L'" :
        rtrn +="L";
        break;
      case "L2" :
        rtrn +="LL";
        break;
      case "l2" : 
        rtrn = rtrn + "LL";
        break;
      case "U" :
        rtrn +="U";
        break;
      case "U'" :
        rtrn +="u";
        break;
      case "U2" :
        rtrn +="UU";
        break;
      case "u2" : 
        rtrn = rtrn + "UU";
        break;

      case "D" :

        rtrn +="d";
        break;
      case "D'" :
        rtrn +="D";
        break;
      case "D2" :
        rtrn +="DD";
        break;
      case "d2" : 
        rtrn = rtrn + "DD";
        break;
      case "F" :

        rtrn +="F";
        break;
      case "F'" :
        rtrn +="f";
        break;
      case "F2" :
        rtrn +="FF";
        break;
      case "f2" : 
        rtrn = rtrn + "FF";
        break;
      case "B" :

        rtrn +="b";
        break;
      case "B'" :
        rtrn +="B";
        break;
      case "B2" :
        rtrn +="BB";
        break;
      case "b2" : 
        rtrn = rtrn + "BB";        
        break;
      }
    }
    return rtrn;
  }
}
