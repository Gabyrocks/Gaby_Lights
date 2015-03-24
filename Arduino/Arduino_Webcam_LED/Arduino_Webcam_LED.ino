// colorwheel demo for Adafruit RGBmatrixPanel library.
// Renders a nice circle of hues on our 32x32 RGB LED matrix:
// http://www.adafruit.com/products/607

// Written by Limor Fried/Ladyada & Phil Burgess/PaintYourDragon
// for Adafruit Industries.
// BSD license, all text above must be included in any redistribution.

//#include <Adafruit_GFX.h>   // Core graphics library
//#include <RGBmatrixPanel.h> // Hardware-specific library

// If your 32x32 matrix has the SINGLE HEADER input,
// use this pinout:
#define CLK 8  // MUST be on PORTB! (Use pin 11 on Mega)
#define OE  9
#define LAT 10
#define A   A0
#define B   A1
#define C   A2
#define D   A3

//RGBmatrixPanel matrix(A, B, C, D, CLK, LAT, OE, false);

void setup() {
  
  int      x, y, RGB;
  float    dx, dy, d;
  long int inByte;
  
  uint8_t  sat, val;
  uint16_t c;

  Serial.begin(9600);
  //matrix.begin();

  //matrix.drawPixel(0, 7, 250);
  
  Serial.println('Hello, world');
  delay(100);
  

}

int inByte;

int* getColour(){
 
  int* colour;
  int i;
  
  i = 0;
  
  while (i < 4) {
    
    if (Serial.available() > 0) {
      colour[i] = Serial.read();
      i++;
    }
  } 
  
  return colour;
}

  char valx; 
  int ledPin = 13; // Set the pin to digital I/O 13



void loop() {
    digitalWrite(ledPin, LOW); // turn the LED on

 
  if (Serial.available() > 0) {
    
//    valx = Serial.read(); // read it and store it in val
//    if (valx == '1') 
//   { // If 1 was received
//     digitalWrite(ledPin, LOW); // turn the LED on
//   } else {
//     digitalWrite(ledPin, HIGH); // otherwise turn it off
//   }
//   delay(10); // Wait 10 milliseconds for next reading
    
    
    
    // This gets incoming byte
    
    inByte = Serial.read();
    
    if (inByte == 'C'){
      
      int * one;
     one = getColour();
     
    
    //outputColour(one[1], one[2], one[3]);
     
    }
  }
}
