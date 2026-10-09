// MovingPlatform arver fra Platform
class MovingPlatform extends Platform {

  // Bestemmer hvor højt platformen mindst må være
  float minY;

  // Bestemmer hvor langt ned platformen må være
  float maxY;

  // Konstruktør til den bevægelige platform
  MovingPlatform(PVector pos, float w, float h, PVector v, float minY, float maxY) {

    // Bruger konstruktøren fra Platform-klassen
    super(pos, w, h, v);

    // Gemmer minimums- og maksimumshøjden
    this.minY = minY;
    this.maxY = maxY;
  }

  // Opdaterer platformens position
  void update() {
    // Flytter platformen op eller ned
    position.y += velocity.y;

    // Tjekker om platformen har nået en af grænserne
    if (position.y <= minY || position.y >= maxY) {

      // Vender platformens retning
      velocity.y *= -1;
    }
  }
