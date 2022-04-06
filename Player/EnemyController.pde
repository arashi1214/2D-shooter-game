class Enemy
{
  int speed, x, y;
  PImage imagePath = loadImage("img/enemy.png");

  //Init
  Enemy()
  {
    this.speed = floor(random(2,8));
    this.x = 0;
    this.y = floor(random(61,539));
  }

  //void move()
  void Move() 
  {
    if(this.x < 800) this.x += this.speed;
    else{
      this.speed = floor(random(2,8));
      this.x = 0;
      this.y = floor(random(61,539));
    }
  }
  
  void Update()
  {
    image(imagePath, this.x, this.y);
  }
}
