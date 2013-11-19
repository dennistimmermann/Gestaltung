PShape pin;
float angle, count;
boolean clicked;

void setup() {
  size(1280,720);
  pin = loadShape("pin.svg");
  pin.disableStyle();
  noStroke();
  clicked = false;
  angle = count = 0;
}

void draw() {
  background(#A5C65B);
  //angle = norm(mouseX, 0, width);
  if(clicked) {
    count += 0.01;
    angle = min(count, 1);
  }
  pushMatrix();
  translate(width/2,height/2+200);
  
  pushMatrix();
  rotate(-PI/7*angle);
  shearX(PI/7*angle);
  scale(1-(0.2y*angle));
  fill(100, 100);
  shape(pin, -200, -400, 400, 400);
  popMatrix();

  fill(#F2EFC4);
  shape(pin, -200, -400, 400, 400);

  fill(0,100);
  popMatrix();
  text("Pin Icon CC BY-SA 3.0 Timothy Miller", width-240, height-20);
}

void mouseClicked() {
  count = 0;
  clicked = true;
}
