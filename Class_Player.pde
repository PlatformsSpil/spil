class Player {
  int liv=3;
  PVector position;
  PVector velocity;
  boolean grounded;
  int energi;
  // vi skal bruge en var til at tælle mønter
  int coins=0;
  // og nøgnlen
  int keys =0;
  float size;
  PVector jumpSpeed;
  PVector runSpeed;

  float gravity = 0.8;
  float groundY;

  float[] offsetX = {-12, -5, 0}; // én værdi pr. frame fordi frane er skæv

  PImage sheet;                    // hele sprite-arket
  PImage[] frames = new PImage[3]; // de 3 figurer hver for sig
  int frameIndex = 0;              // hvilken figur der vises
  float scale = 1;                 // hvor meget den forstørres



  Player(PVector pos, PVector vel, boolean ground) {
    position = pos.copy();
    velocity = vel.copy();
    grounded = ground;
    energi = 50; // altid halvdelen (så 50%)
    size = 12; // kun hvis player er en cirkel ellers er det x,y

    jumpSpeed = new PVector(0, 15);

    // Sætter lige runSpeed til 4 for vi har brug for det
    runSpeed = new PVector(4, 0);

    groundY = height - 50; // jorden ligger 50 pixels fra bunden

    sheet = loadImage("Player.png");
    int w = sheet.width / 3; // arket har 3 figurer ved siden af hinanden
    for (int i = 0; i < 3; i++) {
      frames[i] = sheet.get(i * w, 0, w, sheet.height);
    }
  }

  void displayPlayer() {
    // OPGAVE 4: Vælg hvilken figur (frameIndex) der skal vises: 1 når spilleren bevæger sig mod højre,
    // 2 når han bevæger sig mod venstre, og 0 når han står stille.
if (velocity.x > 0) {
    frameIndex = 1;
  } else if (velocity.x < 0) {
    frameIndex = 2;
  } else {
    frameIndex = 0;
  }
   
    PImage f = frames[frameIndex];
    imageMode(CENTER); // position er midten af figuren
    //image(f, position.x, position.y, f.width * scale, f.height * scale);
    image(f, position.x + offsetX[frameIndex] * scale, position.y, f.width * scale, f.height * scale);


    // til test
    float halvB = frames[0].width * scale / 2 * 0.4;
    float halvH = frames[0].height * scale / 2;
    stroke(255, 0, 0);
    line(position.x - halvB, position.y + halvH, position.x + halvB, position.y + halvH);
  }


  void movePlayer(ArrayList<Platform> platforms) {
    // OPGAVE 5: Spilleren må kun bevæge sig vandret, mens en piletast holdes nede.
    // Nulstil først den vandrette fart, og brug så keyLeft, keyRight (sættes i spil.pde)
    // og runSpeed til at sætte velocity.x.
    // Spørgsmål: hvad sker der med din løsning, hvis begge taster holdes nede?
  }
  void keyPressed(){
 if (key == 'a' || key == 'A'){
    playerHastighedX = -5;
  }
  if (key == 'd'||key == 'D'){
    playerHastighedX = 5;
  }
if (key == 'w'||key == 'W'){
    playerHastighedY = -12;
    grounded = false;
  }
  }

}

}
 
   
    // OPGAVE 6: Hvis hop-tasten er trykket ned OG spilleren står på noget, skal han hoppe:
    // sæt den lodrette fart ud fra jumpSpeed (husk at op er negativ y i Processing),
    // og husk at han nu ikke længere står på noget.

    velocity.y += gravity;

    float halvH = frames[0].height * scale / 2;
    float halvB = frames[0].width * scale / 2 * 0.4; // kun fødderne, ikke hele billedet

    float gammelBund = position.y + halvH; // fødder før bevægelse
    position.add(velocity);
    float nyBund = position.y + halvH;     // fødder efter bevægelse

    grounded = false; // antag han er i luften, indtil vi finder noget han står på

    for (Platform pl : platforms) {
      float top = pl.position.y;
      float forrigeTop = top - pl.velocity.y; // hvor toppen var sidste frame

      boolean overlapperVandret = position.x + halvB > pl.position.x
        && position.x - halvB < pl.position.x + pl.platformWidth;

      if (overlapperVandret && velocity.y >= 0
        && gammelBund <= forrigeTop + 1 && nyBund >= top) {
        position.y = top - halvH;  // stil ham oven på
        velocity.y = 0;
        grounded = true;
        position.x += pl.velocity.x; // følg med hvis platformen bevæger sig
      }
    }

    // jorden i bunden, så han ikke falder ud af skærmen
    if (nyBund >= groundY) {
      position.y = groundY - halvH;
      velocity.y = 0;
      grounded = true;
    }
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

  void setPosition(PVector p) {
    position = p.copy();
  }

  // jeg har rettet til to int værdier for at gøre det lettere i funktionskaldet
  void setVelocity(int x, int y) {
    velocity = new PVector(x, y);
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

  void setRunSpeed(PVector r) {
    runSpeed = r.copy();
  }
  
  void setKeys(int k){
   keys=k;
  }
}
