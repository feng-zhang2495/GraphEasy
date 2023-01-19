// GOALS: 1. GET THE THING TO DRAW A CENTERED AXIS - DONE!
// 2. GET THE THING TO DRAW AN OFFSET AXIS - DONE!
// 3. GET THE USER TO USE THEIR MOUSE TO MOVE THE AXIS - DONE!
// 4. GET THE USER TO ZOOM OUT/IN USING THE MOUSE SCROLL WHELL - DONE!
// 5. GET A GRAPH TO BE DRAWN ON THE SCREEN 
// 6. PARSE AN EQUATION FROM ITS STRING 
// 7. MAKE GUI 

//import g4p_controls.*;

float xMax = 10;
float xMin = -10;
float yMax = 10;
float yMin = -10;
float xScale = 1;
float yScale = 1;
Axis coordinateAxis;

PFont font;

PVector initialCoordinates;
PVector finalCoordinates;
PVector displacement;

Boolean mouseDown = false;

void setup() {
  println("ANSWER", shuntingAlgorithm(test));
  size(700, 700);
  coordinateAxis = new Axis();
  
  font = createFont("Arial", 18);
  textFont(font);
  rectMode(CENTER);
  
  frameRate(60);
  // Transaltes to (0,0) on the center of the screen
  //translate(width/2, height/2);
  
}

void draw() {
  background(255);
  coordinateAxis.drawAxis();
}

// Checks if a character is an integer 
boolean isInteger(char c) {
  try {
    Integer.parseInt(str(c));
    return true;
  } 
  
  catch (Exception e) {
    return false;
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
