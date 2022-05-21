class Player
{
  int hp, speed, MaxHP;
  float chargeReload;
  PImage imagePath = loadImage("img/fighter.png");
  boolean BulletStatus, chargeShooting = false, chargeReady = false;
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
    this.chargeReload = 0.0;
  }

  //void move()
  int[] Move(boolean MoveL, boolean MoveR, boolean MoveU, boolean MoveD)
  {
    // moving
    if (MoveL) this.PlayerAxis[0] -= this.speed;
    if (MoveR) this.PlayerAxis[0] += this.speed;
    if (MoveU) this.PlayerAxis[1] -= this.speed;
    if (MoveD) this.PlayerAxis[1] += this.speed;

    //Judgment out of bounds
    if (this.PlayerAxis[0] + 51 > width) this.PlayerAxis[0] = width - 51;
    if (this.PlayerAxis[0] < 0) this.PlayerAxis[0] = 0;
    if (this.PlayerAxis[1] + 51 > height) this.PlayerAxis[1] = height - 51;
    if (this.PlayerAxis[1] < 0) this.PlayerAxis[1] = 0;

    Update();
    return PlayerAxis;
  }

  void Update()
  {
    image(imagePath, this.PlayerAxis[0], this.PlayerAxis[1]);
    AtkMove();

    //charge bullet reload
    if (chargeReload < 1 && !chargeShooting)
      ChargeBulletReloader(180);
    else if (chargeReload >=1 && !chargeReady)
    {
      se_chargeReady.play(1, 0.6);
      chargeReady = true;
    } else if (chargeShooting)
      chargeAtk();
  }

  void GetTreasure() {
    se_item.play(1, 0.3);
    ChangeHp(20);
    if (chargeReload < 1);
    chargeReload += 0.1;
  }

  void Atk() {
    if (this.bullets.size() < 5) {
      this.bullets.add(new Bullet(3, this.PlayerAxis[0], this.PlayerAxis[1] + 25, 255, 0, 0));
      se_shoot02.play(1, 0.3);
    }
  }

  void ChargeBulletReloader(int time)
  {
    chargeReload += 0.1 / time;
  }

  void showChargeAtk()
  {
    fill(102, 255, 255, 30);
    rect(0, this.PlayerAxis[1]-10, this.PlayerAxis[0], 71);
    fill(102, 204, 255, 60);
    rect(0, this.PlayerAxis[1]-5, this.PlayerAxis[0], 61);
    fill(0, 200, 230);
    rect(0, this.PlayerAxis[1], this.PlayerAxis[0], 51);
    fill(204, 255, 255);
    rect(0, this.PlayerAxis[1]+10, this.PlayerAxis[0], 30);
  }

  void chargeAtk()
  {
    if (chargeReload > 0)
    {
      showChargeAtk();
      ChargeBulletReloader(-10);
    } else
    {
      chargeShooting = false;
      chargeReady = false;
      se_chagerbullet.stop();
    }
  }

  void AtkMove() {
    for (int j=0; j<bullets.size(); j++) {
      BulletStatus = this.bullets.get(j).Move();
      this.bullets.get(j).Update();
      if (!BulletStatus) this.bullets.remove(j);
    }
  }

  boolean AtkCollisionDetection(int EnemyAxis[], int w, int h) {
    for (int j=0; j<bullets.size(); j++) {
      BulletEnemyStatus = this.bullets.get(j).CollisionDetection(EnemyAxis, w, h);
      if (BulletEnemyStatus) {
        bullets.remove(j);
        return true;
      }
    }
    return false;
  }

  boolean CollisionDetection(int EnemyAxis[], int w, int h) {
    if (PlayerAxis[0] < EnemyAxis[0] + w && PlayerAxis[0] + 51 > EnemyAxis[0] && PlayerAxis[1] < EnemyAxis[1] + h && PlayerAxis[1] + 51 > EnemyAxis[1]) {
      ChangeHp(-20);
      return true;
    } else {
      return false;
    }
  }

  void ChangeHp(int change) {
    this.hp += change;
    if (hp > MaxHP)
      hp = MaxHP;
  }
  /*
  void BulletsToLed(int bullets_size){
    for(int i=0; i<bullets_size; i++){
      arduino.digitalWrite(9 + i, Arduino.HIGH);
    }
    
    for(int i=3; i>bullets_size; i--){
      arduino.digitalWrite(9 + i, Arduino.LOW);
    }
  }
  */
}
