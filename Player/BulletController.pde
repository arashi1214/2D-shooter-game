class Bullet
{
  int speed, x, y;
  int r, g, b;

  //Init
  Bullet(int Speed, int X, int Y, int R, int G, int B)
  {
    this.speed = Speed;
    this.x = X;
    this.y = Y;
    this.r = R;
    this.g = G;
    this.b = B;
  }

  //void move()
  boolean Move() 
  {
    if(this.x < 800 && this.x > -20){
      this.x -= this.speed;
      return true;
    }
    return false;
  }
  
  void Update()
  {
    fill(this.r,this.g,this.b);
    rect(this.x, this.y, 20, 10);
  }
  
  boolean CollisionDetection(int[] Axis){
    if(this.x < Axis[0] + 61 && this.x + 51 > Axis[0] && this.y < Axis[1] + 61 && this.y + 51 > Axis[1]){
      return true;
    }
    else{
      return false;
    }
  }
}
