import gab.opencv.*;
import java.awt.*;
import processing.video.*;
import processing.serial.*;
import java.awt.Color;

Capture video;
OpenCV opencv;

// Create object from Serial class

Serial myPort;  
int inByte = -1; 

void setup() 
{
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  video.start();
  
  println(Serial.list());
  //colorMode(HSB, 100,100,100);
  String portName = Serial.list()[5];
  myPort = new Serial(this, Serial.list()[5], 9600);
 
}

void draw() {
  
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  println(faces.length);

//  do cool stuff here:

    int x = int(random(32));
    int y = int(random(16));
    int H = int(222);
    int S = int(10);
    int L = int(random(3));

// convert color to RGB before sending to arduino  
//    color c = Color.HSBtoRGB(H, S, L);
    
//  int R =  int(red(c));
//  int G =  int(green(c));
//  int B =  int(blue(c));
    
    int R =  int(random(255));
    int G =  int(random(255));
    int B =  int(random(255));


//    int R =  255;
//    int G = 0;
//     
//     for (int i = 0; i < faces.length; i++) {
//      G =  faces[0].y ;
//     } 
//     
//    int B =  0;


    
    int F = 0;
    String toard = x + ":" + y + ":" + R + ":" + G + ":" + B + ":" + F +".";
    
    //println(toard);
     myPort.write(toard);   
     
    

//////// UNDER CONSTRUCTION


  
  for (int i = 0; i < faces.length; i++){
   // println(faces[i].x + "," + faces[i].y);
     rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height); 
     
     toard = x + ":" + y + ":" + 0 + ":" + 0 + ":" + 0 + ".";
     myPort.write(toard);
    
  
if (faces.length == 0){
    
    delay(faces[0].x);
    
    }
  }
//} else { F = 0;}
    
    // listen back to the serial data from arduino
    // this is handy for debugging
      while (myPort.available () > 0) {
        // send the string to the arduino over serial port
        inByte = myPort.read();
        //println(int(inByte));
      }
 }


void captureEvent(Capture c) {
  c.read();
}



