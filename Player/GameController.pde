//[Define Region]
//Images
//PImage playerImg, enemyImg, treasureImg; //props
//PImage hpImg;// HUD
//Class
Title title;
Game game;
End end;
Player player;
Enemy[] enemys;
//Other
int gameStatus = 0;
boolean MoveL = false, MoveU = false, MoveR = false, MoveD = false;
boolean Act = false;
int EnemyAxis[][] = new int[5][2];
int EnemyCount = 1;

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
  enemys = new Enemy[5];
  for(int i=0; i<5; i++)
    enemys[i] = new Enemy();
}

void draw() {

  switch(gameStatus)
  {
  case 0: // Title
    gameStatus = title.Update();
    break;
  
  
  case 1:// Game
    gameStatus = game.Update();
    player.Move(MoveL, MoveR, MoveU, MoveD, 800, 600);
    player.Update();
    
    for(int i=0; i<EnemyCount; i++){
      EnemyAxis[i] = enemys[i].Move();
      enemys[i].Update();    
    }

    //player.CollisionDetection(EnemyAxis);

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
 //if(keyCode == 32) Act = true;
}

void keyReleased(){
 if(keyCode == DOWN) MoveD = false;
 if(keyCode == UP) MoveU = false;
 if(keyCode == LEFT) MoveL = false;
 if(keyCode == RIGHT) MoveR = false;
 //if(keyCode == 32) Act = false;
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
