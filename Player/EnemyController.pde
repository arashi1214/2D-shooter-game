class Enemy
{
  int speed;
  int EnemyAxis[] = new int[2];
  boolean status;
  PImage imagePath = loadImage("img/enemy.png");

  //Init
  Enemy(boolean status)
  {
    this.speed = floor(random(2,8));
    this.EnemyAxis[0] = -61;
    this.EnemyAxis[1] = floor(random(61,539));
    this.status = status;
  }

  //void move()
  int[] Move(boolean playerStatus, boolean bulletStatus) 
  {
    if(status){
      if(playerStatus || bulletStatus){
        Remake();
      }
      if(this.EnemyAxis[0] < 800) this.EnemyAxis[0] += this.speed;
      else{
        Remake();
      }
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
      this.EnemyAxis[1] = floor(random(61,539));
  }
  
  void ChangeStatus(boolean status){
    this.status = status;
  }
}
