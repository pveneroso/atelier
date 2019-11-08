import processing.video.*;
import ddf.minim.*;
import processing.serial.*;

Serial port;  // Create object from Serial class
String message;
int[] potentiometers = {0, 0, 0, 0};

Minim minim;
AudioInput in;
//AudioPlayer in;

Movie[] movies = new Movie[31];

// CURRENT >> 
int current_movie = 6;

Movie mov;
Glitcher glitcher;

boolean increase_amp_y = false;
boolean decrease_amp_y = false;
boolean new_message = false;
boolean black_screen = false;

int pin = 0;

String save_name = "exp/dejavu_01_";

void setup() {
  //size(1280, 720, FX2D);
  fullScreen(P2D);
  background(0);
  
  for(int i = 0; i < movies.length; i++){
    movies[i] = new Movie(this, i+".mov");
    movies[i].pause();
  }

  mov = movies[current_movie];  
  mov.play();
  mov.volume(0);
  mov.loop();
  //mov.frameRate(24);
  //frameRate(24);

  glitcher = new Glitcher();

  minim = new Minim(this);
  in = minim.getLineIn();
  //in = minim.loadFile("dejavu_01.mp3");
  //in.play();

  String portName = Serial.list()[2];
  port = new Serial(this, portName, 9600);
}

void draw() {
  //if(in.isPlaying()){
  //  println("play");
  //}
  background(0);
  controlGlitch();
  println(frameRate);

  if ( port.available() > 0) {  
    message = port.readStringUntil('\n');
    if (message != "null" && message != null) {
      convertMessage();
    }
  } 

  if (increase_amp_y) {
    glitcher.increaseAmpY();
  } else if (decrease_amp_y) {
    glitcher.decreaseAmpY();
  }
  if(mov.width> 0){
    glitcher.loadGlitch(mov);
    glitcher.updateGlitch(in);
    glitcher.glitchImage();
  }
  
  if(black_screen){
    fill(0);
    rect(0,0,width,height);
  }
  
  //saveFrame(save_name+"######.png");
}

void movieEvent(Movie m) {
  m.read();
}

void convertMessage() {
  String[] temp_msg = message.split(",");
  if (temp_msg.length == 4) {
    temp_msg[3] = trim(temp_msg[3]);
    for (int i = 0; i < temp_msg.length; i++) {
      potentiometers[i] = parseInt(temp_msg[i]);
    }
    new_message = true;
  }
}

void controlGlitch() {
  glitcher.setAmpY(potentiometers[0]);
  glitcher.setModifierY(potentiometers[1]);
  glitcher.setAmpX(potentiometers[2]);
  glitcher.setCropY(potentiometers[3]);
  new_message = false;
}

void keyPressed() {
  if (key == 'm' || key == 'M') {
    if (!increase_amp_y) {
      increase_amp_y = true;
    }
  } else if (key == 'n' || key == 'N') {
    if (!decrease_amp_y) {
      decrease_amp_y = true;
    }
  } else if (key == 'a' || key == 'A') {
    glitcher.resetValues();
  }
  else if(key == 'w' || key == 'W'){
    current_movie++;
    if(current_movie >= movies.length){
      current_movie = 0;
    }
    mov.stop();
    mov = null;
    mov = movies[current_movie];
    mov.play();
    mov.volume(0);
    mov.loop();
  }
  else if(key == 'q' || key == 'Q'){
    current_movie--;
    if(current_movie < 0){
      current_movie = movies.length-1;
    }
    mov.stop();
    mov = null;
    mov = movies[current_movie];
    mov.play();
    mov.volume(0);
    mov.loop();
  }
  else if(key == '1'){
    mov.pause();
  }
  else if(key == '2'){
    mov.play();
  }
  else if(key == '0'){
    black_screen = !black_screen;
  }
  else if(key == '5'){
    //reset video
    mov.stop();
    mov.play();
    mov.loop();
    mov.volume(0);
  }
}

void keyReleased() {
  if (key == 'm' || key == 'M') {
    increase_amp_y = false;
  } else if (key == 'n' || key == 'N') {
    decrease_amp_y = false;
  }
}
