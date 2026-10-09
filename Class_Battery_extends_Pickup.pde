//kristoffer (og johan)

// OPGAVE 11: Et batteri er en slags Pickup. Ret linjen nedenfor, så Battery arver fra Pickup.
// Spørgsmål: Hvilke variabler og metoder får Battery forærende ved at arve?
class Battery extends Pickup {
  float w; // brug hele ord i stedet for bogstaver! width og height er reserveret i systemet, så det skal hedde noget andet - det gør det nemmere at læse!
  float h;


  Battery(PVector pos) {
    super(pos);
    w = 50;
    h = 20;
    img = loadImage("Battery.png");
    id = "battery";
  }


  void collect(Player p) {
    p.energi = p.energi+25;
    // OPGAVE 12: Når spilleren samler et batteri op, skal han have 25 mere energi.
    // Hint: kig i Class_Player efter en set-metode til energi - hvad gør den præcist?
  }
}
