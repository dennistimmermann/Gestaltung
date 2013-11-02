ArrayList<Point> points = new ArrayList<Point>();
float state = 0;

void setup() {
  frameRate(30);
  size(1280,720);
  
  createPattern();
  points.subList(100,points.size()).clear();
  println(points.size());
  noLoop();
}

void draw() {
  background(250,250,250);
  translate(12.5,10);
  noStroke();
  drawState(state); 
  if(state == 0 || state == 3 || state == 9 || state == 27 || state == 99) {
    //saveFrame("dots-######.jpg"); //uncomment to save frames
  }
  //println(state);
  if(state < 100) {
    state += 1;
  } else {
    //draw to different panes
    translate(256,0);
    drawState(27);
    fill(250,250,250,455-frameCount*2);
    rect(0,0,256,720);
    translate(256,0);
    drawState(9);
    fill(250,250,250,505-frameCount*2);
    rect(0,0,256,720);
    translate(256,0);
    drawState(3);
    fill(250,250,250,555-frameCount*2);
    rect(0,0,256,720);
    translate(256,0);
    drawState(0);
    fill(250,250,250,605-frameCount*2);
    rect(-10,-10,256,720);
    println(frameCount);
  }
  
}

void drawState(float st) {
  float s = 0;
  for(Point p : points) {
    fill( 66 * (1-s) + 201 * s , 31 * (1-s) + 64 * s , 62 * (1-s) + 83 * s); 
    ellipse( (p.x * (1-st/100) + p.x2 * st/100), 
             (p.y * (1-st/100) + p.y2 * st/100),
             4, 4);
    s += 0.01;
  }
}

void drawRapport(int px, int py) {
  points.add(new Point(0 + px,  0 + py));
  points.add(new Point(1 + px, 0 + py));
  points.add(new Point(2 + px, 0 + py));
  points.add(new Point(3 + px, 0 + py));
  points.add(new Point(0 + px,  1 + py));
  points.add(new Point(1 + px, 1 + py));
  points.add(new Point(0 + px, 2 + py));
  points.add(new Point(2 + px, 2 + py));
}

void createPattern() {
  int i = 0;

  while(points.size() < 101) {
      drawRapport(3,0 + i * 6);
      drawRapport(0,3 +  i * 6);
      drawRapport(6,3 +  i * 6);
      i++;
  }

}

class Point {
  public int x, y, x2, y2;

  Point(int _x, int _y) {
    x = _x * 256/10;
    y = _y * 720/25;

    x2 = (int) random(0,256-20);
    y2 = (int) random(0,720-20);
  }
}

void mouseClicked() {
  loop();
  state = 0;
  frameCount = 1;
}
