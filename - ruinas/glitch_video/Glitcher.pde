class Glitcher{
  PImage original;
  PGraphics pg, text;
  PFont font;
  PVector acceleration, velocity;
  PVector temp;
  int force_counter = 0;
  
  float angle_x = 0;
  float angle_y = 0;
  int offset_x, offset_y;
  
  float random_angle_x, random_angle_y;
  float sin_x_min = 0.1; // 0.1
  float sin_x_max = 12;  // 12
  float sin_y_min = 0.01; // 0.1
  float sin_y_max = 4;   // 2
  
  int random_x_shift, random_y_shift;
  float shift_x_min = 0;
  float shift_x_max = 0;
  float shift_y_min = 0;
  float shift_y_max = 0;
  
  float xoff, yoff, zoff, inc;
  
  FloatList angles_x;
  FloatList angles_y;
  
  float amplitude_x = 80;
  float amplitude_y = 3;
  
  float angle_ref = 0;
  int end_offset_y = 0;
  int first_line = 0;
  int last_line = 0;
  boolean keep_checking = true;
  
  float scale = 1.2;
  float y_modifier = 1;
  float max_amplitude_x = 80;
  
  int crop_y = 0;
  
  AudioInput audio;
  //AudioPlayer audio;
  
  Glitcher(){
    acceleration = new PVector(0,0);
    velocity = PVector.fromAngle(radians(90));
    velocity.normalize();
    random_angle_x = random(sin_x_min,sin_x_max);
    random_angle_y = random(sin_y_min,sin_y_max);
    
    inc = 1;
    xoff = 0;
    yoff = 0;
    zoff = 0;
    
    angles_x = new FloatList();
    angles_y = new FloatList();
    
    for(int i = 0; i < 50; i ++){
      angles_x.append(random(sin_x_min,sin_x_max));
      angles_y.append(random(sin_y_min,sin_y_max));
    }
    //noiseSeed(20);
  }
  
  void loadGlitch(PImage in_original){
    original = in_original;
  }
  
  void updateGlitch(AudioInput _in){ // AudioPlayer _in
    audio = _in;   
    amplitude_x = map((_in.left.level()+in.right.level())/2, 0, 0.5, 0, max_amplitude_x);
    //println("lvl "+_in.left.level());
  }
  
  void glitchImage(){
    //PImage original_manipulated = original.get(0,crop_y,width,height-crop_y);
    
    pg = createGraphics(int(original.width*1.4), int(original.height*1.05));
    offset_x = int((pg.width-original.width)/2);
    offset_y = 0;
    pg.beginDraw();
    pg.loadPixels();
    original.loadPixels();
    
    random_angle_x = map(noise(xoff),0,1,sin_x_min,sin_x_max);
    random_angle_y = map(noise(yoff),0,1,sin_y_min,sin_y_max);
    angle_x = 0;
    angle_y = 0;
    keep_checking = true;
    first_line = 0;
    last_line= 0;
    end_offset_y = 0;
    
    int size_x = width;
    int size_y = size_x*pg.height/pg.width;
    
    for(int y = 0; y < pg.height; y++){
      for(int x = 0; x < pg.width; x++){
        int index = y*pg.width+x;
        if(x > offset_x && x < offset_x+original.width){
          int original_index = (offset_y*original.width)+(x-offset_x);
          if(original_index >= 0 && original_index < original.width*original.height){
            pg.pixels[index] = original.pixels[original_index];
          }
          else {
            pg.pixels[index] = color(0);
          }
        }
        else {
          pg.pixels[index] = color(0);
        }
      }
      
      calculateAngles(y);
      checkEndImage(y, size_y);
    }
    
    //drawEndLine(last_line);
    //drawEndLine(first_line);
    pg.updatePixels();
    pg.endDraw();
    //pg.save(file_name+current_counter+file_extension);
    
    // DISPLAY BKUP
    //int off_y = (height-int((last_line*size_y)/pg.height))/2; 
    //image(pg,0, off_y, size_x, size_y);
    
    // SCALE
    float scale_corrector_x = (width-(size_x*scale))/2;
    int off_y = (height-int((last_line*size_y*scale)/pg.height))/2; 
    image(pg,scale_corrector_x, off_y, size_x*scale, size_y*scale);
    
    // BKUP
    //image(pg,(width-((pg.width*height)/pg.height))/2,0,((pg.width*height)/pg.height),height);
    //image(pg,0,width/pg.width*width,0, height/pg.height*height);
    
    // DEBUG POSITION
    //stroke(0,0,255);
    //line(0,size_y+off_y, width, size_y+off_y);
    //line(0,height/2, width, height/2);
    
    zoff += 0.01;
    xoff = 0;
    yoff = 0;
    
    angle_ref+=30;
    if(angle_ref>=360){
      angle_ref = 0;
    }
  }
  
  void calculateAngles(int index){
    int get_element = floor(map(index,0,pg.height,0,audio.bufferSize()));
    
    if(angle_y > 359){
      //random_angle_y = random(sin_y_min,sin_y_max);
      //random_angle_y = (sin_y_min+sin_y_max)/2;
      //random_angle_y = map(noise(yoff),0,1,sin_y_min,sin_y_max);
      if(int(yoff) < angles_y.size()){
        random_angle_y = angles_y.get(int(yoff));
      }
      else{
        angles_y.append(random(sin_x_min,sin_x_max));
        random_angle_y = angles_y.get(int(yoff));
      }
      angle_y = 0;
      yoff += inc;
    }
    angle_y += random_angle_y;
    
    offset_y += int((sin(radians(angle_y))*amplitude_y)+y_modifier);
    //float manipulation_y = (audio.left.get(get_element)*amplitude_y)+1;
    //offset_y += int(manipulation_y);//audio.left.level()*amplitude_y
    
    if(angle_x > 359){
      //random_angle_x = (sin_x_min+sin_x_max)/2;
      //random_angle_x = random(sin_x_min,sin_x_max);
      //random_angle_x = map(noise(xoff),0,1,sin_x_min,sin_x_max);
      if(int(xoff) < angles_x.size()){
        random_angle_x = angles_x.get(int(xoff));
      }
      else{
        angles_y.append(random(sin_x_min,sin_x_max));
        random_angle_y = angles_y.get(int(yoff));
      }
      angle_x = 0;
      xoff+=inc;
    }
    angle_x += random_angle_x;
    
    float manipulation = map((audio.left.get(get_element)),0,1,0,amplitude_x);
    offset_x = int(manipulation+((pg.width-original.width)/2));
  }
  
  void checkEndImage(int y, int _size_y){
    int index = int((pg.width*y)+(pg.width/2));
    first_line = 0;
    
    if(color(pg.pixels[index]) != color(0)){
      last_line = y;
    }
    
    if(y == pg.height-1){
      //end_offset_y = (pg.height-(last_line - first_line))/2;
      int convert_last_line = int((last_line*_size_y)/pg.height); // last > pg.height -- x > size y
      end_offset_y = (_size_y-convert_last_line)/2;
    }
  }
  
  void drawEndLine(int y){
      for(int i = 0; i < pg.width; i++){
        int ind = y*pg.width+i;
        pg.pixels[ind] = color(255,0,0);
      }
  }
  
  void increaseAmpY(){
    if(amplitude_y <= 20){
      amplitude_y += 1;
    }
  }
  
  void decreaseAmpY(){
    if(amplitude_y >= 0.1){
      amplitude_y -= 1;
    }
  }
  
  void setAmpY(int value){
    amplitude_y = map(value,0, 1023, 0.1, 20);
    //println(amplitude_y);
  }
  
  void setModifierY(int value){
    y_modifier = map(value,0, 1023, 0.0, 2);
    //println(y_modifier);
  }
  
  void setAmpX(int value){
    max_amplitude_x = map(value, 0, 1023, 0, 160);
  }
  
  void setCropY(int value){
    crop_y = int(map(value, 0, 1023, 0, 719));
    //println(crop_y);
  }
  
  void resetValues(){
    //println("go");
    //println(angles_y.size());
    angles_x = new FloatList();
    angles_y = new FloatList();
    for(int i = 0; i < 50; i ++){
      angles_x.append(random(sin_x_min,sin_x_max));
      angles_y.append(random(sin_y_min,sin_y_max));
    }
  }
  
}
