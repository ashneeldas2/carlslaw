HScrollbar hs; //<>//

void setup() {
  fullScreen(P3D);
  hs = new HScrollbar(0, height/2+10, width, 16, 16);
//  size(300, 300, P3D); 
}

void draw() {
  background(0, 255, 255);
  pushMatrix();
  translate(width/4, height/4);
  sphere(50);
  popMatrix();
  pushMatrix(); 
  translate(width/4 + 100, height/4);
  ellipse(0, 0, 50, 50);
  popMatrix();
  
  //Scrollbar
  //hs.update();
  //hs.display();
  
  //Draw Axes
  line(width/2 + 30,30, width/2 + 30, height/2);
  line(width/2 + 30, height/2, width - 30, height/2);
  
  //Draw Graph
  for (float i = 0; i < 100; i += 0.2){
   point(i * 5 + width/2 + 30, height/2 - graph(i) * 100000);
  }
  
  
}

float e = 8.85 * pow(10, -12);
float R = 50.0;
float Q = 50.0;

//Solid Uniformly Distributed
float graph(float r) {
  if (r < 50) {
    return (Q * r)/(4 * PI * pow(R, 3));
  }
  else{
    return Q / (4*PI*pow(r, 2));
  }
}


public class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;

  HScrollbar (float xp, float yp, int sw, int sh, int l) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
       mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(204);
    rect(xpos, ypos, swidth, sheight);
    fill(0, 0, 0);
    rect(spos, ypos, sheight, sheight);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
}
