GameMaster gm;

// Keyboard input tracking
boolean keyLeft = false;
boolean keyRight = false;

// Runs once on startup
void setup() {
  gm=new GameMaster();
  // Defines size of window
  size(800, 600);
}

// Draw loops infinitely
void draw() {
  // Sets background color
  background(150);
  // Runs player class
  player();
}

// Called automatically by Processing when a key is pressed
void keyPressed() {
  if (key == 'a' || key == 'A' || keyCode == LEFT) {
    keyLeft = true;
  }
  if (key == 'd' || key == 'D' || keyCode == RIGHT) {
    keyRight = true;
  }

/*

  // Jump action (only allowed if the player is touching the ground!)
  if ((key == 'w' || key == 'W' || key == ' ' || keyCode == UP) && isOnGround) {
    player.velocity.y = jumpForce; // Set vertical velocity to a strong upward (negative Y) value
    isOnGround = false;
  }
  */
}

// Called automatically by Processing when a key is released
void keyReleased() {
  if (key == 'a' || key == 'A' || keyCode == LEFT) {
    keyLeft = false;
  }
  if (key == 'd' || key == 'D' || keyCode == RIGHT) {
    keyRight = false;
  }
}

void player() {
}
