//kristoffer (og johan)

class Coin extends Pickup {
  Coin(PVector pos) {
    super(pos);
    img = loadImage("Coin.png");
    id = "coin";
  }

  void collect(Player p) {
    p.coins++;
  }
}
