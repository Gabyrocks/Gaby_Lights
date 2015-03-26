import processing.video.*;
import processing.serial.*;
// add java color library for HSB to RGB conversion
import java.awt.Color;

Serial myPort;  // Create object from Serial class
int inByte = -1;

int videoScale = 10;
int cols, rows;
Capture video;
PImage img;
    

void setup() 
{
  println(Serial.list());
  colorMode(HSB, 100,100,100);
  size(320, 160);
  String portName = Serial.list()[5];
  myPort = new Serial(this, Serial.list()[5], 9600);
  
  // Initialise columns and rows
  cols = width / videoScale;
  rows = height / videoScale;
  video = new Capture(this, 80, 60);
  video.start(); 
  
}

void captureEvent(Capture video) {
    video.read();
    
    }

void draw() {
  
  // Begin loop for columns
  for (int vi = 0; vi < cols; vi++) { 
    
  // Begin loop for rows
  for (int vj = 0; vj < rows; vj++) {
         
       int vx = vi * videoScale;
       int vy = vj * videoScale;
         
       color vc = video.pixels[vi + vj * video.width];
       int va = (vc >> 24) & 0xFF;
       int vr = (vc >> 16) & 0xFF;  // Faster way of getting red(argb)
       int vg = (vc >> 8) & 0xFF;   // Faster way of getting green(argb)
       int vb = vc & 0xFF;          // Faster way of getting blue(argb)
           
//// do cool stuff here:

    int x = int(random(32));
    int y = int(random(16));
    int H = int(random(20,40));
    int S = int(random(100));
    int L = int(random(100));

///// convert color to RGB before sending to arduino  

    color c = Color.HSBtoRGB(H, S, L);
    int R = int(red(c));
    int G = int(green(c));
    int B = int(blue(c));
    //println(B);
    String toard = x + ":" + y + ":" + R + ":" + G + ":" + B + ".";
    
    // send the string to the arduino over serial port
    myPort.write(toard);   
    
    // add some delay
    //delay(40); 

//////////////////////////////////////////////////

    // listen back to the serial data from arduino
    // this is handy for debugging
    while (myPort.available () > 0) {
      inByte = myPort.read();
      println(int(inByte));


    //fill(H,S,B);
    //rect(0,0, width,height);
      }
    }
  }
 }


