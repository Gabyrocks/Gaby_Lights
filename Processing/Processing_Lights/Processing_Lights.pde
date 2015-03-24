
    // Learning Processing
    
    // Daniel Shiffman
    // http://www.learningprocessing.com
    // Example 16-7: Video pixelation
    import processing.video.*;
    import processing.serial.*;
    Serial myPort;
    
     
    // Size of each cell in the grid, ratio of window size to video size
    int videoScale = 20;
    // Number of columns and rows in our system
    int cols, rows;
    // Variable to hold onto Capture object
    Capture video;
    PImage img;
    
    
    void setup() {
      println(Serial.list());
      size(640, 320);
    myPort = new Serial(this, Serial.list()[5], 57600);
  
     
    // Initialize columns and rows
    cols = width / videoScale;
    rows = height / videoScale;
    video = new Capture(this, 80, 60);
    video.start();
    }
    
    void captureEvent(Capture video) {
    // Read image from the camera
    video.read();
    }
     
    void draw() {
//      if (keyPressed == true){
//        myPort.write("1");
//      } else
//          myPort.write("0");
    video.loadPixels();
     
      // Begin loop for columns
      for (int i = 0; i < cols; i++) {     
      // Begin loop for rows
     
        for (int j = 0; j < rows; j++) {
          // Where are we, pixel-wise?
          int x = i * videoScale;
          int y = j * videoScale;
         
          // Looking up the appropriate color in the pixel array
          color c = video.pixels[i + j * video.width];
          int a = (c >> 24) & 0xFF;
          int r = (c >> 16) & 0xFF;  // Faster way of getting red(argb)
          int g = (c >> 8) & 0xFF;   // Faster way of getting green(argb)
          int b = c & 0xFF;          // Faster way of getting blue(argb)
          
          //g = int(map(g, 0,255,0,7));
          println(g);

          myPort.write(g);
          fill(c);
          stroke(0);
          rect(x, y, videoScale, videoScale);
          
//          img=video.get(0,0,640,320);
//          image(img,0,0);

          
       }    
     }
   }
   

