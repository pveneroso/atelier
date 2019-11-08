import processing.video.*;
Capture cam;

PFont[] chars;
//char[] letters = {'@','#','0','%','$','|','1','*',';','.',' '};
//char[] letters = {'@','0','%','#','$','1','|','*',';','.',' '};
char[] letters = {' ','.',';','*','|','1','$','#','%','0','@'};
//char[] letters = {'Q','W','B','&','N','M','R','@','D','O','H','0','8','K','G','9','6','E','%','U','A','P','S','$','5','Z','X','4','#','3','V','I','2','C','F','J','Y','T','1','}','{','7',']','7','[','|','?','(',')','/','*',';','<','>','=','+','^','!',':',',','_','~','=','.',' '};
//char[] letters = {'@','%','#','*','+','=','-',':','.',' '};
PImage source;
int steps = letters.length;
color back_color = color(255,255,255);
color char_color = color(71,73,157);

int current_font = 0;
int current_char = 0;
int current_range = 0;
int threshold = 0;

int module_width = 12;
int module_height = 12;

int size_width = 1440;//1920
int size_height = 810;//1072
int dimension = size_width*size_height;

int font_size = 32;

boolean invert = false;

int char_r = 0;
int char_g = 0;
int char_b = 0;

boolean color_chars = true;


void setup(){
  fullScreen();
  //size(1440, 1072);
  background(0);
  smooth(2);
  threshold = 256/steps;
  chars = new PFont[6];
  chars[0] = loadFont("SourceCodePro-ExtraLight-32.vlw");
  chars[1] = loadFont("SourceCodePro-Light-32.vlw");
  chars[2] = loadFont("SourceCodePro-Regular-32.vlw");
  chars[3] = loadFont("SourceCodePro-Semibold-32.vlw");
  chars[4] = loadFont("SourceCodePro-Bold-32.vlw");
  chars[5] = loadFont("SourceCodePro-Black-32.vlw");
  
  //chars[0] = loadFont("SourceCodePro-ExtraLight-16.vlw");
  //chars[1] = loadFont("SourceCodePro-Light-16.vlw");
  //chars[2] = loadFont("SourceCodePro-Regular-16.vlw");
  //chars[3] = loadFont("SourceCodePro-Semibold-16.vlw");
  //chars[4] = loadFont("SourceCodePro-Bold-16.vlw");
  //chars[5] = loadFont("SourceCodePro-Black-16.vlw");
  
  String[] cameras = Capture.list();
   if (cameras.length == 0) {
    //println("There are no cameras available for capture.");
    exit();
    } else {
      //println("Available cameras:");
      //for (int i = 0; i < cameras.length; i++) {
      // println(cameras[i]);
      //}
      
      // The camera can be initialized directly using an 
      // element from the array returned by list():
      cam = new Capture(this, cameras[0]);
      cam.start();     
    } 
  
  //source = loadImage("hokusai-site.jpg");

}

void draw(){
  fill(0);
  rect(0,0,1440,810); //1920 1080
  //PImage source1;
  if (cam.available() == true) {
    cam.read();
  }
  source = cam.get();
  
  
  //PImage source = copy(source1, 0, 0, 1280, 720, 0, 0, 1440, 1080);
  //source.copy(0, 0, 1280, 720, 0, 0, 1440, 1080);
  //source.resize(1920,1080);
  source.loadPixels();
  //println(source.pixels.length);
  
  if(source.pixels.length>0){
    source.resize(1440,810);
    source.loadPixels();
    //println(source.width);
    for (int i = 0; i < source.width-16; i+=module_width) { 
      for (int j = 0; j < source.height-16; j+=module_height){
        int origin_pixel = i + size_width*j;
        
        if(color_chars == false){
          int range_count = 0;
          for (int m = 0; m < module_width; m++){
            for (int n = 0; n < module_height; n++){
              int current_pixel = origin_pixel + (m+(n*size_width));
              range_count += red(source.pixels[current_pixel]);
              range_count += green(source.pixels[current_pixel]);
              range_count += blue(source.pixels[current_pixel]);
            }
          }
          current_char = get_char(range_count/((module_width*module_height)*3));
          
          fill(char_color);
          //textFont(chars[current_font], 8);
          //text('A', i, j);
          textFont(chars[current_font], font_size);
          text(letters[current_char], i+3, j+14);  
        }
        else{
          int range_r = 0;
          int range_g = 0;
          int range_b = 0;
          for (int m = 0; m < module_width; m++){
            for (int n = 0; n < module_height; n++){
              int current_pixel = origin_pixel + (m+(n*size_width));
              range_r += red(source.pixels[current_pixel]);
              range_g += green(source.pixels[current_pixel]);
              range_b += blue(source.pixels[current_pixel]);
            }
          }
          int range_count=range_r+range_g+range_b;
          current_char = get_char(range_count/((module_width*module_height)*3));
          int color_rgb = color(range_r/(module_width*module_height),range_g/(module_width*module_height),range_b/(module_width*module_height));
          
          fill(color_rgb);
          //textFont(chars[current_font], 8);
          //text('A', i, j);
          textFont(chars[current_font], font_size);
          text(letters[current_char], i+3, j+14);
        }
      }
    }
  }
}

