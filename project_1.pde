PImage player, BG;
int speed = 5;
int PlayerX;
int PlayerY;

void setup(){
  size(800,600);
  player = loadImage("./img/player.png");
  BG = loadImage("./img/BG.jpg");
  
  PlayerX = 30;
  PlayerY = 30;
}

void draw(){
  image(BG, 0,0,800,600);
  image(player, PlayerX, PlayerY, 128, 128);
}


void keyPressed(){
   if(keyCode == DOWN) PlayerY += speed;
   else if(keyCode == UP) PlayerY -= speed;
   if(keyCode == LEFT) PlayerX -= speed;
   else if(keyCode == RIGHT) PlayerX += speed;
}

void keyReleased()
{

}
