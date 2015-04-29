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

int screen_width = 640;
int screen_height = 480;
int cam_width = screen_width/2;
int cam_height = screen_height/2;


void setup() 
{
  size(screen_width, screen_height);
  video = new Capture(this, cam_width, cam_height);
  opencv = new OpenCV(this, cam_width, cam_height);
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
  //println(faces.length);

  int x = int(random(32));
  int y = int(random(16));
  int H = int(random(222));
  int S = int(random(222));
  int L = int(random(222));


  int midFaceY=0;
  int midFaceX=0;
  int midScreenY = (height/2);
  int midScreenX = (width/2);


  // convert color to RGB before sending to arduino  
  //    color c = Color.HSBtoRGB(H, S, L);


  StringList toard = new StringList();
  int F = 0;
  //String toard = x + ":" + y + ":" + 0 + ":" + 0 + ":" + 0 + ":" + 0 +".";
  //myPort.write(toard);   


  for (int i = 0; i < faces.length; i++) {
    if (faces.length > 0) {

      midFaceY = faces[0].y + (faces[0].height/2);
      midFaceX = faces[0].x + (faces[0].width/2);

      if(faces.length >= 1) {

        for (int j = 0; j < (faces.length * 5); j++) {
          
          toard.append(x + ":" + y + ":" + H + ":" + S + ":" + L + ":" + F +".");

          //toard = x + ":" + y + ":" + H + ":" + S + ":" + L + ":" + F +".";
          //println(toard);
          //myPort.write(toard);
        }
      }
    }

    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height); 
    delay(faces[0].x);
    //toard = x + ":" + y + ":" + H + ":" + S + ":" + L + ":" + F +".";
    // println(toard);
   // myPort.write(toard);


    println(cam_width/2);
    println(midFaceX);

    if (midFaceX < cam_width/2) {
      

      //toard.clear();
      toard.append(x + ":" + y + ":" + H + ":" + S + ":" + L + ":" + F +".");

      //if(midFaceX < midScreenX){
      println("Left");

      //     
      //toard = x + ":" + y + ":" + 0 + ":" + 0 + ":" + 0 + ":" + F +".";  
      //     myPort.write(toard);
      //
    } else {

      println("right");
    }
    //     
    //     if(faces.length > midScreenX){
    //     
    //      delay(faces[0].x);
    //       toard = x + ":" + y + ":" + H + ":" + S + ":" + L + ":" + F +".";  
    //     
    //      }
    
    for (int ii = 0; ii < toard.size (); ii = ii+1) {
   // line(30, i, 80, i);
    
   //String item = inventory.get(2);
   println(toard.get(ii));
   myPort.write(toard.get(ii));
  }
    //myPort.write(toard);
    
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

