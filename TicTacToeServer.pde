//Sever sneds x's (2)
import processing.net.*;

Server myServer;
int [][] Grid;

boolean Check = false;
int Turns = 0;

void setup(){
  
  size(900,900);
  Grid = new int [3][3];
  textAlign(CENTER,CENTER);
  textSize(40);
  myServer = new Server(this, 1234);
  
}


void draw(){
  background(#C1A170);
  
  fill(RGB,0);
  if (Turns == 1){
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
  
  
  for (int RowNumber = 0; RowNumber < 3; RowNumber++){
    for (int ColumnNumber = 0; ColumnNumber < 3; ColumnNumber++){
      DrawXO(RowNumber, ColumnNumber);
    }
  }
  
  fill(0);
  text(mouseX + "," + mouseY, width/2, 850);
  
  Client myClient = myServer.available();
  if (myClient != null){
    String incoming = myClient.readString();
    int r = int(incoming.substring(0,1));
    int c = int(incoming.substring(2,3));
    Turns = int(incoming.substring(4,5));
    Grid[r][c] = 1;
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
    if (Grid[RowNumber][ColumnNumber] == 0 && Turns == 1){// check if empty or not
      Turns = 0;
      Grid[RowNumber][ColumnNumber] = 2;
      myServer.write(RowNumber + "," + ColumnNumber + "," + Turns);
    }
  }
  
  
  println(RowNumber,ColumnNumber);
}
//=====================================================================================================
