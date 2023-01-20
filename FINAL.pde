// GOALS: 1. GET THE THING TO DRAW A CENTERED AXIS - DONE!
// 2. GET THE THING TO DRAW AN OFFSET AXIS - DONE!
// 3. GET THE USER TO USE THEIR MOUSE TO MOVE THE AXIS - DONE!
// 4. GET THE USER TO ZOOM OUT/IN USING THE MOUSE SCROLL WHELL - DONE!
// 5. GET A GRAPH TO BE DRAWN ON THE SCREEN - DONE!
// 6. PARSE AN EQUATION FROM ITS STRING - DONE!
// 6.1 PARSE TRIG EQUATIONS - DONE!
// 6.2 PARSE SQUARE ROOT FUNCTION - 
// 6.3 PARSE "e"
// 6.4 PARSE LOG FUNCTION
// 7. DRAW LINES BETWEEN POINTS NOT JUST POINTS THEMSELVES
// 8. MAKE GUI 
// 9. PUT THE PRIORITIES IN A TXT FILE INSTEAD OF HARD CODING DATA

//BUGS:
// 1. -(x^2), make egatives outside a left bracket be -1*
// 2. fix scrolling to the left and bottom - DONE


//import g4p_controls.*;

String equation = "-x^2";  //-2*cos((x^3)/(x^2+10))

float xMax = 5;
float xMin = -5;
float yMax = 5;
float yMin = -5;
float xScale = 1;
float yScale = 1;

Axis coordinateAxis;
Graph graph;

PFont font;

PVector initialCoordinates;
PVector finalCoordinates;
PVector displacement;

Boolean mouseDown = false;
Boolean graphChanged = true;



void setup() {
  //println("ANSWER", shuntingAlgorithm(test));
  size(600, 600);
  
  coordinateAxis = new Axis();
  graph = new Graph(equation);
  
  graph.drawGraph();
  
  font = createFont("Times New Roman", 18);
  textFont(font);
  rectMode(CENTER);
  frameRate(1);
  
  loop();
  frameRate(30);
  // Transaltes to (0,0) on the center of the screen
  //translate(width/2, height/2);
  
}

void draw() {
  if(graphChanged) {
    println(xScale);
    background(255);
    coordinateAxis.drawAxis();
    graph.drawGraph();
    graph.drawLabel();
    graphChanged = !graphChanged;
  }
}


// Checks if a string is a number
boolean isNumber(String c) {
  try {
    Float.parseFloat(c);
    return true;
  } 
  
  catch (Exception e) {
    return false;
  }
}
