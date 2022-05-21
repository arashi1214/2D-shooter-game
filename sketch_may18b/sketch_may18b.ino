#include <Adafruit_NeoPixel.h>

int control_x = A1;
int control_y = A0;
int control_k = A2;
int round_led = 7;
int light_led = 3;
int buttonPin = 5;
bool button_status;
/* 建立環燈物件 */
Adafruit_NeoPixel strip = Adafruit_NeoPixel(16, round_led);
Adafruit_NeoPixel light = Adafruit_NeoPixel(15, light_led);

int X;
int Y;
int K;
int bullets = 5;

void setup()
{
  Serial.begin(9600);
  pinMode(control_x,INPUT);
  pinMode(control_y,INPUT);
  pinMode(control_k,INPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(11, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(13, OUTPUT);
  pinMode(buttonPin, INPUT);
  
  strip.begin();
  strip.setBrightness(32); //降低亮度為1/8
  strip.show();

  light.begin();
  light.setBrightness(32);
  light.show();
  
}

void loop()
{
  char code = Serial.read();
  if(code >= 65 && code <= 70)
    BulletsController(code - 65);
  else if(code == "F"){
    colorWipe(strip.Color(20, 0, 0), 16);
  }


  /* 環燈顏色控制
  colorWipe(strip.Color(20, 0, 0), 500); // Red
  colorWipe(strip.Color(0, 255, 0), 500); // Green
  colorWipe(strip.Color(0, 0, 255), 500); // Blue
  */

  //BulletsController(bullets);
  /* 偵測按鈕 */
  button_status = digitalRead(buttonPin);
  if(!button_status){
    Serial.print('z');
    //bullets --;
  }



  //analogRead
  /* 搖桿測試*/
  X = analogRead(control_x);
  Y = analogRead(control_y);
  K = digitalRead(control_k);

 /*
  Serial.print("X:");
  Serial.println(X, DEC);
  Serial.print("Y:");
  Serial.println(Y, DEC);
  Serial.println("---------------------");
 */
  if(X > 600){
    Serial.print('a');
    //Serial.println("向左");
  }
  
  else if(X <= 500){
    Serial.print('b');
    //Serial.println("向右");
  }

  if(Y > 600){
    Serial.print('c');
    //Serial.println("向上");
  }
  
  else if(Y <= 500){
    Serial.print('d');
    //Serial.println("向下");
  }

  if(X<=600 && X>= 500 && Y<=600 && Y>= 500){
    Serial.print('n');
    //Serial.println("中間");
  }

  if(!K){
    Serial.print('k');
  }
 
  delay(1000);
  
}


/*給顏色與亮到哪顆燈(energy，最多16) */
void colorWipe(uint32_t c, int energy) {
    for(int i=0; i<energy;i++){
      strip.setPixelColor(i, c);
      strip.show();
      delay(500);
    }
}

void addbullets(){
  bullets += 1;
  if (bullets > 5){
    bullets = 5;
  }
}

void colorHp(int hp){
  // 重整
  for(int i=0; i<15; i++){
      light.setPixelColor(i, 0, 0, 0);
      light.show();
  }
  
  for(int i=0; i<map(hp, 0, 100, 0, 15); i++){
      light.setPixelColor(i, 255, 0, 0);
      light.show();
  }
}

// 給予剩餘子彈數，最多5
void BulletsController(int bullets){
  //9 10 11 12 13 給LED腳位

  for(int i=0; i<bullets; i++){
    digitalWrite(9 + i, HIGH);
  }
  
  for(int i=3; i>bullets; i--){
    digitalWrite(9 + i, LOW);
  }
}
