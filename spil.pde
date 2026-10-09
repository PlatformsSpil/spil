Player player;

Level level = new Level();
PVector velocity = new PVector(0, 8); // ved ikke om det er det samme som gravity!??
//PVector gravity = new PVector(0, 0.8);
ArrayList<Platform> platforms = new ArrayList<Platform>();
ArrayList<Pickup> pickups = new ArrayList<Pickup>();
// i kan ikke sætte gravity til at være 0,8 når det er en PVector

// Keyboard input tracking
boolean keyLeft = false;
boolean keyRight = false;
boolean keyJump = false;


// Runs once on startup
void setup() {
  // Defines size of window
  size(800, 600);
  //load the level
  level.loadLevel();
  player = new Player(level.getSpawnPosition(), velocity, true);
  rectMode(CORNER);
}

// Draw loops infinitely
void draw() {
  // Sets background color
  background(150);


  // tegner banen
  level.display();

  // for at se min player til test
  line(0, player.groundY, width, player.groundY); // så du kan se jorden
  for (Platform pl : level.platforms) {
    pl.update();
  }
  // flyt player
  player.movePlayer(level.platforms);
  // tegn player


  if (level.door.touches(player)) {
    if (player.keys > 0) {
      /*level.setLevelUp();
      if (level.level > level.maxLevel) {
        fill(0,200,200);
        text("VUNDET!!!", 100, 100);
      } else {
        level.loadLevel();
        player.setKeys(0);
        player.setPosition(level.getSpawnPosition());
        player.setVelocity(0, 0);
      }*/
      if (level.setLevelUp()) {
      level.loadLevel();
      player.setKeys(0);
      player.setPosition(level.getSpawnPosition());
      player.setVelocity(0, 0);
    } else {
      fill(0, 200, 200);
      textSize(40);
      text("VUNDET!!!", width/2 - 100, height/2);
      noLoop();
    }
    }
  }

  player.displayPlayer();

  // fjenden søger spilleren hvis han kommer for tæt på
  if (level.enemy != null) {
    level.enemy.update(player, level.platforms);

    // OPGAVE 1: Hvis fjenden rører spilleren, skal spilleren miste et liv og starte forfra ved
    // banens spawn-punkt uden fart på. Fjenden skal også sendes tilbage til sin startplads.
    // Hint: Player har set-metoder til liv, position og fart. Enemy har en metode der
    // sætter den tilbage til start, og Level kan fortælle hvor spawn-punktet er.

    if (level.enemy.touches(player)) {
      // Reset enemy placeringe
      level.enemy.reset();

      // Reset Playeren
      //player = new Player(level.getSpawnPosition(), velocity, true);
      player.setPosition(level.getSpawnPosition());
      player.setVelocity(0, 0);
      player.liv -= 1;

      // Reset Enemien
      level.enemy.reset();
    }
  }

  if (player.getliv() <= 0) {
    fill(255, 0, 0);
    textSize(40);
    text("GAME OVER", width/2 - 110, height/2);
    noLoop(); // stop spillet
  }





  // OPGAVE 2: Gå alle pickups i banen igennem (de ligger i level.pickUps).
  // Hvis en pickup rører spilleren, skal den samles op: kald dens collect-metode
  // og marker den som samlet op. Til sidst skal hver pickup tegnes.
  // Hint: brug en for-each-løkke, og kig i Class_Pickup efter de metoder du skal bruge.

  for (Pickup p : level.pickUps) {
    if (p.touches(player)) {
      p.collect(player);
      p.setPickedUp();
    } else {
      p.display();
    }
  }

  // OPGAVE 3: Her skal der udskrives til skærmen: liv, mønter, nøgler og hvor meget energi en player har.
  // Sørg for at fonten er 12 og brug kommandoen for sort tekst.

  textSize(12);
  fill(0);
  text("Coins: " + player.coins, 10, 30);
  text("Life: " + player.liv, 10, 45);
  text("Keys: " + player.keys, 10, 60);
  text("Energi: " + player.energi, 10, 75);
}



void keyPressed() {
  if (key == 'a' || key == 'A' || keyCode == LEFT)  keyLeft = true;
  if (key == 'd' || key == 'D' || keyCode == RIGHT) keyRight = true;
  if (key == 'w' || key == 'W' || key == ' ' || keyCode == UP) keyJump = true;
}

void keyReleased() {
  if (key == 'a' || key == 'A' || keyCode == LEFT)  keyLeft = false;
  if (key == 'd' || key == 'D' || keyCode == RIGHT) keyRight = false;
  if (key == 'w' || key == 'W' || key == ' ' || keyCode == UP) keyJump = false;
}
