class LongBullet
{
  int speed, x, y, end_x;
  int r, g, b;

  //Init
  LongBullet(int Speed, int X, int Y, int R, int G, int B)
  {
    this.speed = Speed;
    this.x = X + 60;
    this.end_x = X + 60;
    this.y = Y;
    this.r = R;
    this.g = G;
    this.b = B;
  }

  //void move()
  boolean Move() 
  {
    if(this.end_x < 800){
      this.end_x -= this.speed;
      return true;
    }
    return false;
  }
  
  void Update()
  {
    fill(this.r,this.g,this.b);
    rect(this.x, this.y, end_x, 30);
  }
  
  boolean CollisionDetection(int[] Axis, int w, int h){
    if(this.x < Axis[0] + w && this.x + end_x > Axis[0] && this.y < Axis[1] + h && this.y + 30 > Axis[1]){
      return true;
    }
    else{
      return false;
    }
  }
}
