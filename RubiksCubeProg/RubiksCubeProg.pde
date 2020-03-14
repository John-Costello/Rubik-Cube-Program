// Programmed by John Costello  24/12/18
//-----------------------------------------
import javax.swing.*;
byte[] cell = new byte[55];            // The two-dimensional visual grid of cells, where each sticker is located.
byte[] stickerRequiredByCell = new byte[55]; // The stickerRequiredByCell[k] gives the sticker_number required by cell[k] for the sticker to be in the correct cell relative the cube's center stickers.
byte[] cellOfStickerRequiredByCell = new byte[55];  // Is the cell number that a stricker is in, where that sticker is required by a different cell.
byte[] stickerColour = new byte[55];  // The sticker_color of each sticker.
byte[] cellOfSticker = new byte[55];  // Gives the value of the cell where a sticker is held
byte[] cellRequiredBySticker= new byte[55];
byte startColourFrontFace=-1;         // The colour of the front face of the cube when stage one is started.
byte startColourTopFace=-2;           // The colour of the top face of the cube when stage one is started.
byte activeSticker=0;                   // The sticker that the programs is currently try to move to its correct cell.
float[] cellXLoc = new float[55];     // The visual display x-location of each cell.
float[] cellYLoc= new float[55];      // The visual display y-location of each cell.
float[] buttonXLoc= new float[19];    // The visual display x-location of each circular button.
float[] buttonYLoc= new float[19];    // The visual display y-location of each circular button.
float[] disToButton= new float[19];   // The distance of the mouse to the centre of that button.
float cellLength=50;                  // The visual display length of each cell.
float cellDatumX=100;                 // The visual display datum in the x-axis of the cells.
float cellDatumY=400;                 // The visual display datum in the y-axis of the cells.
float rectButtonDatumX=900;           // The visual display datum in the x-axis of the rectangular buttons.
float rectButtonDatumY=200;           // The visual display datum in the y-axis of the rectangular buttons.
float rectButtonWidth=130;            // The visual display length in the x-axis of the rectangular buttons.
float rectButtonHeight=40;            // The visual display height in the y-axis of the rectangular buttons.
float buttonDiameter=0.8*cellLength;  // The visual display diameter of circular buttons.
float buttonRadius=0.4*buttonDiameter;  // The visual display diameter of circular buttons.
byte buttonPrimed,buttonHoovering, buttonReleased, buttonSelected;  // Conditions relating to pressing the buttons
boolean mouseLongTimePressed;      // Conditions relating to pressing the buttons such that the buttons does not activate until mouse is released
boolean displayNumbers=false;         // Set to 'true' to show numbers relating to cells.
String name;

byte[] centerStickers={26,5,29,50,23,32};

byte[] centerCellsFrBtBkTp={26,50,32,5};     byte[] centerStickersFrBtBkTp={26,50,32,5};
byte[] centerCellsLtFrRtBk={26,29,32,23};   byte[] centerStickersLtFrRtBk={26,29,32,23};

byte[] frontFaceEdgeCells={38,25,14,27};      byte[] frontFaceEdgeStickers={38,25,14,27};
byte[] topFaceEdgeCells={2,4,6,8};               byte[] topFaceEdgeStickers={2,4,6,8};
byte[] bottomFaceEdgeCells={47,49,51,53};   byte[] bottomFaceEdgeStickers={47,49,51,53};
byte[] leftFaceEdgeCells={11,22,24,35};       byte[] leftFaceEdgeStickers={11,22,24,35};
byte[] rightFaceEdgeCells={17,28,41,30};    byte[] rightFaceEdgeStickers={17,28,41,30};
byte[] backFaceEdgeCells={20,31,44,33};      byte[] backFaceEdgeStickers={20,31,44,33};

byte[] frontRimEdgeCells={8,24,47,28};         byte[] frontRimEdgeStickers={8,24,47,28};
byte[] topRimEdgeCells={11,14,17,20};         byte[] topRimEdgeStickers={11,14,17,20};
byte[] bottomRimEdgeCells={35,38,41,44};     byte[] bottomRimEdgeStickers={35,38,41,44};
byte[] backRimEdgeCells={2,22,30,53};          byte[] backRimEdgeStickers={2,22,30,53};
byte[] leftRimEdgeCells={4,25,33,49};           byte[] leftRimEdgeStickers={4,25,33,49};
byte[] rightRimEdgeCells={6,27,31,51};        byte[] rightRimEdgeStickers={6,27,31,51};

byte[] frontFaceCornerCells={13,15,37,39};
byte[] frontRimCornerCells={7,9,12,16,36,40,46,48};
byte[] backFaceCornerCells={19,21,43,45};
byte[] backRimCornerCells={1,3,10,18,34,42,52,54};

byte[] redCornerStickers={13,15,37,39};
byte[] yellowCornerStickers={1,3,7,9};
byte[] greenCornerStickers={16,18,40,42};
byte[] whiteCornerStickers={46,48,52,54};
byte[] blueCornerStickers={10,12,34,36};
byte[] orangeCornerStickers={19,21,43,45};

byte[] redOrangeAxisMidRegionEdgeStickers={4,6,11,17,35,41,49,51};
byte[] yellowWhiteAxisMidRegionEdgeStickers={22,24,25,27,28,30,31,33};
byte[] greenBlueAxisMidRegionEdgeStickers={2,8,14,20,38,44,47,53};
byte[] activeMidRegionEdgeStickers={0,0,0,0,0,0,0,0};

byte[][] cellCornerCubelet={{0,0,0},{7,12,13},{9,15,16},{39,40,48},{36,37,46},{1,10,21},{3,18,19},{42,43,54},{34,45,52}};

