const char EOPmarker = '.';
char serialbuf[32];

#include <Adafruit_GFX.h>   // Core graphics library
#include <RGBmatrixPanel.h> // Hardware-specific library
#define MAX_STRING_LEN 20
#include <string.h>

#define CLK 8  
#define OE  9
#define LAT 10
#define A   A0
#define B   A1
#define C   A2
#define D   A3

RGBmatrixPanel matrix(A, B, C, D, CLK, LAT, OE, false);

void setup() {
  
  Serial.begin(9600);
  matrix.begin();

}

void loop() {
  
    if (Serial.available() > 0) { //makes sure something is ready to be read
      static int bufpos = 0; //starts the buffer back at the first position in the incoming serial.read
      char inchar = Serial.read(); //assigns one byte (as serial.read()'s only input one byte at a time
      if (inchar != EOPmarker) { //if the incoming character is not the byte that is the incoming package ender
        serialbuf[bufpos] = inchar; //the buffer position in the array get assigned to the current read
        bufpos++; //once that has happend the buffer advances, doing this over and over again until the end of package marker is read.
        
      }
      
      else { //once the end of package marker has been read
        serialbuf[bufpos] = 0; //restart the buff
        bufpos = 0; //restart the position of the buff
        
 //////////////////////////////////////////////////////////////////////////////////////////////
 // this is where we grab the x y HSB values and do whatever we thing is nice :) //////////////
        
         int x = atoi(subStr(serialbuf, ":", 1));
         int y = atoi(subStr(serialbuf, ":", 2));
         int R = atoi(subStr(serialbuf, ":", 3));
         int G = atoi(subStr(serialbuf, ":", 4));
         int B = atoi(subStr(serialbuf, ":", 5));

         // send back to processing for debugging 
        
         Serial.write(x);
          // quick and dirty LED tester
          if(x >= 16){
            //matrix.drawPixel(x, y, matrix.Color333(R, G, B));
            Serial.write(x);
          } //else 
          
          //matrix.fillScreen(0);
          
          

          
      // all our stuff goes above here /////////////////////////////////////////////////
      }
       //Serial.flush();
    }
   
}


// this is the function that allows us to easily grab an item from the string by index

char* subStr (char* input_string, char *separator, int segment_number) {
  char *act, *sub, *ptr;
  static char copy[MAX_STRING_LEN];
  int i;
  strcpy(copy, input_string);
  for (i = 1, act = copy; i <= segment_number; i++, act = NULL) {
    sub = strtok_r(act, separator, &ptr);
    if (sub == NULL) break;
  }
 return sub;
}


/// note : need to add matrix
