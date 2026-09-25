//johan (og kristoffer)

class Pickup {
  PVector position;
  boolean pickedUp;
  
  int collectedCoin = 0;
  int collectedKey = 0;
  int collectedBattery = 0;
  
  
  Pickup(PVector pos) {
    position = pos.copy();
  }
}
