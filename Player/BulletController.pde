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
  boolean Move() 
  {
    if(this.x < 800){
      this.x -= this.speed;
      return true;
    }
    return false;
  }
  
  void Update()
  {
    fill(255,0,0);
    rect(this.x, this.y, 20, 10);
  }
  
  boolean CollisionDetection(int[][] EnemyAxis){
    if(this.x < EnemyAxis[0][0] + 61 && this.x + 51 > EnemyAxis[0][0] && this.y < EnemyAxis[0][1] + 61 && this.y + 51 > EnemyAxis[0][1]){
      return true;
    }
    else{
      return false;
    }
  }
}
