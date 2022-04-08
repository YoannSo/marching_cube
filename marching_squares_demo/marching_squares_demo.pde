final int rez = 10;
final int N = 50;
final float radius = 50;
final float vel = 2;
final int REC_INTERP = 5;

float[][] field;
int cols, rows;
ImplicitParticles particles;

float f(float d) {
  return (d < 1) ? 8.0*pow(1 - d*d,2)/9 : 0;
}

void setup() {
  size(500, 500);
  particles = new ImplicitParticles();
  cols = 1 + width / rez;
  rows = 1 + height / rez;
  field = new float[cols][rows];
}

void line(PVector v1, PVector v2) {
  line(v1.x, v1.y, v2.x, v2.y);
}

void draw() {
  background(0); 

  /*
  stroke(255);
  noFill();
  particles.drawCircles();
  */

  /*
  stroke(255);
  for (int i = 0; i < width; i++) 
    for (int j = 0; j < height; j++) 
      if (particles.eval(i,j) == 1) point(i, j);      
  */
  
  for (int i = 0; i < cols-1; i++) {
    for (int j = 0; j < rows-1; j++) {
      float x = i * rez;
      float y = j * rez;
      PVector a = particles.interp(x, y, x + rez, y);
      PVector b = particles.interp(x + rez, y, x + rez, y + rez);
      PVector c = particles.interp(x, y + rez, x + rez, y + rez);
      PVector d = particles.interp(x, y, x, y + rez);
      int state = getState(  particles.evalInt(x,y),
                             particles.evalInt(x+rez,y),
                             particles.evalInt(x+rez,y+rez),
                             particles.evalInt(x,y+rez));
      stroke(255);
      strokeWeight(1);
      switch (state) {
      case 1:  
        line(c, d);
        break;
      case 2:  
        line(b, c);
        break;
      case 3:  
        line(b, d);
        break;
      case 4:  
        line(a, b);
        break;
      case 5:  
        line(a, d);
        line(b, c);
        break;
      case 6:  
        line(a, c);
        break;
      case 7:  
        line(a, d);
        break;
      case 8:  
        line(a, d);
        break;
      case 9:  
        line(a, c);
        break;
      case 10: 
        line(a, b);
        line(c, d);
        break;
      case 11: 
        line(a, b);
        break;
      case 12: 
        line(b, d);
        break;
      case 13: 
        line(b, c);
        break;
      case 14: 
        line(c, d);
        break;
      }
    }
  }
  particles.nextStep();

}

int getState(int a, int b, int c, int d) {
  return a * 8 + b * 4  + c * 2 + d * 1;
}
