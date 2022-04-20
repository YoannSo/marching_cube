final int rez =30 ;
final int N = 1;
final float radius = 50;
final float vel = 2;
final int REC_INTERP = 5;
float[][][] field;
int cols, rows;
float posXCam=0;
void setup(){
size(500, 500,P3D);
  cols = 1 + width / rez;
  rows = 1 + height / rez;
  field = new float[cols][cols][rows];
  
  camera(width/2,height/2,-500,width*0.5,height*0.5,0,0,1,0);
}

void draw(){
 background(0); 
posXCam+=1;
  
  stroke(255);
  noFill();
 for (int i = 0; i < cols-1; i++) {
   for(int k=0;k<cols-1;k++){
    for (int j = 0; j < rows-1; j++) {
      point(i*rez,k*rez,j*rez);
    }
   }
  }

    camera(posXCam,height/2,-500,width*0.5,height*0.5,0,0,1,0);


}
