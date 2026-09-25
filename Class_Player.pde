class Player {
  int liv;
  PVector position;
  PVector velocity;
  boolean grounded;
  int energi;
  float size;
  PVector jumpSpeed;
  PVector runSpeed;

  Player() {
    liv = 3;

    position = new PVector(100, 100);

    velocity = new PVector (5, 0);

    grounded = true;

    energi = 50; // altid halvdelen (så 50%)

    size = 12; // kun hvis player er en cirkel ellers er det x,y

    jumpSpeed = new PVector(0, 5);
    runSpeed = new PVector(0, 0);
  }

  int getliv () {
    return liv;
  }


  PVector getPosition() {
    return position;
  }


  PVector getVelocity() {
    return velocity;
  }

  boolean getGrounded() {
    return grounded;
  }

  int getEnergi() {
    return energi;
  }

  float getSize() {
    return size;
  }

  PVector getJumpSpeed() {
    return jumpSpeed;
  }
  PVector getRunSpeed() {
    return runSpeed;
  }

  void setLiv(int L) {
    liv = liv + L;
  }

  void setPosition(PVector P) {
    position = P.copy();
  }
  void setVelocity(PVector V) {
    velocity = V.copy();
  }
  void setGrounded(boolean G) {
    grounded = G;
  }
  void setEnergi(int E) {
    energi = energi + E;
  }
  void setSize(float S) {
    size = size + S;
  }

  void setJumpSpeed(PVector J) {
    jumpSpeed = J.copy();
  }
  void setRunSpeed(PVector R) {
    runSpeed = R.copy();
  }
}
