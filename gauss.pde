void setup() { //<>//
  fullScreen(P3D);
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
}
