class Bullet
{
  int speed, x, y;

  //Init
  Bullet(int Speed, int X, int Y)
  {
    this.speed = Speed;
    this.x = X;
    this.y = Y;
  }

  //void move()
  void Move() 
  {
    // moving

  }
  
  void Update()
  {
    fill(255,0,0);
    rect(this.x, this.y, 20, 10);
  }
}
