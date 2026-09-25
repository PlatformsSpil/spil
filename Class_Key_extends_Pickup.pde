class Key extends Pickup {

  Key(PVector pos) {
    super(pos);
    
  }

  void drawkey() {
    circle(position.x, position.y, 20);
  }
}
