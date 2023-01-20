// GOALS: 1. GET THE THING TO DRAW A CENTERED AXIS - DONE!
// 2. GET THE THING TO DRAW AN OFFSET AXIS - DONE!
// 3. GET THE USER TO USE THEIR MOUSE TO MOVE THE AXIS - DONE!
// 4. GET THE USER TO ZOOM OUT/IN USING THE MOUSE SCROLL WHELL - DONE!
// 5. GET A GRAPH TO BE DRAWN ON THE SCREEN - DONE!
// 6. PARSE AN EQUATION FROM ITS STRING - DONE!
// 6.1 PARSE TRIG EQUATIONS
// 7. MAKE GUI 

//import g4p_controls.*;

String equation = "sin((x^3)/(x^2+1))";

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
  size(700, 700);
  
  coordinateAxis = new Axis();
  graph = new Graph(equation);
  
  graph.drawGraph();
  
  font = createFont("Arial", 18);
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
    background(255);
    coordinateAxis.drawAxis();
    graph.drawGraph();
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
