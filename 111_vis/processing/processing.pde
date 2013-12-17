PFont font, headline, sub;
Table table;
float sketch = 1;
float sketcht = 1;
int click = 1;
boolean changed, switched;
int frames;

float[] numbers4, numbers4t;
float[] numbers2, numbers2t;

String lines[];

void setup() {
    table = loadTable("data.csv", "header");
    println(table.getRowCount());
    font = loadFont("rst12.vlw");
    headline = loadFont("ab42.vlw");
    sub = loadFont("rst16.vlw");
    textFont(font, 12);
    size(1280,720, P2D);
    changed = false;
    switched = false;

    numbers4 = new float[table.getRowCount()];
    numbers4t = new float[table.getRowCount()];
    for(int h = 0; h < numbers4.length; h++) {
        numbers4[h] = table.getRow(h).getInt("f_"+click);
        numbers4t[h] = table.getRow(h).getInt("f_"+click);
    }

    numbers2 = new float[table.getColumnCount()];
    numbers2t = new float[table.getColumnCount()];
    for(int h = 0; h < numbers2.length; h++) {
        numbers2[h] = table.getRow(click-1).getInt("f_"+(1+h));
        numbers2t[h] = table.getRow(click-1).getInt("f_"+(1+h));
    }

    frames = 0;

    lines = loadStrings("text.txt");
}

