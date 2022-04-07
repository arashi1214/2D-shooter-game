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
    this.EnemyAxis[1] = floor(random(61,539));
  }

  //void move()
  int[] Move() 
  {
    if(this.EnemyAxis[0] < 800) this.EnemyAxis[0] += this.speed;
    else{
      this.speed = floor(random(2,8));
      this.EnemyAxis[0] = 0;
      this.EnemyAxis[1] = floor(random(61,539));
    }
    return this.EnemyAxis;
  }
  
  void Update()
  {
    image(imagePath, this.EnemyAxis[0], this.EnemyAxis[1]);
  }
}
