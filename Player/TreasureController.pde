class Treasure
{
  int x, y;
  PImage imagePath = loadImage("img/treasure.png");
  
  //Init
  Treasure(int X, int Y)
  {
    this.x = X;
    this.y = Y;
  }
  
  void Update()
  {
    image(imagePath, this.x, this.y);
  }
  
  boolean CollisionDetection(int[] PlayerAxis, Object player){
    if(this.x < PlayerAxis[0] + 51 && this.x + 41 > PlayerAxis[0] && this.y < PlayerAxis[1] + 51 && this.y + 41 > PlayerAxis[1]){
      //player.GetTreasure();
      return true;
    }
    else{
      return false;
    }
  }
}