//int get_char(int temp_range){
//  int current_char = 0;
//  for(int i=0; i<letters.length; i++){
//    println(temp_range);
//    if(temp_range >= i*threshold && temp_range < (i+1)*threshold){
//      current_char = i;
//    }
//    else if(temp_range >= threshold*letters.length && temp_range <256){
//      current_char = chars.length-1;
//    }
//  }
  
//  return current_char;
//}

int get_char(int temp_range){
  //int current_char = 0;
  for(int i=0; i<letters.length; i++){
    //println(temp_range);
    if(temp_range >= i*threshold && temp_range < (i+1)*threshold){
      current_char = i;
    }
    else if(temp_range >= threshold*letters.length && temp_range <256){
      current_char = letters.length-1;
    }
  }
  
  return current_char;
}

void keyPressed() {
  if(key=='p'){
    //println(chars.length);
    if(current_font+1<chars.length){
      current_font++;    
    }
  }
  else if(key=='o'){
    if(current_font-1>=0){
      current_font--;    
    }
  }
  
  if(key=='i'){
    color temp_color = char_color;
    char_color = back_color;
    back_color = temp_color;
    invert = !invert;
     //println(invert);
  }
  
  if(key=='m'){
    if(font_size+1<=32){
      font_size++;
    }
  }
  else if(key=='n'){
    if(font_size-1>0){
       font_size--;
    }
  }
  
  if(invert == false){
    if(key=='w'){
      if(red(char_color)+10<=255){
        char_color = color(red(char_color)+10,green(char_color),blue(char_color));
      }
    }
    else if(key=='q'){
      if(red(char_color)-10>=0){
        char_color = color(red(char_color)-10,green(char_color),blue(char_color));
      }
    }
    else if(key=='e'){
      char_color = color(0,green(char_color),blue(char_color));
    }
    else if(key=='r'){
      char_color = color(255,green(char_color),blue(char_color));
    }
    
    if(key=='s'){
      if(green(char_color)+10<=255){
        char_color = color(red(char_color),green(char_color)+10,blue(char_color));
      }
    }
    else if(key=='a'){
      if(green(char_color)-10>=0){
        char_color = color(red(char_color),green(char_color)-10,blue(char_color));
      }
    }
    else if(key=='d'){
      char_color = color(red(char_color),0,blue(char_color));
    }
    else if(key=='f'){
      char_color = color(red(char_color),255,blue(char_color));
    }
    
    if(key=='x'){
      if(blue(char_color)+10<=255){
        char_color = color(red(char_color),green(char_color),blue(char_color)+10);
      }
    }
    else if(key=='z'){
      if(blue(char_color)-10>=0){
        char_color = color(red(char_color),green(char_color),blue(char_color)-10);
      }
    }
    else if(key=='c'){
      char_color = color(red(char_color),green(char_color),0);
    }
    else if(key=='v'){
      char_color = color(red(char_color),green(char_color),255);
    }
  }
  else{
    if(key=='w'){
      if(red(back_color)+10<=255){
        back_color = color(red(back_color)+10,green(back_color),blue(back_color));
      }
    }
    else if(key=='q'){
      if(red(back_color)-10>=0){
        back_color = color(red(back_color)-10,green(back_color),blue(back_color));
      }
    }
    else if(key=='e'){
      back_color = color(0,green(back_color),blue(back_color));
    }
    else if(key=='r'){
      back_color = color(255,green(back_color),blue(back_color));
    }
    
    if(key=='s'){
      if(green(back_color)+10<=255){
        back_color = color(red(back_color),green(back_color)+10,blue(back_color));
      }
    }
    else if(key=='a'){
      if(green(back_color)-10>=0){
        back_color = color(red(back_color),green(back_color)-10,blue(back_color));
      }
    }
    else if(key=='d'){
      back_color = color(red(back_color),0,blue(back_color));
    }
    else if(key=='f'){
      back_color = color(red(back_color),255,blue(back_color));
    }
    
    if(key=='x'){
      if(blue(back_color)+10<=255){
        back_color = color(red(back_color),green(back_color),blue(back_color)+10);
      }
    }
    else if(key=='z'){
      if(blue(back_color)-10>=0){
        back_color = color(red(back_color),green(back_color),blue(back_color)-10);
      }
    }
    else if(key=='c'){
      back_color = color(red(back_color),green(back_color),0);
    }
    else if(key=='v'){
      back_color = color(red(back_color),green(back_color),255);
    }
  }
  
  if(key=='h'){
    char_color = color(71,73,151);
    back_color = color(255,255,255);
    current_font = 0;
    module_width = 12;
    module_height = 12;
    font_size = 32;
    invert = false;
  }
  
  if(key=='5'){
     module_width = 12;
     module_height = 12;
     font_size = 32;
  }
  
  if(key=='6'){
     module_width = 15;
     module_height = 15;
     font_size = 32;
  }
  
  if(key=='4'){
     module_width = 10;
     module_height = 10;
     font_size = 32;
  }
  
  if(key=='3'){
     module_width = 8;
     module_height = 8;
     font_size = 32;
  }
  
  if(key=='2'){
     module_width = 6;
     module_height = 6;
     font_size = 32;
  }
  
  if(key=='1'){
     module_width = 4;
     module_height = 4;
     font_size = 32;
  }
}