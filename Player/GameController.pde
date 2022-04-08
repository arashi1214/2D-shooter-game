//[Define Region]
//Images
//PImage playerImg, enemyImg, treasureImg; //props
//PImage hpImg;// HUD
//Class
Title title;
Game game;
End end;
Player player;
Enemy enemy;
Bullet bullets;

//Other
int gameStatus = 0;
boolean MoveL = false, MoveU = false, MoveR = false, MoveD = false;
int EnemyAxis[][] = new int[5][2];
boolean PlayerEnemyStatus = false;
boolean BulletEnemyStatus = false;
int bulletsCount = 0;
boolean Act = false;
int PlayerAxis[] = new int[2];
//ArrayList<Object> Enemys = new ArrayList<Object>();

//[Main Region]
void setup() {
  //Canvus Setting
  size(800, 600);
  
  //Class instantiate
  title = new Title();
  game = new Game();
  end = new End();
  player = new Player(100,5,400,300);
  // create all enemys
  enemy = new Enemy();
  
  /* array list testing
  Enemys.add(new Enemy());
  print(Enemys.get(0).getClass());
  enemy.Update();
  print(enemy == Enemys.get(0));
  */
}
void draw() {

  switch(gameStatus)
  {
  case 0: // Title
    gameStatus = title.Update();
    break;
  
  
  case 1:// Game
    gameStatus = game.Update();
    PlayerAxis = player.Move(MoveL, MoveR, MoveU, MoveD, 800, 600);
    player.Update();
    EnemyAxis[0] = enemy.Move(PlayerEnemyStatus, BulletEnemyStatus);
    enemy.Update();    
    
    PlayerEnemyStatus = player.CollisionDetection(EnemyAxis);
    
    if(bulletsCount > 0){
      bullets = new Bullet(2, PlayerAxis[0]+25, PlayerAxis[1]+25);
      bulletsCount -= 1;
      Act = true;
    }else{
      BulletEnemyStatus = false;
    }
    if(Act){
      Act = bullets.Move();
      bullets.Update();
      BulletEnemyStatus = bullets.CollisionDetection(EnemyAxis);
      if(BulletEnemyStatus) Act = false;
    }
    
    break;
  
  case 2:// Ending
    gameStatus = end.Update();
  }
}

void keyPressed(){
 if(keyCode == DOWN) MoveD = true;
 if(keyCode == UP) MoveU = true;
 if(keyCode == LEFT) MoveL = true;
 if(keyCode == RIGHT) MoveR = true;
 if(keyCode == 32){
   if(bulletsCount <= 5 ){
     bulletsCount += 1; 
   }
 }
}

void keyReleased(){
 if(keyCode == DOWN) MoveD = false;
 if(keyCode == UP) MoveU = false;
 if(keyCode == LEFT) MoveL = false;
 if(keyCode == RIGHT) MoveR = false;
 //if(keyCode == 32)
}

//[Function Region]
/*void Imageload(){
 //props
 playerImg = loadImage("img/fighter.png");
 enemyImg = loadImage("img/enemy.png");
 treasureImg = loadImage("img/treasure.png");
 //background
 Game_bg1 = loadImage("img/bg1.png");
 Game_bg2 = loadImage("img/bg2.png");
 End_bg1 = loadImage("img/end2.png");
 End_bg2 = loadImage("img/end1.png");
 //HUD
 hpImg=loadImage("img/hp.png");
 }*/
