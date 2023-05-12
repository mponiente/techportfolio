//VERSION 5
float JUMP = 10;
float GRAVITY = 0.6;
float MINGAP = 0.2;
float MAXGAP = 0.35;
float MINPIPE = 0.2;
boolean GAMEOVER = false;

boolean collision(Rect r1, Rect r2) {
  
  if (r1.x + r1.w >= r2.x && r1.x <= r2.x + r2.w && r1.y + r1.h >= r2.y && r1.y <= r2.y + r2.h) {
        return true;       
  } 
  
  if (r2.x + r2.w >= r1.x && r2.x <= r1.x + r1.w && r2.y + r2.h >= r1.y && r2.y <= r1.y + r1.h) {
        return true;
  }  
  return false;
  
}

public class Rect{
  float x;
  float y;
  float w;
  float h;
  
  Rect(float x, float y, float w, float h){ 
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;  
  }
}

public class Bird extends Rect{
  int player;
  boolean ctrl;
  float speed;

  Bird(int player) {
    
    super(player * width/8, height/6, width/40, width/40);
    this.player = player;
    ctrl = false;
    speed = 0;
  }

  void move() {
    y += speed;
    speed += GRAVITY;
   
    if (y < 0){ 
      y = 0;  
    } 
  }
  
  void draw(){
    
    if (player == 1) {
      fill(255, 0, 0);
      noStroke();
      ellipse(x + w/2, y + h/2, w, h);
      fill(255); 
      textSize(h/1.5); 
      text("P1", x + w/2, y + h/1.32);
    }

    if (player == 2) {
      fill(0, 0, 255);
      noStroke();
      ellipse(x + w/2, y + h/2, w, h);
      fill(255); 
      textSize(h/1.5); 
      text("P2", x + w/2, y + h/1.32);
    }
  }
}

public class Pipe extends Rect {
  
  Pipe(float y, float h) {
    super(width, y, width/40, h);
  }

  void draw() {
    fill(0, 255, 0);
    stroke(79, 140, 139);
    rect(x, y, w, h);
  }
}

Bird p1;
Bird p2;

PFont fontStart;
PFont fontEnd;
ArrayList<Pipe> pipes = new ArrayList<Pipe>();

float t;
float timer;
boolean startGame = false;

void keyPressed() {
  
    if (keyCode == 87 && !p1.ctrl){
      p1.ctrl = true ;
      p1.speed = -JUMP;
    }
    
    if (keyCode == UP && !p2.ctrl) {
      p2.ctrl = true;
      p2.speed = -JUMP;
    }
    
    if (keyCode == 80){
      noLoop();
    }
}   
   
void keyReleased() {
  
  if (keyCode == 87){
    p1.ctrl = false;
  }
    
  if (keyCode == UP) {
    p2.ctrl = false;
  }
  
  if (keyCode == 32){
    startGame = true;
  }
  
  if (keyCode == 82) {
      t = millis();
      loop();
    }  
}
 
void setup(){
  fullScreen();
  p1 = new Bird(1);
  p2 = new Bird(2);
}

void draw(){
  
  background(96, 96, 251);
  textAlign(CENTER);
  fill(255);

  fontStart = createFont("Impact", height/10);
  textFont(fontStart);
  text("2-PLAYER FLAPPY BIRD", width/2, height/2.5);
  text("PRESS THE SPACE BAR TO BEGIN", width/2, height/1.5);
  
  

  if (startGame == true){ 
    
    float ms = millis();
    float delta = ms - t;
    t = ms;
    timer -= delta;
      
    if (timer <= 0){
      timer = 1000;
      float gapH = random(height * MINGAP, height * MAXGAP); 
      float gapY = random(height * MINPIPE, height - height * MINPIPE - gapH);
      float bottomY = gapY + gapH;
      pipes.add(new Pipe(0, gapY));
      pipes.add(new Pipe(bottomY, height - bottomY));
    }
    
    background(164, 237, 236);
    p1.move();
    p2.move();
    p1.draw();
    p2.draw();
    
    fontEnd = createFont("Yu Gothic UI Bold", height/8);
    
    if (p2.y > height){
      textFont(fontEnd);
      gameover("Player One Wins", 255, 0, 0);

    }
    
    if (p1.y > height){
      textFont(fontEnd);
      gameover("Player Two Wins", 0, 0, 255);
    }
    
    for (Pipe pipe : pipes) { 
      
      if (!GAMEOVER){
        pipe.x -= 5;
        pipe.draw();
      } 
      else {
        if (GAMEOVER){
          continue;
        }
      }

      if (collision(p2, pipe)){
         textFont(fontEnd);
         gameover("Player One Wins", 255, 0, 0);
       }
    
      if (collision(p1, pipe)){
         textFont(fontEnd);
         gameover("Player Two Wins", 0, 0, 255);
      }  
    }
  }  
}

void gameover(String display, int r, int g, int b){
  background(255);
  textAlign(CENTER);
  textSize(height/6);
  fill (r, g, b);
  text(display, width/2, height/2);
  GAMEOVER = true;
  noLoop();
}
