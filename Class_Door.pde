//Lasse og Mikkel

class Door {
  PVector position;
  float doorWidth;
  float doorHeight;

  // Konstruktør
  Door(PVector pos) {
    position = pos.copy();

    // Dørens størrelse afhænger af canvasets størrelse

    // i har to konstanter i kan bruge, men de hedder det samme som i har kaldt jeres variabler - det bliver lidt bøvlet.
    //width = gm.canvasWidth * 0.05;
    //height = gm.canvasHeight * 0.15;
    //this.doorWidth = doorWidth*0.05;   // doorWidth er 0 her, så døren blev 0 stor
    //this.doorHeight = doorHeight*0.15;
    this.doorWidth = 40;
    this.doorHeight = 55;  // passer til dør-positionerne i json-filerne
  }

  // rører spilleren døren?
  boolean touches(Player p) {
    if (p.position.dist(position)<10) {
      return true;
    } else {
      return false;
    }
  }

  // Tegner døren
  void drawDoor() {
    fill(120);
    rect(position.x, position.y, doorWidth, doorHeight);
    noFill();
  }
}
