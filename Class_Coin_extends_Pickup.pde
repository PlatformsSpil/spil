//kristoffer (og johan)

class Coin extends Pickup {
  Coin(PVector pos) {
    super(pos);
    img = loadImage("Coin.png");
    id = "coin";
  }
}

// OPGAVE 9: Skriv konstruktøren til Coin. Den får en position (PVector) med.
// Den skal kalde Pickup's konstruktør, sætte id til "coin" og indlæse billedet Coin.png.
// Hint: superklassens konstruktør kaldes med super(...), og det skal være det første i konstruktøren.

void collect(Player p) {
  p.coins++;
}
