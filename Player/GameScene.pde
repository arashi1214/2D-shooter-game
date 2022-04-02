/*/summary
 This is the Scene Triggered by "Click the Title Scene button".
 All the Gameplay will put it in here, include
 Player, Enemy, Treasure.
/*/

//Player pl;

class Game
{
  //Arguments
  PImage Game_bg1, Game_bg2;

  //init
  Game()
  {
    ImageLoad();
  }

  void ImageLoad()
  {
    Game_bg1 = loadImage("img/bg1.png");
    Game_bg2 = loadImage("img/bg2.png");
  }

  void display(int img)
  {
    background(122);
    switch(img)
    {
    case 0:
      image(Game_bg1, 0, 0);
      break;
    case 1:
      image(Game_bg1, 0, 0);
      break;
    }
  }

  int Update()
  {
    display(1);
    if (keyPressed)
    {
      if (keyCode == CONTROL)
        return 2;
    }
    return 1;
  }
}
