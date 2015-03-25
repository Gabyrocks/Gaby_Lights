#include <Adafruit_GFX.h>  
#include <RGBmatrixPanel.h> 
  
#define CLK 8  
#define LAT A3
#define OE  9
#define A   A0
#define B   A1
#define C   A2
RGBmatrixPanel matrix(A, B, C, CLK, LAT, OE, false);
int valx;
float bla;

void setup(){
  
  Serial.begin(115200); 
  matrix.begin();
 
}
int m;
int counter =0;

void loop(){
  counter++ %100;
  if(counter==1){
   int m = random(0,100);
    
  }
  
  int rx = random(32);
  int ry = random(16);
  int rg = random(255);
  int rb = random(255);
//  int rg = random((255*m)/100);
//  int rb = random((255*m)/100);
    //int rd = random(50);

  if (Serial.available() > 0){
   valx = Serial.read(); // read it and store it in val
   bla = map(valx, 0,255,0,7);
   matrix.drawPixel(rx,ry, matrix.Color333(bla,rg,rb));
   //delay(rd);

   //matrix.drawPixel(rx,ry, matrix.Color333(0,0,0));

   //matrix.drawPixel(valx);
   
 
   }else{
    
   matrix.fillScreen(0);
   
  }
//delay(rd);
}



