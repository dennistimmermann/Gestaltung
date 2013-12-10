float c, x, y;
boolean clicked = false;
color l, d, a, b;

void setup() {
  size(1280,720);
  noStroke();
  c = HALF_PI;
  l = #165659;
  d = #339ABF;
  y = 0;
}

void draw() {

  //background(#383532);
  background(#ffffff);

  translate(width/2, height/2);
  rotate(-0.1);
  
  if(y >= 0) {
    drawSun();
  }

  x = cos(c)*500;
  y = sin(c)*120;

  if(y >= 0) {
    a = l;
    b = d;
  } else {
    a = d;
    b = l;
  }

  pushMatrix();
  fill(b);
  translate(x,y);
  ellipse(0,0,100,100);

  fill(a);
  
  if(y < 0) {
    rotate(PI);
  }

  if(x > 0) {
    rotate(PI);
  }

  arc(0,0,100,100,HALF_PI, PI+HALF_PI);
  beginShape();
  vertex(-1,-50);
  float amp = (1-norm(pow(abs(x), 2),0,pow(500, 2)))*66;
  bezierVertex(amp,-50, amp,50, -1,50);
  endShape();
  popMatrix();

  if(y <= 0) {
    drawSun();
  }
  if(clicked)
    c += 0.005;
}

void drawSun() {
  fill(#FFA90D);
  ellipse(0,0,400,400);
}

void mouseClicked() {
  //println(x + " - " + y);
  clicked = !clicked;
}

