HScrollbar hs; //<>// //<>//
public static Boolean started; 
public static Boolean sphere, cylinder, plate; 

void setup() {
  fullScreen(P3D);
  started = false;
  hs = new HScrollbar(width/2+30, height/2+75, width/2-100, 16, 16);
//  size(300, 300, P3D);   
}

void draw() {
  background(0, 255, 255);
  if (!started) {
      fill(255, 0, 0); 
      rect(width/4, height/2, 50, 30); 
      fill(0, 255, 0); 
      rect(2 * width/4, height/2, 50, 30);
      fill(0, 0, 255); 
      rect(3 * width/4, height/2, 50, 30);
  }
  //Scrollbar
  if (started && sphere) {
  stroke(0, 0, 0);
  hs.update();
  hs.display();
  float r = (hs.spos - (width/2 + 30))/5; 
  
  //Draw Axes
  line(width/2 + 30,30, width/2 + 30, height/2);
  line(width/2 + 30, height/2, width - 30, height/2);
  
  //Labels
  PFont myFont = createFont("Sans Serif", 15);
  textFont(myFont);
  fill(255, 0, 0); 
  text("Radius", 3*width/4-30, height/2+25);
  text("Electric Field", width/2-75, height/4+25);
  
  //Draw Graph
  for (float i = 0; i < r; i += 0.2){
   point(i * 5 + width/2 + 30, height/2 - graph(i) * 130000);
  }
   
  //Sphere (this may be a lil bit of a problem rn) 
  pushMatrix();
  //noStroke();
  lights();
  translate(width/4, height/4);
  noStroke();
  if (r > 50) {
    fill(0, 0, 0);
    sphere(50);
    fill(255, 255, 255, 127.5); 
    sphere(r);
  }
  else {
    fill(255, 255, 255);
    sphere(r);
    fill(0, 0, 0, 127.5); 
    sphere(50);
  }
  popMatrix();
  }
}

void mousePressed() {
    
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
