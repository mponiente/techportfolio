float s = 160;


void draw(){
  size(width, height);
  float t = millis()/1000.0;
 
  background(255);
  translate(mouseX, mouseY);
  rotateY(t);
  rotateX(t);
  fill(0, 96, 125);
  box(s);

  if (mousePressed){
    s -= 1.1;
  }
 
  else if(s > 0){
   
   
    s += 0.5;
 
  }
 
 
 
}

void setup(){
  size(400,400,P3D);
 
}
