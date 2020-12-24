class HillClimberSolver {

  //cube should be pre scrambled.


  int currentHealth;
  int startHealth=0;
  String[] moveSequence = {"U", "U", "U", "U", "D", "D", "D", "D", "L", "L", "L", "L", "R", "R", "R", "R", "F", "F", "F", "F", "B", "B", "B", "B","M","M","M","M","E","E","E","E","S","S","S","S"};
  int results[]= new int[moveSequence.length];
  Cube cb;
  HillClimberSolver(Cube c) {
    cb=c;
    startHealth = cb.getOrientationHealth();
  }

  void getGoing() {
    int currentMove;
    for (currentMove=0; currentMove<moveSequence.length; currentMove++) {
      currentHealth=cb.getOrientationHealth();
      //get current move
      String move = moveSequence[currentMove];
      c.sendMoves(move);

      //store health
      results[currentMove] = cb.getOrientationHealth();
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
    int times = (hiIndex % 4);
    for (int t = 0; t<times; t++) {
      c.sendMoves(moveSequence[hiIndex]);
    }
    if (random(1)<.01) {
      //c.sendMoves(c.alg.algorithms.value((int)random(c.alg.algorithms.size())));
      c.sendMoves(c.alg.algorithms.value(5));
    }
  }
}
