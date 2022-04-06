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
  void Move(boolean MoveL, boolean MoveR, boolean MoveU, boolean MoveD, int ScenesX, int ScenesY) 
  {
    // moving
    if(MoveL) this.x -= this.speed;
    if(MoveR) this.x += this.speed;
    if(MoveU) this.y -= this.speed;
    if(MoveD) this.y += this.speed;
    
    //Judgment out of bounds
    if(this.x + 64 > ScenesX) this.x = ScenesX - 64;
    if(this.x < 0) this.x = 0;
    if(this.y + 64 > ScenesY) this.y = ScenesY - 64;
    if(this.y < 0) this.y = 0;
  }
  
  void Update()
  {
    image(imagePath, this.x, this.y, 64, 64);
  }
}
