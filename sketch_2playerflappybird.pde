//Version 5
float JUMP = 10;
float GRAVITY = 0.6;
float MINGAP = 0.13;
float MAXGAP = 0.3;
float MINPIPE = 0.2;
boolean GAMEOVER = false;

//Collision
boolean collision(Rect r1, Rect r2) {
  if (r1.x + r1.w >= r2.x && r1.x <= r2.x + r2.w && r1.y + r1.h >= r2.y && r1.y <= r2.y + r2.h) {
        return true;       
  } 
  
  if (r2.x + r2.w >= r1.x && r2.x <= r1.x + r1.w && r2.y + r2.h >= r1.y && r2.y <= r1.y + r1.h) {
        return true;
  } 
  return GAMEOVER;
}

//Inheritance Class
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

//Bird Class - Player One = Red, Player Two = Blue

public class Bird extends Rect{
  int player;
  boolean ctrl;
  float speed;

  Bird(int player) {
    //Rectangle Inheritance
    super(player * width/8, height/6, width/40, width/40);
    this.player = player;
    ctrl = false;
    speed = 0;
  }
  //Gravity + Gravity Reset
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
    }

    if (player == 2) {
      fill(0, 0, 255);
      noStroke();
      ellipse(x + w/2, y + h/2, w, h);
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
  if (keyCode == 32){
    startGame = true;
  }
  
  if (keyCode == 87){
    p1.ctrl = false;
    }
  if (keyCode == UP) {
    p2.ctrl = false;
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
    
    if (p2.y > height){
      gameover("Player One Wins", 255, 0, 0);
    }
 
    if (p1.y > height){
      gameover("Player Two Wins",  0, 0 , 255);
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
         fontEnd = createFont("Yu Gothic UI Bold", height/8);
         textFont(fontEnd);
         gameover("Player One Wins", 255, 0, 0);
       }
    
      if (collision(p1, pipe)){
         fontEnd = createFont("Yu Gothic UI Bold", height/8);
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

////Version 4
//float JUMP = 10;
//float GRAVITY = 0.6;
//float MINGAP = 0.13;
//float MAXGAP = 0.3;
//float MINPIPE = 0.2;
//boolean GAMEOVER = false;

////Collision
//boolean collision(Rect r1, Rect r2) {
//  if (r1.x + r1.w >= r2.x && r1.x <= r2.x + r2.w && r1.y + r1.h >= r2.y && r1.y <= r2.y + r2.h) {
//        return true;       
//  } 
  
//  if (r2.x + r2.w >= r1.x && r2.x <= r1.x + r1.w && r2.y + r2.h >= r1.y && r2.y <= r1.y + r1.h) {
//        return true;
//  } 
//  return GAMEOVER;
//}

////Inheritance Class
//public class Rect{
//  float x;
//  float y;
//  float w;
//  float h;
  
//  Rect(float x, float y, float w, float h){ 
//    this.x = x;
//    this.y = y;
//    this.w = w;
//    this.h = h;  
//  }
//}

////Bird Class - Player One = Red, Player Two = Blue

//public class Bird extends Rect{
//  int player;
//  boolean ctrl;
//  float speed;

//  Bird(int player) {
//    //Rectangle Inheritance
//    super(player * width/8, height/6, width/40, width/40);
//    this.player = player;
//    ctrl = false;
//    speed = 0;
//  }
//  //Gravity + Gravity Reset
//  void move() {
//    y += speed;
//    speed += GRAVITY;
   
//    if (y < 0){ 
//      y = 0;  
//    } 
//  }
  
//  void draw(){
//    if (player == 1) {
//      fill(255, 0, 0);
//      noStroke();
//      ellipse(x + w/2, y + h/2, w, h);
//    }

//    if (player == 2) {
//      fill(0, 0, 255);
//      noStroke();
//      ellipse(x + w/2, y + h/2, w, h);
//    }
//  }
//}

//public class Pipe extends Rect {
//  Pipe(float y, float h) {
//    super(width, y, width/40, h);
//  }

//  void draw() {
//    fill(0, 255, 0);
//    stroke(79, 140, 139);
//    rect(x, y, w, h);
//  }
//}

//Bird p1;
//Bird p2;

//PFont fontStart;
//PFont fontEnd;
//ArrayList<Pipe> pipes = new ArrayList<Pipe>();

//float t;
//float timer;
//boolean startGame = false;

//void keyPressed() {
//    if (keyCode == 87 && !p1.ctrl){
//      p1.ctrl = true ;
//      p1.speed = -JUMP;
//    }
    
//    if (keyCode == UP && !p2.ctrl) {
//      p2.ctrl = true;
//      p2.speed = -JUMP;
//    }
    
//    if (keyCode == 80){
//      noLoop();
//    }
//}   
   
//void keyReleased() {
//  if (keyCode == 32){
//    startGame = true;
//  }
  
//  if (keyCode == 87){
//    p1.ctrl = false;
//    }
//  if (keyCode == UP) {
//    p2.ctrl = false;
//  }
  
//  if (keyCode == 82) {
//      t = millis();
//      loop();
//    }  
//}
 
//void setup(){
//  fullScreen();
//  p1 = new Bird(1);
//  p2 = new Bird(2);
//}

//void draw(){
//  background(96, 96, 251);
//  textAlign(CENTER);
//  fill(255);

//  fontStart = createFont("Impact", height/10);
//  textFont(fontStart);

//  text("2-PLAYER FLAPPY BIRD", width/2, height/2.5);
  
//  text("PRESS THE SPACE BAR TO BEGIN", width/2, height/1.5);

//  if (startGame == true){ 
//    float ms = millis();
//    float delta = ms - t;
//    t = ms;
//    timer -= delta;
      
//    if (timer <= 0){
//      timer = 1000;
//      float gapH = random(height * MINGAP, height * MAXGAP); 
//      float gapY = random(height * MINPIPE, height - height * MINPIPE - gapH);
//      float bottomY = gapY + gapH;
//      pipes.add(new Pipe(0, gapY));
//      pipes.add(new Pipe(bottomY, height - bottomY));
//    }
    
//    background(164, 237, 236);
//    p1.move();
//    p2.move();
//    p1.draw();
//    p2.draw();
    
//    if (p2.y > height){
//      gameover("Player One Wins", 255, 0, 0);
//    }
 
//    if (p1.y > height){
//      gameover("Player Two Wins",  0, 0 , 255);
//    }
    
//    for (Pipe pipe : pipes) { 
      
//      if (!GAMEOVER){
//        pipe.x -= 5;
//        pipe.draw();
//      } 
//      else {
//        if (GAMEOVER){
//          continue;
//        }
//      }
      
//      if (collision(p2, pipe)){
//         fontEnd = createFont("Yu Gothic UI Bold", height/8);
//         textFont(fontEnd);
//         gameover("Player One Wins", 255, 0, 0);
//       }
    
//      if (collision(p1, pipe)){
//         fontEnd = createFont("Yu Gothic UI Bold", height/8);
//         textFont(fontEnd);
//         gameover("Player Two Wins", 0, 0, 255);
//      }  
//    }
//  }  
//}

//void gameover(String display, int r, int g, int b){
//  background(255);
//  textAlign(CENTER);
//  textSize(height/6);
//  fill (r, g, b);
//  text(display, width/2, height/2);
//  GAMEOVER = true;
//  noLoop();
//}


////Version 3 

//float JUMP = 10;

//float GRAVITY = 0.6;

//float MINGAP = 0.13;

//float MAXGAP = 0.3;

//float MINPIPE = 0.2;

//boolean GAMEOVER = false;


////Collision

//boolean collision(Rect r1, Rect r2) {

//  if (r1.x + r1.w >= r2.x && r1.x <= r2.x + r2.w && r1.y + r1.h >= r2.y && r1.y <= r2.y + r2.h) {
   
//        return !GAMEOVER;
       
//  } 
  
//  if (r2.x + r2.w >= r1.x && r2.x <= r1.x + r1.w && r2.y + r2.h >= r1.y && r2.y <= r1.y + r1.h) {
   
//        return !GAMEOVER;
       
//  } 
  
//  return GAMEOVER; 
  
//}

//public class Rect{
 
//  float x;
  
//  float y;
  
//  float w;
  
//  float h;
  
 
//  Rect(float x, float y, float w, float h){
   
//    this.x = x;
    
//    this.y = y;
    
//    this.w = w;
    
//    this.h = h;  
 
//  }
//}

//public class Bird extends Rect{
 
//  int player;
  
//  boolean ctrl;
  
//  float speed;
  
//  float up;
  
//  boolean win;


//  Bird(int player) {
    
//    super(player * width/8, height/6, width/40, width/40);
    
//    this.player = player;
    
//    ctrl = false;
    
//    win = false;
    
//    speed = 0;
    
//  }

//  void move() {
   
//    y += speed;
    
//    speed += GRAVITY;
   
//    if (y < 0){
      
//      y = 0;
      
//    }
    
//  }

  
//  void draw(){
    
//    if (player == 1) {
      
//      fill(255, 0, 0);
//      noStroke();
//      ellipse(x + w/2, y + h/2, w, h);
      
//    }

//    if (player == 2) {
      
//      fill(0, 0, 255);
//      noStroke();
//      ellipse(x + w/2, y + h/2, w, h);
      
//    }
    
//  }
  
//}

//public class Pipe extends Rect {


//  Pipe(float y, float h) {
    
//    super(width, y, width/40, h);

//  }

//  void draw() {
    
//    fill(0, 255, 0);
    
//    stroke(79, 140, 139);
    
//    rect(x, y, w, h);
    
//  }
  
//}



//Bird p1;

//Bird p2;



//PFont fontStart;

//PFont fontEnd;

//ArrayList<Pipe> pipes = new ArrayList<Pipe>();

//float t;

//float timer;

//boolean startGame = false;


//void keyPressed() {
  
//    if (keyCode == 87 && !p1.ctrl){
      
//      p1.ctrl = true ;
      
//      p1.speed = -JUMP;
      
//    }
    
//    if (keyCode == UP && !p2.ctrl) {
      
//      p2.ctrl = true;
      
//      p2.speed = -JUMP;
      
//    }
    
//    if (keyCode == 80){
      
//      noLoop();
  
//    }
    
//}   
   
 
//void keyReleased() {
  
//  if (keyCode == 32){

//    startGame = true;
  
//  }
  
//  if (keyCode == 87){
    
//    p1.ctrl = false;
    
//    }
    
//  if (keyCode == UP) {
    
//    p2.ctrl = false;
    
//  }
  
//  if (keyCode == 82) {
    
//      t = millis();
      
//      loop();
   
//    }
    
//}
 

//void setup(){
  
//  fullScreen();
  
//  p1 = new Bird(1);
  
//  p2 = new Bird(2);
  
//}

//void draw(){
  
//  //Opening Screen
  
//  background(96, 96, 251);
//  textAlign(CENTER);
//  fill(255);
  
//  //String[] fontList = PFont.list();
//  //printArray(fontList);

//  fontStart = createFont("Impact", height/10);
//  textFont(fontStart);

//  text("2-PLAYER FLAPPY BIRD", width/2, height/2.5);
  
//  text("PRESS THE SPACE BAR TO BEGIN", width/2, height/1.5);
  
  
 
//  if (startGame == true){ 
    
//    float ms = millis();
    
//    float delta = ms - t;
    
//    t = ms;
   
   
//    timer -= delta;
      
//    if (timer <= 0){
      
//      timer = 1000;
      
//      float gapH = random(height * MINGAP, height * MAXGAP); 
      
//      float gapY = random(height * MINPIPE, height - height * MINPIPE - gapH);
      
//      float bottomY = gapY + gapH;
      
//      pipes.add(new Pipe(0, gapY));
      
//      pipes.add(new Pipe(bottomY, height - bottomY));
      
//    }
    
//    background(164, 237, 236);
    
//    p1.move();
    
//    p2.move();
    
//    p1.draw();
    
//    p2.draw();
    
//    boolean optRestart = false;
    
//    for (Pipe pipe : pipes) { 
      
//      if (optRestart == false){
        
//        pipe.x -= 5;
        
//        pipe.draw();
        
//      } 
      
//      else {
        
//        if (optRestart == true){
      
//          noLoop();
        
//        }
      
//      }
      
        
//      if (p2.y > height || collision(p2, pipe)){
        
//        //Condition ^ :  || (p1.x >= pipe.x && p1.y <= height - (height - pipe.h))
     
//         background(255);
//         textAlign(CENTER);
//         fill (255, 0, 0);
         
//         fontEnd = createFont("Yu Gothic UI Bold", height/8);
//         textFont(fontEnd);
         
//         text("Player One Wins!", width/2, height/2);
         
//         optRestart = true;
//         noLoop();
     
//       }
    
//      if (p1.y > height || collision(p1, pipe)){
       
//         background(255);
//         textAlign(CENTER);
//         fill(0, 0, 255);
         
//         fontEnd = createFont("Yu Gothic UI Bold", height/8);
//         textFont(fontEnd);
         
//         text("Player Two Wins!", width/2, height/2);
         
//         optRestart = true;
//         noLoop();
      
//      }  
    
//    }
      
//  }  
    
  
//}





////Version 2

////Global Variables

//float JUMP = 10;

//float GRAVITY = 0.6;

//float MINGAP = 0.13;

//float MAXGAP = 0.3;

//float MINPIPE = 0.2;

////boolean GAMEOVER = false;


//public class Bird{
 
//  int player;

//  float x;

//  float y;

//  float w;

//  float h;

//  float dx;

//  float dy;

//  boolean ctrl;

//  float speed;

//  float up;

//  boolean win;


//  Bird(int player) {
    
//    this.player = player;

//    ctrl = false;

//    win = false;

//    x = player * width/8;

//    y = height/6;

//    w = width/40;

//    h = width/40;

//    speed = 0;
    
//  }

   
 
//  void move() {
   
//    y += speed;

//    speed += GRAVITY;
   
//    if (y < 0){
      
//      y = 0;
      
//    }
    
//  }

  
//  //Bottom Boundaries: possible break;

//  //void boundary(){
  
//  //  if (p1.y > height){
  
//  //    p1.x -= -1;

//  //  }

//  //  if (p2.y > height){
  
//  //    p2.x -= -1;

//  //  }

//  //}
  
//  //Possible Game Over screen. 

//  //void gameOver(){
  
//  //if (player == 1 && p1.x > p2.x){
  
//  //  WIN = true;

//  //}
  
//  //if (player == 2 && p2.x > p1.x){
  
//  //  WIN = true;

//  //}

////void win(){
  
////  if (p1.x > p2.x && player == 1){
    
////    background (255);

////    fill(0);

////    textSize(height/2);

    
////  }
  
////  if ( p2.x > p1.x && player == 2){
    
////    background(255);

////    fill(0);

////    textSize(height/2);
    
////  }

////}


////void gameOver(){
  
////  if (!p2.win && p1.x > p2.x && player == 1){
    
////    text("Player One wins!", width/2, height/2);
    
////  }
  
////  if (!p1.win && p2.x > p1.x & player == 2){
    
////    text("Player Two wins!", width/2, height/2);
    
////  }
  
////}

//  void draw(){
    
//    if (player == 1) {
      
//      fill(255, 0, 0);

//      noStroke();

//      ellipse(x + w/2, y + h/2, w, h);
      
//    }

//    if (player == 2) {
      
//      fill(0, 0, 255);

//      noStroke();

//      ellipse(x + w/2, y + h/2, w, h);
      
//    }
//  }
//}

//public class Pipe {

//  float x;

//  float y;

//  float w;

//  float h;

//  boolean shift;

//  Pipe(float y, float h) {

//    x = width;

//    this.y = y;

//    w = width/40;

//    this.h = h;
//  }

//  void draw() {
    
//    fill(0, 255, 0);

//    stroke(79, 140, 139);

//    rect(x, y, w, h);

//  }

//}

////Global State

//Bird p1;

//Bird p2;

//ArrayList<Pipe> pipes = new ArrayList<Pipe>();

//float t;

//float timer;

////float pipetimer;

////float pipet;



//void keyPressed() {
  
//    if (keyCode == 87 && !p1.ctrl){
      
//      p1.ctrl = true ;

//      p1.speed = -JUMP;
      
//    }
    
//    if (keyCode == UP && !p2.ctrl) {
      
//      p2.ctrl = true;

//      p2.speed = -JUMP;
      
//    }
    
//   ////temporary gameOver()

//   // if (keyCode == 80 && (!p2.ctrl || !p1.ctrl)){
      
//   //   GAMEOVER = true;
      
//   // }

//   // if (keyCode == 82){
      
//   //  GAMEOVER = false;
     
//   // }
//}   
   
 
//void keyReleased() {
  
//  if (keyCode == 87){
    
//    p1.ctrl = false;
    
//    }
    
//  if (keyCode == UP) {
    
//    p2.ctrl = false;
    
//  }
  
//  //if (keyCode == 80){
  
//  //    GAMEOVER = true;

//  //    noLoop();
      
//  //}
      

//  ////Resume Button

//  //if (keyCode == 82){
    
//  //  GAMEOVER = false;

//  //  loop();
    
//  //}     
//}
 

//void setup(){
  
//  fullScreen();

//  p1 = new Bird(1);

//  p2 = new Bird(2);
  
//}

//void draw(){
  
//  float ms = millis();

//  float delta = ms - t;

//  t = ms;
 
//  timer -= delta;
  
//  //Pipe spawn
  
//  if (timer <= 0){
  
//    timer = 1000;

//    float gapH = random(height * MINGAP, height * MAXGAP); 

//    float gapY = random(height * MINPIPE, height - height * MINPIPE - gapH);

//    float bottomY = gapY + gapH;

//    pipes.add(new Pipe(0, gapY));

//    pipes.add(new Pipe(bottomY, height - bottomY));
    
//  }
  
//  //if(p1.x > p2.x){
  
//  //  p1.gameOver();

//  //} else {
  
//  //  p2.gameOver();
  
//  //}
  
  
//  background(164, 237, 236);

//  p1.move();

//  p2.move();

//  p1.draw();

//  p2.draw();
  
//  //Increment more speed every 10 seconds.
  
//  //if (timer >= 0){
    
//  //}
  
//  //Pipe timer for stopping pipe movement when pausing the game.
 
//  //float pipems = millis();

//  //float pipedelta = pipems - pipet;

//  //pipet = ms;
  
//  //pipetimer -= pipedelta;
  
//  boolean gameOver = false;
  
//  for (Pipe pipe : pipes) { 
    
//    if (gameOver == false){
  
//      pipe.x -= 5;

//      pipe.draw();

//    } else {
  
//      noLoop();
    
//    }

// if (p2.y > height || p2.x > pipe.x){
  
//        noLoop();

//        background(255);

//        fill(0);

//        textSize(height/6);

//        textAlign(CENTER);

//        text("Player One wins!", width/2, height/2);

//        gameOver = true;

//      }
  
//   if (p1.y > height || p1.x > pipe.x){
  
//      noLoop();

//      background(255);

//      fill(0);

//      textSize(height/6);

//      textAlign(CENTER);

//      text("Player Two wins!", width/2, height/2); 

//      gameOver = true;
    
    
//   }
  
//}   
//}
//Pipe movement 
    
    //if ((pause == false || pipetimer <= 0) || (keyCode != 80 && keyCode != 82)){
      
    //  pipetimer = dist(width, 0, width - height - height * 0.2 - random(height * 0.13, height * 0.3), 0) * 3000;
    
    //  loop();
   
        //if (p1.x > pipe.x || p2.x > pipe.x){
          
        //}
    
    //else {
      
    //  pause = true;
    
    //}
    
    
    ////Pause Button
    
    //if (keyCode == 80){
      
    //  pause = true;
    
    //  while (pause == true){
      
    //    noLoop();


    //    //pipe.x += 6;
    
    //    //pipe.x += 0;
    
    //    if (keyCode == 82){
      
    //      //pipetimer = 10000;
    
    //      loop();
    
    //    } 
    //    else{
      
    //      break;
    
    //      //pause = false;
        
        
    //    }
          


      
    
    
      
      

    
    //if (pause == false){
      
    //  pipe.x -= 5;
    
    //  pipe.draw();
    //}
    
    
    
   
   
  
      //if (p1.x > p2.x){
        
      //  background(255);
      
      //  fill(0);
      
      //  textSize(height/2);
      
      //  text("Player One wins!", width/2, height/2);
      
      //}
      
      //if (p2.x > p1.x){
        
      //  background(255);
      
      //  fill(0);
      
      //  textSize(height/2);
      
      //  text("Player Two wins!", width/2, height/2);
      
      //}


  //background(255);
  
  //boolean startGame = true;

  //if (keyCode == 32 && startGame){
    
  //    background(164, 237, 236);
  
  //    //move bird
  
  //    p1.move();
  
  //    p2.move();
  
  //    p1.draw();
  
  //    p2.draw();
      
  //    for (Pipe pipe : pipes) {
    
  //      //move each pipe
  
  //      pipe.x -= 5;
  
  //      pipe.draw();
  
  //    }
    
    
  //}




//Version One

//public class Bird{
  
//  float player;

//  float x;

//  float y;

//  float w;

//  float h;

//  float dx;

//  float dy;

//  boolean ctrl;

//  float yspeed;

//  float ms;

//  float timer;

//  float W;

//  float up;

//  Bird() {
  
//    ctrl = false;

//    x = width/8;

//    y = height/6;

//    w = width/40;

//    h = width/40;

//    yspeed = 0;

//    ms = millis();

//    timer = max(10000 - ms, 0);
//  }

//    boolean keyPressed(boolean ctrl) {
      
//    if ((keyCode == UP || keyCode == 87) && timer == 0) {
  
//      ctrl = true;

//    } 

//    else {
  
//        if (timer > 0){
  
//        ctrl = false;

//        }  

//      }
//      return ctrl;

      
//    }
  
//  //void keyReleased() {
  
//  //  if (timer > 0) {
  
//  //    ctrl = false;

//  //  }  

//  //}

  
//  void move(boolean ctrl) {
  
//    if (p1.keyPressed(ctrl)){
  
//      player = 1;

//      y -= 20;

//    }
    
//    if (p2.keyPressed(ctrl)){
  
//      player = 2;

//      y -= 20;

//    }
    
//    y += yspeed;

//    yspeed = 0;

//    y += 2.4;

//  }
  
//  void draw(){
  
//    if (player == 1) {
  
//      fill(255, 0, 0);

//      noStroke();

//      ellipse(x + w/2, y + h/2, w, h);

//    }

//    if (player == 2) {
  
//      y = y/2;

//      fill(0, 0, 255);

//      noStroke();

//      ellipse(x + w/2, y + h/2, w, h);

//    }

//  }

//}


//public class Pipe {

//  float x;

//  float y;

//  float w;

//  float h;

//  boolean shift;

//  Pipe() {

//    x = width/2.5;

//    y = 0;

//    w = width/40;

//    h = height/15;

//  }

//  void draw() {
  
//    fill(0, 255, 0);

//    stroke(79, 140, 139);

//    rect(x, y, w, h);

//  }

//}

////global state

//Bird p1;

//Bird p2;



//ArrayList<Pipe> pipes = new ArrayList<Pipe>();



//void setup() {
  
//  fullScreen();

//  p1 = new Bird();

//  p2 = new Bird();

//  pipes.add(new Pipe());

//  p1.keyPressed(true);

//  p2.keyPressed(true);

//}

//void draw() {
  
//  background(164, 237, 236);

//  //move bird

//  p1.draw();

//  p2.draw();

//  for (Pipe pipe : pipes) {
  
//    //move each pipe

//    pipe.draw();

//  }

//}


//possible movement method

//public class Controls{
  
//    float dx;

//    float dy;

//    keys = set();

//    keyMap = keyMap;


//    public void update(){
  
//    dx = keys(1, 0) - keys(-1, 0);

//    dy = keys(0, 1) - keys(0, -1);}

//    public void keyPressed(){
  
//    if (keyMap(key){
  
//      keys.add(keyMap[key])}

//     else{
  
//       if (keyMap(key){
  
//         keys.add(keyMap[keyCode])}

//     }


//  def keyReleased(self):

//    if key in self.keyMap:

//      self.keys.remove(self.keyMap[key])

//    elif keyCode in self.keyMap:

//      self.keys.remove(self.keyMap[keyCode])}


//def ControllerWASD():

//  return Controller({'a': (-1, 0), 'd': (1, 0), 'w': (0, -1), 's': (0, 1)})


//def ControllerArrows():
