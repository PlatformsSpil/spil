class Level {
  // der er fejl i json filen - brug https://jsonlint.com/

  JSONObject json;

  PVector spawn;          // hvor spilleren starter
  PVector ground;         // hvor jorden starter (x) og ligger (y)
  Door door;           // Døren
  Enemy enemy;         // der er kun én fjende pr. bane
  ArrayList<Platform> platforms = new ArrayList<Platform>();
  ArrayList<Pickup> pickUps = new ArrayList<Pickup>();



  // vi skal bruge en tilstand som kan fortælle hvilken level vi er på.
  int level=1;
  int maxLevel=3; // maximale level

  // void setup() kan kun være i hovedprogrammet.
  /*
  void setup() {
   if (GameMaster.level = 1) {
   json = loadJSONObject("level1.json");
   } else if (GameMaster.level = 2) {
   json = loadJSONObject("level2.json");
   } else if (GameMaster.level = 3) {
   json = loadJSONObject("level3.json");
   }
   */

  // construktor
  Level() {
  }




  //Metoder
  // går en bane op - og fortæller om der var flere baner
  boolean setLevelUp() {
    // OPGAVE 17: Gå én bane op, hvis der er flere baner (se maxLevel).
    // Returner true hvis der var en bane mere, og false hvis det var sidste bane.
    if (level < maxLevel) {
      level++;
      return true;
    } else {
      return false;
    }
  }

  // hvilket levet er vi på
  int getLevel() {
    return level;
  }


  void loadLevel() {
    // jeg konstruerer filnavnet udfra min level variabel
    String fileName = "level" + level + ".json";
    println(fileName);
    json = loadJSONObject(fileName);

    // tøm listerne, så gamle data ikke hænger ved når man skifter bane
    platforms.clear();
    pickUps.clear();

    // spawn, ground og door har kun ét objekt hver -> vi tager nr. 0
    spawn  = readPoint("spawn");
    ground = readPoint("ground");

    door = new Door(readPoint("door"));

    // OPGAVE 18: Opret banens fjende ud fra json-filen. Der må kun være én fjende, så brug kun
    // den første under "enemy". Ikke alle baner har en fjende: tjek om nøglen findes,
    // og lad enemy være null, hvis den ikke gør.
    // Hint: JSONObject har metoden hasKey(). Enemy's konstruktør skal have position, minX og maxX.

    enemy = null;
    if (json.hasKey("enemy")) {
      JSONObject e =json.getJSONArray("enemy").getJSONObject(0);
      PVector pos = new PVector(e.getFloat("x"), e.getFloat("y"));
      enemy = new Enemy(pos, e.getFloat("minX"), e.getFloat("maxX"));
    }

    // platforme
    // OPGAVE 19: Læs alle platforme fra json-filen (nøglen hedder "platform") og tilføj dem til
    // listen platforms. Hver platform er 80 bred, 15 høj og står stille.
    // Hint: åbn level1.json og se hvordan en platform ser ud.
    /*JSONArray platformArray = json.getJSONArray("platform");
     for (int i = 0; i < platformArray.size(); i++) {
     JSONObject p = platformArray.getJSONObject(i);
     PVector pos = new PVector(p.getFloat("x"), p.getFloat("y"));
     platforms.add(new Platform(pos, 80, 15, new PVector(0, 0)));
     
     }*/
    JSONArray platformArray = json.getJSONArray("platform");
    for (int i = 0; i < platformArray.size(); i++) {
      JSONObject p = platformArray.getJSONObject(i);
      PVector pos = new PVector(p.getFloat("x"), p.getFloat("y"));
      String type = p.getString("type", "");

      if (type.equals("moving")) {
        PVector v = new PVector(0, 0);
        float minX = pos.x, maxX = pos.x;
        float minY = pos.y, maxY = pos.y;

        if (p.hasKey("minX")) {
          minX = p.getFloat("minX");
          maxX = p.getFloat("maxX");
          v.x = 1.5;
        }
        if (p.hasKey("minY")) {
          minY = p.getFloat("minY");
          maxY = p.getFloat("maxY");
          v.y = 1.5;
        }
        platforms.add(new MovingPlatform(pos, 80, 15, v, minX, maxX, minY, maxY));
      } else {
        platforms.add(new Platform(pos, 80, 15, new PVector(0, 0)));
      }
    }

    // pickups (coin, key, battery)
    JSONArray pickupArray = json.getJSONArray("pickup");
    for (int i = 0; i < pickupArray.size(); i++) {
      JSONObject p = pickupArray.getJSONObject(i);
      PVector pos = new PVector(p.getFloat("x"), p.getFloat("y"));
      String type = p.getString("type");

      if (type.equals("coin")) {
        pickUps.add(new Coin(pos));
      } else if (type.equals("key")) {
        pickUps.add(new Key(pos));
      } else if (type.equals("battery")) {
        pickUps.add(new Battery(pos));
      } else {
        println("Error reading json");
      }
    }
  }


  void display() {
    // jorden
    noStroke();
    fill(90, 60, 40);
    rect(ground.x, ground.y, width, height - ground.y);

    // tegner alle platform
    for (Platform p : platforms) p.drawPlatform();

    // tegner alle pickups
    for (Pickup pu : pickUps) {
      pu.display();
    };

    // døren
    door.drawDoor();

    // fjenden
    if (enemy != null) enemy.drawEnemy();
    /*
    // spawn-punkt (kun til test)
     fill(0, 200, 255);
     ellipse(spawn.x, spawn.y, 10, 10);
     */
  }


  // hjælpefunktion: læser x og y fra første objekt i et array
  PVector readPoint(String key) {
    JSONObject o = json.getJSONArray(key).getJSONObject(0);
    return new PVector(o.getFloat("x"), o.getFloat("y"));
  }

  // til player start pos
  PVector getSpawnPosition() {
    return spawn;
  }


  /*
    JSONArray platform = json.getJSONArray("platform");
   
   for (int i = 0; i < values.size(); i++) {
   
   JSONObject platform = values.getJSONObject(i);
   
   int x = platform.getInt("x");
   int y = platform.getInt("y");
   int type = platform.getInt("type");
   
   println(x + ", " + y + ", " + type);
   }
   }
   */
}
