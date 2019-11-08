  
import processing.video.*;

Capture cam;
Ascii ascii;
PImage current_frame;

void setup() {
  size(displayWidth, displayHeight);
  ascii = new Ascii(displayWidth, displayHeight);
  ascii.setModuleSize(15,18);
  ascii.setFontColor(71,73,157);
  ascii.setFontSize(18);
  ascii.setFontWeight(100);
  ascii.setLineHeight(18);
  ascii.setLetterSpacing(0.01); //.41em
  ascii.getVideo(100,75);
  ascii.calculatePixelOffset();
  ascii.calculateModules();

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
     println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }      
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  current_frame = cam.get();
  image(current_frame,0,0);
  //ascii.drawAscii(cam);
  //image(cam, 0, 0);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
}