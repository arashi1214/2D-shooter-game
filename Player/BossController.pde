class Boss
{
  int speed, HP, mode;
  int BossAxis[] = new int[2];
  boolean status = true; //true: up false: down
  PImage imagePath = loadImage("img/Moocs-element-enemy1.png");
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  
  //Init
  Boss()
  {
    this.HP = 50;
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
    
      if(BossAxis[1] < 0 || BossAxis[1] > height) this.status = !this.status;
    }
    return this.BossAxis;
  }
  
  void Act(int time){
    this.mode = floor(random(1,2));
    if(this.bullets.size() == 0 && time % 5000 > 4980){
      switch(mode){
        case 1:
          this.bullets.add(new Bullet(-3, this.BossAxis[0], this.BossAxis[1] + 30));
          break;
        case 2:
          this.bullets.add(new Bullet(-3, this.BossAxis[0], this.BossAxis[1]));
          this.bullets.add(new Bullet(-3, this.BossAxis[0], this.BossAxis[1] + 60));
          break;
      }
    }
    ActMove();
  }
  
  void ActMove(){
   for(int j=0; j<this.bullets.size(); j++){
      this.bullets.get(j).Move();
      this.bullets.get(j).Update();
    }
  }
  
  void Update()
  {
    image(imagePath, this.BossAxis[0], this.BossAxis[1]);
  }
}
