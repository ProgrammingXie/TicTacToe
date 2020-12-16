// Client use Circles (1)
import processing.net.*;

Client myClient;
int [][] Grid;

boolean Check = false;
int Turns = 0;

void setup(){
  
  size(900,900);
  //fullScreen();
  Grid = new int [3][3];
  textAlign(CENTER,CENTER);
  textSize(40);
  myClient = new Client(this, "127.0.0.1", 1234);
  
}


void draw(){
  background(#C1A170);
  
  fill(RGB,0);
  if (Turns == 0){
    stroke(#03FF58);
  }
  else {
    stroke(#FF0303);
  }
  strokeWeight(20);
  rect(0,0,width,height);// most outer lines
  
  fill(#DBBB8C);
  stroke(#5B2C12);
  strokeWeight(20);
  rect(120,120,660,660,5);
  
  stroke(10);
  strokeWeight(2);
  rect(130,130,640,640);
  
  line(343,130, 343,770);// verticles line 1
  line(556,130, 556,770);// verticles line 2
  line(130,343, 770,343);// horizontal line 1
  line(130,556, 770,556);// horizontal line 2
  
  
  //int RowNumber = 0;
  //int ColumnNumber = 0;
  //while (RowNumber < 3) {
  //  DrawXO(RowNumber, ColumnNumber);
  //  ColumnNumber++;
  //  if (ColumnNumber == 3) {
  //    ColumnNumber = 0;
  //    RowNumber++;
  //  }
  //} 
  for (int RowNumber = 0; RowNumber < 3; RowNumber++){
    for (int ColumnNumber = 0; ColumnNumber < 3; ColumnNumber++){
      DrawXO(RowNumber, ColumnNumber);
    }
  }
  
  fill(0);
  text(mouseX + "," + mouseY, width/2, 850);
  
  if (myClient.available() > 0){
    String incoming = myClient.readString();
    int r = int(incoming.substring(0,1));
    int c = int(incoming.substring(2,3));
    Turns = int(incoming.substring(4,5));
    Grid[r][c] = 2;
  }
  
  if (mouseX > 130 && mouseX < 770 && mouseY > 130 && mouseY < 770){
    Check = true;
  }
  else {
    Check = false;
  }
  
  //println(RowNumber,ColumnNumber);
  //println(Check);
  //println(Grid[RowNumber][ColumnNumber]);
  println(mouseX,mouseY);
  

}
//=====================================================================================================

void DrawXO(int RowNumber, int ColumnNumber){
  pushMatrix();
  translate(ColumnNumber*213+130, RowNumber*213+130);
  if (Grid[RowNumber][ColumnNumber] == 1){
    fill(RGB,0);
    stroke(0);
    strokeWeight(10);
    ellipse(106.5,106.5,130,130);
  }
  else if (Grid[RowNumber][ColumnNumber] == 2){
    stroke(0);
    strokeWeight(10);
    line(41,41, 172,172);
    line(172,41, 41,172);
  }
  popMatrix();
}
//=====================================================================================================

void mouseReleased(){
  int RowNumber = (int) ((mouseY-130)/214);
  int ColumnNumber = (int) ((mouseX-130)/214);
  if (Check){
    if (Grid[RowNumber][ColumnNumber] == 0 && Turns == 0){// check if empty or not
      Grid[RowNumber][ColumnNumber] = 1;
      Turns = 1;
      myClient.write(RowNumber + "," + ColumnNumber + "," + Turns);
      myClient.write(Turns);
    }
  }
  
  
  println(RowNumber,ColumnNumber);
}
//=====================================================================================================
