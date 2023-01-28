// GOALS: 1. GET THE THING TO DRAW A CENTERED AXIS - DONE!
// 2. GET THE GRAPH TO DRAW AN OFFSET AXIS - DONE!
// 3. GET THE USER TO USE THEIR MOUSE TO MOVE THE AXIS - DONE!
// 4. GET THE USER TO ZOOM OUT/IN USING THE MOUSE SCROLL WHELL - DONE!
// 5. GET A GRAPH TO BE DRAWN ON THE SCREEN - DONE!
// 6. PARSE AN EQUATION FROM ITS STRING - DONE!
// 6.1 PARSE TRIG EQUATIONS - DONE!
// 6.2 PARSE SQUARE ROOT FUNCTION - DONE!
// 6.3 PARSE "e" - DONE!
// 6.4 PARSE LOG FUNCTION
// 7. DRAW THE DERIVATIVE LINE - DONE
// 7.1 WRITE THE EQUATION OF THE DERIVATIVE ON THE SCREEN 
// 7.2 LOCK THE TANGENT LINE AT THE POINT WHERE THE USER CLICKED - DONE
// 7.3 OUTPUT THE SLOPE OF THE CURRENT POINT 
// 7.4 SHOW THE COORDINATES OF THE MOUSE POSITION ON THE GRAPH - DONE
// 8. MAKE GUI 
// 9. PUT THE PRIORITIES IN A TXT FILE INSTEAD OF HARD CODING DATA
// 10. FIX BUGS AND FIX CODE

//BUGS:
// 1. -(x^2), make egatives outside a left bracket be -1*
// 2. fix scrolling to the left and bottom - DONE
// 3. -2*x^2 make negative number coefficients work
// 4. DRAW LINES BETWEEN POINTS NOT JUST POINTS THEMSELVES


import g4p_controls.*;
import java.awt.Font;

PApplet pa;

String equation = "(x^2-5)/(x-1)";  //  -2*cos((x^3)/(x^2+10))

float xMax = 5;
float xMin = -5;
float yMax = 5;
float yMin = -5;
float xScale = 1;
float yScale = 1;
float adjustmenty = 0;
float adjustmentx = 0;

Axis coordinateAxis;
Graph graph;

PFont font;

Font titleFont = new Font("Serif", Font.PLAIN, 24);
Font labelFont = new Font("Serif", Font.PLAIN, 16);

PVector initialCoordinates;
PVector finalCoordinates;
PVector displacement;

Boolean mouseDown = false;
Boolean graphClicked = false;
boolean tangentLocked = false; 
Boolean updatingValues = false;
Boolean updatingGraph = false;


void setup() {
  size(600, 600);
  
  coordinateAxis = new Axis();
  graph = new Graph(equation);
    
  font = createFont("Times New Roman", 18);
  textFont(font);
  rectMode(CENTER);
  
  frameRate(60);
  createGUI();
  updateGUIvalues();
  equationField.setText(equation);
  setSettingsForGUI();
}

void draw() {
  background(255);
  
  coordinateAxis.drawAxis();
  graph.drawGraph();
  graph.drawTangentLine();
  graph.drawLabel();
  graph.displayMousePosition();
  updateAdjustment();
  
  
}
