class Ascii { 
int current_mode = 0; //[0 = image, 1 = video] mode defaults to image
int current_canvas_width = 0;
int current_canvas_height = 0;
int current_font_size = 16; // font size defaults to 16
color current_font_color = color(0,0,0); // font color defaults to black
int current_font_weight = 300;
int current_line_height = current_font_size;
float current_letter_spacing = 6;
String[] ascii_chars = {"@","#","0","%","$","[","1","*",";","."," "}; // default tonal scale with characters
int tonal_steps = ascii_chars.length;
int threshold = int(floor(256/tonal_steps));

int module_width = current_font_size;
int module_height = current_font_size;

int offset_vertical = 0;
int offset_horizontal = 0;
int remove_pixels_vertical = 0;
int remove_pixels_horizontal = 0;

int current_image_width = 0;
int current_image_height = 0;

int video_width = 0;
int video_height = 0;

PFont chars;
  
Ascii(int w, int h) {  
 current_canvas_width = w; 
 current_canvas_height = h; 
 chars = new PFont();
 chars = loadFont("SourceCodePro-Regular-16.vlw");
} 
  
 // --- GENERAL SETTINGS --- //
void setCanvasSize(int in_width, int in_height){ // sets canvas size
 current_canvas_width = in_width;
 current_canvas_height = in_height;
}

void setFontSize(int in_font_size){ // sets font size
 current_font_size = in_font_size;
}

void setFontColor(int in_font_color_r, int in_font_color_g, int in_font_color_b){ // sets font color with RGB values
 current_font_color = color(in_font_color_r,in_font_color_g,in_font_color_b);
}

void setFontWeight(int in_font_weight){ // sets font weight
 current_font_weight = in_font_weight;
}

void setLineHeight(int in_line_height){
 current_line_height = in_line_height;
}

void setLetterSpacing(float in_letter_spacing){
 current_letter_spacing = in_letter_spacing;
}

void setModuleSize(int in_module_width, int in_module_height){
 module_width = in_module_width;
 module_height = in_module_height;
}

void setAsciiChars(String[] in_chars){ // sets array of chars to be used: from darkest to lightest
 ascii_chars = in_chars;
 tonal_steps = ascii_chars.length;
 threshold = int(floor(256/tonal_steps));
}


// --- CALCULATIONS --- //
void calculatePixelOffset(){ // calculates correct aspect ratio for the image
  float image_ratio = video_width/video_height;
  float canvas_ratio = current_canvas_width/current_canvas_height;
  if(image_ratio<canvas_ratio){ // image horizontal size must be equal to canvas width; there will be vertical offset
   current_image_width = current_canvas_width;
   current_image_height = (current_image_width*video_height)/video_width;
   offset_vertical = current_image_height-current_canvas_height;
   offset_horizontal = 0;
  }
  else if(canvas_ratio<image_ratio){ // image vertical size must be equal to canvas height; there will be horizontal offset
   current_image_height = current_canvas_height;
   current_image_width = (current_image_height*video_width)/video_height;
   offset_horizontal = current_image_width - current_canvas_width;
   offset_vertical = 0;
  }
  else{
   current_image_width = current_canvas_width;
   current_image_height = current_canvas_height;
   offset_horizontal = 0;
   offset_vertical = 0;
  }
}

void calculateModules(){ // calculates pixels to be removed to fit modules precisely in the canvas
  remove_pixels_horizontal = 0;
  remove_pixels_vertical = 0;
  int test_canvas_width = current_canvas_width;
  while(test_canvas_width%module_width != 0){
    test_canvas_width--;
    remove_pixels_horizontal++;
  }
  int test_canvas_height = current_canvas_height;
  while(test_canvas_height%module_height != 0){
    test_canvas_height--;
    remove_pixels_vertical++;
  }
}

int getChar(int in_mean_luminosity){
int get_char = 0;
for(int i = 0; i < ascii_chars.length;i++){
  if(in_mean_luminosity >= i*threshold && in_mean_luminosity < (i+1)*threshold){
    get_char = i;
    if(in_mean_luminosity >= 224){
      get_char = ascii_chars.length-1;
    }
  }
  else if(in_mean_luminosity >= threshold*ascii_chars.length/* && in_mean_luminosity<256*/){
    get_char = ascii_chars.length-1;
  }
}
return get_char;
}

//// --- IN FUNCTIONS --- //

void getVideo(int wi, int he){
  video_width = wi;
  video_height = he;
}

//// --- DRAW --- //
void drawAscii(int current_image){
  //var check_existing_canvas = document.getElementById('image_processing');
  //if(check_existing_canvas != null){
  //  check_existing_canvas.parentNode.removeChild(check_existing_canvas);
  //}
  //var canvas  = document.createElement("canvas");//document.getElementById("ex1");
  //canvas.setAttribute('width', Math.floor(current_image_width));
  //canvas.setAttribute('height', Math.floor(current_image_height));
  //canvas.id = 'image_processing';
  //document.body.appendChild(canvas);
  //var context = canvas.getContext("2d");
  //context.drawImage(current_image, 0, 0, Math.floor(current_image_width), Math.floor(current_image_height));
  //var image_data = context.getImageData(0, 0, Math.floor(current_image_width), Math.floor(current_image_height));

  //var check_existing_div = document.getElementById('video_text');
  //if(check_existing_div != null){
  //  check_existing_div.parentNode.removeChild(check_existing_div);
  //}
  //var div = document.createElement('div');
  //div.id="video_text";
  //div.style.width = current_canvas_width+"px";
  //div.style.height = current_canvas_height+"px";
  //div.style.position = "absolute";
  //div.style.top = "0px";
  //div.style.marginLeft = "0px";
  //div.style.color = current_font_color;
  //div.style.fontSize = current_font_size+"px";
  //div.style.fontWeight = current_font_weight;
  //div.style.lineHeight = current_line_height+"px";
  //div.style.letterSpacing = current_letter_spacing;

  //var start_offset_horizontal = Math.floor(offset_horizontal/2);
  //var start_offset_vertical = Math.floor(offset_vertical/2);
  //var origin_index = 0;
  //var index = 0;
  //var mean_rgb = 0;
  //var mean_luminosity = 0;

  //for(var j = start_offset_vertical;j < (current_canvas_height + start_offset_vertical - remove_pixels_vertical); j+=module_height){
  //  for(var i = start_offset_horizontal; i < (current_canvas_width + start_offset_horizontal - remove_pixels_horizontal); i+=module_width){
  //    origin_index = (i+(j*Math.floor(current_image_width)))*4;
  //    for(var n = 0; n < module_height; n++){
  //      for(var m = 0; m < module_width; m++){
  //        index = origin_index+((m+(n*Math.floor(current_image_width)))*4);
  //        mean_rgb = Math.floor((image_data.data[index]+image_data.data[index+1]+image_data.data[index+2])/3);
  //        mean_luminosity += mean_rgb;
  //        }
  //    }
  //    mean_luminosity/=(module_width*module_height);
  //    mean_luminosity = Math.floor(mean_luminosity);

  //    if(i === start_offset_horizontal && j != start_offset_vertical){
  //      //div.innerHTML += jump line;
  //    }
  //    div.innerHTML += ascii_chars[master.getChar(mean_luminosity)];
  //    mean_luminosity = 0;
  //  }
  //}
  //document.body.appendChild(div);
}

//// --- UPDATE --- //

void resetAscii(){
  // current_text = new Array();
  // text_canvas = undefined;
  // count_current_words = 0;

  // current_button = new Array();
  // button_canvas = undefined;

  // module_width = current_font_size;
  // module_height = current_font_size;

  offset_vertical = 0;
  offset_horizontal = 0;
  remove_pixels_vertical = 0;
  remove_pixels_horizontal = 0;

  //var current_image = new Image();
  // current_image = undefined;
  current_image_width = 0;
  current_image_height = 0;

  // click = "";
}
  
////void update() { 
////  ypos += speed; 
////  if (ypos > height) { 
////    ypos = 0; 
////  } 
////  line(0, ypos, width, ypos); 
////} 
  
} 