void setup()
{
   size(1100,950);
   background(212);
   reset();
   //----------------------
   stroke(0);
   strokeWeight(1);
   textSize(100);
   fill(0,0,255);
   text('R',300,100);
   fill(255,255,0);
   text('u',360,100);
   fill(0,255,0);
   text('b',420,100);
   fill(255,0,0);
   text('i',480,100);  
   fill(255);
   text('k',510,100); 
   fill(255,127,0);
   text("'",570,100); 
   fill(255,127,0);
   text("s",585,100);
   fill(255,0,0);
   text('C',300,190);
   fill(0,255,0);
   text('u',360,190);
   fill(0,0,255);
   text('b',420,190);
   fill(255,255,0);
   text('e',480,190);   
}
//====================================================================================================================
void reset()
{  
   for(byte k=0;k<=54;k++)
   {
      cell[k]=k;
      stickerRequiredByCell[k]=k;
      cellOfStickerRequiredByCell[k]=k; 
      cellRequiredBySticker[k]=k;
   }
   for(byte k=0;k<=54;k++)
   {
      cellOfSticker[cell[k]]=k;
   }
   for(byte i=1;i<=3;i++)
   {
      for(byte j=0;j<3;j++)
      {
          stickerColour[i+j*3]=-2;     // Yellow stickers are represented by the stickerColour value -2.
          stickerColour[9+i+j*12]=-5;  // Blue stickers are represented by the stickerColour value -5.
          stickerColour[12+i+j*12]=-1;  // Red stickers are represented by the stickerColour value -1. 
          stickerColour[15+i+j*12]=-3;  // Green stickers are represented by the stickerColour value -3.
          stickerColour[18+i+j*12]=-6;  // Orange sticker are represented by the stickerColour value -6.
          stickerColour[45+i+j*3]=-4;   // White stickers are represented by the stickerColour value -4.
          //--------------------------------------------------------------
          cellXLoc[i+j*3]=cellDatumX+(2+i)*cellLength;
          cellXLoc[9+i+j*12]=cellDatumX+(i-1)*cellLength;
          cellXLoc[12+i+j*12]=cellDatumX+(2+i)*cellLength;
          cellXLoc[15+i+j*12]=cellDatumX+(5+i)*cellLength;
          cellXLoc[18+i+j*12]=cellDatumX+(8+i)*cellLength;
          cellXLoc[45+i+j*3]=cellDatumX+(2+i)*cellLength;
          //--------------------------------------------------------------
          cellYLoc[i+j*3]=cellDatumY+(j)*cellLength;
          cellYLoc[9+i+j*12]=cellDatumY+(3+j)*cellLength;
          cellYLoc[12+i+j*12]=cellDatumY+(3+j)*cellLength;
          cellYLoc[15+i+j*12]=cellDatumY+(3+j)*cellLength;
          cellYLoc[18+i+j*12]=cellDatumY+(3+j)*cellLength;
          cellYLoc[45+i+j*3]=cellDatumY+(6+j)*cellLength;
      }
   }
   drawCube();
   drawButtons();
}
//====================================================================================================================
void draw()
{  
   for(byte k=1;k<=18;k++)
   {
      disToButton[k]=(sqrt(sq(mouseX-buttonXLoc[k])+sq(mouseY-buttonYLoc[k])));
   }
   if(mousePressed==true && mouseLongTimePressed==false)
   {  
      if(mouseX>=rectButtonDatumX && mouseX<=rectButtonDatumX+rectButtonWidth)
      {
         if(mouseY>=rectButtonDatumY && mouseY<=rectButtonDatumY+rectButtonHeight){buttonPrimed=19;}
         else if(mouseY>=rectButtonDatumY+2*rectButtonHeight && mouseY<=rectButtonDatumY+3*rectButtonHeight){buttonPrimed=20;}
         else if(mouseY>=rectButtonDatumY+4*rectButtonHeight && mouseY<=rectButtonDatumY+5*rectButtonHeight){buttonPrimed=21;}
         else if(mouseY>=rectButtonDatumY+6*rectButtonHeight && mouseY<=rectButtonDatumY+7*rectButtonHeight){buttonPrimed=22;}
         else if(mouseY>=rectButtonDatumY+8*rectButtonHeight && mouseY<=rectButtonDatumY+9*rectButtonHeight){buttonPrimed=23;}
         else if(mouseY>=rectButtonDatumY+10*rectButtonHeight && mouseY<=rectButtonDatumY+11*rectButtonHeight){buttonPrimed=24;}
         else if(mouseY>=rectButtonDatumY+12*rectButtonHeight && mouseY<=rectButtonDatumY+13*rectButtonHeight){buttonPrimed=25;}
         else if(mouseY>=rectButtonDatumY+14*rectButtonHeight && mouseY<=rectButtonDatumY+15*rectButtonHeight){buttonPrimed=26;}
      }
      else
      {
         for(byte k=1;k<=18;k++)
         {
            if(disToButton[k]<=buttonRadius){buttonPrimed=k;}
         }
      }
      mouseLongTimePressed=true;
   }
   if(mousePressed==true && mouseLongTimePressed==true) 
   {
      buttonHoovering=0;
      if(mouseX>=rectButtonDatumX && mouseX<=rectButtonDatumX+rectButtonWidth)
      {
         if(mouseY>=rectButtonDatumY && mouseY<=rectButtonDatumY+rectButtonHeight){buttonHoovering=19;}
         else if(mouseY>=rectButtonDatumY+2*rectButtonHeight && mouseY<=rectButtonDatumY+3*rectButtonHeight){buttonHoovering=20;}
         else if(mouseY>=rectButtonDatumY+4*rectButtonHeight && mouseY<=rectButtonDatumY+5*rectButtonHeight){buttonHoovering=21;}
         else if(mouseY>=rectButtonDatumY+6*rectButtonHeight && mouseY<=rectButtonDatumY+7*rectButtonHeight){buttonHoovering=22;}
         else if(mouseY>=rectButtonDatumY+8*rectButtonHeight && mouseY<=rectButtonDatumY+9*rectButtonHeight){buttonHoovering=23;}
         else if(mouseY>=rectButtonDatumY+10*rectButtonHeight && mouseY<=rectButtonDatumY+11*rectButtonHeight){buttonHoovering=24;}
         else if(mouseY>=rectButtonDatumY+12*rectButtonHeight && mouseY<=rectButtonDatumY+13*rectButtonHeight){buttonHoovering=25;}
         else if(mouseY>=rectButtonDatumY+14*rectButtonHeight && mouseY<=rectButtonDatumY+15*rectButtonHeight){buttonHoovering=26;}
      }
      else
      {
         for(byte k=1;k<=18;k++)
         {
            if(disToButton[k]<=buttonRadius){buttonHoovering=k;}
         }   
      }
      strokeWeight(2);
      stroke(0);
      fill(255,255,0);
      for(byte k=1;k<=18;k++)
      {
         if(buttonPrimed==k)
         {
            if(buttonHoovering==k)
            {  
               strokeWeight(2);
               stroke(0);
               fill(225,255,0);
               ellipse(buttonXLoc[k],buttonYLoc[k],buttonDiameter,buttonDiameter);
            }
            else
            {
               strokeWeight(4);
               stroke(255,150,50);
               fill(212);
               ellipse(buttonXLoc[k],buttonYLoc[k],buttonDiameter-6,buttonDiameter-6);
            }  
         }
      }
      strokeWeight(2);
      stroke(0);
      fill(225,255,0);
      if(buttonPrimed==19 && buttonHoovering==19){rect(rectButtonDatumX,rectButtonDatumY,rectButtonWidth,rectButtonHeight);}
      if(buttonPrimed==20 && buttonHoovering==20){rect(rectButtonDatumX,rectButtonDatumY+2*rectButtonHeight,rectButtonWidth,rectButtonHeight);}
      if(buttonPrimed==21 && buttonHoovering==21){rect(rectButtonDatumX,rectButtonDatumY+4*rectButtonHeight,rectButtonWidth,rectButtonHeight);}
      if(buttonPrimed==22 && buttonHoovering==22){rect(rectButtonDatumX,rectButtonDatumY+6*rectButtonHeight,rectButtonWidth,rectButtonHeight);}
      if(buttonPrimed==23 && buttonHoovering==23){rect(rectButtonDatumX,rectButtonDatumY+8*rectButtonHeight,rectButtonWidth,rectButtonHeight);}
      if(buttonPrimed==24 && buttonHoovering==24){rect(rectButtonDatumX,rectButtonDatumY+10*rectButtonHeight,rectButtonWidth,rectButtonHeight);}
      if(buttonPrimed==25 && buttonHoovering==25){rect(rectButtonDatumX,rectButtonDatumY+12*rectButtonHeight,rectButtonWidth,rectButtonHeight);}
      if(buttonPrimed==26 && buttonHoovering==26){rect(rectButtonDatumX,rectButtonDatumY+14*rectButtonHeight,rectButtonWidth,rectButtonHeight);}
      strokeWeight(4);
      stroke(255,150,50);
      fill(212);
      if(buttonPrimed==19 && buttonHoovering!=19){rect(rectButtonDatumX+3,rectButtonDatumY+3,rectButtonWidth-6,rectButtonHeight-6);}
      if(buttonPrimed==20 && buttonHoovering!=20){rect(rectButtonDatumX+3,rectButtonDatumY+3+2*rectButtonHeight,rectButtonWidth-6,rectButtonHeight-6);}
      if(buttonPrimed==21 && buttonHoovering!=21){rect(rectButtonDatumX+3,rectButtonDatumY+3+4*rectButtonHeight,rectButtonWidth-6,rectButtonHeight-6);}
      if(buttonPrimed==22 && buttonHoovering!=22){rect(rectButtonDatumX+3,rectButtonDatumY+3+6*rectButtonHeight,rectButtonWidth-6,rectButtonHeight-6);}
      if(buttonPrimed==23 && buttonHoovering!=23){rect(rectButtonDatumX+3,rectButtonDatumY+3+8*rectButtonHeight,rectButtonWidth-6,rectButtonHeight-6);}
      if(buttonPrimed==24 && buttonHoovering!=24){rect(rectButtonDatumX+3,rectButtonDatumY+3+10*rectButtonHeight,rectButtonWidth-6,rectButtonHeight-6);}
      if(buttonPrimed==25 && buttonHoovering!=25){rect(rectButtonDatumX+3,rectButtonDatumY+3+12*rectButtonHeight,rectButtonWidth-6,rectButtonHeight-6);}
      if(buttonPrimed==26 && buttonHoovering!=26){rect(rectButtonDatumX+3,rectButtonDatumY+3+14*rectButtonHeight,rectButtonWidth-6,rectButtonHeight-6);}
      drawButtonSymbols();
   }
   buttonReleased=0;
   buttonSelected=0;
   if(mousePressed==false && mouseLongTimePressed==true)
   {   
      if(mouseX>=rectButtonDatumX && mouseX<=rectButtonDatumX+rectButtonWidth)
      {
         if(mouseY>=rectButtonDatumY && mouseY<=rectButtonDatumY+rectButtonHeight){if(buttonPrimed==19){buttonSelected=19;}}
         else if(mouseY>=rectButtonDatumY+2*rectButtonHeight && mouseY<=rectButtonDatumY+3*rectButtonHeight){if(buttonPrimed==20){buttonSelected=20;}}
         else if(mouseY>=rectButtonDatumY+4*rectButtonHeight && mouseY<=rectButtonDatumY+5*rectButtonHeight){if(buttonPrimed==21){buttonSelected=21;}}
         else if(mouseY>=rectButtonDatumY+6*rectButtonHeight && mouseY<=rectButtonDatumY+7*rectButtonHeight){if(buttonPrimed==22){buttonSelected=22;}}
         else if(mouseY>=rectButtonDatumY+8*rectButtonHeight && mouseY<=rectButtonDatumY+9*rectButtonHeight){if(buttonPrimed==23){buttonSelected=23;}}
         else if(mouseY>=rectButtonDatumY+10*rectButtonHeight && mouseY<=rectButtonDatumY+11*rectButtonHeight){if(buttonPrimed==24){buttonSelected=24;}}
         else if(mouseY>=rectButtonDatumY+12*rectButtonHeight && mouseY<=rectButtonDatumY+13*rectButtonHeight){if(buttonPrimed==25){buttonSelected=25;}}
         else if(mouseY>=rectButtonDatumY+14*rectButtonHeight && mouseY<=rectButtonDatumY+15*rectButtonHeight){if(buttonPrimed==26){buttonSelected=26;}}
      }
      else
      {
         for(byte k=1;k<=18;k++)
         {  
            if(disToButton[k]<=buttonRadius){buttonReleased=k;}
            if(buttonPrimed==k && buttonReleased==k){buttonSelected=k;}
         }
      }   
      mouseLongTimePressed=false;
      drawButtons();
   }
   if(mousePressed==false)
   {
      mouseLongTimePressed=false;
      buttonPrimed=0;
   }
   if(buttonSelected>=1 && buttonSelected<=18)
   { 
      cubeButton(buttonSelected);
      drawCube();
   }
   if(buttonSelected==19)
   {
      name=JOptionPane.showInputDialog("        Greetings\n\n"+"Please enter your name: " + "");
      JOptionPane.showMessageDialog(null,"     Hello "+name+"\n\nBest of luck with Rubik's Cube");
      JOptionPane.showMessageDialog(null,"With the Rubik's Cube, the best way to solve it is to pick a\n side and firstly get the four edge cubelets for that side.\n"+
      "Then get the four corner cublets for the same side.\nThen get the four edge cubelets for the mid region of the cube.\n"+
      "Then the four edge cubelets for the far side of the cube.\nAnd lastly the four corner cubelets of the far side of the cube.");        
   }
   if(buttonSelected==20)
   {  
      reset();
   }
   if(buttonSelected==21)
   {
      randonize();
   }
   if(buttonSelected==22)
   {
      solveOne();
   }
   if(buttonSelected==23)
   {
      solveTwo();
   }
   if(buttonSelected==24)
   {
      solveThree();
   }
   if(buttonSelected==25)
   {
      solveFour();
   }
   if(buttonSelected==26)
   {  
      solveFive();
   } 
}
//===============================================================================================
void randonize()
{   
    for(int m=0;m<=150;m++)
    {
       cubeButton(byte(1+random(18)));
    }
    drawCube();
}
//================================================================================================
void drawCube()
{  
   strokeWeight(1);
   for(byte k=1;k<=54;k++)
   {
      if(stickerColour[cell[k]]==-2){fill(255,255,0);}  // Fill cell yellow.
      else if(stickerColour[cell[k]]==-5){fill(0,0,255);}  // Fill cell blue.
      else if(stickerColour[cell[k]]==-1){fill(255,0,0);}  // Fill cell red.
      else if(stickerColour[cell[k]]==-3){fill(0,255,0);}  // Fill cell green.
      else if(stickerColour[cell[k]]==-6){fill(255,127,0);}  // Fill cell orange.     
      else if(stickerColour[cell[k]]==-4){fill(255,255,255);}  // Fill cell white.
      rect(cellXLoc[k],cellYLoc[k],cellLength,cellLength);
      textSize(cellLength/5);
      fill(0);
      if(displayNumbers==true)
      {
         text(k,cellXLoc[k]+1,cellYLoc[k]+10);
         text(stickerRequiredByCell[k],cellXLoc[k]+1,cellYLoc[k]+cellLength-12);
         text(cellOfStickerRequiredByCell[k],cellXLoc[k]+1,cellYLoc[k]+cellLength-2);
         textSize(cellLength*3/10);
         text(cell[k],cellXLoc[k]+cellLength-19,cellYLoc[k]+15);
         textSize(cellLength/5);
         text(cellRequiredBySticker[cell[k]],cellXLoc[k]+cellLength-13,cellYLoc[k]+cellLength-12);
         //text("",cellXLoc[k]+cellLength-13,cellYLoc[k]+cellLength-2);
      }
   }
}
//=============================================================================================
void drawButtons()
{
   buttonXLoc[1]=cellXLoc[1]+cellLength/2;
   buttonXLoc[2]=cellXLoc[2]+cellLength/2;
   buttonXLoc[3]=cellXLoc[3]+cellLength/2;
   buttonXLoc[4]=cellXLoc[52]+cellLength/2;
   buttonXLoc[5]=cellXLoc[53]+cellLength/2;
   buttonXLoc[6]=cellXLoc[54]+cellLength/2;
   buttonXLoc[7]=cellXLoc[10]-cellLength/2;
   buttonXLoc[8]=cellXLoc[22]-cellLength/2;
   buttonXLoc[9]=cellXLoc[34]-cellLength/2;
   buttonXLoc[10]=cellXLoc[21]+3*cellLength/2;
   buttonXLoc[11]=cellXLoc[33]+3*cellLength/2;
   buttonXLoc[12]=cellXLoc[45]+3*cellLength/2;
   buttonXLoc[13]=cellXLoc[16]+cellLength/2;
   buttonXLoc[14]=cellXLoc[16]+cellLength/2+0.75*cellLength;
   buttonXLoc[15]=cellXLoc[16]+cellLength/2+0.75*2*cellLength;
   buttonXLoc[16]=cellXLoc[40]+cellLength/2;
   buttonXLoc[17]=cellXLoc[40]+cellLength/2+0.75*cellLength;
   buttonXLoc[18]=cellXLoc[40]+cellLength/2+0.75*2*cellLength;
   
   buttonYLoc[1]=cellYLoc[1]-cellLength/2;
   buttonYLoc[2]=cellYLoc[2]-cellLength/2;
   buttonYLoc[3]=cellYLoc[3]-cellLength/2;
   buttonYLoc[4]=cellYLoc[52]+3*cellLength/2;
   buttonYLoc[5]=cellYLoc[53]+3*cellLength/2;
   buttonYLoc[6]=cellYLoc[54]+3*cellLength/2;
   buttonYLoc[7]=cellYLoc[10]+cellLength/2;
   buttonYLoc[8]=cellYLoc[22]+cellLength/2;
   buttonYLoc[9]=cellYLoc[34]+cellLength/2;
   buttonYLoc[10]=cellYLoc[21]+cellLength/2;
   buttonYLoc[11]=cellYLoc[33]+cellLength/2;
   buttonYLoc[12]=cellYLoc[45]+cellLength/2;
   buttonYLoc[13]=cellYLoc[9]+cellLength/2;
   buttonYLoc[14]=cellYLoc[9]+cellLength/2-0.75*cellLength;
   buttonYLoc[15]=cellYLoc[9]+cellLength/2-0.75*2*cellLength;
   buttonYLoc[16]=cellYLoc[48]+cellLength/2;
   buttonYLoc[17]=cellYLoc[48]+cellLength/2+0.75*cellLength;
   buttonYLoc[18]=cellYLoc[48]+cellLength/2+0.75*2*cellLength;
   strokeWeight(2);
   stroke(0);
   fill(212);
   for(byte k=1;k<=18;k++)
   {
     ellipse(buttonXLoc[k],buttonYLoc[k],buttonDiameter,buttonDiameter);
   }
   rect(rectButtonDatumX,rectButtonDatumY,rectButtonWidth,rectButtonHeight);   
   rect(rectButtonDatumX,rectButtonDatumY+2*rectButtonHeight,rectButtonWidth,rectButtonHeight);
   rect(rectButtonDatumX,rectButtonDatumY+4*rectButtonHeight,rectButtonWidth,rectButtonHeight);
   rect(rectButtonDatumX,rectButtonDatumY+6*rectButtonHeight,rectButtonWidth,rectButtonHeight);
   rect(rectButtonDatumX,rectButtonDatumY+8*rectButtonHeight,rectButtonWidth,rectButtonHeight);
   rect(rectButtonDatumX,rectButtonDatumY+10*rectButtonHeight,rectButtonWidth,rectButtonHeight);
   rect(rectButtonDatumX,rectButtonDatumY+12*rectButtonHeight,rectButtonWidth,rectButtonHeight);
   rect(rectButtonDatumX,rectButtonDatumY+14*rectButtonHeight,rectButtonWidth,rectButtonHeight);
   drawButtonSymbols();
}
//=================================================================================================
void drawButtonSymbols()
{
   strokeWeight(1);
   stroke(0);
   noFill();
   for(byte k=1;k<=3;k++)
   {
      line(buttonXLoc[k],buttonYLoc[k]-buttonRadius*0.5,buttonXLoc[k],buttonYLoc[k]+buttonRadius*0.5);
      line(buttonXLoc[k],buttonYLoc[k]-buttonRadius*0.5,buttonXLoc[k]-buttonRadius*0.25,buttonYLoc[k]-buttonRadius*0.012);
      line(buttonXLoc[k],buttonYLoc[k]-buttonRadius*0.5,buttonXLoc[k]+buttonRadius*0.25,buttonYLoc[k]-buttonRadius*0.012);
   }
   for(byte k=4;k<=6;k++)
   {
      line(buttonXLoc[k],buttonYLoc[k]-buttonRadius*0.5,buttonXLoc[k],buttonYLoc[k]+buttonRadius*0.5);
      line(buttonXLoc[k],buttonYLoc[k]+buttonRadius*0.5,buttonXLoc[k]-buttonRadius*0.25,buttonYLoc[k]+buttonRadius*0.012);
      line(buttonXLoc[k],buttonYLoc[k]+buttonRadius*0.5,buttonXLoc[k]+buttonRadius*0.25,buttonYLoc[k]+buttonRadius*0.012);
   }
   for(byte k=7;k<=9;k++)
   {
      line(buttonXLoc[k]-buttonRadius*0.5,buttonYLoc[k],buttonXLoc[k]+buttonRadius*0.5,buttonYLoc[k]);
      line(buttonXLoc[k]-buttonRadius*0.5,buttonYLoc[k],buttonXLoc[k]-buttonRadius*0.012,buttonYLoc[k]-buttonRadius*0.25);
      line(buttonXLoc[k]-buttonRadius*0.5,buttonYLoc[k],buttonXLoc[k]-buttonRadius*0.012,buttonYLoc[k]+buttonRadius*0.25);
   }
   for(byte k=10;k<=12;k++)
   {
      line(buttonXLoc[k]+buttonRadius*0.5,buttonYLoc[k],buttonXLoc[k]-buttonRadius*0.5,buttonYLoc[k]);
      line(buttonXLoc[k]+buttonRadius*0.5,buttonYLoc[k],buttonXLoc[k]+buttonRadius*0.012,buttonYLoc[k]-buttonRadius*0.25);
      line(buttonXLoc[k]+buttonRadius*0.5,buttonYLoc[k],buttonXLoc[k]+buttonRadius*0.012,buttonYLoc[k]+buttonRadius*0.25);
   }
   for(byte k=13;k<=15;k++)
   {
      arc(buttonXLoc[k]-buttonRadius*0.45,buttonYLoc[k]+buttonRadius*0.05,buttonDiameter*0.515,buttonDiameter*0.515,-.4*PI,0.25*PI);
      line(buttonXLoc[k]-buttonRadius*0.2,buttonYLoc[k]-buttonRadius*0.6,buttonXLoc[k]+buttonRadius*0.33,buttonYLoc[k]-buttonRadius*0.5);
      line(buttonXLoc[k]-buttonRadius*0.3,buttonYLoc[k]-buttonRadius*0.6,buttonXLoc[k]-buttonRadius*0.15,buttonYLoc[k]+buttonRadius*0.012);
   }
      for(byte k=16;k<=18;k++)
   {
      arc(buttonXLoc[k]-buttonRadius*0.45,buttonYLoc[k]-buttonRadius*0.05,buttonDiameter*0.515,buttonDiameter*0.515,-.25*PI,0.4*PI);
      line(buttonXLoc[k]-buttonRadius*0.2,buttonYLoc[k]+buttonRadius*0.6,buttonXLoc[k]+buttonRadius*0.33,buttonYLoc[k]+buttonRadius*0.5);
      line(buttonXLoc[k]-buttonRadius*0.3,buttonYLoc[k]+buttonRadius*0.6,buttonXLoc[k]-buttonRadius*0.15,buttonYLoc[k]-buttonRadius*0.012);
   } 
   textSize(18);
   stroke(0);
   fill(0);
   text("About",rectButtonDatumX+13,rectButtonDatumY+27);
   text("Reset",rectButtonDatumX+13,rectButtonDatumY+27+2*rectButtonHeight);
   text("Randonize",rectButtonDatumX+13,rectButtonDatumY+27+4*rectButtonHeight);
   text("Stage One",rectButtonDatumX+13,rectButtonDatumY+27+6*rectButtonHeight);
   text("Stage Two",rectButtonDatumX+13,rectButtonDatumY+27+8*rectButtonHeight);
   text("Stage Three",rectButtonDatumX+13,rectButtonDatumY+27+10*rectButtonHeight);
   text("Stage Four",rectButtonDatumX+13,rectButtonDatumY+27+12*rectButtonHeight);
   text("Stage Five",rectButtonDatumX+13,rectButtonDatumY+27+14*rectButtonHeight);
}
//=============================================================================================
//This method moves the pieces from their old cell to their new cell.
//
void cubeButton(byte b)
{  
   byte[] oldCell = new byte[55];
   byte[] newCell = new byte[55];
   byte[] oldStkrRqrd = new byte[55];
   byte[] newStkrRqrd = new byte[55];
   for(byte k=0;k<=54;k++)
   {   oldCell[k]=cell[k];
       newCell[k]=oldCell[k];
       oldStkrRqrd[k]=stickerRequiredByCell[k];
       newStkrRqrd[k]=oldStkrRqrd[k];
   }
   
   if(b==1)
   {
      newCell[1]=oldCell[13]; newCell[4]=oldCell[25]; newCell[7]=oldCell[37];
      newCell[13]=oldCell[46]; newCell[25]=oldCell[49]; newCell[37]=oldCell[52];
      newCell[46]=oldCell[45]; newCell[49]=oldCell[33]; newCell[52]=oldCell[21];
      newCell[45]=oldCell[1]; newCell[33]=oldCell[4]; newCell[21]=oldCell[7];
      newCell[10]=oldCell[12]; newCell[11]=oldCell[24]; newCell[12]=oldCell[36]; 
      newCell[22]=oldCell[11]; newCell[24]=oldCell[35]; 
      newCell[34]=oldCell[10]; newCell[35]=oldCell[22]; newCell[36]=oldCell[34];
   }
   else if(b==4)
   {
      newCell[13]=oldCell[1]; newCell[25]=oldCell[4]; newCell[37]=oldCell[7];
      newCell[46]=oldCell[13]; newCell[49]=oldCell[25]; newCell[52]=oldCell[37];
      newCell[45]=oldCell[46]; newCell[33]=oldCell[49]; newCell[21]=oldCell[52];
      newCell[1]=oldCell[45]; newCell[4]=oldCell[33]; newCell[7]=oldCell[21];
      newCell[12]=oldCell[10]; newCell[24]=oldCell[11]; newCell[36]=oldCell[12]; 
      newCell[11]=oldCell[22]; newCell[35]=oldCell[24]; 
      newCell[10]=oldCell[34]; newCell[22]=oldCell[35]; newCell[34]=oldCell[36];
   }
   else if(b==2)
   {  
      newCell[2]=oldCell[14]; newCell[5]=oldCell[26]; newCell[8]=oldCell[38];
      newCell[14]=oldCell[47]; newCell[26]=oldCell[50]; newCell[38]=oldCell[53];
      newCell[47]=oldCell[44]; newCell[50]=oldCell[32]; newCell[53]=oldCell[20];
      newCell[44]=oldCell[2]; newCell[32]=oldCell[5]; newCell[20]=oldCell[8];
   }
   else if(b==5)
   {  
      newCell[14]=oldCell[2]; newCell[26]=oldCell[5]; newCell[38]=oldCell[8];
      newCell[47]=oldCell[14]; newCell[50]=oldCell[26]; newCell[53]=oldCell[38];
      newCell[44]=oldCell[47]; newCell[32]=oldCell[50]; newCell[20]=oldCell[53];
      newCell[2]=oldCell[44]; newCell[5]=oldCell[32]; newCell[8]=oldCell[20];
   }
   else if(b==3)
   {
      newCell[3]=oldCell[15]; newCell[6]=oldCell[27]; newCell[9]=oldCell[39];
      newCell[15]=oldCell[48]; newCell[27]=oldCell[51]; newCell[39]=oldCell[54];
      newCell[48]=oldCell[43]; newCell[51]=oldCell[31]; newCell[54]=oldCell[19];
      newCell[43]=oldCell[3]; newCell[31]=oldCell[6]; newCell[19]=oldCell[9];
      newCell[16]=oldCell[40]; newCell[17]=oldCell[28]; newCell[18]=oldCell[16]; 
      newCell[28]=oldCell[41]; newCell[30]=oldCell[17]; 
      newCell[40]=oldCell[42]; newCell[41]=oldCell[30]; newCell[42]=oldCell[18];
   }
   else if(b==6)
   {
      newCell[15]=oldCell[3]; newCell[27]=oldCell[6]; newCell[39]=oldCell[9];
      newCell[48]=oldCell[15]; newCell[51]=oldCell[27]; newCell[54]=oldCell[39];
      newCell[43]=oldCell[48]; newCell[31]=oldCell[51]; newCell[19]=oldCell[54];
      newCell[3]=oldCell[43]; newCell[6]=oldCell[31]; newCell[9]=oldCell[19];
      newCell[40]=oldCell[16]; newCell[28]=oldCell[17]; newCell[16]=oldCell[18]; 
      newCell[41]=oldCell[28]; newCell[17]=oldCell[30]; 
      newCell[42]=oldCell[40]; newCell[30]=oldCell[41]; newCell[18]=oldCell[42];
   }
   else if(b==7)
   {
      newCell[10]=oldCell[13]; newCell[11]=oldCell[14]; newCell[12]=oldCell[15];
      newCell[13]=oldCell[16]; newCell[14]=oldCell[17]; newCell[15]=oldCell[18];
      newCell[16]=oldCell[19]; newCell[17]=oldCell[20]; newCell[18]=oldCell[21];
      newCell[19]=oldCell[10]; newCell[20]=oldCell[11]; newCell[21]=oldCell[12];
      newCell[7]=oldCell[9]; newCell[8]=oldCell[6]; newCell[9]=oldCell[3]; 
      newCell[4]=oldCell[8]; newCell[6]=oldCell[2]; 
      newCell[1]=oldCell[7]; newCell[2]=oldCell[4]; newCell[3]=oldCell[1];
   }
   else if(b==10)
   {
      newCell[13]=oldCell[10]; newCell[14]=oldCell[11]; newCell[15]=oldCell[12];
      newCell[16]=oldCell[13]; newCell[17]=oldCell[14]; newCell[18]=oldCell[15];
      newCell[19]=oldCell[16]; newCell[20]=oldCell[17]; newCell[21]=oldCell[18];
      newCell[10]=oldCell[19]; newCell[11]=oldCell[20]; newCell[12]=oldCell[21];
      newCell[9]=oldCell[7]; newCell[6]=oldCell[8]; newCell[3]=oldCell[9]; 
      newCell[8]=oldCell[4]; newCell[2]=oldCell[6]; 
      newCell[7]=oldCell[1]; newCell[4]=oldCell[2]; newCell[1]=oldCell[3];
   }
   else if(b==8)
   {  
      newCell[22]=oldCell[25]; newCell[23]=oldCell[26]; newCell[24]=oldCell[27];
      newCell[25]=oldCell[28]; newCell[26]=oldCell[29]; newCell[27]=oldCell[30];
      newCell[28]=oldCell[31]; newCell[29]=oldCell[32]; newCell[30]=oldCell[33];
      newCell[31]=oldCell[22]; newCell[32]=oldCell[23]; newCell[33]=oldCell[24];
   }
   else if(b==11)
   {  
      newCell[25]=oldCell[22]; newCell[26]=oldCell[23]; newCell[27]=oldCell[24];
      newCell[28]=oldCell[25]; newCell[29]=oldCell[26]; newCell[30]=oldCell[27];
      newCell[31]=oldCell[28]; newCell[32]=oldCell[29]; newCell[33]=oldCell[30];
      newCell[22]=oldCell[31]; newCell[23]=oldCell[32]; newCell[24]=oldCell[33];
   }
   else if(b==9)
   {
      newCell[34]=oldCell[37]; newCell[35]=oldCell[38]; newCell[36]=oldCell[39];
      newCell[37]=oldCell[40]; newCell[38]=oldCell[41]; newCell[39]=oldCell[42];
      newCell[40]=oldCell[43]; newCell[41]=oldCell[44]; newCell[42]=oldCell[45];
      newCell[43]=oldCell[34]; newCell[44]=oldCell[35]; newCell[45]=oldCell[36];
      newCell[46]=oldCell[48]; newCell[47]=oldCell[51]; newCell[48]=oldCell[54]; 
      newCell[49]=oldCell[47]; newCell[51]=oldCell[53]; 
      newCell[52]=oldCell[46]; newCell[53]=oldCell[49]; newCell[54]=oldCell[52];
   }
   else if(b==12)
   {
      newCell[37]=oldCell[34]; newCell[38]=oldCell[35]; newCell[39]=oldCell[36];
      newCell[40]=oldCell[37]; newCell[41]=oldCell[38]; newCell[42]=oldCell[39];
      newCell[43]=oldCell[40]; newCell[44]=oldCell[41]; newCell[45]=oldCell[42];
      newCell[34]=oldCell[43]; newCell[35]=oldCell[44]; newCell[36]=oldCell[45];
      newCell[48]=oldCell[46]; newCell[51]=oldCell[47]; newCell[54]=oldCell[48]; 
      newCell[47]=oldCell[49]; newCell[53]=oldCell[51]; 
      newCell[46]=oldCell[52]; newCell[49]=oldCell[53]; newCell[52]=oldCell[54];
   }
   else if(b==13)
   {
      newCell[16]=oldCell[48]; newCell[28]=oldCell[47]; newCell[40]=oldCell[46];
      newCell[48]=oldCell[36]; newCell[47]=oldCell[24]; newCell[46]=oldCell[12];
      newCell[36]=oldCell[7]; newCell[24]=oldCell[8]; newCell[12]=oldCell[9];
      newCell[7]=oldCell[16]; newCell[8]=oldCell[28]; newCell[9]=oldCell[40];
      newCell[13]=oldCell[15]; newCell[14]=oldCell[27]; newCell[15]=oldCell[39]; 
      newCell[25]=oldCell[14]; newCell[27]=oldCell[38]; 
      newCell[37]=oldCell[13]; newCell[38]=oldCell[25]; newCell[39]=oldCell[37];
   }
   else if(b==16)
   {
      newCell[48]=oldCell[16]; newCell[47]=oldCell[28]; newCell[46]=oldCell[40];
      newCell[36]=oldCell[48]; newCell[24]=oldCell[47]; newCell[12]=oldCell[46];
      newCell[7]=oldCell[36]; newCell[8]=oldCell[24]; newCell[9]=oldCell[12];
      newCell[16]=oldCell[7]; newCell[28]=oldCell[8]; newCell[40]=oldCell[9];
      newCell[15]=oldCell[13]; newCell[27]=oldCell[14]; newCell[39]=oldCell[15]; 
      newCell[14]=oldCell[25]; newCell[38]=oldCell[27]; 
      newCell[13]=oldCell[37]; newCell[25]=oldCell[38]; newCell[37]=oldCell[39];
   }
   else if(b==14)
   {  
      newCell[4]=oldCell[17]; newCell[5]=oldCell[29]; newCell[6]=oldCell[41];
      newCell[35]=oldCell[4]; newCell[23]=oldCell[5]; newCell[11]=oldCell[6];
      newCell[51]=oldCell[35]; newCell[50]=oldCell[23]; newCell[49]=oldCell[11];
      newCell[17]=oldCell[51]; newCell[29]=oldCell[50]; newCell[41]=oldCell[49];
   }
   else if(b==17)
   {  
      newCell[17]=oldCell[4]; newCell[29]=oldCell[5]; newCell[41]=oldCell[6];
      newCell[4]=oldCell[35]; newCell[5]=oldCell[23]; newCell[6]=oldCell[11];
      newCell[35]=oldCell[51]; newCell[23]=oldCell[50]; newCell[11]=oldCell[49];
      newCell[51]=oldCell[17]; newCell[50]=oldCell[29]; newCell[49]=oldCell[41];
   }   
   else if(b==15)
   {
      newCell[1]=oldCell[18]; newCell[2]=oldCell[30]; newCell[3]=oldCell[42];
      newCell[18]=oldCell[54]; newCell[30]=oldCell[53]; newCell[42]=oldCell[52];
      newCell[54]=oldCell[34]; newCell[53]=oldCell[22]; newCell[52]=oldCell[10];
      newCell[34]=oldCell[1]; newCell[22]=oldCell[2]; newCell[10]=oldCell[3];
      newCell[19]=oldCell[43]; newCell[20]=oldCell[31]; newCell[21]=oldCell[19]; 
      newCell[31]=oldCell[44]; newCell[33]=oldCell[20]; 
      newCell[43]=oldCell[45]; newCell[44]=oldCell[33]; newCell[45]=oldCell[21];
   }
   else if(b==18)
   {
      newCell[18]=oldCell[1]; newCell[30]=oldCell[2]; newCell[42]=oldCell[3];
      newCell[54]=oldCell[18]; newCell[53]=oldCell[30]; newCell[52]=oldCell[42];
      newCell[34]=oldCell[54]; newCell[22]=oldCell[53]; newCell[10]=oldCell[52];
      newCell[1]=oldCell[34]; newCell[2]=oldCell[22]; newCell[3]=oldCell[10];
      newCell[43]=oldCell[19]; newCell[31]=oldCell[20]; newCell[19]=oldCell[21]; 
      newCell[44]=oldCell[31]; newCell[20]=oldCell[33]; 
      newCell[45]=oldCell[43]; newCell[33]=oldCell[44]; newCell[21]=oldCell[45];
   }
   //-------------------------------------------------------------------------------
   if(b==2)
   {
      newStkrRqrd[1]=oldStkrRqrd[13]; newStkrRqrd[4]=oldStkrRqrd[25]; newStkrRqrd[7]=oldStkrRqrd[37];
      newStkrRqrd[13]=oldStkrRqrd[46]; newStkrRqrd[25]=oldStkrRqrd[49]; newStkrRqrd[37]=oldStkrRqrd[52];
      newStkrRqrd[46]=oldStkrRqrd[45]; newStkrRqrd[49]=oldStkrRqrd[33]; newStkrRqrd[52]=oldStkrRqrd[21];
      newStkrRqrd[45]=oldStkrRqrd[1]; newStkrRqrd[33]=oldStkrRqrd[4]; newStkrRqrd[21]=oldStkrRqrd[7];
      newStkrRqrd[10]=oldStkrRqrd[12]; newStkrRqrd[11]=oldStkrRqrd[24]; newStkrRqrd[12]=oldStkrRqrd[36]; 
      newStkrRqrd[22]=oldStkrRqrd[11]; newStkrRqrd[24]=oldStkrRqrd[35]; 
      newStkrRqrd[34]=oldStkrRqrd[10]; newStkrRqrd[35]=oldStkrRqrd[22]; newStkrRqrd[36]=oldStkrRqrd[34];
     
      newStkrRqrd[2]=oldStkrRqrd[14]; newStkrRqrd[5]=oldStkrRqrd[26]; newStkrRqrd[8]=oldStkrRqrd[38];
      newStkrRqrd[14]=oldStkrRqrd[47]; newStkrRqrd[26]=oldStkrRqrd[50]; newStkrRqrd[38]=oldStkrRqrd[53];
      newStkrRqrd[47]=oldStkrRqrd[44]; newStkrRqrd[50]=oldStkrRqrd[32]; newStkrRqrd[53]=oldStkrRqrd[20];
      newStkrRqrd[44]=oldStkrRqrd[2]; newStkrRqrd[32]=oldStkrRqrd[5]; newStkrRqrd[20]=oldStkrRqrd[8];

      newStkrRqrd[3]=oldStkrRqrd[15]; newStkrRqrd[6]=oldStkrRqrd[27]; newStkrRqrd[9]=oldStkrRqrd[39];
      newStkrRqrd[15]=oldStkrRqrd[48]; newStkrRqrd[27]=oldStkrRqrd[51]; newStkrRqrd[39]=oldStkrRqrd[54];
      newStkrRqrd[48]=oldStkrRqrd[43]; newStkrRqrd[51]=oldStkrRqrd[31]; newStkrRqrd[54]=oldStkrRqrd[19];
      newStkrRqrd[43]=oldStkrRqrd[3]; newStkrRqrd[31]=oldStkrRqrd[6]; newStkrRqrd[19]=oldStkrRqrd[9];
      newStkrRqrd[16]=oldStkrRqrd[40]; newStkrRqrd[17]=oldStkrRqrd[28]; newStkrRqrd[18]=oldStkrRqrd[16]; 
      newStkrRqrd[28]=oldStkrRqrd[41]; newStkrRqrd[30]=oldStkrRqrd[17]; 
      newStkrRqrd[40]=oldStkrRqrd[42]; newStkrRqrd[41]=oldStkrRqrd[30]; newStkrRqrd[42]=oldStkrRqrd[18];
   }
   else if(b==5)
   {
      newStkrRqrd[13]=oldStkrRqrd[1]; newStkrRqrd[25]=oldStkrRqrd[4]; newStkrRqrd[37]=oldStkrRqrd[7];
      newStkrRqrd[46]=oldStkrRqrd[13]; newStkrRqrd[49]=oldStkrRqrd[25]; newStkrRqrd[52]=oldStkrRqrd[37];
      newStkrRqrd[45]=oldStkrRqrd[46]; newStkrRqrd[33]=oldStkrRqrd[49]; newStkrRqrd[21]=oldStkrRqrd[52];
      newStkrRqrd[1]=oldStkrRqrd[45]; newStkrRqrd[4]=oldStkrRqrd[33]; newStkrRqrd[7]=oldStkrRqrd[21];
      newStkrRqrd[12]=oldStkrRqrd[10]; newStkrRqrd[24]=oldStkrRqrd[11]; newStkrRqrd[36]=oldStkrRqrd[12]; 
      newStkrRqrd[11]=oldStkrRqrd[22]; newStkrRqrd[35]=oldStkrRqrd[24]; 
      newStkrRqrd[10]=oldStkrRqrd[34]; newStkrRqrd[22]=oldStkrRqrd[35]; newStkrRqrd[34]=oldStkrRqrd[36];
    
      newStkrRqrd[14]=oldStkrRqrd[2]; newStkrRqrd[26]=oldStkrRqrd[5]; newStkrRqrd[38]=oldStkrRqrd[8];
      newStkrRqrd[47]=oldStkrRqrd[14]; newStkrRqrd[50]=oldStkrRqrd[26]; newStkrRqrd[53]=oldStkrRqrd[38];
      newStkrRqrd[44]=oldStkrRqrd[47]; newStkrRqrd[32]=oldStkrRqrd[50]; newStkrRqrd[20]=oldStkrRqrd[53];
      newStkrRqrd[2]=oldStkrRqrd[44]; newStkrRqrd[5]=oldStkrRqrd[32]; newStkrRqrd[8]=oldStkrRqrd[20];
   
      newStkrRqrd[15]=oldStkrRqrd[3]; newStkrRqrd[27]=oldStkrRqrd[6]; newStkrRqrd[39]=oldStkrRqrd[9];
      newStkrRqrd[48]=oldStkrRqrd[15]; newStkrRqrd[51]=oldStkrRqrd[27]; newStkrRqrd[54]=oldStkrRqrd[39];
      newStkrRqrd[43]=oldStkrRqrd[48]; newStkrRqrd[31]=oldStkrRqrd[51]; newStkrRqrd[19]=oldStkrRqrd[54];
      newStkrRqrd[3]=oldStkrRqrd[43]; newStkrRqrd[6]=oldStkrRqrd[31]; newStkrRqrd[9]=oldStkrRqrd[19];
      newStkrRqrd[40]=oldStkrRqrd[16]; newStkrRqrd[28]=oldStkrRqrd[17]; newStkrRqrd[16]=oldStkrRqrd[18]; 
      newStkrRqrd[41]=oldStkrRqrd[28]; newStkrRqrd[17]=oldStkrRqrd[30]; 
      newStkrRqrd[42]=oldStkrRqrd[40]; newStkrRqrd[30]=oldStkrRqrd[41]; newStkrRqrd[18]=oldStkrRqrd[42];
   }
   else if(b==8)
   {
      newStkrRqrd[10]=oldStkrRqrd[13]; newStkrRqrd[11]=oldStkrRqrd[14]; newStkrRqrd[12]=oldStkrRqrd[15];
      newStkrRqrd[13]=oldStkrRqrd[16]; newStkrRqrd[14]=oldStkrRqrd[17]; newStkrRqrd[15]=oldStkrRqrd[18];
      newStkrRqrd[16]=oldStkrRqrd[19]; newStkrRqrd[17]=oldStkrRqrd[20]; newStkrRqrd[18]=oldStkrRqrd[21];
      newStkrRqrd[19]=oldStkrRqrd[10]; newStkrRqrd[20]=oldStkrRqrd[11]; newStkrRqrd[21]=oldStkrRqrd[12];
      newStkrRqrd[7]=oldStkrRqrd[9]; newStkrRqrd[8]=oldStkrRqrd[6]; newStkrRqrd[9]=oldStkrRqrd[3]; 
      newStkrRqrd[4]=oldStkrRqrd[8]; newStkrRqrd[6]=oldStkrRqrd[2]; 
      newStkrRqrd[1]=oldStkrRqrd[7]; newStkrRqrd[2]=oldStkrRqrd[4]; newStkrRqrd[3]=oldStkrRqrd[1];
     
      newStkrRqrd[22]=oldStkrRqrd[25]; newStkrRqrd[23]=oldStkrRqrd[26]; newStkrRqrd[24]=oldStkrRqrd[27];
      newStkrRqrd[25]=oldStkrRqrd[28]; newStkrRqrd[26]=oldStkrRqrd[29]; newStkrRqrd[27]=oldStkrRqrd[30];
      newStkrRqrd[28]=oldStkrRqrd[31]; newStkrRqrd[29]=oldStkrRqrd[32]; newStkrRqrd[30]=oldStkrRqrd[33];
      newStkrRqrd[31]=oldStkrRqrd[22]; newStkrRqrd[32]=oldStkrRqrd[23]; newStkrRqrd[33]=oldStkrRqrd[24];
   
      newStkrRqrd[34]=oldStkrRqrd[37]; newStkrRqrd[35]=oldStkrRqrd[38]; newStkrRqrd[36]=oldStkrRqrd[39];
      newStkrRqrd[37]=oldStkrRqrd[40]; newStkrRqrd[38]=oldStkrRqrd[41]; newStkrRqrd[39]=oldStkrRqrd[42];
      newStkrRqrd[40]=oldStkrRqrd[43]; newStkrRqrd[41]=oldStkrRqrd[44]; newStkrRqrd[42]=oldStkrRqrd[45];
      newStkrRqrd[43]=oldStkrRqrd[34]; newStkrRqrd[44]=oldStkrRqrd[35]; newStkrRqrd[45]=oldStkrRqrd[36];
      newStkrRqrd[46]=oldStkrRqrd[48]; newStkrRqrd[47]=oldStkrRqrd[51]; newStkrRqrd[48]=oldStkrRqrd[54]; 
      newStkrRqrd[49]=oldStkrRqrd[47]; newStkrRqrd[51]=oldStkrRqrd[53]; 
      newStkrRqrd[52]=oldStkrRqrd[46]; newStkrRqrd[53]=oldStkrRqrd[49]; newStkrRqrd[54]=oldStkrRqrd[52];
   }
   else if(b==11)
   {
      newStkrRqrd[13]=oldStkrRqrd[10]; newStkrRqrd[14]=oldStkrRqrd[11]; newStkrRqrd[15]=oldStkrRqrd[12];
      newStkrRqrd[16]=oldStkrRqrd[13]; newStkrRqrd[17]=oldStkrRqrd[14]; newStkrRqrd[18]=oldStkrRqrd[15];
      newStkrRqrd[19]=oldStkrRqrd[16]; newStkrRqrd[20]=oldStkrRqrd[17]; newStkrRqrd[21]=oldStkrRqrd[18];
      newStkrRqrd[10]=oldStkrRqrd[19]; newStkrRqrd[11]=oldStkrRqrd[20]; newStkrRqrd[12]=oldStkrRqrd[21];
      newStkrRqrd[9]=oldStkrRqrd[7]; newStkrRqrd[6]=oldStkrRqrd[8]; newStkrRqrd[3]=oldStkrRqrd[9]; 
      newStkrRqrd[8]=oldStkrRqrd[4]; newStkrRqrd[2]=oldStkrRqrd[6]; 
      newStkrRqrd[7]=oldStkrRqrd[1]; newStkrRqrd[4]=oldStkrRqrd[2]; newStkrRqrd[1]=oldStkrRqrd[3];
  
      newStkrRqrd[25]=oldStkrRqrd[22]; newStkrRqrd[26]=oldStkrRqrd[23]; newStkrRqrd[27]=oldStkrRqrd[24];
      newStkrRqrd[28]=oldStkrRqrd[25]; newStkrRqrd[29]=oldStkrRqrd[26]; newStkrRqrd[30]=oldStkrRqrd[27];
      newStkrRqrd[31]=oldStkrRqrd[28]; newStkrRqrd[32]=oldStkrRqrd[29]; newStkrRqrd[33]=oldStkrRqrd[30];
      newStkrRqrd[22]=oldStkrRqrd[31]; newStkrRqrd[23]=oldStkrRqrd[32]; newStkrRqrd[24]=oldStkrRqrd[33];

      newStkrRqrd[37]=oldStkrRqrd[34]; newStkrRqrd[38]=oldStkrRqrd[35]; newStkrRqrd[39]=oldStkrRqrd[36];
      newStkrRqrd[40]=oldStkrRqrd[37]; newStkrRqrd[41]=oldStkrRqrd[38]; newStkrRqrd[42]=oldStkrRqrd[39];
      newStkrRqrd[43]=oldStkrRqrd[40]; newStkrRqrd[44]=oldStkrRqrd[41]; newStkrRqrd[45]=oldStkrRqrd[42];
      newStkrRqrd[34]=oldStkrRqrd[43]; newStkrRqrd[35]=oldStkrRqrd[44]; newStkrRqrd[36]=oldStkrRqrd[45];
      newStkrRqrd[48]=oldStkrRqrd[46]; newStkrRqrd[51]=oldStkrRqrd[47]; newStkrRqrd[54]=oldStkrRqrd[48]; 
      newStkrRqrd[47]=oldStkrRqrd[49]; newStkrRqrd[53]=oldStkrRqrd[51]; 
      newStkrRqrd[46]=oldStkrRqrd[52]; newStkrRqrd[49]=oldStkrRqrd[53]; newStkrRqrd[52]=oldStkrRqrd[54];
   }
   else if(b==14)
   {
      newStkrRqrd[16]=oldStkrRqrd[48]; newStkrRqrd[28]=oldStkrRqrd[47]; newStkrRqrd[40]=oldStkrRqrd[46];
      newStkrRqrd[48]=oldStkrRqrd[36]; newStkrRqrd[47]=oldStkrRqrd[24]; newStkrRqrd[46]=oldStkrRqrd[12];
      newStkrRqrd[36]=oldStkrRqrd[7]; newStkrRqrd[24]=oldStkrRqrd[8]; newStkrRqrd[12]=oldStkrRqrd[9];
      newStkrRqrd[7]=oldStkrRqrd[16]; newStkrRqrd[8]=oldStkrRqrd[28]; newStkrRqrd[9]=oldStkrRqrd[40];
      newStkrRqrd[13]=oldStkrRqrd[15]; newStkrRqrd[14]=oldStkrRqrd[27]; newStkrRqrd[15]=oldStkrRqrd[39]; 
      newStkrRqrd[25]=oldStkrRqrd[14]; newStkrRqrd[27]=oldStkrRqrd[38]; 
      newStkrRqrd[37]=oldStkrRqrd[13]; newStkrRqrd[38]=oldStkrRqrd[25]; newStkrRqrd[39]=oldStkrRqrd[37];
  
      newStkrRqrd[4]=oldStkrRqrd[17]; newStkrRqrd[5]=oldStkrRqrd[29]; newStkrRqrd[6]=oldStkrRqrd[41];
      newStkrRqrd[35]=oldStkrRqrd[4]; newStkrRqrd[23]=oldStkrRqrd[5]; newStkrRqrd[11]=oldStkrRqrd[6];
      newStkrRqrd[51]=oldStkrRqrd[35]; newStkrRqrd[50]=oldStkrRqrd[23]; newStkrRqrd[49]=oldStkrRqrd[11];
      newStkrRqrd[17]=oldStkrRqrd[51]; newStkrRqrd[29]=oldStkrRqrd[50]; newStkrRqrd[41]=oldStkrRqrd[49];

      newStkrRqrd[1]=oldStkrRqrd[18]; newStkrRqrd[2]=oldStkrRqrd[30]; newStkrRqrd[3]=oldStkrRqrd[42];
      newStkrRqrd[18]=oldStkrRqrd[54]; newStkrRqrd[30]=oldStkrRqrd[53]; newStkrRqrd[42]=oldStkrRqrd[52];
      newStkrRqrd[54]=oldStkrRqrd[34]; newStkrRqrd[53]=oldStkrRqrd[22]; newStkrRqrd[52]=oldStkrRqrd[10];
      newStkrRqrd[34]=oldStkrRqrd[1]; newStkrRqrd[22]=oldStkrRqrd[2]; newStkrRqrd[10]=oldStkrRqrd[3];
      newStkrRqrd[19]=oldStkrRqrd[43]; newStkrRqrd[20]=oldStkrRqrd[31]; newStkrRqrd[21]=oldStkrRqrd[19]; 
      newStkrRqrd[31]=oldStkrRqrd[44]; newStkrRqrd[33]=oldStkrRqrd[20]; 
      newStkrRqrd[43]=oldStkrRqrd[45]; newStkrRqrd[44]=oldStkrRqrd[33]; newStkrRqrd[45]=oldStkrRqrd[21];
   }
      else if(b==17)
   {
      newStkrRqrd[48]=oldStkrRqrd[16]; newStkrRqrd[47]=oldStkrRqrd[28]; newStkrRqrd[46]=oldStkrRqrd[40];
      newStkrRqrd[36]=oldStkrRqrd[48]; newStkrRqrd[24]=oldStkrRqrd[47]; newStkrRqrd[12]=oldStkrRqrd[46];
      newStkrRqrd[7]=oldStkrRqrd[36]; newStkrRqrd[8]=oldStkrRqrd[24]; newStkrRqrd[9]=oldStkrRqrd[12];
      newStkrRqrd[16]=oldStkrRqrd[7]; newStkrRqrd[28]=oldStkrRqrd[8]; newStkrRqrd[40]=oldStkrRqrd[9];
      newStkrRqrd[15]=oldStkrRqrd[13]; newStkrRqrd[27]=oldStkrRqrd[14]; newStkrRqrd[39]=oldStkrRqrd[15]; 
      newStkrRqrd[14]=oldStkrRqrd[25]; newStkrRqrd[38]=oldStkrRqrd[27]; 
      newStkrRqrd[13]=oldStkrRqrd[37]; newStkrRqrd[25]=oldStkrRqrd[38]; newStkrRqrd[37]=oldStkrRqrd[39];
     
      newStkrRqrd[17]=oldStkrRqrd[4]; newStkrRqrd[29]=oldStkrRqrd[5]; newStkrRqrd[41]=oldStkrRqrd[6];
      newStkrRqrd[4]=oldStkrRqrd[35]; newStkrRqrd[5]=oldStkrRqrd[23]; newStkrRqrd[6]=oldStkrRqrd[11];
      newStkrRqrd[35]=oldStkrRqrd[51]; newStkrRqrd[23]=oldStkrRqrd[50]; newStkrRqrd[11]=oldStkrRqrd[49];
      newStkrRqrd[51]=oldStkrRqrd[17]; newStkrRqrd[50]=oldStkrRqrd[29]; newStkrRqrd[49]=oldStkrRqrd[41];
   
      newStkrRqrd[18]=oldStkrRqrd[1]; newStkrRqrd[30]=oldStkrRqrd[2]; newStkrRqrd[42]=oldStkrRqrd[3];
      newStkrRqrd[54]=oldStkrRqrd[18]; newStkrRqrd[53]=oldStkrRqrd[30]; newStkrRqrd[52]=oldStkrRqrd[42];
      newStkrRqrd[34]=oldStkrRqrd[54]; newStkrRqrd[22]=oldStkrRqrd[53]; newStkrRqrd[10]=oldStkrRqrd[52];
      newStkrRqrd[1]=oldStkrRqrd[34]; newStkrRqrd[2]=oldStkrRqrd[22]; newStkrRqrd[3]=oldStkrRqrd[10];
      newStkrRqrd[43]=oldStkrRqrd[19]; newStkrRqrd[31]=oldStkrRqrd[20]; newStkrRqrd[19]=oldStkrRqrd[21]; 
      newStkrRqrd[44]=oldStkrRqrd[31]; newStkrRqrd[20]=oldStkrRqrd[33]; 
      newStkrRqrd[45]=oldStkrRqrd[43]; newStkrRqrd[33]=oldStkrRqrd[44]; newStkrRqrd[21]=oldStkrRqrd[45];
   }
   //-------------------------------------------------------------------------------
   for(byte k=0;k<=54;k++)
   {   
      cell[k]=newCell[k];
      stickerRequiredByCell[k]=newStkrRqrd[k];
   }
   //---------------------------------------
   for(byte k=1;k<=54;k++)
   {
      cellOfSticker[cell[k]]=k;  
   }  
   //---------------------------------------
   for(byte k=1;k<=54;k++)
   {
      cellOfStickerRequiredByCell[k]=cellOfSticker[stickerRequiredByCell[k]];
   }   
   //---------------------------------------
   cellRequiredBySticker[0]=0;
   for(byte k=1;k<=54;k++)
   {
      for(byte s=1;s<=54;s++)
      {
         if(stickerRequiredByCell[k]==s)
         {
            cellRequiredBySticker[s]=k; 
         }  
      }  
   }   
   //---------------------------------------
   for(int i=0;i<4;i++)
   {
       centerStickersFrBtBkTp[i]=cell[int(centerCellsFrBtBkTp[i])];   
       centerStickersLtFrRtBk[i]=cell[int(centerCellsLtFrRtBk[i])];   
       
       frontFaceEdgeStickers[i]=cell[int(frontFaceEdgeCells[i])];     
       topFaceEdgeStickers[i]=cell[int(topFaceEdgeCells[i])];         
       bottomFaceEdgeStickers[i]=cell[int(bottomFaceEdgeCells[i])];   
       leftFaceEdgeStickers[i]=cell[int(leftFaceEdgeCells[i])];       
       rightFaceEdgeStickers[i]=cell[int(rightFaceEdgeCells[i])];     
       backFaceEdgeStickers[i]=cell[int(backFaceEdgeCells[i])];       

       frontRimEdgeStickers[i]=cell[int(frontRimEdgeCells[i])];       
       topRimEdgeStickers[i]=cell[int(topRimEdgeCells[i])];           
       bottomRimEdgeStickers[i]=cell[int(bottomRimEdgeCells[i])];     
       backRimEdgeStickers[i]=cell[int(backRimEdgeCells[i])];         
       leftRimEdgeStickers[i]=cell[int(leftRimEdgeCells[i])];         
       rightRimEdgeStickers[i]=cell[int(rightRimEdgeCells[i])];   
   }    
   if(displayNumbers==true)
   {
      fill(212);
      rect(0,0,340,300);
      textSize(15);
      fill(0);
      strokeWeight(1);
      for(int i=0;i<4;i++)
      {
         text(centerStickersFrBtBkTp[i],(10+32*i),20);
         text(centerStickersLtFrRtBk[i],(10+32*i),40);
       
         text(frontFaceEdgeStickers[i],(10+32*i),60);
         text(topFaceEdgeStickers[i],(10+32*i),80);
         text(bottomFaceEdgeStickers[i],(10+32*i),100);
         text(leftFaceEdgeStickers[i],(10+32*i),120);
         text(rightFaceEdgeStickers[i],(10+32*i),140);
         text(backFaceEdgeStickers[i],(10+32*i),160);

         text(frontRimEdgeStickers[i],(10+32*i),180);
         text(topRimEdgeStickers[i],(10+32*i),200);
         text(bottomRimEdgeStickers[i],(10+32*i),220);
         text(backRimEdgeStickers[i],(10+32*i),240);
         text(leftRimEdgeStickers[i],(10+32*i),260);
         text(rightRimEdgeStickers[i],(10+32*i),280);
      }    
      text("centerStickersFrBtBkTp",150,20);
      text("centerStickersLtFrRtBk",150,40);
      text("frontFaceEdgeStickers",150,60);
      text("topFaceEdgeStickers",150,80);
      text("bottomFaceEdgeStickers",150,100);
      text("leftFaceEdgeStickers",150,120);
      text("rightFaceEdgeStickers",150,140);
      text("backFaceEdgeStickers",150,160);
      text("frontRimEdgeStickers",150,180);
      text("topRimEdgeStickers",150,200);
      text("bottomRimEdgeStickers",150,220);
      text("backRimEdgeStickers",150,240);
      text("leftRimEdgeStickers",150,260);
      text("rightRimEdgeStickers",150,280); 
   }   
}
//=============================================================================================
void cubeSequence(int buttonSequence)
{  
   if(buttonSequence==102)
   {
      cubeButton(byte(1));cubeButton(byte(2));cubeButton(byte(3));
   }
   else if(buttonSequence==105)
   {
      cubeButton(byte(4));cubeButton(byte(5));cubeButton(byte(6));
   }
   else if(buttonSequence==108)
   {
      cubeButton(byte(7));cubeButton(byte(8));cubeButton(byte(9));
   }
   else if(buttonSequence==111)
   {
      cubeButton(byte(10));cubeButton(byte(11));cubeButton(byte(12));
   }
   else if(buttonSequence==114)
   {
      cubeButton(byte(13));cubeButton(byte(14));cubeButton(byte(15));
   }
   else if(buttonSequence==117)
   {
      cubeButton(byte(16));cubeButton(byte(17));cubeButton(byte(18));
   }
   //-------------------
   byte F=16;
   byte Fi=13;
   byte L=4;
   byte Li=1;
   byte U=7;
   byte Ui=10;
   byte R=3;
   byte Ri=6;
   byte D=12;
   byte Di=9;
   byte B=15;
   byte Bi=18;
   byte C=17;
   byte Ci=14;
   //------------------
   if(buttonSequence==1001)
   {
      cubeButton(Fi);cubeButton(U);cubeButton(Li);cubeButton(Ui);
   }
   if(buttonSequence==1002)
   {
      cubeButton(Ri);cubeButton(Di);cubeButton(R);cubeButton(D);
   }
   if(buttonSequence==1003)
   {
      cubeButton(Ui);cubeButton(Li);cubeButton(U);cubeButton(L);
      cubeButton(U);cubeButton(F);cubeButton(Ui);cubeButton(Fi);
   }
   if(buttonSequence==10031)
   {
      cubeButton(F);cubeButton(U);cubeButton(Fi);cubeButton(Ui);
      cubeButton(Li);cubeButton(Ui);cubeButton(L);cubeButton(U);
   }
   if(buttonSequence==1004)
   {
      cubeButton(U);cubeButton(R);cubeButton(Ui);cubeButton(Ri);
      cubeButton(Ui);cubeButton(Fi);cubeButton(U);cubeButton(F);
   }
   if(buttonSequence==10041)
   {
      cubeButton(Fi);cubeButton(Ui);cubeButton(F);cubeButton(U);
      cubeButton(R);cubeButton(U);cubeButton(Ri);cubeButton(Ui);
   }   
   if(buttonSequence==1005)
   {
      cubeButton(F);cubeButton(R);cubeButton(U);cubeButton(Ri);
      cubeButton(Ui);cubeButton(Fi);
   }
   if(buttonSequence==1006)
   {
      cubeButton(R);cubeButton(U);cubeButton(Ri);cubeButton(U);
      cubeButton(R);cubeButton(U);cubeButton(U);cubeButton(Ri);
   }
   if(buttonSequence==1007)
   {
      cubeButton(U);cubeButton(R);cubeButton(Ui);cubeButton(Li);
      cubeButton(U);cubeButton(Ri);cubeButton(Ui);cubeButton(L);
   }
   if(buttonSequence==1008)
   {
      cubeButton(Ri);cubeButton(Di);cubeButton(R);cubeButton(D);
   }
   if(buttonSequence==1011)
   {
      cubeButton(Fi);cubeButton(D);cubeButton(Ri);cubeButton(Di);
   }
   if(buttonSequence==1012)
   {
      cubeButton(Fi);cubeButton(L);cubeButton(Di);cubeButton(Li);
   }
   if(buttonSequence==1013)
   {
      cubeButton(Fi);cubeButton(U);cubeButton(Li);cubeButton(Ui);
   }
   if(buttonSequence==1014)
   {
      cubeButton(Fi);cubeButton(R);cubeButton(Ui);cubeButton(Ri);
   }
   if(buttonSequence==1021)
   {
      cubeButton(D);cubeButton(C);cubeButton(Di);cubeButton(Ci);
   }
   if(buttonSequence==1022)
   {
      cubeButton(L);cubeButton(C);cubeButton(Li);cubeButton(Ci);
   }
   if(buttonSequence==1023)
   {
      cubeButton(U);cubeButton(C);cubeButton(Ui);cubeButton(Ci);
   }
   if(buttonSequence==1024)
   {
      cubeButton(R);cubeButton(C);cubeButton(Ri);cubeButton(Ci);
   }
   if(buttonSequence==1031)
   {
      cubeButton(Bi);cubeButton(Di);cubeButton(B);cubeButton(D);
   }
}   
//=============================================================================================
// The method checks if an element is a member of a set of number and return 'true' if it is.
//
boolean elementOfSet(byte element, byte[] set)
{ 
  boolean elementOfSetValue=false;
  for(byte i=0; i<set.length;i++)
  {
     if(set[i]==element){elementOfSetValue=true;}
  }
  return(elementOfSetValue);
}  
//=============================================================================================
void solveOne()
{  
   stageOne();
   drawCube();
}  
//=============================================================================================
void solveTwo()
{  
   stageOne();
   stageTwo();
   drawCube();
}  
//=============================================================================================
void solveThree()
{  
   stageOne();
   stageTwo();
   stageThree();
   drawCube();
}  
//=============================================================================================
void solveFour()
{  
   stageOne();
   stageTwo();
   stageThree();
   stageFour();
   drawCube();
}  
//=============================================================================================
void solveFive()
{  
   stageOne();
   stageTwo();
   stageThree();
   stageFour();
   stageFive();
   drawCube();
}  
//=============================================================================================
//------------------------Rotate cube RedCenterFront  And  YellowCenterTop---------------------
void rotateCubeRedCenterFrontAndYellowCenterTop()
{  
   /*--------------------------------To move the red center sticker to front face --------*/
   if(cell[26]!=26 && elementOfSet(byte(26), centerStickersFrBtBkTp)==true)
   {   
      do{cubeButton(byte(5));}while(cell[26]!=26);
   }
   else if(cell[26]!=26 && elementOfSet(byte(26), centerStickersLtFrRtBk)==true)
   {
      do{cubeButton(byte(8));}while(cell[26]!=26);
   }
   /*-----------------------------------To move the yellow center sticker to top face -----*/
   if(cell[5]!=5)
   {
      do{cubeButton(byte(17));}while(cell[5]!=5);
   }
}   
//=============================================================================================================================
// This method does a sequence of steps to get the first four edge pieces in place.
//---------------------------------------- Stage one ------------------------------------------
void stageOne()
{  
   //   rotateCubeRedCenterFrontAndYellowCenterTop();
   startColourFrontFace=stickerColour[cell[26]];
   startColourTopFace=stickerColour[cell[5]];
   for(byte i=0;i<4;i++)   
   {  
      byte kCell=frontFaceEdgeCells[i];                       //the cell to be filled
      byte stkrInCellK=cell[kCell];                           //what sticker is in kCell
      byte stkrReqrd=stickerRequiredByCell[kCell];             //what sticker is required for kCell
      byte celOfStRqrd=cellOfSticker[stkrReqrd];  
      while(stkrInCellK!=stkrReqrd)
      {  
         if(elementOfSet(kCell,bottomRimEdgeCells)==true)  //----------for sticker on bottom rim of front face-----------------
         {
            while(stkrInCellK!=stkrReqrd)
            { 
               if(elementOfSet(celOfStRqrd,bottomRimEdgeCells)==true)
               {  
                  while(elementOfSet(celOfStRqrd,bottomRimEdgeCells)==true && stkrInCellK!=stkrReqrd)
                  {  
                     cubeButton(byte(9));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                  }  
               }  
               else if(elementOfSet(celOfStRqrd,leftRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==false)
               {   
                  for(int j=0;j<4;j++)
                  {  
                     cubeButton(byte(1));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     if(elementOfSet(celOfStRqrd,leftRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==true)
                     {
                        cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     }
                  }  
               }
               else if(elementOfSet(celOfStRqrd,topRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==false)
               {  
                  for(int j=0;j<4;j++)
                  {
                     cubeButton(byte(7));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     if(elementOfSet(celOfStRqrd,topRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==true)
                     {
                        cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     }
                  }  
               }
               else if(elementOfSet(celOfStRqrd,rightRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==false)
               {  
                  for(int j=0;j<4;j++)
                  {
                     cubeButton(byte(3));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     if(elementOfSet(celOfStRqrd,rightRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==true)
                     {
                        cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     }
                  }  
               }
               else if(elementOfSet(celOfStRqrd,backFaceEdgeCells)==true && elementOfSet(celOfStRqrd,bottomRimEdgeCells)==false)
               {  
                  cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
               }
               else if(elementOfSet(celOfStRqrd,backRimEdgeCells)==true && elementOfSet(celOfStRqrd,bottomFaceEdgeCells)==false)
               { 
                  cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];  
               }
               else if(elementOfSet(celOfStRqrd,backRimEdgeCells)==true && elementOfSet(celOfStRqrd,bottomFaceEdgeCells)==true)
               { 
                  cubeButton(byte(9));cubeButton(byte(9));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];        
               }
               else if(elementOfSet(celOfStRqrd,frontRimEdgeCells)==true && elementOfSet(celOfStRqrd,bottomFaceEdgeCells)==false)
               {  
                  if(elementOfSet(celOfStRqrd,leftFaceEdgeCells)==true)
                  {
                     cubeButton(byte(1));cubeButton(byte(1));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];    
                  }
                  else if(elementOfSet(celOfStRqrd,topFaceEdgeCells)==true)
                  {
                     cubeButton(byte(7));cubeButton(byte(7));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];    
                  }
                  else if(elementOfSet(celOfStRqrd,rightFaceEdgeCells)==true)
                  {
                     cubeButton(byte(3));cubeButton(byte(3));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];   
                  }
               }
               else if(elementOfSet(celOfStRqrd,frontRimEdgeCells)==true && elementOfSet(celOfStRqrd,bottomFaceEdgeCells)==true)
               {   
                  
                  cubeSequence(1021);celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
               }  
            }
         }
         else if(elementOfSet(kCell,leftRimEdgeCells)==true)  //----------for sticker on left rim of front face-----------------
         {
            while(stkrInCellK!=stkrReqrd)
            {
               if(elementOfSet(celOfStRqrd,leftRimEdgeCells)==true)
               { 
                  while(elementOfSet(celOfStRqrd,leftRimEdgeCells)==true && stkrInCellK!=stkrReqrd)
                  {  
                     cubeButton(byte(1));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                  }  
               }  
               else if(elementOfSet(celOfStRqrd,bottomRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==false)  
               {   
                  for(int j=0;j<4;j++)
                  {
                     cubeButton(byte(9));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     if(elementOfSet(celOfStRqrd,bottomRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==true)
                     {
                        cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     }
                  }  
               }  
               else if(elementOfSet(celOfStRqrd,topRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==false)  
               {   
                  for(int j=0;j<4;j++)
                  {
                     cubeButton(byte(7));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     if(elementOfSet(celOfStRqrd,topRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==true)
                     {
                        cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     }
                  }  
               }
               else if(elementOfSet(celOfStRqrd,rightRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==false) 
               {  
                  for(int j=0;j<4;j++)
                  {
                     cubeButton(byte(3));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     if(elementOfSet(celOfStRqrd,rightRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==true)
                     {
                        cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     }
                  }  
               }
               else if(elementOfSet(celOfStRqrd,backFaceEdgeCells)==true && elementOfSet(celOfStRqrd,leftRimEdgeCells)==false)
               {  
                  cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
               }
               else if(elementOfSet(celOfStRqrd,backRimEdgeCells)==true && elementOfSet(celOfStRqrd,leftFaceEdgeCells)==false)
               {  
                  cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];  
               }
               else if(elementOfSet(celOfStRqrd,backRimEdgeCells)==true && elementOfSet(celOfStRqrd,leftFaceEdgeCells)==true)
               {  
                  cubeButton(byte(1));cubeButton(byte(1));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];  
               }
               else if(elementOfSet(celOfStRqrd,frontRimEdgeCells)==true && elementOfSet(celOfStRqrd,leftFaceEdgeCells)==false)
               {  
                  if(elementOfSet(celOfStRqrd,bottomFaceEdgeCells)==true)
                  {
                     cubeButton(byte(9));cubeButton(byte(1));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                  }
                  else if(elementOfSet(celOfStRqrd,topFaceEdgeCells)==true)
                  {
                     cubeButton(byte(7));cubeButton(byte(7));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];  
                  }
                  else if(elementOfSet(celOfStRqrd,rightFaceEdgeCells)==true)
                  {
                     cubeButton(byte(3));cubeButton(byte(3));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                  }
               }
               else if(elementOfSet(celOfStRqrd,frontRimEdgeCells)==true && elementOfSet(celOfStRqrd,leftFaceEdgeCells)==true)
               {   
                  cubeSequence(1022);celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
               }  
            }
         }
         else if(elementOfSet(kCell,topRimEdgeCells)==true)   //----------for sticker on top rim of front face-----------------
         {
            while(stkrInCellK!=stkrReqrd)
            { 
               if(elementOfSet(celOfStRqrd,topRimEdgeCells)==true)
               {     
                  while(elementOfSet(celOfStRqrd,topRimEdgeCells)==true && stkrInCellK!=stkrReqrd)
                  { 
                     cubeButton(byte(7));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                  }  
               }  
               else if(elementOfSet(celOfStRqrd,leftRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==false)
               {   
                  for(int j=0;j<4;j++)
                  { 
                     cubeButton(byte(1));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     if(elementOfSet(celOfStRqrd,leftRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==true)
                     {
                        cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     }
                  }  
               }
               else if(elementOfSet(celOfStRqrd,bottomRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==false)
               {  
                  for(int j=0;j<4;j++)
                  {  
                     cubeButton(byte(9));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     if(elementOfSet(celOfStRqrd,bottomRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==true)
                     {
                        cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     }
                  }  
               }
               else if(elementOfSet(celOfStRqrd,rightRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==false)
               {  
                  for(int j=0;j<4;j++)
                  {  
                     cubeButton(byte(3));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     if(elementOfSet(celOfStRqrd,rightRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==true)
                     {
                        cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     }
                  }  
               }
               else if(elementOfSet(celOfStRqrd,backFaceEdgeCells)==true && elementOfSet(celOfStRqrd,topRimEdgeCells)==false)
               {   
                  cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
               }
               else if(elementOfSet(celOfStRqrd,backRimEdgeCells)==true && elementOfSet(celOfStRqrd,topFaceEdgeCells)==false)
               {   
                  cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];  
               }
               else if(elementOfSet(celOfStRqrd,backRimEdgeCells)==true && elementOfSet(celOfStRqrd,topFaceEdgeCells)==true)
               {  
                  cubeButton(byte(7));cubeButton(byte(7));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];  
               }
               else if(elementOfSet(celOfStRqrd,frontRimEdgeCells)==true && elementOfSet(celOfStRqrd,topFaceEdgeCells)==false)
               {   
                  if(elementOfSet(celOfStRqrd,leftFaceEdgeCells)==true)
                  {
                     cubeButton(byte(1));cubeButton(byte(1));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                  }
                  else if(elementOfSet(celOfStRqrd,bottomFaceEdgeCells)==true)
                  {
                     cubeButton(byte(9));cubeButton(byte(9));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];  
                  }
                  else if(elementOfSet(celOfStRqrd,rightFaceEdgeCells)==true)
                  {
                     cubeButton(byte(3));cubeButton(byte(3));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                  }
               }
               else if(elementOfSet(celOfStRqrd,frontRimEdgeCells)==true && elementOfSet(celOfStRqrd,topFaceEdgeCells)==true)
               {   
                  cubeSequence(1023);celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
               }  
            }
         }
         else if(elementOfSet(kCell,rightRimEdgeCells)==true)  //----------for sticker on right rim of front face-----------------
         {
            while(stkrInCellK!=stkrReqrd)
            { 
               if(elementOfSet(celOfStRqrd,rightRimEdgeCells)==true)
               {  
                  while(elementOfSet(celOfStRqrd,rightRimEdgeCells)==true && stkrInCellK!=stkrReqrd)
                  {  
                     cubeButton(byte(3));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                  }  
               }  
               else if(elementOfSet(celOfStRqrd,leftRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==false)
               { 
                  for(int j=0;j<4;j++)
                  {
                     cubeButton(byte(1));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     if(elementOfSet(celOfStRqrd,leftRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==true)
                     {
                        cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     }
                  }  
               }
               else if(elementOfSet(celOfStRqrd,topRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==false)
               {  
                  for(int j=0;j<4;j++)
                  {
                     cubeButton(byte(7));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     if(elementOfSet(celOfStRqrd,topRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==true)
                     {
                        cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     }
                  }  
               }  
               else if(elementOfSet(celOfStRqrd,bottomRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==false)
               {   
                  for(int j=0;j<4;j++)
                  {
                     cubeButton(byte(9));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     if(elementOfSet(celOfStRqrd,bottomRimEdgeCells)==true && elementOfSet(celOfStRqrd,backFaceEdgeCells)==true)
                     {
                        cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                     }
                  }  
               }  
               else if(elementOfSet(celOfStRqrd,backFaceEdgeCells)==true && elementOfSet(celOfStRqrd,rightRimEdgeCells)==false)
               { 
                  cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
               }
               else if(elementOfSet(celOfStRqrd,backRimEdgeCells)==true && elementOfSet(celOfStRqrd,rightFaceEdgeCells)==false)
               {  
                  cubeButton(byte(15));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];  
               }
               else if(elementOfSet(celOfStRqrd,backRimEdgeCells)==true && elementOfSet(celOfStRqrd,rightFaceEdgeCells)==true)
               {  
                  cubeButton(byte(3));cubeButton(byte(3));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];  
               }
               else if(elementOfSet(celOfStRqrd,frontRimEdgeCells)==true && elementOfSet(celOfStRqrd,rightFaceEdgeCells)==false)
               {
                  if(elementOfSet(celOfStRqrd,leftFaceEdgeCells)==true)
                  {  
                     cubeButton(byte(1));cubeButton(byte(1));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                  }
                  else if(elementOfSet(celOfStRqrd,topFaceEdgeCells)==true)
                  {  
                     cubeButton(byte(7));cubeButton(byte(7));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];  
                  }
                  else if(elementOfSet(celOfStRqrd,bottomFaceEdgeCells)==true)
                  {  
                     cubeButton(byte(9));cubeButton(byte(9));celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
                  }
               }
               else if(elementOfSet(celOfStRqrd,frontRimEdgeCells)==true && elementOfSet(celOfStRqrd,rightFaceEdgeCells)==true)
               {   
                  cubeSequence(1024);celOfStRqrd=cellOfSticker[stkrReqrd];stkrInCellK=cell[kCell];
               }  
            }
         }
      }   
   }   
}      
//=============================================================================================================================
// This method does a sequence of steps to get the front face corner pieces in place.
//---------------------------------------- Stage two ------------------------------------------
void stageTwo()
{
   for(byte i=0;i<4;i++)
   {
      if(startColourFrontFace==-1){activeSticker=redCornerStickers[i];}
      else if(startColourFrontFace==-2){activeSticker=yellowCornerStickers[i];}
      else if(startColourFrontFace==-3){activeSticker=greenCornerStickers[i];}
      else if(startColourFrontFace==-4){activeSticker=whiteCornerStickers[i];}
      else if(startColourFrontFace==-5){activeSticker=blueCornerStickers[i];}
      else if(startColourFrontFace==-6){activeSticker=orangeCornerStickers[i];}
      while(elementOfSet(cellOfSticker[activeSticker],cellCornerCubelet[4])==false && elementOfSet(cellOfSticker[activeSticker],cellCornerCubelet[8])==false)
      {
         cubeSequence(byte(114));
      }
      while(stickerRequiredByCell[37]!=activeSticker || cell[37]!=activeSticker)
      {
         if(elementOfSet(cellOfSticker[activeSticker],frontFaceCornerCells)==true || elementOfSet(cellOfSticker[activeSticker],frontRimCornerCells)==true)
         {
            while(elementOfSet(cellOfSticker[activeSticker],frontFaceCornerCells)==true || elementOfSet(cellOfSticker[activeSticker],frontRimCornerCells)==true)
            {
               cubeSequence(1031); 
            }
         }
         while(stickerRequiredByCell[37]!=activeSticker)
         {
            cubeButton(byte(13));cubeButton(byte(14)); 
         }   
         while(cell[37]!=activeSticker)
         {
            cubeSequence(1031);
         } 
      }
   }
}
//=============================================================================================================================
// This method does a sequence of steps to get the mid region edge corner pieces in place.
//---------------------------------------- Stage three ------------------------------------------
void stageThree()
{  
   while((stickerColour[cell[50]]!=startColourFrontFace))
   {   
      for(byte i=0;i<4;i++)
      {
         if(stickerColour[cell[50]]!=startColourFrontFace){cubeSequence(byte(102));}
      }   
      for(byte i=0;i<4;i++)
      {
         if(stickerColour[cell[50]]!=startColourFrontFace){cubeSequence(byte(114));}
      }
   }
   for(byte i=0;i<8;i++)
   {
      if(stickerColour[cell[50]]==-1 || stickerColour[cell[50]]==-6){activeMidRegionEdgeStickers[i]=redOrangeAxisMidRegionEdgeStickers[i];}
      else if (stickerColour[cell[50]]==-2 || stickerColour[cell[50]]==-4){activeMidRegionEdgeStickers[i]=yellowWhiteAxisMidRegionEdgeStickers[i];}
      else if (stickerColour[cell[50]]==-3 || stickerColour[cell[50]]==-5){activeMidRegionEdgeStickers[i]=greenBlueAxisMidRegionEdgeStickers[i];}
   }   
   //---------------------------------------
   for(byte i=0;i<8;i++)
   {  
      activeSticker=activeMidRegionEdgeStickers[i];
      while(cellOfSticker[activeSticker]!=cellRequiredBySticker[activeSticker])
      {  
         while(elementOfSet(cellOfSticker[activeSticker],frontFaceEdgeCells)==false && cellOfSticker[activeSticker]!=8)    
         {
            cubeSequence(108);
         }
         if(elementOfSet(cellOfSticker[activeSticker],frontFaceEdgeCells)==true)
         {
            if(cellOfSticker[activeSticker]==25){cubeSequence(10031);}
            else if(cellOfSticker[activeSticker]==27){cubeSequence(10041);}
            while(elementOfSet(cellRequiredBySticker[activeSticker],frontFaceEdgeCells)==false)
            {
               cubeButton(byte(8));cubeButton(byte(9)); 
            } 
            if(cellRequiredBySticker[activeSticker]==25){cubeSequence(1003);}
            else if(cellRequiredBySticker[activeSticker]==27){cubeSequence(1004);}
         }
         else if(cellOfSticker[activeSticker]==8)
         {
             while(cellRequiredBySticker[activeSticker]!=24 && cellRequiredBySticker[activeSticker]!=28)
             {
                cubeButton(byte(8));cubeButton(byte(9));
             }   
            if(cellRequiredBySticker[activeSticker]==24){cubeSequence(1003);}
            else if(cellRequiredBySticker[activeSticker]==28){cubeSequence(1004);}
         }   
      }  
   }
   //---------------------------------------
   while((stickerColour[cell[26]]!=startColourFrontFace))
   {   
      for(byte i=0;i<4;i++)
      {
         if(stickerColour[cell[26]]!=startColourFrontFace){cubeSequence(byte(102));}
      }   
      for(byte i=0;i<4;i++)
      {
         if(stickerColour[cell[26]]!=startColourFrontFace){cubeSequence(byte(108));}
      }
   }
   while((stickerColour[cell[5]]!=startColourTopFace))
   {
      cubeSequence(114);  
   }  
}
//=============================================================================================================================
// This method does a sequence of steps to get the back face edge pieces in place.
//---------------------------------------- Stage four ------------------------------------------
void stageFour()
{  
   while((stickerColour[cell[50]]!=startColourFrontFace))
   {   
      for(byte i=0;i<4;i++)
      {
         if(stickerColour[cell[50]]!=startColourFrontFace){cubeSequence(byte(102));}
      }   
      for(byte i=0;i<4;i++)
      {
         if(stickerColour[cell[50]]!=startColourFrontFace){cubeSequence(byte(114));}
      }
   }
   //---------------------------------------
   while(stickerColour[cell[2]]!=stickerColour[cell[5]] || stickerColour[cell[4]]!=stickerColour[cell[5]] || stickerColour[cell[6]]!=stickerColour[cell[5]] || stickerColour[cell[8]]!=stickerColour[cell[5]])
   {
      if(stickerColour[cell[2]]!=stickerColour[cell[5]] && stickerColour[cell[4]]!=stickerColour[cell[5]] && stickerColour[cell[6]]!=stickerColour[cell[5]] && stickerColour[cell[8]]!=stickerColour[cell[5]])
      {
      cubeSequence(1005);
      }

      if(stickerColour[cell[2]]!=stickerColour[cell[5]] && stickerColour[cell[4]]==stickerColour[cell[5]] && stickerColour[cell[6]]!=stickerColour[cell[5]] && stickerColour[cell[8]]==stickerColour[cell[5]])
      {
         cubeButton(byte(7));
      }
      if(stickerColour[cell[2]]!=stickerColour[cell[5]] && stickerColour[cell[4]]!=stickerColour[cell[5]] && stickerColour[cell[6]]==stickerColour[cell[5]] && stickerColour[cell[8]]==stickerColour[cell[5]])
      {
         cubeButton(byte(10));cubeButton(byte(10));
      }
      if(stickerColour[cell[2]]==stickerColour[cell[5]] && stickerColour[cell[4]]!=stickerColour[cell[5]] && stickerColour[cell[6]]==stickerColour[cell[5]] && stickerColour[cell[8]]!=stickerColour[cell[5]])
      {
         cubeButton(byte(10));
      }
      if(stickerColour[cell[2]]==stickerColour[cell[5]] && stickerColour[cell[4]]==stickerColour[cell[5]] && stickerColour[cell[6]]!=stickerColour[cell[5]] && stickerColour[cell[8]]!=stickerColour[cell[5]])
      {
         cubeSequence(1005);
      }
      
      if(stickerColour[cell[2]]==stickerColour[cell[5]] && stickerColour[cell[4]]!=stickerColour[cell[5]] && stickerColour[cell[6]]!=stickerColour[cell[5]] && stickerColour[cell[8]]==stickerColour[cell[5]])
      {
         cubeButton(byte(10));
      }
      if(stickerColour[cell[2]]!=stickerColour[cell[5]] && stickerColour[cell[4]]==stickerColour[cell[5]] && stickerColour[cell[6]]==stickerColour[cell[5]] && stickerColour[cell[8]]!=stickerColour[cell[5]])
      {
         cubeSequence(1005);
      }

   }
   //---------------------------------------
   while(stickerRequiredByCell[11]!=cell[11] || stickerRequiredByCell[14]!=cell[14] || stickerRequiredByCell[17]!=cell[17] || stickerRequiredByCell[20]!=cell[20])
   {
      while(stickerRequiredByCell[20]!=cell[20])
      {
         cubeButton(byte(10));
      }
      if(stickerRequiredByCell[20]==cell[20] && stickerRequiredByCell[11]==cell[11] && stickerRequiredByCell[14]!=cell[14] && stickerRequiredByCell[17]!=cell[17])
      {
         cubeSequence(108);  
      }  
      if(stickerRequiredByCell[20]==cell[20] && stickerRequiredByCell[14]==cell[14] && stickerRequiredByCell[17]!=cell[17] && stickerRequiredByCell[11]!=cell[11])
      {
         cubeSequence(1006); 
      }      
      if(stickerRequiredByCell[20]==cell[20] && stickerRequiredByCell[17]==cell[17] && stickerRequiredByCell[14]!=cell[14] && stickerRequiredByCell[11]!=cell[11])
      {
         cubeSequence(1006); 
      }
      if(stickerRequiredByCell[20]==cell[20] && stickerRequiredByCell[17]!=cell[17] && stickerRequiredByCell[14]!=cell[14] && stickerRequiredByCell[11]!=cell[11])
      {
         cubeSequence(108);  
      } 
   }
   //---------------------------------------
   while((stickerColour[cell[26]]!=startColourFrontFace))
   {   
      for(byte i=0;i<4;i++)
      {
         if(stickerColour[cell[26]]!=startColourFrontFace){cubeSequence(byte(102));}
      }   
      for(byte i=0;i<4;i++)
      {
         if(stickerColour[cell[26]]!=startColourFrontFace){cubeSequence(byte(108));}
      }
   }
   while((stickerColour[cell[5]]!=startColourTopFace))
   {
      cubeSequence(114);  
   }
}   
//=============================================================================================================================
// This method give a number that represents which cubelet that a corner sticker is on.
byte cubeletOfCell(byte kIn)
{   
   byte cubeletOut=0;
   for(byte j=0;j<=8;j++)
   {
     if(elementOfSet(kIn,cellCornerCubelet[j])==true){cubeletOut=j;}
   }
   return(cubeletOut);
} 
//=============================================================================================================================
// This method does a sequence of steps to get the back face corner pieces in place.
//---------------------------------------- Stage five ------------------------------------------
void stageFive()
{  
   while((stickerColour[cell[50]]!=startColourFrontFace))
   {   
      for(byte i=0;i<4;i++)
      {
         if(stickerColour[cell[50]]!=startColourFrontFace){cubeSequence(byte(102));}
      }   
      for(byte i=0;i<4;i++)
      {
         if(stickerColour[cell[50]]!=startColourFrontFace){cubeSequence(byte(114));}
      }
   }
   //---------------------------------------  
   for(byte i=0;i<4;i++)
   {
      if(cubeletOfCell(cellOfStickerRequiredByCell[9])!=cubeletOfCell(byte(9)))
      {
          cubeSequence(108);
      }
   }
   if(cubeletOfCell(cellOfStickerRequiredByCell[9])!=cubeletOfCell(byte(9)))
   {
      cubeSequence(1007);
      for(byte i=0;i<4;i++)
      {
         if(cubeletOfCell(cellOfStickerRequiredByCell[9])!=cubeletOfCell(byte(9)))
         {
            cubeSequence(108);
         }
      }
   }
   for(byte i=0;i<3;i++)
   {
      if(cubeletOfCell(cellOfStickerRequiredByCell[7])!=cubeletOfCell(byte(7)))
      {
          cubeSequence(1007);
      }
   }
   //---------------------------------------
   for(byte i=0;i<4;i++)
   {
      while(stickerColour[cell[9]]!=stickerColour[cell[6]] || stickerColour[cell[15]]!=stickerColour[cell[14]] || stickerColour[cell[16]]!=stickerColour[cell[17]])
      {
         cubeSequence(1008);
      } 
      cubeButton(byte(7));
   }
   //---------------------------------------
   while((stickerColour[cell[26]]!=startColourFrontFace))
   {   
      for(byte i=0;i<4;i++)
      {
         if(stickerColour[cell[26]]!=startColourFrontFace){cubeSequence(byte(102));}
      }   
      for(byte i=0;i<4;i++)
      {
         if(stickerColour[cell[26]]!=startColourFrontFace){cubeSequence(byte(108));}
      }
   }
   while((stickerColour[cell[5]]!=startColourTopFace))
   {
      cubeSequence(114);  
   }   
}
//=============================================================================================================================
boolean check()
{ 
  boolean checkStatusOut=true;
  for(byte k=1;k<=54;k++)
  {
     if(cell[k]!=stickerRequiredByCell[k]){checkStatusOut=false;}
  }
  return(checkStatusOut);
}  
//=============================================================================================================================
void thousandSolveCheck()
{  
   for(int index=1;index<=1024;index++)
   {
      print(" "+index+" ");
      randonize();
      stageOne();
      stageTwo();
      stageThree();
      stageFour();
      stageFive();
      if(check()==true)
      {
         println(true);
      }
      else
      {
         println(false);
         index=1025;
      }   
      drawCube();
   }   
} 
//=============================================================================================================================
