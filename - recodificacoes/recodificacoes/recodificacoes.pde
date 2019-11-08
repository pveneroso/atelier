import processing.pdf.*;

String text = "RECODIFICAR";// da exposição;
//String text = "PEDRO VENEROSO";
//String text = "20/11/2019";
float x, y, w;
PFont font;
PGraphics pg;

void setup(){
  size(1400, 600);
  noStroke();
  smooth();
  background(255);
  pg = createGraphics(width, height, PDF, "arte/"+text+".pdf");
  
  font = createFont("Fakt", 12);
  textFont(font);
  textAlign(CENTER, CENTER);
  
  pg.beginDraw();
  pg.background(255);
  pg.noStroke();
  pg.textFont(font);
  pg.textAlign(CENTER, CENTER);
  w = 84;//(width-200)/text.length();
  y = height/2;
  for(int i = 0; i < text.length(); i++){
    x = 100+(i*w);
    //println(int(text.charAt(i)));
    code(calc(int(text.charAt(i))), x, y, text.charAt(i));
  }
  pg.dispose();
  pg.endDraw();
}

int[] calc(int character){
  int a = floor(character/(pow(4,3)));
  character -= (a*(pow(4,3)));
  int b = floor(character/(pow(4,2)));
  character -= (b*(pow(4,2)));
  int c = floor(character/(pow(4,1)));
  character -= (c*(pow(4,1)));
  int d = floor(character);
  int[] result = {a, b, c, d};
  return result;
}

void code(int[] result, float x, float y, char c){
  //println(result);
  for(int i = 0; i < result.length; i++){
    checkColor(result[i]);
    float tx = x+18+(i*16);//x+10+(i*((w-20)/4));
    ellipse(tx, y, 12, 12);
    pg.ellipse(tx, y, 12, 12);
    fill(0);
    pg.fill(0);
    text(result[i], tx, y-50);
    pg.text(result[i], tx, y-50);
  }
  //stroke(0);
  //noFill();
  //rect(x, y-(w/2), w, w);
  //noStroke();
  fill(0);
  pg.fill(0);
  //text(c, x+(w/2)-8, y+30);
  text(int(c), x+(w/2), y-100);
  pg.text(int(c), x+(w/2), y-100);
  text(c, x+(w/2), y-150);
  pg.text(c, x+(w/2), y-150);
}

void checkColor(int c){
      //if(result[i] == 1){ //0
    //  fill(216, 29, 29);
    //}
    //else if(result[i] == 2){//1
    //  fill(75, 75, 191);
    //}
    //else if(result[i] == 0){//2
    //  fill(255);
    //}
    //else{
    //  fill(229, 217, 0);//
    //}
    if(c == 0){ 
      fill(216, 29, 29);
      pg.fill(216, 29, 29);
    }
    else if(c == 1){
      fill(75, 75, 191);
      pg.fill(75, 75, 191);
    }
    else if(c == 2){
      fill(44, 145, 89);
      pg.fill(44, 145, 89);
    }
    else{
      fill(229, 217, 0);
      pg.fill(229, 217, 0);
    }
}