void draw() {

    sketch = ( sketch*8 + sketcht )/9;

    if(sketcht > 4) {
        sketcht = 1;
    }

    if(sketcht < 1) {
        sketcht = 4;
    }

    frames = min(100, frames+3);
    background(250);

    pushMatrix();

    translate(0, (sketch-1) * height * -1);



    int x = 0;
    int y = 0;

    if(sketcht == 1 || sketcht == 2) {

        pushMatrix();

        noStroke();
        fill(#ebfce5);
        rect(0,0,width, height);



        float s = width/50;

        textAlign(LEFT);
        textFont(headline, 42);
        fill(20);
        text("STREUDIAGRAMM", 150, 150);

        rectMode(CORNER);
        noStroke();
        fill(#628163);
        rect(90,110,50,50);

        textAlign(CENTER);
        textFont(font, 12);

        translate(3*s, 20*s +50);


        for(TableRow row : table.rows()) {
            y -= s;
            for(int i = 1; i <= 44; i++) {
                int u = row.getInt("f_"+i);
                fill(100-u*10,155 + u*10,y*-0.2, u*40);
                ellipse(i*s,y,u*3, u*3);
            }
            // println(row.getInt("f_2"));
        }

        stroke(200);
        strokeWeight(1);
        line(0 , s - 45, 0, -10*s - 5);
        line(0, -10*s - 5, -10, -10*s +10);

        fill(150);
        for(int i = 1; i <= 44; i++) {
            fill(#2f7b2b);
            text(""+i, i*s, 10);
        }
        // text("Tasks", 1.5*s, 30);
        // line(s - 45, 250, 45*s, 250);
        rotate(-HALF_PI);
        fill(#2e3f2e);
        text("weeks", 130, -8);
        //translate(500,500);
        popMatrix();
    }

    if(sketcht == 1 || sketcht == 2 || sketcht == 3) {

        pushMatrix();


        translate(0, height);

        fill(#e4f2f3);
        rect(0,0,width, height);

        textAlign(LEFT);
        textFont(headline, 42);
        fill(20);
        text("VERTEILUNG WOCHE "+click, 150, 150);

        rectMode(CORNER);
        noStroke();
        fill(#5c8d9b);
        rect(90,110,50,50);

        textAlign(CENTER);
        textFont(font, 12);

        if(click > 10) {
            click = 1;
        }

        if(click < 1 ) {
            click = 10;
        }

        if(changed) {
            for(int h = 0; h < numbers2t.length; h++) {
                numbers2t[h] = table.getRow(click-1).getInt("f_"+(h+1));
            }
            println("running");
            changed = false;
        }

        for(int h = 0; h < numbers2.length; h++) {
            numbers2[h] = ( numbers2[h]*7 + numbers2t[h] )/8;
        }

        stroke(200);
        strokeWeight(1);
        textAlign(CENTER);

        float s = width/54;

        translate(5*s, 20*s +80);
        // TableRow row = table.getRow(click);

        for(int i = 0; i <= 6; i++) {
            fill(#1ca4af);
            line(0, i * -2 * s, 46*s, i * -2* s);
            fill(#314e57);
            text(""+i, -12, i* -2 * s +4);
        }

        // noStroke();
        stroke(#e1f3f5);
        strokeWeight(3);

        for(int i = 1; i <= 44; i++) {
            fill(#1ca4af);
            rect(i*s, 2, s-3, -2*s*numbers2[i-1]-4);
            fill(#156269);
            text(""+i, (i+0.45)*s, 20);
        }
        popMatrix();
    }

    if(sketcht == 2 || sketcht == 3 || sketcht == 4) {

        pushMatrix();

        translate(0,2*height);

        fill(#f4e3d1);
        rect(0,0,width, height);

        textAlign(LEFT);
        textFont(headline, 42);
        fill(20);
        text("VARIANZ (max/min)", 150, 150);

        rectMode(CORNER);
        noStroke();
        fill(#928e74);
        rect(90,110,50,50);

        textAlign(CENTER);
        textFont(font, 12);

        if(switched) {
            frames = 0;
            switched = false;
        }

        rectMode(CORNERS);
        textAlign(CENTER);
        float s = width/54;
        translate(5*s,20*s +100);
        noStroke();
        for(int i = 1; i <= 6; i++) {
            // line(0, i * -2 * s, 46*s, i * -2* s);
            if(i % 2 == 1) {
                fill(#d0ccb8, 160);
            }
            else{
                // fill(#fafafa);
                fill(#d0ccb8, 90);
            }
            rect(0, i* -2 * s -s, 46*s, i * -2 * s +s);
            fill(#4b493a);
            text(""+i, -12, i* -2 * s);
        }

        for(int i = 1; i <= 44; i++) {

            int max = 0;
            int min = 6;
            for(TableRow row : table.rows()) {
                int k = row.getInt("f_"+i);

                if(k != 0 ) {
                    max = max(max, k);
                    min = min(min, k);
                }
            }
            fill(#fd6861);
            // stroke(#f2f1ed);
            // strokeWeight(3);
            rect(i*s, (-s*min*2 +s)  -(s*(max-min)*1) * (1 - 0.01 * min(100, frames)), i*s + 18,  (-s*max*2 -s) +(s*(max-min)*1) * (1 - 0.01 * min(100, frames)));
            //println("column "+i+": "+min+" bis "+max);
            fill(#bc3d3c);
            text(""+i, i*s +s/2, 0);
        }

        popMatrix();
    }

    if(sketcht == 3 || sketcht == 4) {

        pushMatrix();



        translate(0,3*height);

        fill(#edf2d7);
        rect(0,0,width, height);

        pushMatrix();

        if(click > 44) {
            click = 1;
        }

        if(click < 1 ) {
            click = 44;
        }

        if(changed) {
            for(int h = 0; h < numbers4t.length; h++) {
                numbers4t[h] = table.getRow(h).getInt("f_"+click);
            }
            println("running"+click);
            changed = false;
        }

        for(int h = 0; h < numbers4.length; h++) {
            numbers4[h] = ( numbers4[h]*7 + numbers4t[h] )/8;
        }

        //f me
        float sum = 0;
        int i;

        float s = width/11.25;
        float sy = width/54;
        textAlign(CENTER);
        translate(1.17*s,16*sy +170);

        for(i = 0; i < numbers4.length; i++) {
            sum += numbers4[i];
        }

        float avg = sum/numbers4.length;
        // println(avg);

        rectMode(CORNERS);
        noStroke();
        fill(#b1f0ad);
        rect(0,6 * sy*-2, 9*s-1, avg * sy*-2);
        fill(#fba6aa);
        rect(0,avg * sy*-2, 9*s-1, 0);
        fill(#f6f6ea, 215);

        PShape sh = createShape();
        sh.beginShape();
        sh.vertex(0,0);
        sh.vertex(0, 6*sy*-2);
        sh.vertex(9*s, 6*sy*-2);
        sh.vertex(9*s, 0);


        sh.beginContour();
        sh.vertex(0,avg * sy*-2);
        sh.curveVertex(0, numbers4[0]*sy*-2);
        for(i = 0; i < numbers4.length; i++) {
            sh.curveVertex(i*s, numbers4[i]*sy*-2);
        }
        sh.curveVertex((i-1)*s, numbers4[i-1]*sy*-2);
        sh.vertex((i-1)*s,avg * sy*-2);
        sh.endContour();
        sh.endShape();
        // fill(250, 100);
        shape(sh);
        strokeWeight(1);
        stroke(200);
        fill(100);

        for(int j = 0; j <= 6; j++) {
            line(0, j * -2 * sy, 9*s, j * -2* sy);
            text(""+j, -22, j* -2 * sy +4);
        }
        for(int l = 0; l < 10; l++) {
            text(""+(l+1), l*s, 30);
        }
        // text(""+avg, 9*s + 22, avg*sy*-2);

        noFill();
        strokeWeight(8);
        strokeCap(ROUND);
        strokeJoin(BEVEL);
        stroke(100);
        beginShape();
        curveVertex(0, numbers4[0]*sy*-2);
        for(i = 0; i < numbers4.length; i++) {
            curveVertex(i*s, numbers4[i]*sy*-2);
            // ellipse(i*s, table.getRow(i).getInt("f_"+click)*sy*-2, 5, 5);
        }
        curveVertex((i-1)*s, numbers4[i-1]*sy*-2);
        endShape();


        popMatrix();
        textAlign(LEFT);
        textFont(headline, 42);
        fill(20);
        text("VERTEILUNG FRAGE "+click, 150, 150);
        textFont(sub, 16);
        text(lines[click-1], 150,180);

        rectMode(CORNER);
        noStroke();
        fill(#9dac65);
        rect(90,110,50,50);

        textAlign(CENTER);
        textFont(font, 12);
        // line(0, avg* sy*-2, 9*s, avg*sy*-2);
        popMatrix();
    }

    popMatrix();
}

void mouseClicked() {
    click++;
}

void keyPressed() {
    if(keyCode == RIGHT) {
        click++;
        changed = true;
    }
    if(keyCode == LEFT) {
        click--;
        changed = true;
    }
    if(keyCode == DOWN) {
        frames = 0;
        sketcht++;
    }
    if(keyCode == UP) {
        frames = 0;
        sketcht--;
    }
}
