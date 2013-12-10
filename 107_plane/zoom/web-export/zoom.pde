float top, t;

void setup() {
  size(1280,720);
  noStroke();
  top = 20;
  t = width/3;
  rectMode(CORNERS);
}

void draw() {
  background(220);
  top = min(mouseY, height/2)*1-50;
  fill(#5298F2);
  //rect(0,0, width/3,height);
  quad(0,0, t,top, t,height-top, 0,height); 
  fill(#44D2F2);
  rect(t,top, t*2,height-top);
  fill(#44F2C1);
  //rect(width/3*2,0 , width, height);
  quad(t*2,top, width,0, width,height, t*2,height-top);
  //println(pmouseY);
}

