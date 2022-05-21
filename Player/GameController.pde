//Self Define Class
Title title;
Game game;
End end;
Player player;
Treasure treasures;

//Audio
import processing.sound.*;
SoundFile bgm_Title;
SoundFile bgm_Game;
SoundFile bgm_End;
SoundFile se_ButtonClick;
SoundFile se_chagerbullet;
SoundFile se_item;
SoundFile se_shoot01;
SoundFile se_shoot02;
SoundFile se_shoot03;
SoundFile se_chargeReady;

//Other
int gameStatus = 0;
int EnemyAxis[][] = new int[5][2];
int PlayerAxis[] = new int[2];
int BossAxis[] = new int[2];
int BossRe, EnemyRe;
float time;
boolean MoveL = false, MoveU = false, MoveR = false, MoveD = false;
boolean PlayerEnemyStatus = false, PlayerBossStatus = false, BulletEnemyStatus = false, BulletBossStatus = false, BulletPlayerStatus = false;
boolean PlayerCollisionStatus = false;
ArrayList<Enemy> enemys = new ArrayList<Enemy>();
ArrayList<Boss> boss = new ArrayList<Boss>();

//arduino
import processing.serial.*;
import cc.arduino.*;
Serial myPort = new Serial(this, Serial.list()[0], 9600);
Arduino arduino;

int inByte;

//[Main Region]
void setup() {
  //Canvus Setting
  //size(800, 600);
  size(641, 482);
  frameRate(60);

  //Class instantiate
  title = new Title();
  game = new Game();
  end = new End();
  treasures = new Treasure(floor(random(50, width - 50)), floor(random(50, height - 50)));
  // create all enemys
  enemys.add(new Enemy());
  EnemyRe = floor(random(60, 180));
  BossRe = floor(random(480, 600));

  // BGM
  bgm_Title = new SoundFile(this, "audio/Adventure_time.mp3");
  bgm_Game = new SoundFile(this, "audio/Fight_in_the_outer_space.mp3");
  bgm_End = new SoundFile(this, "audio/fail.mp3");
  
  // SE
  se_ButtonClick = new SoundFile(this, "audio/se3.wav");
  se_chagerbullet = new SoundFile(this, "audio/elevator01.mp3");
  se_item = new SoundFile(this, "audio/item.mp3");
  se_shoot01 = new SoundFile(this, "audio/shoot01.mp3");
  se_shoot02 = new SoundFile(this, "audio/shoot02.mp3");
  se_shoot03 = new SoundFile(this, "audio/shoot03.mp3");
  se_chargeReady = new SoundFile(this, "audio/chargeReady.mp3");

  //SET connect port and arduino
  //arduino = new Arduino(this, Arduino.list()[0], 57600);
  //for(int i=9; i<=13; i++) arduino.pinMode(i, Arduino.OUTPUT);
}

