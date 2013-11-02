import java.util.Collections;
import java.util.*;
import de.looksgood.ani.*;

MainCluster main;
Stack<Cluster> leftCluster;
Stack<Cluster> rightCluster;
boolean check = false;

float offLeft, offRight, off, rotation, cameraZ, fov, angle, trWin, trLose;

PImage bg, lose, win, keys;

void setup() {

  size(1280, 720, P3D);
  angle = 0.0;
  cameraZ = (height/2.0) / tan(fov/2.0);
  Ani.init(this);
  
  bg = loadImage("bg.png");
  win = loadImage("win.png");
  lose = loadImage("lose.png");
  keys = loadImage("keys.png");

  String two = "";
  String one = "4321";

  ArrayList<String> permlist = new ArrayList<String>();
  offLeft = offRight = 0;
  leftCluster = new Stack<Cluster>();
  rightCluster = new Stack<Cluster>();

  permutate(one, two, permlist);
  Collections.shuffle(permlist);
  println(permlist.size());

  for(int n = 0; n < 12; n++) {
    leftCluster.push(new Cluster(permlist.get(n),     n));
    rightCluster.push(new Cluster(permlist.get(n+12), n));
  }

  //clust = new Cluster("1234",0,0);
  main = new MainCluster("2314",0);
  //pl();

}

void pl() {
  leftCluster.pop();
  setRot();
}

void pr() {
  rightCluster.pop();
  setRot();
}

void setRot() {
  angle = (rightCluster.size()-leftCluster.size()) * 0.1;
  Ani.to(this, 2, "rotation", angle, Ani.BACK_OUT);
  if(abs(angle) > 0.3) {
    println("you lose");
    Ani.to(this, 2, "trLose", 255); 
  }
  if(rightCluster.empty() && leftCluster.empty()) {
      Ani.to(this, 2, "trWin", 255);
      println("you win");
    }
}

void bounce(float where) {
  if(where > 0) {
    Ani.to(this, 0.5, "offLeft", offLeft+1, Ani.QUAD_IN, "onEnd:pl");
    Ani.to(leftCluster.peek(), 0.5, "s", 0, Ani.SINE_IN);
  }
  else {
    Ani.to(this, 0.5, "offRight", offRight+1, Ani.QUAD_IN, "onEnd:pr");
    Ani.to(rightCluster.peek(), 0.5, "s", 0, Ani.SINE_IN);
  }
  //angle = (-1.0 * (leftCluster.size()-rightCluster.size()) + (1.0 * (rightCluster.size() - leftCluster.size())))*0.1;//((rightCluster.size()-leftCluster.size())) * 0.1;
  //Ani.to(this, 0.2, 0.5, "off", where, Ani.QUAD_OUT, "onEnd:rebounce");
}
void rebounce() {
  Ani.to(this, 0.4, "off", 0, Ani.BACK_IN);
}



void draw() {
  pushMatrix();
  camera(width/2 + ( (mouseX-width/2) / 40), height/2.5- ( (mouseY) / 10), 330.0, width/2, height/2, 0.0, 0.0, 1.0, 1.0); 
  image(bg,0,0);
  background(220,230*(1-abs(rotation)),220*(1-abs(rotation)), 100);
  
  translate(width/2, height/2+40, -200);
  rotate(rotation);
  translate(off-30, 0);
  
  //ellipse(0,0,20,20);
  pushMatrix();
  translate(0,0,-20);
  scale(2);
  main.draw();
  popMatrix();
  pushMatrix();
  translate( (14-offLeft) * -40 + 20, 0);
  for(Cluster c : leftCluster) {
    translate(40,0);
    c.draw();
  }
  popMatrix();
  pushMatrix();
  translate( (14-offRight) * 40 +20, 0);
  for(Cluster c : rightCluster) {
    translate(-40,0);
    c.draw();
  }
  popMatrix();

  if(check) {
    check = false;
    //println("going to check for " + main.type);
    //println("need " + leftCluster.peek().type);
    if(!leftCluster.empty() && main.type.equals(leftCluster.peek().type)) {
      bounce(5);
    }
    if(!rightCluster.empty() && main.type.equals(rightCluster.peek().type)) {
      bounce(-5);
    }
    
  }
  popMatrix();
  
  tint(255,trLose);
  image(lose,0,0);
  tint(255,trWin);
  image(win,0,0);
  tint(255,127);
  image(keys,50,50);
}

