// - IMAGE
PImage compass;
float scale = 0.25;
float offset_x = 0;
float offset_y = 0;

// - PHYSICS
// -- GENERAL
float angle = 0;
float speed = 0;
float acceleration = 0.02;
float speed_limit = 8;

// -- COMPASS
int duration = 0;
int min_duration = 30;
int max_duration = 150;
int current_frame = 0;

boolean allow_inversion = true;


void setup() {
  size(640, 480);
  compass = loadImage("bussola.jpg");
  compass.resize(int(compass.width*scale), int(compass.height*scale));
  frameRate(30);

  duration = int(random(min_duration, max_duration));
}

void draw() {
  updateCompass();

  /*
   limita a velocidade à velocidade máxima
   considerando valores positivos e negativos
   */
  if (speed > 0 && speed + acceleration < speed_limit) {
    speed += acceleration;
  } else if (speed <= 0 && speed + acceleration > -speed_limit) {
    speed += acceleration;
  }

  angle += speed; // atualiza o ângulo com base nos cálculos efetuados

  // desenha e rotaciona a bússola
  pushMatrix();
  translate(width/2, height/2);
  rotate(radians(angle));
  image(compass, -compass.width/2-offset_x, -compass.height/2-offset_y);
  popMatrix();

  current_frame++;
}

void updateCompass() {
  monitorInversion(); // função que monitora a desaceleração da bússola

  // checa que chegamos na duração prevista e se a inversão de movimento pode ocorrer
  if (current_frame >= duration && allow_inversion) {
    /*
     inverte a aceleração e trava qualquer inversão posterior até que
     a desaceleração seja concluída (cálculo disso ocorre na função monitorInversion());
     */

    acceleration *= -1;
    allow_inversion = false;
  }
}

void monitorInversion() {
  if (!allow_inversion) {
    /* 
     se velocidade for negativa e aceleração positiva ou se
     velocidade for positiva e aceleração negativa, significa que
     a bússola está desacelerando; nesse caso, a aceleração não pode
     ser invertida e o movimento atual deve continuar até que a
     bússola volte a acelerar.
     
     em todas as outras situações (velocidade e aceleração ambas positivas
     ou ambas negativas), deve-se calcular um período para ocorrer a próxima
     inversão de aceleração e essa alteração de comportamento deve ser
     autorizada
     */

    if (speed < 0 & acceleration > 0) { 
      // não fazer nada
    } else if (speed > 0 & acceleration < 0) {
      // não fazer nada
    } else {
      // autorizar inversão e calcular duração até a próxima inversão
      allow_inversion = true;
      current_frame = 0;
      duration = int(random(min_duration, max_duration));
    }
  }
}
