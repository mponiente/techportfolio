//VERSION 2.0.0

int EMPTY = 0;
int INCORRECT = 1;
int XPLACE = 2;
int CORRECT = 3;

char[][] grid;

int [][] status;
float tw;
float th;
int wordindex = 0;
int letterindex = 0;
String word = "OCTET";


void scanrow(int r){

  ArrayList<Character> grabbag = new ArrayList<Character>();
 
  for (int i = 0; i < word.length(); i ++){
   
    grabbag.add(word.charAt(i));
   
  }
 
  for (int c = 0; c < 5; c ++){    
   
   
    if (grid[r][c] == word.charAt(c)){
     
      status[r][c] = CORRECT;
      grabbag.remove(Character.valueOf(grid[r][c]));
   
    } else if(grabbag.contains(grid[r][c])){
     
      status[r][c] = XPLACE;
      grabbag.remove(Character.valueOf(grid[r][c]));
     
    } else {
     
      status[r][c] = INCORRECT;
 
    }
   
  }

}
void keyPressed(){
 
 
  if (keyCode == ESC){
    exit();
  }
 
  if (keyCode == BACKSPACE){
    if (letterindex >= 5){
      letterindex = 4;
   
    }
    
    grid[wordindex][letterindex] = 0;
   
    if (letterindex > 0){
      letterindex -= 1;
      return;
    }
  }
 
  if (keyCode == ENTER && letterindex > 4){
   
    scanrow(wordindex);
    wordindex += 1;
    letterindex = 0;
    return;
   
    // To Do: Deal w/ row overflow
 
  }
 
  if (letterindex < 5){
    grid[wordindex][letterindex] = (char) keyCode;
    letterindex += 1;
  }  
 

}

void setup(){
 
  fullScreen();
  tw = width/13.5;
  th = height/8;
  fill(0);
  grid = new char[6][5];
  status = new int[6][5];
 
}


void draw(){
 
  background(255);
 
  PFont font;
  font = createFont("Impact", height/10);

  for (int r = 0; r < 6; r++){
    for (int c = 0; c < 5; c ++){
      float x = tw * 4 + c * tw;
      float y = th + r * th;
      char letter = grid[r][c];
     
     
      stroke(0, 500);
     
      if (status[r][c] == EMPTY){
        fill(180);
      } else if(status[r][c] == INCORRECT){
       
        fill(254, 101, 101);
       
      } else if (status [r][c] == XPLACE){
       
        fill (252, 222, 105);
     
      } else if (status [r][c] == CORRECT){
       
        fill (75, 214, 85);
     
     
      }
     
     
     
      rect(x, y, tw, th);
     
      if (letter != 0){
        fill(255);
        textAlign(CENTER, CENTER);
        textFont(font);
        text(letter, x + tw/2, y + th/2);
      }
    }



////VERSION 1.0.0
//int EMPTY = 0;
//int INCORRECT = 1;
//int XPLACEMENT = 2;
//int CORRECT = 3;

////public class Word {
  
////  String word;
////  char c1;
////  char c2;
////  char c3;
////  char c4;
////  char c5;
  
////  Word(){
  
  
  
////  }

////}
//char[][] grid;

//int [][] status;
//float tw;
//float th;
//int wordindex = 0;
//int letterindex = 0;
//String word = "rupee";


//void keyPressed(){

//  grid[wordindex][letterindex] = (char) keyCode;
//  letterindex += 1;
 
//  if (letterindex >= 5){
//    wordindex += 1;
//    letterindex = 0;
//  }
//}

//void setup(){
  
//  fullScreen();
//  tw = width/13.5;
//  th = height/8;
//  fill(255);
//  grid = new char[6][5];
//  status = new int[6][5];
  
//  status [0][0] = CORRECT;
//  status [0][1] = INCORRECT;
//  status [0][2] = XPLACEMENT;
//  status [0][3] = EMPTY;
//  status [0][4] = EMPTY;
  
//}

//void draw(){
 
//  background(255);
  
//  PFont fontStart;
//  fontStart = createFont("Impact", height/10);

//  for (int r = 0; r < 6; r++){
//    for (int c = 0; c < 5; c ++){
//      float x = 600 + c * tw;
//      float y = 200 + r * th;
//      char letter = grid[r][c];
//      stroke(2);
      
//      for(wordindex = 0; wordindex <= word.length() -1; wordindex++){
        
//        if (wordindex == word.charAt(c)){
          
//          status[r][c] = CORRECT;
          
        
        
//        } else if (word.charAt(1) == word.charAt(c) || word.charAt(2) == word.charAt(c) || word.charAt(3) == word.charAt(c) || word.charAt(4) == word.charAt(c)){
          
//          status[r][c] = XPLACEMENT;
          
        
//        } else if (letterat == 'e' || letterat == 'p' || letterat == 'u'){
          
//          status[r][c] = MISS;
        
//        }
        
//      r += 1;
      
        
//      }
  
//      if (status[r][c] == EMPTY){
//        fill(180);
        
//      } else if(status[r][c] == INCORRECT){
       
//        fill(254, 101, 101);
       
//      } else if (status [r][c] == XPLACEMENT){
       
//        fill (252, 222, 105);
     
//      } else if (status [r][c] == CORRECT){
       
//        fill (75, 214, 85);
     
//      }
      
//      rect(x, y, tw, th);
     
//      if (letter != 0){
//        fill(255);
//        textAlign(CENTER, CENTER);
//        textFont(fontStart);
//        text(letter, x + tw/2, y + th/2);
//      }
//    }
//  }
}}
