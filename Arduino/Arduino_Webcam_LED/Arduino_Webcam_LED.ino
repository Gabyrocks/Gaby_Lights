

const char EOPmarker = '.';
char serialbuf[32];

#include <Adafruit_GFX.h>
#include <RGBmatrixPanel.h> 
#define MAX_STRING_LEN 20
#include <string.h>

#define CLK 8
#define LAT A3
#define OE  9
#define A   A0
#define B   A1
#define C   A2
RGBmatrixPanel matrix(A, B, C, CLK, LAT, OE, false);

uint8_t r=7, g=7, b=7;

void setup() {


  Serial.begin(9600);
  matrix.begin();
  pinMode(13, OUTPUT);
  digitalWrite(13, LOW);

}

void loop() {

  if (Serial.available() > 0) { 
    static int bufpos = 0; 
    char inchar = Serial.read(); 
    if (inchar != EOPmarker) { 
      serialbuf[bufpos] = inchar; 
      bufpos++; 

    } 
    else { 

      serialbuf[bufpos] = 0;
      bufpos = 0; //restart the position of the buff



    }

    // this is where we grab the x y HSB values and do whatever we think is nice :) //////////////
    // send back to processing for debugging 

    int x = atoi(subStr(serialbuf, ":", 1));
    int y = atoi(subStr(serialbuf, ":", 2));
    int H = atoi(subStr(serialbuf, ":", 3));
    int S = atoi(subStr(serialbuf, ":", 4));
    int L = atoi(subStr(serialbuf, ":", 5));
    int F = atoi(subStr(serialbuf, ":", 6));
    int G = atoi(subStr(serialbuf, ":", 7));

    float vH = map(H, 0, 222, 0, 7);
    float vS = map(S, 0, 222, 0, 7);
    float vL = map(L, 0, 222, 0, 7);
    

    Serial.write(x);
    matrix.drawPixel(x, y, matrix.Color333(vH, vS, vL));
    


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




