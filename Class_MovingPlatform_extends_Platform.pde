// MovingPlatform arver fra Platform
class MovingPlatform extends Platform {

  // Bestemmer hvor højt og lavt platformen må være
  float minY, maxY;

  // Bestemmer hvor langt til venstre og højre platformen må være
  float minX, maxX;
 
  // Konstruktør til den bevægelige platform
  MovingPlatform(PVector pos, float w, float h, PVector v, float minX, float maxX, float minY, float maxY) {

    // Bruger konstruktøren fra Platform-klassen
    super(pos, w, h, v);

    // Gemmer minimums- og maksimums placeringer
    this.minX = minX;
    this.maxX = maxX;
    this.minY = minY;
    this.maxY = maxY;
  }

  // Opdaterer platformens position
  void update() {
    /*// Flytter platformen op eller ned
    position.y += velocity.y;

    // Tjekker om platformen har nået en af grænserne
    if (position.y <= minY || position.y >= maxY) {

      // Vender platformens retning
      velocity.y *= -1;
    }*/
    position.add(velocity);

    // vend om ved grænserne
    if (position.x >= maxX) velocity.x = -abs(velocity.x);
    if (position.x <= minX) velocity.x = abs(velocity.x);
    if (position.y >= maxY) velocity.y = -abs(velocity.y);
    if (position.y <= minY) velocity.y = abs(velocity.y);
  }
}
