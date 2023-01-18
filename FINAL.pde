// GOALS: 1. GET THE THING TO DRAW A CENTERED AXIS - DONE!
// 2. GET THE THING TO DRAW AN OFFSET AXIS
// 3. GET THE USER TO USE THEIR MOUSE TO MOVE THE AXIS

//import g4p_controls.*;

float xMax = 150;
float xMin = -50;
float yMax = 50;
float yMin = -10;
float xScale = 30;
float yScale = 5;
Graph graph;

PFont font;

void setup() {
  size(700, 700);
  graph = new Graph();
  
  font = createFont("Arial", 18);
  textFont(font);
  rectMode(CENTER);
  
  // Transaltes to (0,0) on the center of the screen
  //translate(width/2, height/2);
}

void draw() {
  graph.drawAxis();
}
