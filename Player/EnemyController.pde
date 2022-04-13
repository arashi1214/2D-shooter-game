class Enemy
{
  int speed;
  int EnemyAxis[] = new int[2];
  PImage imagePath = loadImage("img/enemy.png");
  //Init
  Enemy()
  {
    this.speed = floor(random(2,8));
    this.EnemyAxis[0] = -61;
    this.EnemyAxis[1] = floor(random(61, height - 61));
  }

  //void move()
  int[] Move(int PlayerAxis[]) 
  {
    if(this.EnemyAxis[0] < 800){
      this.EnemyAxis[0] += this.speed;
      if(this.EnemyAxis[1] < PlayerAxis[1]) this.EnemyAxis[1] += 1;
      else if(this.EnemyAxis[1] > PlayerAxis[1]) this.EnemyAxis[1] -= 1;
    }
    else{
      Remake();
    }
    return this.EnemyAxis;
  }
  
  void Update()
  {
    image(imagePath, this.EnemyAxis[0], this.EnemyAxis[1]);
  }
  
  void Remake(){
      this.speed = floor(random(2,8));
      this.EnemyAxis[0] = -61;
      this.EnemyAxis[1] = floor(random(61, height - 61));
  }
}
