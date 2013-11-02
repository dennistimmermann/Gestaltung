float off;
boolean exit ;

ArrayList<Line> s = new ArrayList<Line>(); //fixed lines
ArrayList<Line> l = new ArrayList<Line>(); //lines moving to the left...
ArrayList<Line> r = new ArrayList<Line>(); //...and right

void setup(){
  size(1280,720);
  strokeCap(SQUARE);
  strokeWeight(0.2);

  //H1
  s.add(new Line(0,0,0,4));
  s.add(new Line(0,5,0,9)); //r
  r.add(new Line(0,4,0,5));

  //H2
  s.add(new Line(2,0,2,9));

  //a1
  s.add(new Line(4,6,4,8));
  r.add(new Line(4,5,4,6)); //r
  r.add(new Line(4,8,4,9)); //r

  //a2
  s.add(new Line(6,5,6,8));
  l.add(new Line(6,4,6,5)); //b

  //l1
  s.add(new Line(8,0,8,8));
  r.add(new Line(8,8,8,9)); //r

  //l2
  s.add(new Line(10,0,10,8));
  r.add(new Line(10,8,10,9)); //r

  //o1
  s.add(new Line(12,5,12,8));
  r.add(new Line(12,8,12,9)); //r

  //o2
  s.add(new Line(14,5,14,8));
  l.add(new Line(14,4,14,5)); //b

}

class Line {
  public int x1, x2, y1, y2;
  Line(int _x1, int _y1, int _x2, int _y2) {
    x1 = _x1;
    x2 = _x2;
    y1 = _y1;
    y2 = _y2;
  }
}

void draw() {
  exit = false;

  background(145,196,108);
  stroke(84,122,74);
  scale(50);
  translate(6.5,3);

  noSmooth();
  off = 1.0*pmouseX/width;
  while(true) {
    for(Line part : s) {
      line(part.x1, part.y1, part.x2, part.y2);
    }
    for(Line part : r) {
      line(part.x1 + off, part.y1, part.x2 + off, part.y2);
    }
    for(Line part : l) {
      line(part.x1 - off, part.y1, part.x2 - off, part.y2);
    }
    if(exit) {
      break;
    }
    translate(-0.1,-0.1);
    stroke(252,255,245);
    //filter(BLUR, 4); //set for smooth shadow
    exit = true;
  }
}
