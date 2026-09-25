//Lasse og Mikkel

class Platform {
  PVector position;
  float width;
  float height;
  PVector velocity;

  Platform(PVector pos, float w, float h, PVector v) {
    position = pos.copy();
    height=h;
    width=w;
    velocity=v.copy();
  }

  void drawPlatform() {
    fill(0);
    rect(position.x, position.y, width, height);
  }
  
  PVector getPosition(){
  return position;
  }
  
  float getWidth(){
  return width;
  }
  
  float getHeight(){
  return height;
  }
  
  PVector getVelocity(){
  return velocity;
  }
  
  boolean collision(Player player) {
if (player.position.x >= position.x-player.size/2 && player.position.x <= position.x+width+player.size/2 &&
player.position.y+player.size/2 >= position.y && player.position.y+player.size/2 <= position.y+player.size/2 && player.velocity.y >= 0) {
}
