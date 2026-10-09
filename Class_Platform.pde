//Lasse og Mikkel

class Platform {
  PVector position;
  float platformWidth;
  float height;
  PVector velocity;

  Platform(PVector pos, float w, float h, PVector v) {
    // OPGAVE 13: Gem parametrene i klassens variabler. Brug copy() på de to PVector'er.
    // Spørgsmål: hvad kunne gå galt, hvis man skrev position = pos; uden copy()?
    position = pos.copy();
    platformWidth = w;
    height = h;
    velocity = v.copy();
  }

  void drawPlatform() {
    fill(0);
    rect(position.x, position.y, platformWidth, height);
  }

  PVector getPosition() {
    return position;
  }

  float getplatformWidth() {
    return platformWidth;
  }

  float getHeight() {
    return height;
  }

  PVector getVelocity() {
    return velocity;
  }
}
