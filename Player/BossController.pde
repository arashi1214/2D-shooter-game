class Boss
{
  int speed, hp, mode;
  int BossAxis[] = new int[2];
  boolean status = true; //true: up false: down
  boolean BulletStatus;
  boolean LongBulletStatus;
  PImage imagePath = loadImage("img/Moocs-element-enemy1.png");
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  ArrayList<LongBullet> longbullets = new ArrayList<LongBullet>();
  
  //Init
  Boss()
  {
    this.hp = 50;
    this.speed = floor(random(2,5));
    this.BossAxis[0] = -61;
    this.BossAxis[1] = width / 2;
  }

  //void move()
  int[] Move() 
  {
    if(this.BossAxis[0] < 50){
      this.BossAxis[0] += this.speed;
    }
    else{
      if(this.status) this.BossAxis[1] -= this.speed;
      else this.BossAxis[1] += this.speed;
    
      if(BossAxis[1] < 0 || BossAxis[1] > height - 80) this.status = !this.status;
    }
    Update();
    return this.BossAxis;
  }
  
  void Atk(int time){
    if(this.bullets.size() == 0 && time % 150 == 0){
      this.mode = floor(random(1,4));
      switch(mode){
        case 1:
          this.bullets.add(new Bullet(-3, this.BossAxis[0], this.BossAxis[1] + 30, 0, 255, 0));
          break;
        case 2:
          this.bullets.add(new Bullet(-3, this.BossAxis[0], this.BossAxis[1], 0, 255, 0));
          this.bullets.add(new Bullet(-3, this.BossAxis[0], this.BossAxis[1] + 80, 0, 255, 0));
          break;
        case 3:
          if(this.longbullets.size() == 0)
            this.longbullets.add(new LongBullet(-10, this.BossAxis[0], this.BossAxis[1] + 60, 0, 255, 0));
          break;
      }
    }
    AtkMove();
  }
  
  void AtkMove(){
    for(int j=0; j<this.bullets.size(); j++){
      BulletStatus = this.bullets.get(j).Move();
      this.bullets.get(j).Update();
      if(!BulletStatus) this.bullets.remove(j);
    }
    
    for(int k=0; k<this.longbullets.size(); k++){
      LongBulletStatus = this.longbullets.get(k).Move();
      this.longbullets.get(k).Update();
      if(!LongBulletStatus) this.longbullets.remove(k);
    }
  }
  
  boolean AtkCollisionDetection(int PlayerAxis[]){
    for(int j=0; j<bullets.size(); j++){
        if(this.bullets.get(j).CollisionDetection(PlayerAxis, 51, 51)){
          bullets.remove(j);
          return true;
        }
    }
    
    for(int k=0; k<this.longbullets.size(); k++){
        if(this.longbullets.get(k).CollisionDetection(PlayerAxis, 51, 51)){
          longbullets.remove(k);
          return true;
        }
    }
    return false;
  } 
  
  void ChangeHp(int change){
    this.hp += change;
  }
  
  void Update()
  {
    image(imagePath, this.BossAxis[0], this.BossAxis[1], 61, 120);
    Atk(frameCount)); 
  }
}
