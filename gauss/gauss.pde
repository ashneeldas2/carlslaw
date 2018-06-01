HScrollbar hs; //<>// //<>//

void setup() {
  fullScreen(P3D);
  hs = new HScrollbar(width/2+30, height/2+75, width/2-100, 16, 16);
//  size(300, 300, P3D); 
}

void draw() {
  background(0, 255, 255);
  //Scrollbar
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
  fill(255, 255, 255);
  sphere(50);
  stroke(0, 0, 0);
  fill(255, 0, 0); 
  sphere(r);
  popMatrix();

 
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
