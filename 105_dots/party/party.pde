import ddf.minim.*;
Minim minim;

AudioPlayer player, sirene;

import java.util.Random;

ArrayList<Particle> ps;
ArrayList<Particle> lost;
int encounter = 600;
boolean loseShit = false;
int shitLost = 0;
PVector center;

float destination;

void setup() {

  size(1280,720);
  ps = new ArrayList<Particle>();
  lost = new ArrayList<Particle>();

  minim = new Minim(this);
  player = minim.loadFile("11h30.wav");
  sirene = minim.loadFile("sirene.wav");
  player.play();

  center = new PVector(width/2, height/2);

  destination = width/2;

  for(int i = 120; i > 0; i--) {
    ps.add(new Particle(getRandomLocation()));
  }

}

PVector getRandomLocation() {
    float x,y;
    x = width/2 + randd() * (40 * (7-log(random(0,1000))));
    y = height/2 + randd() * (40 * (6.4-log(random(0,600))));
    return new PVector(x,y);
}

void draw() {
  fill(0);
  background(255);
  for(Particle p : ps) {
    if(!loseShit) {
      p.moveToTarget();
    }
    else {
      p.avoid();
      ellipse(mouseX, mouseY, 4, 4);
    }
    p.draw();
  }  
}

class Particle {

  float speed = 3.0;

  PVector location = new PVector(0,0);
  PVector velocity = new PVector(0,0);
  PVector acceleration = new PVector(0,0);
  PVector target = null;

  Particle nearest = null;
  float distance;

  Particle(float x, float y) {
    location = new PVector(x,y);
  }

  Particle(PVector loc) {
    location = loc;
  }

  void setTarget(PVector _target) {
    target = target;
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

  void avoid() {
    PVector mouse = new PVector(mouseX, mouseY);
    PVector dir = PVector.sub(mouse, location);
    dir.normalize();
    dir.mult(-1);
    dir.setMag(max(1,1/location.dist(mouse)*500)-0.5);
    dir.limit(2);
    location.add(dir);

  }

  void moveToNearest() {
    findNearest();
    if(nearest != null)
      moveTo(nearest.location);
  }

  void getInLine() {
    Particle q = findPrevInLine();

    if(q != null) {
      //moveTo(new PVector(qy.location.x, q.location.y + 30));
      if(acceleration.mag() < 3) {
        moveTo(new PVector(q.location.x, q.location.y + 10));
      }
      else {
        moveTo(new PVector(destination, q.location.y + 10));
      }
    }
  }

  void moveTo(PVector _target) {
    //PVector mouse = new PVector(mouseX,mouseY);
    PVector dir = PVector.sub(_target, location);


    acceleration = dir;
    acceleration.normalize();
    acceleration.setMag(location.dist(center)/10);

    velocity.add(acceleration);
    move();
   

  }

  void moveToTarget() {
    if(target == null || location.dist(target) < 1) {
      target = getRandomLocation();
    }
    moveTo(target);
  }

  void move() {
    //velocity.mult(PVector.sub(location, center).mag()/center.dist(location));
    for(Particle p : ps) {
      if(p != this) {
        if(location.dist(p.location) < 20) {
          velocity.setMag(0.4);
          target.add(PVector.fromAngle(PVector.angleBetween(location, p.location)+random(-PI,PI)));

        }
      }
    }

    velocity.limit(1);
    location.add(velocity);
  }

  void draw() {
    ellipse(location.x, location.y, 4, 4);
  }
}

void mousePressed() {
  loseShit = true;
  println("oh noes");
  //player.close();
  sirene.play();
}

void keyPressed() {
  if(key == ' ') {
    noLoop(); 
  }
}

int randd() {
  Random r = new Random();
  return r.nextBoolean() ? -1 : 1;
}
