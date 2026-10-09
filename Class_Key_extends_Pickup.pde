//kristoffer (og johan)

class Key extends Pickup {


  Key(PVector pos) {
    super(pos);
    img = loadImage("Key.png");
    id = "key";
  }
  void.collect(player p) {
    p.keys++;
  }
  // OPGAVE 10: Pickup har en tom metode collect(Player p). Overskriv den her, så spilleren
  // får én nøgle mere, når nøglen samles op.
  // Spørgsmål: spil.pde kalder bare pu.collect(player) - hvordan ved Processing om det
  // er Coin, Key eller Battery's collect der skal køres?
}
