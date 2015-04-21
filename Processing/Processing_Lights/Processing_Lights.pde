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

  image(video, 0, 0);

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  println(faces.length);
  
  int x = int(random(32));
  int y = int(random(16));
  int H = int(random(222));
  int S = int(random(222));
  int L = int(random(222));
  
  
  int midFaceY=0;
  int midFaceX=0;
  int midScreenY = (height/2);
  int midScreenX = (width/2);
  int midScreenWindow = 10;

  //  do cool stuff here:

  

  // convert color to RGB before sending to arduino  
  //    color c = Color.HSBtoRGB(H, S, L);


  //    int R =  int(random(255));
  //    int G =  int(random(255));
  //    int B =  int(random(255));


  int F = 0;
  String toard = x + ":" + y + ":" + 0 + ":" + 0 + ":" + 0 + ":" + 0 +".";
  myPort.write(toard);   
  
  
    for (int i = 0; i < faces.length; i++){
    if(faces.length > 1) {
      for(int j = 0; j < (faces.length * 5); j++){
   
       toard = x + ":" + y + ":" + H + ":" + S + ":" + L + ":" + F +".";
       println(toard);
       myPort.write(toard);
    
      
        }
      }
      
     rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height); 
     delay(faces[0].x);
     toard = x + ":" + y + ":" + H + ":" + S + ":" + L + ":" + F +".";
     println(toard);
     myPort.write(toard);
     
     
     //if(midFaceX < (midScreenX - midScreenWindow)){
       if(faces.length < midScreenX){
      
         ///SORT OUT G
     
     toard = x + ":" + y + ":" + H + ":" + S + ":" + L + ":" + F +".";  
     myPort.write(toard);
  
     }  
     
     if(faces.length > midScreenX){
     
      delay(faces[0].x);
       toard = x + ":" + y + ":" + H + ":" + S + ":" + L + ":" + F +".";  
     
      }
  }


      while (myPort.available () > 0) {
        // send the string to the arduino over serial port
        inByte = myPort.read();
        //println(int(inByte));
      }
 }


void captureEvent(Capture c) {
  c.read();
}