void draw() {   
  switch(gameStatus)
  {
  case 0: // Title
    gameStatus = title.Update();

    //BGM
    if (!bgm_Title.isPlaying())
    {
      bgm_End.stop();
      bgm_Game.stop();
      bgm_Title.loop(1, 0.3);
    }
    // init game
    player = new Player(100, 5, width/2, height/2);
    enemys.clear();
    boss.clear();
    game.Score = 0;

    break;


  case 1:// Game
    //read port
    while (myPort.available() > 0) {
      ArduinoInput();
     }
       
  
    // Updata Scence
    gameStatus = game.Update();

    //BGM
    if (!bgm_Game.isPlaying())
    {
      bgm_Title.stop();
      bgm_End.stop();
      bgm_Game.loop(1, 0.3);
    }

    //player moving
    PlayerAxis = player.Move(MoveL, MoveR, MoveU, MoveD);

    treasures.Update();

    // treasures collision detection
    if (treasures.CollisionDetection(PlayerAxis, player)) treasures = new Treasure(floor(random(50, width - 50)), floor(random(50, height - 50)));

    for (int i=0; i<enemys.size(); i++) {
      // enemys moving
      EnemyAxis[i] = enemys.get(i).Move(PlayerAxis);

      // enemys collision detection
      if (!PlayerCollisionStatus) {
        PlayerEnemyStatus = player.CollisionDetection(EnemyAxis[i], 61, 61);
        if (PlayerEnemyStatus)
          PlayerCollisionStatus = true;
      }

      //charge atk dectet
      if (player.chargeShooting)
      {
        if (EnemyAxis[i][0] < PlayerAxis[1] && EnemyAxis[i][1] <= PlayerAxis[1]+51 && EnemyAxis[i][1] >= PlayerAxis[1] ||
          EnemyAxis[i][0] < PlayerAxis[1] && EnemyAxis[i][1] +61 <= PlayerAxis[1]+51 && EnemyAxis[i][1] +61 >= PlayerAxis[1])
        {
          game.ScoreUpdate(20);
          EnemyRe = floor(random(60, 180));
          enemys.remove(i);
        }
      }

      BulletEnemyStatus = player.AtkCollisionDetection(EnemyAxis[i], 61, 61);

      if (PlayerEnemyStatus || BulletEnemyStatus)
      {
        if (BulletEnemyStatus)
          game.ScoreUpdate(20);
        EnemyRe = floor(random(60, 180));
        enemys.remove(i);
      }
    }

    for (int j=0; j<boss.size(); j++) {
      // boss moving
      BossAxis = boss.get(j).Move();

      // boss collision detection
      BulletPlayerStatus = boss.get(j).AtkCollisionDetection(PlayerAxis);
      if (BulletPlayerStatus)
        player.ChangeHp(-20);

      //charge bullet atk detect
      if (player.chargeShooting)
      {
        if (BossAxis[0] < PlayerAxis[1] && BossAxis[1] <= PlayerAxis[1]+51 && BossAxis[1] >= PlayerAxis[1] ||
          BossAxis[0] < PlayerAxis[1] && BossAxis[1] +120 <= PlayerAxis[1]+51 && BossAxis[1] + 120 >= PlayerAxis[1])
        {
          boss.get(j).ChangeHp(-100);
        }
      }

      BulletBossStatus = player.AtkCollisionDetection(BossAxis, 61, 120);
      if (BulletBossStatus) boss.get(j).ChangeHp(-10);
      if (boss.get(j).hp <= 0)
      {
        game.ScoreUpdate(100);
        boss.remove(j);
        BossRe = floor(random(480, 600));
      }

      if (!PlayerCollisionStatus) {
        PlayerBossStatus = player.CollisionDetection(BossAxis, 61, 120);
        if (PlayerBossStatus)
          PlayerCollisionStatus = true;
      }
    }

    // add enemy
    time = frameCount;

    if (time % 60 == 0 && PlayerCollisionStatus) {
      PlayerCollisionStatus = false;
    }

    if (time % EnemyRe == 0 && enemys.size() < 5) {
      enemys.add(new Enemy());
    }

    if (time % BossRe == 0 && boss.size() == 0) {
      boss.add(new Boss());
    }

    game.UIDisplay();
    // game over
    if (player.hp <= 0) gameStatus = 2;

    break;

  case 2:// Ending
    end.SetScore(game.Score);
    gameStatus = end.Update();
    //BGM
    if (!bgm_End.isPlaying())
    {
      bgm_Game.stop();
      bgm_Title.stop();
      bgm_End.play(1, 0.5);
    }
  }
}

void ArduinoInput(){
  inByte = myPort.read();
  if(inByte>= 97 && inByte<= 122){
    //println(inByte);
    if(inByte == 'a') MoveL = true;
    if(inByte == 'b') MoveR = true;
    if(inByte == 'c') MoveU = true;
    if(inByte == 'd') MoveD = true;
    if(inByte == 'n'){
      // remake move
      MoveL = false;
      MoveU = false;
      MoveR = false;
      MoveD = false;
    }
    if(inByte == 'k'){
      player.Atk();
    }
    if(inByte == 'z' && player.chargeReload >=1)
    {
      player.chargeShooting = true;
      se_chagerbullet.play();
    }
  }
}



void keyPressed() {
  if (keyCode == DOWN) MoveD = true;
  if (keyCode == UP) MoveU = true;
  if (keyCode == LEFT) MoveL = true;
  if (keyCode == RIGHT) MoveR = true;
  if (keyCode == 32) {
    player.Atk();
  }
  if (keyCode == 'Z' && player.chargeReload >=1)
  {
    player.chargeShooting = true;
    se_chagerbullet.play();
  }
}

/*
void keyReleased() {
  if (keyCode == DOWN) MoveD = false;
  if (keyCode == UP) MoveU = false;
  if (keyCode == LEFT) MoveL = false;
  if (keyCode == RIGHT) MoveR = false;
}
*/
