
class Title
{
  //Arguments
  PImage Title_bg1, Title_bg2;
  
  //init
  Title()
  {
    ImageLoad();
  }

  void ImageLoad()
  {
    Title_bg1 = loadImage("img/start1.png");
    Title_bg2 = loadImage("img/start2.png");
  }

  void display(int img)
  {
    background(122);
    switch(img)
    {
    case 0:
      image(Title_bg1, 0, 0);
      break;
    case 1:
      image(Title_bg2, 0, 0);
      break;
    }
  }

  int Update()
  {
    if (mouseX >= 200 && mouseX <= 440
      && mouseY >= 380 && mouseY <= 420)
    {
      display(1);
      if (mousePressed)
        return 1;
    } else
      display(0);
    return 0;
  }
}
