class HillClimberSolverSmart {

  //cube should be pre scrambled.


  int currentHealth;

  int results[];
  Cube cb;
  HillClimberSolverSmart(Cube c) {
    cb=c;
  }

  void getGoing() {
    if (getEdges()) {
      //getCorners();
    }
  }

  boolean getEdges() {

    String[] faces = {"U", "D", "L", "R", "F", "B"};
    boolean match = true;
    for (String f : faces) {

      Cubie[] face = cb.getFace(f);
      Cubie center=null;
      for (Cubie cubie : face) {
        //println("CubieID:"+cubie.locationID);
        if (cubie.isCenter()) {
          center=cubie;
          break;
        }
      }

      for (Cubie c : face) {
        if (c.isEdge()) {
          for (int col=0; col<c.cols.length; col++) {
            try{
            match = match & (c.cols[col]==center.cols[col]);
            } catch (Exception e){
            
            }
          }
        }
      }
    }
    if (match) {

      return true;
    } else {

      int[] results = new int[6];
      for (int c=0; c<6; c++) {

        cb.sendMoves(cb.alg.algorithms.get("sexy"));

        results[c]=cb.getOrientationHealth();
      }


      //find highest element.
      int highest = results[0];
      int hiIndex = 0;
      for (int r=1; r<results.length; r++) {
        if (results[r] > highest) {
          highest = results[r];
          hiIndex=r;
        }
      }
      for (int c=0; c<hiIndex; c++) {
        cb.sendMoves(cb.alg.algorithms.get("sexy"));
        
      }

      return false;
    }
  }
}
