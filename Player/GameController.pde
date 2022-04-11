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
int bulletsCount = 0;
int PlayerAxis[] = new int[2];
boolean MoveL = false, MoveU = false, MoveR = false, MoveD = false;
boolean PlayerEnemyStatus = false;
boolean BulletEnemyStatus = false;
boolean BulletStatus;

ArrayList<Enemy> enemys = new ArrayList<Enemy>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();

//[Main Region]
void setup() {
  //Canvus Setting
  size(800, 600);
  
  //Class instantiate
  title = new Title();
  game = new Game();
  end = new End();
  player = new Player(100,5,width/2,height/2);
  treasures = new Treasure(floor(random(50, width - 50)), floor(random(50, height - 50)));
  // create all enemys
  enemys.add(new Enemy());
}
void draw() {

  switch(gameStatus)
  {
  case 0: // Title
    gameStatus = title.Update();
    break;
  
  
  case 1:// Game
    // Updata Scence
    gameStatus = game.Update();
    
    PlayerAxis = player.Move(MoveL, MoveR, MoveU, MoveD, 800, 600);
    player.Update();
    
    for(int i=0; i<enemys.size(); i++){
      EnemyAxis[i] = enemys.get(i).Move();
      enemys.get(i).Update();  
    }
    
    for(int j=0; j<bullets.size(); j++){
      BulletStatus = bullets.get(j).Move();
      if(!BulletStatus) bullets.remove(j);
        bullets.get(j).Update();
    }
    
    treasures.Update();
    
    // CollisionDetection
    treasures.CollisionDetection(PlayerAxis, player);
    
    for(int i=0; i<enemys.size(); i++){
      PlayerEnemyStatus = player.CollisionDetection(EnemyAxis[i]);
      if(PlayerEnemyStatus) enemys.remove(i);
      
      for(int j=0; j<bullets.size(); j++){
        BulletEnemyStatus = bullets.get(j).CollisionDetection(EnemyAxis[i]);
        if(BulletEnemyStatus){
          enemys.get(i).Remake();
          bullets.remove(j);
        }
      }
    }

    // add enemy
    if(millis() % 5000 > 4980 && enemys.size() <= 5){
      enemys.add(new Enemy());
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
   if(bullets.size() < 5){
     bullets.add(new Bullet(3, PlayerAxis[0], PlayerAxis[1] + 25));
   }
 }
}

void keyReleased(){
 if(keyCode == DOWN) MoveD = false;
 if(keyCode == UP) MoveU = false;
 if(keyCode == LEFT) MoveL = false;
 if(keyCode == RIGHT) MoveR = false;
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