void permutate(String head, String tail, ArrayList<String> out) {
  if(head.length() != 0) {
    for(int i = 0; i < head.length(); i++) {
      String e = "" + head.charAt(i);
      String h = head.replace(e, "");
      String t = tail + e;
      permutate(h, t, out);
    }
  } 
  else {
    //println("ende" + tail);
    out.add(tail);
  }
}

class Cluster {

  String type;
  int x, y;
  float s;

  Cluster(String _type, int _x) {
    type = _type;
    x = _x;
    s = 1;
  }

  void draw() {
    int k = 0;
    float red = 0;
    stroke(216,242,240,20*s);
    for(int i = 0; i < 2; i++) {
      for(int j = 0; j < 2; j++) {
        pushMatrix();
        translate(j * 20, i * 20);
        //scale(s);
        switch(type.charAt(k)) {
        case '1':
          fill(15, 45, 64,250*s);
          break;
        case '2':
          fill(25,71,89,250*s);
          translate(20,0);
          rotateZ(PI/2);
          break;
        case '3':
          fill(41,107,115,250*s);
          translate(20,20);
          rotateZ(PI);
          break;
        case '4':
          fill(62,140,132,250*s);
          translate(0,20);
          rotate(PI * 1.5);
          break;
        }
        drawL();
        //pushMatrix();
        //scale(s);
        //box(20,20, 20);y
        popMatrix();
        k++;
      }
    }
  }
}

class MainCluster extends Cluster {

  MainCluster(String _type, int _x) {
    super(_type, _x);
  }

  void swap(int what) {
    switch(what) {
    case UP:
      type = "" + type.charAt(1) + type.charAt(0) + type.charAt(2) + type.charAt(3);      
      break;
    case DOWN:
      type = "" + type.charAt(0) + type.charAt(1) + type.charAt(3) + type.charAt(2);      
      break;
    case LEFT:
      type = "" + type.charAt(2) + type.charAt(1) + type.charAt(0) + type.charAt(3);      
      break;
    case RIGHT:
      type = "" + type.charAt(0) + type.charAt(3) + type.charAt(2) + type.charAt(1);      
      break;
    }
  }
}

void keyPressed() {
  check = true;
  main.swap(keyCode);
}

void drawL() {
  beginShape();
  vertex(0,0,0);
  vertex(10,0,0);
  vertex(10,10,0);
  vertex(20,10,0);
  vertex(20,20,0);
  vertex(0,20,0);
  endShape(CLOSE);
  
  beginShape();
  vertex(0,0,20);
  vertex(10,0,20);
  vertex(10,10,20);
  vertex(20,10,20);
  vertex(20,20,20);
  vertex(0,20,20);
  endShape(CLOSE);
  
  beginShape();
  vertex(0,0,0);
  vertex(0,20,0);
  vertex(0,20,20);
  vertex(0,0,20);
  endShape(CLOSE);
  
  beginShape();
  vertex(0,20,0);
  vertex(20,20,0);
  vertex(20,20,20);
  vertex(0,20,20);
  endShape(CLOSE);
  
  beginShape();
  vertex(0,0,0);
  vertex(10,0,0);
  vertex(10,0,20);
  vertex(0,0,20);
  endShape(CLOSE);
  
  beginShape();
  vertex(20,20,0);
  vertex(20,10,0);
  vertex(20,10,20);
  vertex(20,20,20);
  endShape(CLOSE);
  
  beginShape();
  vertex(10,10,0);
  vertex(20,10,0);
  vertex(20,10,20);
  vertex(10,10,20);
  endShape(CLOSE);
  
  beginShape();
  vertex(10,0,0);
  vertex(10,10,0);
  vertex(10,10,20);
  vertex(10,0,20);
  endShape(CLOSE);
}
