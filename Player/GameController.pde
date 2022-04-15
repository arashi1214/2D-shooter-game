//[Define Region]
//Images
//PImage playerImg, enemyImg, treasureImg; //props
//PImage hpImg;// HUD
//Class
Title title;
Game game;
End end;
Player player;
Treasure treasures;

//Other
int gameStatus = 0;
int EnemyAxis[][] = new int[5][2];
int PlayerAxis[] = new int[2];
int BossAxis[] = new int[2];
float time;
boolean MoveL = false, MoveU = false, MoveR = false, MoveD = false;
boolean PlayerEnemyStatus = false, BulletEnemyStatus = false, BulletBossStatus = false, BulletPlayerStatus = false;
ArrayList<Enemy> enemys = new ArrayList<Enemy>();
ArrayList<Boss> boss = new ArrayList<Boss>();

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
}
void draw() {
  switch(gameStatus)
  {
  case 0: // Title
    gameStatus = title.Update();

    // init game
    player = new Player(100, 5, width/2, height/2);
    enemys.clear();
    boss.clear();
    game.Score = 0;
    
    break;


  case 1:// Game
    // Updata Scence
    gameStatus = game.Update();

    //player moving
    PlayerAxis = player.Move(MoveL, MoveR, MoveU, MoveD);

    treasures.Update();

    // treasures collision detection
    if (treasures.CollisionDetection(PlayerAxis, player)) treasures = new Treasure(floor(random(50, width - 50)), floor(random(50, height - 50)));

    for (int i=0; i<enemys.size(); i++) {
      // enemys moving
      EnemyAxis[i] = enemys.get(i).Move(PlayerAxis);

      // enemys collision detection
      PlayerEnemyStatus = player.CollisionDetection(EnemyAxis[i], 61, 61);
      BulletEnemyStatus = player.AtkCollisionDetection(EnemyAxis[i], 61, 61);

      if (PlayerEnemyStatus || BulletEnemyStatus)
      {
        if (BulletEnemyStatus)
          game.ScoreUpdate(20);
        enemys.remove(i);
      }
    }

    for (int j=0; j<boss.size(); j++) {
      // boss moving
      BossAxis = boss.get(j).Move();

      // boss collision detection
      BulletPlayerStatus = boss.get(j).AtkCollisionDetection(PlayerAxis);
      if (BulletPlayerStatus) player.ChangeHp(-20);

      BulletBossStatus = player.AtkCollisionDetection(BossAxis, 61, 120);
      if (BulletBossStatus) boss.get(j).ChangeHp(-10);
      if (boss.get(j).hp <= 0)
      {
        game.ScoreUpdate(100);
        boss.remove(j);
      }

      player.CollisionDetection(BossAxis, 61, 120);
    }

    // add enemy
    time = frameCount;

    if (time % 120 == 0 && enemys.size() < 5) {
      enemys.add(new Enemy());
    }

    if (time % 480 == 0 && boss.size() == 0) {
      boss.add(new Boss());
    }

    game.UIDisplay();
    // game over
    if (player.hp <= 0) gameStatus = 2;

    break;

  case 2:// Ending
    end.SetScore(game.Score);
    gameStatus = end.Update();
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
}

void keyReleased() {
  if (keyCode == DOWN) MoveD = false;
  if (keyCode == UP) MoveU = false;
  if (keyCode == LEFT) MoveL = false;
  if (keyCode == RIGHT) MoveR = false;
}
