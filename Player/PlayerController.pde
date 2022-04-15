class Player
{
  int hp, speed, MaxHP;
  PImage imagePath = loadImage("img/fighter.png");
  boolean BulletStatus;
  // 0=x, 1=y
  int PlayerAxis[] = new int[2];
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  
  //Init
  Player(int maxHP, int Speed, int X, int Y)
  {
    this.MaxHP = maxHP;
    this.hp = MaxHP;
    this.speed = Speed;
    this.PlayerAxis[0] = X;
    this.PlayerAxis[1] = Y;
  }

  //void move()
  int[] Move(boolean MoveL, boolean MoveR, boolean MoveU, boolean MoveD) 
  {
    // moving
    if(MoveL) this.PlayerAxis[0] -= this.speed;
    if(MoveR) this.PlayerAxis[0] += this.speed;
    if(MoveU) this.PlayerAxis[1] -= this.speed;
    if(MoveD) this.PlayerAxis[1] += this.speed;
    
    //Judgment out of bounds
    if(this.PlayerAxis[0] + 51 > width) this.PlayerAxis[0] = width - 51;
    if(this.PlayerAxis[0] < 0) this.PlayerAxis[0] = 0;
    if(this.PlayerAxis[1] + 51 > height) this.PlayerAxis[1] = height - 51;
    if(this.PlayerAxis[1] < 0) this.PlayerAxis[1] = 0;
    
    Update();
    return PlayerAxis;
  }
  
  void Update()
  {
    image(imagePath, this.PlayerAxis[0], this.PlayerAxis[1]);
    AtkMove();
  }
  
  void GetTreasure(){
    ChangeHp(20);
  }
  
  void Atk(){
    if(this.bullets.size() < 5){
        this.bullets.add(new Bullet(3, this.PlayerAxis[0], this.PlayerAxis[1] + 25, 255, 0, 0));
    }
  }
  
  void AtkMove(){
    for(int j=0; j<bullets.size(); j++){
      BulletStatus = this.bullets.get(j).Move();
      this.bullets.get(j).Update();
      if(!BulletStatus) this.bullets.remove(j);
    }
  }
  
  boolean AtkCollisionDetection(int EnemyAxis[], int w, int h){
    for(int j=0; j<bullets.size(); j++){
        BulletEnemyStatus = this.bullets.get(j).CollisionDetection(EnemyAxis, w, h);
        if(BulletEnemyStatus){
          bullets.remove(j);
          return true;
        }
    }
    return false;
  }
  
  boolean CollisionDetection(int EnemyAxis[], int w, int h){
    if(PlayerAxis[0] < EnemyAxis[0] + w && PlayerAxis[0] + 51 > EnemyAxis[0] && PlayerAxis[1] < EnemyAxis[1] + h && PlayerAxis[1] + 51 > EnemyAxis[1]){
      ChangeHp(-20);
      return true;
    }
    else{
      return false;
    }
  }
  
  void ChangeHp(int change){
    this.hp += change;
    if (hp > MaxHP)
      hp = MaxHP;
  }
  
}
