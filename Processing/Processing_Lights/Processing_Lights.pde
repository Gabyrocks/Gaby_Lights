
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
    byte[] matrixbuff = new byte[4096];
    
    
    void setup() {
    size(640, 320);
    myPort = new Serial(this, Serial.list()[3], 9600);
  
     
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
          myPort.write(c);
     
          fill(c);
          stroke(0);
          rect(x, y, videoScale, videoScale);
          
//          img=video.get(0,0,640,320);
//          image(img,0,0);
//          update();
          
       }    
     }
   }
   
   void update(){
     if (myPort != null){
       
       myPort.write((byte)(192)); //00001000
       myPort.write((byte)(192)); //00100001
       
       int pIdx = 0;
       for (int y = 0; y < 32; y++) {
        for (int x = 0; x < 32; x++) {

          float ga = 4f;

          color c = img.get(x, y);
          int r = int(red(c));
          int g = int(green(c));
          int b = int(blue(c));

          r = (byte)(Math.pow(((float)r)/255.0,ga)*255.0);
          g = (byte)(Math.pow(((float)g)/255.0,ga)*255.0);
          b = (byte)(Math.pow(((float)b)/255.0,ga)*255.0);

          matrixbuff=drawPixel888(x,y,(byte)r,(byte)g,(byte)b,matrixbuff);
          pIdx++;
        }}

    myPort.write(matrixbuff);
    //println(matrixbuff);
  }
}

byte[] drawPixel888(int x, int y, byte r, byte g, byte b, byte target[]) {    
int rowLength = 32*16; 

int targetRow = getTargetRow(y);      
boolean targetHigh = getTargetHigh(y);
