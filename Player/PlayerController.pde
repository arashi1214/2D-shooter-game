class Player
{
  int hp, speed, x, y;
  PImage imagePath = loadImage("img/fighter.png");

  //Init
  Player(int HP, int Speed, int X, int Y)
  {
    this.hp = HP;
    this.speed = Speed;
    this.x = X;
    this.y = Y;
  }

  

  //void move()
  void move() 
  {
    
  }
  
  void update()
  {
    image(imagePath, playerPositionX, playerPositionY, 128, 128);
  }
}
