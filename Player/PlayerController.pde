class Player
{
  int hp, speed;
  PImage imagePath = loadImage("img/fighter.png");
  // 0=x, 1=y
  int PlayerAxis[] = new int[2];
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  
  //Init
  Player(int HP, int Speed, int X, int Y)
  {
    this.hp = HP;
    this.speed = Speed;
    this.PlayerAxis[0] = X;
    this.PlayerAxis[1] = Y;
  }

  //void move()
  int[] Move(boolean MoveL, boolean MoveR, boolean MoveU, boolean MoveD, int ScenesX, int ScenesY) 
  {
    // moving
    if(MoveL) this.PlayerAxis[0] -= this.speed;
    if(MoveR) this.PlayerAxis[0] += this.speed;
    if(MoveU) this.PlayerAxis[1] -= this.speed;
    if(MoveD) this.PlayerAxis[1] += this.speed;
    
    //Judgment out of bounds
    if(this.PlayerAxis[0] + 51 > ScenesX) this.PlayerAxis[0] = ScenesX - 51;
    if(this.PlayerAxis[0] < 0) this.PlayerAxis[0] = 0;
    if(this.PlayerAxis[1] + 51 > ScenesY) this.PlayerAxis[1] = ScenesY - 51;
    if(this.PlayerAxis[1] < 0) this.PlayerAxis[1] = 0;
    
    return PlayerAxis;
  }
  
  void Update()
  {
    image(imagePath, this.PlayerAxis[0], this.PlayerAxis[1]);
  }
  
  void GetTreasure(){
    this.hp += 20;
  }
  
  void Act(){
    if(this.bullets.size() < 5){
        this.bullets.add(new Bullet(3, this.PlayerAxis[0], this.PlayerAxis[1] + 25));
    }
  }
  
  void ActMove(){
    for(int j=0; j<bullets.size(); j++){
      BulletStatus = this.bullets.get(j).Move();
      this.bullets.get(j).Update();
      if(!BulletStatus) this.bullets.remove(j);
    }
  }
  
  boolean ActCollisionDetection(int EnemyAxis[]){
    for(int j=0; j<bullets.size(); j++){
        BulletEnemyStatus = this.bullets.get(j).CollisionDetection(EnemyAxis);
        if(BulletEnemyStatus){
          bullets.remove(j);
          return true;
        }
    }
    return false;
  }
  
  boolean CollisionDetection(int[] EnemyAxis){
    if(PlayerAxis[0] < EnemyAxis[0] + 61 && PlayerAxis[0] + 51 > EnemyAxis[0] && PlayerAxis[1] < EnemyAxis[1] + 61 && PlayerAxis[1] + 51 > EnemyAxis[1]){
      this.hp -= 20;  
      return true;
    }
    else{
      return false;
    }
  }
  
}
