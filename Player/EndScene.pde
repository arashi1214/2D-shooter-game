class End
{
  PImage End_bg1, End_bg2;

  //init
  End()
  {
    ImageLoad();
  }

  void ImageLoad()
  {
    End_bg1 = loadImage("img/end1.png");
    End_bg2 = loadImage("img/end2.png");
  }


  void display(int img)
  {
    background(122);
    switch(img)
    {
    case 0:
      image(End_bg1, 0, 0);
      break;
    case 1:
      image(End_bg2, 0, 0);
      break;
    }
  }

  int Update()
  {
    if (mouseX >= 200 && mouseX <= 440
      && mouseY >= 300 && mouseY <= 360)
    {
      display(1);
      if (mousePressed)
        return 0;
    } else
      display(0);
    return 2;
  }
}
