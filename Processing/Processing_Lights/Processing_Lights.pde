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

  // Define parameters for your arduino
  int x = int(random(32));
  int y = int(random(16));
  int H = int(random(222));
  int S = int(random(222));
  int L = int(random(222));  
  int F = 0;
  String toard = x + ":" + y + ":" + 0 + ":" + 0 + ":" + 0 + ":" + 0 +".";
  myPort.write(toard);   
  int faceCount = 0;
  //for when there is more than one face, loop   
  for (int i = 0; i < faces.length; i++) {
    //if there's more than one face, faceCount is 1
    if (faces.length > 0) {
      faceCount = 1;
      //set MidFace cross position
      int midFaceX = 0;
      midFaceX = faces[0].x + (faces[0].width/2);
      //If there is more than one face, limit faceCount to 2 or you'll blow the arduino!
      if (faces.length > 1) {
        faceCount = 2;
      }
      //for faceCount *2 to increase amount of LEDs showing, do stuff
      for (int j = 0; j < (faceCount * 2); j++) {
        x = int(random(32));
        y = int(random(16));
        H = int(random(222));
        //if not they're on the right (1 or more people)
        if ((midFaceX < cam_width/2)) {
          println("on the right");
          H = int(random(0, 110));
          L = int(random(0, 110));
          S = int(random(0, 110));
        }
        //if not they're on the left (1 or more people)
        else {
          println("on the left");
          H = int(random(111, 222));
          L = int(random(111, 222));
          S = int(random(111, 222));
        }

        toard = x + ":" + y + ":" + H + ":" + S + ":" + L + ":" + F +".";
        println(toard);
        myPort.write(toard);
      }
    }

    // println(faces[i].x + "," + faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height); 
    delay(faces[0].x);
    toard = x + ":" + y + ":" + H + ":" + S + ":" + L + ":" + F +".";
    //println(toard);
    myPort.write(toard);
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


