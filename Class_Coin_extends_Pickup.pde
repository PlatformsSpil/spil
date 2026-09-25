class Coin extends Pickup {
  
  
 
  Coin(PVector pos) {
    super(pos);
    
  }

  
  void drawcoin() {
    circle(position.x, position.y, 20);
  }
}
