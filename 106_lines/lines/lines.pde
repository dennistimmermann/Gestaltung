import de.looksgood.ani.*;
PFont font, font2;

// x,y,z,time
float[][] p = { {    0,   0,    8,   0 },
                {    1,   1,   12,  40 },
                {    2,   4,   14,  60 },
                {    4,   6,   14, 100 },
                {  6.5,   7,   14, 120 }, 
                {    9,   8,   14, 150 },
                { 13.5, 8.5, 12.5, 185 },
                {   18,   9,   11, 220 },
                { 20.5, 9.5,   10, 265 },
                {   23,  10,    8, 290 },
                { 23.5,  13,    8, 325 },
                {   24,  16,    8, 360 },
                {   25,  17,    7, 385 },
                {   26,  19,    0, 420 } };
int r,s,t, cc;
float shx, roty, rotx, scl, f1, f2, f3;

void setup() {
  size(1280,720, P3D);
  r = 25;
  s = 25;
  t = 15;
  cc = 0;
  f1 = 255;
  f2 = f3 = 0;

  Ani.init(this);
  font = loadFont("ab28.vlw");
  font2 = loadFont("ab12.vlw");

  shx = PI/16;
  roty = PI/12;
  rotx = PI/16;
  scl = 0.8;
}

void draw() {
  pushMatrix();
  background(250);
  ortho(0, width, 0, height);
  strokeWeight(1);
  translate(width/2,height/2+110);
  scale(scl);
  shearX(shx);
  rotateY(roty);
  rotateZ(shx);
  fill(#F28850);
  textFont(font2, 12);
  text("Zeit", 13*r+10,5,0);
  rotateX(rotx);

  translate(-26*r/2, -13*s, -12*t);
  
  stroke(#5B696A);
  for(int i = 0; i < p.length-1; i++) {
    line(p[i][0]*r,p[i][1]*s,p[i][2]*t, p[i+1][0]*r,p[i+1][1]*s,p[i+1][2]*t);
  }

  strokeWeight(1);
  stroke(#AA7163,100);
  for(int i = 0; i < p.length; i++) {
    line(p[i][0]*r,p[i][1]*s,p[i][2]*t, map(p[i][3], 0, 420, 0, 26*r) ,13*s,12*t);
  }

  stroke(#F28850);
  line(0*r,13*s,12*t, 26*r,13*s,12*t);

  stroke(#81AC8B);
  line(-0.5*r,12.5*s,12*t, -0.5*r,0*s,12*t);//y
  line(-0.5*s,13*s,11.5*t, -0.5*s,13*s,0*t); //z

  popMatrix();

  textFont(font, 28);
  fill(50, f1);
  text("Übersicht", 30, 50, 0);
  fill(50, f2);
  text("Karte", 30, 50, 0);
  fill(50, f3);
  text("Höhe", 30, 50, 0);

}

void mouseClicked() {
  //saveFrame("##.jpg");
  if(cc == 0) {
    Ani.to(this, 2, "shx", 0);
    Ani.to(this, 2, "roty", 0);
    Ani.to(this, 2, "rotx", 0);
    Ani.to(this, 2, "scl", 1);
    Ani.to(this, 2, "f1", 0);
    Ani.to(this, 2, "f2", 255);
  }
  if(cc == 1) {
    Ani.to(this, 2, "rotx", HALF_PI*-1);
    Ani.to(this, 2, "f2", 0);
    Ani.to(this, 2, "f3", 255);
  }
  if(cc == 2) {
    Ani.to(this, 2, "shx", PI/16);
    Ani.to(this, 2, "roty", PI/12);
    Ani.to(this, 2, "rotx", PI/16);
    Ani.to(this, 2, "scl", 0.8);
    Ani.to(this, 2, "f3", 0);
    Ani.to(this, 2, "f1", 255);
  }

  cc = ++cc%3;
}
