import java.util.Random;

ArrayList<Particle> ps;
ArrayList<Particle> lost;
int encounter = 600;
boolean loseShit = false;
int shitLost = 0;

float destination;

void setup() {

  size(1280,720);
  ps = new ArrayList<Particle>();
  lost = new ArrayList<Particle>();

  destination = width/2;
  

  //ps.add(new Particle(30,30));
  //ps.add(new Particle(70,70));

  for(int i = 50; i > 0; i--) {
  }
  
  noLoop();

}

void draw() {
  

  if(encounter == 0) {
    encounter = frameCount + (int) random(max(1,50-shitLost),max(5,320-shitLost*2)+1);
    if(loseShit) {
      shitLost += 20;
    }
  }

  if(frameCount%30 == 0 && ps.size() < 64 && !loseShit) {
    ps.add(new Particle(random(0,width),height+10));
  }

  if(frameCount == encounter && ps.size() > 0) {
    //println(ps.size());
    Particle removed = ps.remove(int(random(0,ps.size()-1)));
    removed.acceleration = new PVector(randd()*random(5,10), random(0,3));
    lost.add(removed);
    encounter = 0;
  }
  fill(0);
  //noStroke();
  background(255);

  boolean first = true;

  for(Particle p : ps) {
    if(first) {
      ps.get(0).moveTo(new PVector(destination, 200));
      first = false;
    }
    else {
      
      p.checkCollision();
      p.getInLine();
      p.draw();
    }
  }
  for(Particle p : lost) {
    p.move();
    p.draw();
  }
  //ps.get(1).getInLine();

  //noLoop();
}

class Particle {

  float speed = 3.0;

  PVector location;
  PVector velocity = new PVector(0,0);
  PVector acceleration = new PVector(0,0);

  Particle nearest = null;
  float distance;

  float divX, divY;

  Particle(float x, float y) {
    location = new PVector(x,y);

    divX = random(-5,6);
    divY = random(-3,3);
  }

  void checkCollision() {
    for(Particle p : ps) {
      if(p == this) {
        //println("thats me");
      }
    }
  }

  void findNearest() {
    for(Particle p : ps) {
      if(p == this)
        continue;
      float dist = location.dist(p.location);
      if(nearest == null || abs(dist) < distance) {
        nearest = p;
        distance = dist;
      } 
    }
  }

  Particle findPrevInLine() {
    int index = ps.indexOf(this);
    if(index > 0) {  //maaaaaaybe?
      return ps.get(index-1);
    }
    return null;
  }

  void moveToNearest() {
    findNearest();
    if(nearest != null)
      moveTo(nearest.location);
  }

  void getInLine() {
    Particle q = findPrevInLine();

    if(q != null) {
      //moveTo(new PVector(q.location.x, q.location.y + 30));
      if(acceleration.mag() < 3) {
        moveTo(new PVector(q.location.x + q.divX, q.location.y + 10));
      }
      else {
        moveTo(new PVector(destination, q.location.y + 10));
      }
    }
  }

  void moveTo(PVector target) {
    //PVector mouse = new PVector(mouseX,mouseY);
    PVector dir = PVector.sub(target, location);

    //dir.normalize();
    dir.mult(0.1);

    acceleration = dir;

    velocity.add(acceleration);
    //velocity.limit(topspeed);
    //acceleration.limit(5);
    //location.add(acceleration);
    if(acceleration.mag() > 0.1) {
      move();
    }

  }

  void move() {
    acceleration.limit(5);
    location.add(acceleration);
  }

  void draw() {
    ellipse(location.x, location.y+divY, 4, 4);
  }
}

void mousePressed() {
  loseShit = true;
  println("oh noes");
}

void keyPressed( ) {
  if(key == ' ')
    loop();
}

int randd() {
  Random r = new Random();
  return r.nextBoolean() ? -1 : 1;
}
