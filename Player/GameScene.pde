/*/summary
 This is the Scene Triggered by "Click the Title Scene button".
 All the things about gameplay should be put it in here, include
 Player, Enemy, Treasure.
 
 This script included class: ~HealthBar~, ~Item~, ~Game~.
/*/



class Game
{
  //Arguments
  PImage Game_bg1, Game_bg2, HealthBar_bg;
  int Score = 0;
  int Item_timer = 0, Enemy_Timer = 0;
  HealthBar health = new HealthBar();
  Item item = new Item();


  //------------------------------------------
  //init
  Game()
  {
    ImageLoad();
  }
  
  //------------------------------------------
  void ImageLoad()
  {
    Game_bg1 = loadImage("img/bg1.png");
    Game_bg2 = loadImage("img/bg2.png");
    HealthBar_bg = loadImage("img/hp.png");
  }
  //------------------------------------------
  void HpUpdate()
  {
    noStroke();
    fill (255, 0, 0);
    rect(health.x + 13, health.y + 3, health.w * float(player.hp) / float(player.MaxHP), health.h);
    print("HP = " + float(player.hp/player.MaxHP));
    print("; Health = " + health.w * float(player.hp) / float(player.MaxHP));
    image(HealthBar_bg, health.x, health.y);
    
  }
  //------------------------------------------
  void ScoreUpdate(int score)
  {
    Score += score;
    textSize(30);
    fill(255, 255, 255);
    text("Score: " + Score, 450, 40);
  }

  //------------------------------------------
  void UIDisplay()
  {
    HpUpdate();
    ScoreUpdate(0);
  }
  
  //------------------------------------------

  void BackgroundDisplay()
  {
    //background Setting
    background(122);
          image(Game_bg1, 0 - (frameCount % width), 0);
          image(Game_bg2, width-(frameCount % width), 0);
    /*switch(img)
    {
    case 0:
      image(Game_bg1, 0 - (frameCount % width), 0);
      break;
    case 1:
      image(Game_bg2, width - (frameCount %width), 0);
      break;
    }*/

    //UI Update
    
  }
  //------------------------------------------
  int Update()
  {
      BackgroundDisplay();
  
    if (keyPressed)
    {
      if (keyCode == CONTROL)
        return 2;
    }
    return 1;
  }
  //------------------------------------------
}

static class HealthBar
{
  int x = 15;
  int y = 10;
  int w = 194;
  int h = 17;
}

class Item
{
  boolean isExist = false;
  PImage icon = loadImage("img/bg1.png");
  int[] position = {0, 0}; //position (x, y)
  int size = 41;

  void setPosition(int x, int y)
  {
    position[0] = x;
    position[1] = y;
  }

  int[] getPosition()
  {
    return position;
  }

  void Create(int x, int y)
  {
    setPosition(x, y);
    image(icon, x, y);
    isExist = true;
  }
}
