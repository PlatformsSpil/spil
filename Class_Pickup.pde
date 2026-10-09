//johan (og kristoffer) //<>//

class Pickup {
  PVector position;
  boolean pickedUp = false;

  PImage img;

  String id; // bruger jeg til at se hvad det er for en nedarving

  //konstruktør
  Pickup(PVector pos) {
    position = pos.copy();
  }

  //metoder
  PVector getPosition() {
    return position;
  }
  boolean getPickedUp() {
    return pickedUp;
  }

  // pickedUp er en boolean - vi har brug for en metode som kan fortælle at vores pickUp er picked up ;)
  void setPickedUp() {
    pickedUp = true;
  }




  float radius() {
    if (img != null) return img.width / 2;
    return 10; // reserve-størrelse hvis billedet mangler
  }

  void display() {
    // OPGAVE 7: Hvis pickup'en allerede er samlet op, skal den ikke tegnes. Stop metoden her i så fald.
    if (pickedUp == false) {
      if (img != null) {
        imageMode(CENTER);
        image(img, position.x, position.y);
      } else {
        // reserve: cirkel med første bogstav af typen
        String type = getClass().getSimpleName();
        fill(255, 200, 0);
        circle(position.x, position.y, radius() * 2);
        fill(0);
        textAlign(CENTER, CENTER);
        text(type.charAt(0), position.x, position.y);
      }
    }
  }

  boolean touches(Player p) {
    float spillerRadius = p.frames[0].width * p.scale / 2;

    if (!pickedUp && position.dist(p.position) < (spillerRadius + radius()) * 0.5) {
      return true;
    } else {
      return false;
    }
    // OPGAVE 8: Returner true hvis spilleren rører pickup'en, ellers false.
    // - En pickup der allerede er samlet op, kan ikke røres.
    // - Spillerens radius er halvdelen af bredden på p.frames[0] gange p.scale.
    // - Brug dist() til at finde afstanden mellem pickup'ens og spillerens midte.
    // - De rører hinanden, når afstanden er mindre end de to radier lagt sammen gange 0.5
    //   (0.5 betyder at spilleren skal halvvejs ind over pickup'en).
  }

  void collect(Player p) {
    // tom - hver underklasse bestemmer selv hvad der sker
  }
}


//get pickup, set pickup, get position

// i tvivl om det skal bruges
//  int collectedCoin = 0;
//  int collectedKey = 0;
//  int collectedBattery = 0;
