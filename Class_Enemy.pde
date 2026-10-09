// Enemy - en robot der patruljerer frem og tilbage,
// og som begynder at jagte spilleren hvis han kommer for tæt på.

class Enemy {
  PVector position;   // midten af robotten
  PVector startPosition; // hvor han starter - han går tilbage hertil når han har fanget spilleren
  PVector velocity;
  float enemyWidth;   // width og height er reserveret i Processing, derfor andre navne
  float enemyHeight;

  PImage img;

  // patrulje-område (x-værdier) - læses fra json
  float minX;
  float maxX;

  float patrolSpeed = 1;    // hastighed når han går rundt
  float chaseSpeed = 2.5;   // hastighed når han jagter (spilleren løber 4, så man kan nå at flygte)
  float seeRange = 200;     // hvor tæt spilleren skal være før han bliver opdaget
  float loseRange = 300;    // hvor langt væk spilleren skal være før robotten giver op

  boolean chasing = false;  // jagter han lige nu?
  int direction = 1;        // 1 = højre, -1 = venstre

  float gravity = 0.8;
  float groundY;
  Platform standingOn = null; // den platform han står på (null = jorden eller i luften)

  // konstruktør
  // pos er hvor robottens FØDDER er (y i json-filen ligger lige over en platform)
  Enemy(PVector pos, float minX, float maxX) {
    velocity = new PVector(0, 0);
    this.minX = minX;
    this.maxX = maxX;

    // Enemy.png har to figurer - vi skærer robotten til venstre ud
    PImage sheet = loadImage("Enemy.png");
    img = sheet.get(23, 12, 34, 52);
    enemyWidth = img.width;
    enemyHeight = img.height;

    // position er midten af billedet, så vi flytter en halv højde op fra fødderne
    position = new PVector(pos.x, pos.y - enemyHeight / 2);
    startPosition = position.copy();

    groundY = height - 50; // samme jord som spilleren
  }

  // flytter robotten: patrulje eller jagt
  void update(Player p, ArrayList<Platform> platforms) {
    float afstand = dist(position.x, position.y, p.position.x, p.position.y);

    // OPGAVE 20: Robotten skal begynde at jagte (chasing), når spilleren er tættere på end seeRange,
    // og give op, når spilleren er længere væk end loseRange.
    // Spørgsmål: hvorfor bruger vi to forskellige afstande i stedet for kun én?
    if (!chasing && afstand < seeRange) {
      chasing = true;
    }

    if (chasing && afstand > loseRange) {
      chasing = false;
    }

    if (chasing) {
      // OPGAVE 21: Sæt direction så robotten går mod spilleren: 1 = højre, -1 = venstre og 0 = stå stille,
      // når den er (næsten) lige under eller over spilleren. Sæt derefter velocity.x ud fra
      // direction og chaseSpeed.
      // Spørgsmål: hvad sker der, hvis du ikke har "stå stille"-tilfældet?
      if (p.position.x > position.x + 5) {
        direction = 1;
      } else if (p.position.x < position.x - 5) {
        direction = -1;
      } else {
        direction = 0;
      }
      velocity.x = direction * chaseSpeed;
    } else {
      // gå frem og tilbage mellem minX og maxX
      if (direction == 0) direction = 1;
      if (position.x >= maxX) direction = -1;
      if (position.x <= minX) direction = 1;

      // står han på en platform, vender han ved kanten i stedet for at falde ned
      if (standingOn != null) {
        if (position.x + patrolSpeed >= standingOn.position.x + standingOn.platformWidth) direction = -1;
        if (position.x - patrolSpeed <= standingOn.position.x) direction = 1;
      }
      velocity.x = direction * patrolSpeed;
    }

    // tyngdekraft og platforme - samme idé som i Player.movePlayer()
    velocity.y += gravity;

    float halvH = enemyHeight / 2;
    float halvB = enemyWidth / 2;

    float gammelBund = position.y + halvH;
    position.add(velocity);
    float nyBund = position.y + halvH;

    standingOn = null;
    for (Platform pl : platforms) {
      float top = pl.position.y;
      float forrigeTop = top - pl.velocity.y;

      boolean overlapperVandret = position.x + halvB > pl.position.x
        && position.x - halvB < pl.position.x + pl.platformWidth;

      if (overlapperVandret && velocity.y >= 0
        && gammelBund <= forrigeTop + 1 && nyBund >= top) {
        position.y = top - halvH;
        velocity.y = 0;
        position.x += pl.velocity.x;
        standingOn = pl;
      }
    }

    if (nyBund >= groundY) {
      position.y = groundY - halvH;
      velocity.y = 0;
    }

    // hold ham inde på skærmen
    position.x = constrain(position.x, halvB, width - halvB);
  }

  void drawEnemy() {
    imageMode(CENTER);
    image(img, position.x, position.y);

    // et rødt ! over hovedet når han jagter
    if (chasing) {
      fill(255, 0, 0);
      textAlign(CENTER, BOTTOM);
      textSize(20);
      text("!", position.x, position.y - enemyHeight / 2 - 2);
      textSize(12);
      textAlign(LEFT, BASELINE); // sæt tilbage så resten af teksten i spillet ikke flytter sig
    }
  }

  // tilbage til start - bruges når han har fanget spilleren,
  // så han ikke står og venter ved spawn-punktet
  void reset() {
    // OPGAVE 22: Sæt robotten tilbage til der hvor den startede, uden fart, og så den ikke jagter længere.
    position = startPosition.copy();
    velocity = new PVector(0, 0);
    chasing = false;
    direction = 1;
    standingOn = null;
  }

  // rører robotten spilleren?
  boolean touches(Player p) {
    float spillerRadius = p.frames[0].width * p.scale / 2;
    float afstand = dist(position.x, position.y, p.position.x, p.position.y);

    float naerhed = 0.6; // samme idé som i Pickup.touches()
    return afstand < (spillerRadius + enemyWidth / 2) * naerhed;
  }

  // metoder fra klassediagrammet
  PVector getPosition() {
    return position;
  }

  PVector getVelocity() {
    return velocity;
  }

  float getWidth() {
    return enemyWidth;
  }

  float getHeight() {
    return enemyHeight;
  }
}
