//http://www.jeffreythompson.org/collision-detection/circle-rect.php
boolean circleRectCollision(float cx, float cy, float radius, float rx, float ry, float rw, float rh) {

  float testX = cx;
  float testY = cy;

  if (cx < rx)         testX = rx;      // test left edge
  else if (cx > rx+rw) testX = rx+rw;   // right edge
  if (cy < ry)         testY = ry;      // top edge
  else if (cy > ry+rh) testY = ry+rh;   // bottom edge

  float distX = cx-testX;
  float distY = cy-testY;
  float distance = sqrt( (distX*distX) + (distY*distY) );

  if (distance <= radius) {
    return true;
  }
  return false;
}








class Paddle {
  float x;
  float y;
  float w;
  float h;
  
  Paddle(){
    reset();
  }
  
  void reset(){
    w = width * 0.1;
    h = height * 0.01;
    x = width/2 - w/2;
    y = height - 1.5 * h;
    
  }
  
  void draw(){
    fill(0);
    rect(x, y, w, h);
  }
}


class Ball {
  boolean active;
  float x;
  float y;
  float r;
  float dx;
  float dy;
 
 
  void spawn(){
   x = random(0, width);
   y = 0;
   r = height * 0.01;
   dx = 0;
   dy = 0;
   active = true;
   
  }
  
  void draw(){
    fill(255);
    circle(x, y, r*2);
  }
}






class Controls {
  boolean[] arrows = {false, false, false, false};
  
  void update(int keycode, boolean pressed){
      int i = keycode - 37;
      if (i < 0 || i > 3){
        return;  
      
    }
      arrows[i] = pressed;
  }
  
  boolean left(){
    return arrows[0]; 
  }
  boolean right(){
    return arrows[2]; 
  }
  
}

final int DURATION = 31000;

Paddle paddle;
Ball[] balls;
Controls controls;
boolean gameOver = false;
int ms = 0;
int prevSpawn = 0;
int count = 0;
int score = 0;
int start = 0;


void restart(){
  start = ms;
  paddle.reset();
  for (Ball ball : balls){
    ball.active = false;
  }
}

void keyPressed(){
  controls.update(keyCode, true);
  if (gameOver && keyCode == 'R'){
    restart();
  }
  
}

void keyReleased(){
  controls.update(keyCode, false);
}

void setup(){
  fullScreen();
  paddle = new Paddle();
  balls = new Ball[30];
  for (int i = 0; i < 30; i+=1){
    balls[i] = new Ball();
  }
  controls = new Controls();
  balls[0].spawn();
}

void draw(){
  ms = millis();
  int timeLeft = DURATION - (ms - start);
  gameOver = timeLeft <= 0;
  if (ms - prevSpawn > 3000 && !gameOver){
    prevSpawn = ms;
    for (Ball ball : balls){
      if (ball.active == false){
        ball.spawn();
        break;
      }
    }
    
  }
  float dx = 0;
  if (controls.left()){
    dx -= 1;
  }
  if (controls.right()){
    dx += 1;
  }
  paddle.x += dx * 15.5;
  paddle.x = constrain(paddle.x, 10, width - paddle.w - 10);
  background (140, 164, 245);
  count = 0;
  for (Ball b : balls){
    if (!b.active) continue; 
    count += 1;
    b.dy += 0.095;
    b.y += b.dy * 2;
    b.x += b.dx * 1.1;
    //float cx, float cy, float radius, float rx, float ry, float rw, float rh
    if (circleRectCollision(b.x, b.y, b.r, paddle.x, paddle.y, paddle.w, paddle.h)){
      b.dy = -10;
      b.dx = random(-5, 5);
      
    }
    if (b.x - b.r < 0){
      b.dx = abs(b.dx);
    } else if(b.x + b.r > width){
        b.dx = -abs(b.dx); 
    }
    if (b.y > height){
      b.active = false;
    }
    b.draw();
  }
  if (count > score) {
    score = count;
  }
  paddle.draw();
  textSize(24);
  fill (84, 66, 245);
  text("Count: " + count, width - width * 0.1, 50); 
  text("High Score: " + score, width - width * 0.1, 100);
  textSize(48);
  if (gameOver){
    text("Game Over!", width/2 - 150, 100); 
    
    
  } else {
    text(timeLeft/1000, width/2, 100);
  }
}
