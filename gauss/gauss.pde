HScrollbar hs; //<>// //<>// //<>//
public static Boolean started; 
public static Boolean sphere, cylinder, sheet; 

void setup() {
  fullScreen(P3D);
  started = false;
  sphere = false;
  cylinder = false;
  sheet = false;
  hs = new HScrollbar(width/2+30, height/2+75, width/2-100, 16, 16);
//  size(300, 300, P3D);   
}

void draw() {
  background(165,216,255);
  stroke(0, 0, 0);
  if (!started) {
      PFont memes = createFont("Sans Serif", 20);
      textFont(memes);
      fill(144,195,200); 
      rect(width/4 - 60, height/2 - 40, 140, 80, 5, 5, 5, 5); 
      fill(0, 0, 0);
      text("Sphere", width/4 - 20, height/2 + 5);
      fill(185,184,211); 
      rect(width/2 - 60, height/2 - 40, 140, 80, 5, 5, 5, 5); 
      fill(0, 0, 0);
      text("Cylinder", width/2 - 30, height/2 + 5); 
      fill(117,159,188); 
      rect(width/4 * 3 - 60, height/2 - 40, 140, 80, 5, 5, 5, 5); 
      fill(0, 0, 0);
      text("Sheet", 3 * width/4 - 20, height/2 + 5); 
  }
  if (started) {
      PFont memes = createFont("Sans Serif", 20);
      textFont(memes);
      fill(144,195,200); 
      rect(50, height/16, 140, 80, 5, 5, 5, 5); 
      fill(0, 0, 0);
      text("Back", 100, height/16+45); 
  }
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
   
  //Sphere 
  pushMatrix();
  //noStroke();
  lights();
  translate(width/4, height/4);
  noStroke();
  if (r > 50) {
    fill(255, 255, 255);
    sphere(50);
    fill(176, 246, 250, 127.5); 
    sphere(r);
  }
  else {
    fill(176, 246, 250);
    sphere(r);
    fill(255, 255, 255, 127.5); 
    sphere(50);
  }
  popMatrix();
  }
  
    // CYLINDER START 
  if (started && cylinder) {
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
   point(i * 5 + width/2 + 30, height/2 - graphC(i) * 1000);
  }
   
  //Cylinder
  pushMatrix();
  //noStroke();
  translate(width/4, height/4);
  noStroke();
  rotateX(PI/4); 
  rotateY(PI/4);
  noLights();
  if (r > 50) {
    lights();
    fill(130, 151, 186); 
    drawCylinder(50, 50, 150); 
    fill(176, 246, 250, 127.5); 
    drawCylinder(50, r, 150);
  }
  else {
    lights();
    
    fill(176, 246, 250);
    drawCylinder(50, r, 150);
     fill(130, 151, 186, 127.5);
    drawCylinder(50, 50, 150);
  }
  popMatrix();
  }
}

void mousePressed() {
    if (!started){
      if ((mouseX > width/4 - 60 && mouseX < width/4 + 80) && (mouseY > height/2 - 40 && mouseY < height/2 + 40)){
        sphere = true;
        started = true;
      }
      else if ((mouseX > width/2 - 60 && mouseX < width/2 + 80) && (mouseY > height/2 - 40 && mouseY < height/2 + 40)){
        cylinder = true;
        started = true;
      }
      else if ((mouseX > width/4 * 3 - 60 && mouseX < width/4 * 3 + 80) && (mouseY > height/2 - 40 && mouseY < height/2 + 40)){
        sheet = true;
        started = true;
      }
    }
    else {
       if ((mouseX > 50 && mouseX < 190) && (mouseY > height/16 && mouseY < height/16 + 80)) {
         started = false; 
         sphere = false;
         cylinder = false;
         sheet = false;
       }
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

float graphC(float r) {
  if (r < 50) {
     return (Q * r)/(2 * PI * pow(R, 2));
  }
  else {
     return Q/(2 * PI * r);
  }
}

void drawCylinder(int sides, float r, float h)
{
    float angle = 360 / sides;
    float halfHeight = h / 2;
    // draw top shape
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, -halfHeight );    
    }
    endShape(CLOSE);
    // draw bottom shape
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, halfHeight );    
    }
    endShape(CLOSE);
    
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
      float x = cos( radians( i * angle ) ) * r;
      float y = sin( radians( i * angle ) ) * r;
      vertex( x, y, halfHeight);
      vertex( x, y, -halfHeight);    
    }
    endShape(CLOSE); 
} 
