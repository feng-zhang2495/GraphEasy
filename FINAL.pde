// GOALS: 1. GET THE THING TO DRAW A CENTERED AXIS DONE
// 2. GET THE THING TO DRAW AN OFFSET AXIS
// 3. GET THE USER TO USE THEIR MOUSE TO MOVE THE AXIS

//import g4p_controls.*;

float xMax = 5;
float xMin = -7;
float yMax = 10;
float yMin = -10;
float xScale = 1;
float yScale = 1;
float xAxisLength;
float yAxisLength;

PFont font;

void setup() {
  size(700, 700);
  
  xAxisLength = xMax - xMin;
  yAxisLength = yMax - yMin;
  
  font = createFont("Arial", 18);
  textFont(font);
  rectMode(CENTER);
  
  // Transaltes to (0,0) on the center of the screen
  //translate(width/2, height/2);
}

void draw() {
  drawGraph();
}

// Draws the graph and axis 
void drawGraph() {
  strokeWeight(2);
  stroke(255, 0, 0);
  
  if(xMin < 0) {
    // X-axis
    line(0, height/2, width, height/2); 
    fill(255, 0, 0);
    textAlign(RIGHT);
    text("x", width-10, height/2-3);
    
    // Y-axis
    line(width/2, 0, width/2, height);
    textAlign(UP);
    text("y", width/2+3, 10);
    
    // Draws the triangles on the ends of the axis  
    //triangle(width/2, 0, width/2-5, 10, width/2+5, 10);
    //triangle(width/2, height, width/2-5, height-10, width/2+5, height-10);
    //triangle(0, height/2, 10, height/2-5, 10, height/2+5);
    //triangle(width, height/2, width-10, height/2-5, width-10, height/2+5);
  }
  
  noStroke();
  fill(0);
  
  // Draws the ticks on the x axis
  float spacing = width/xAxisLength/xScale;
  textAlign(CENTER, TOP);
  
  for(int i = 0; i < xAxisLength/xScale+1; i++) {
    rect(spacing*i, height/2, 2.3, 7); //<>//
    text(str(xMin + xScale*i), spacing*i, height/2);
  }
  
  // Draws the ticks on the y axis
  spacing = height/yAxisLength/yScale;
  for(int i = 0; i < yAxisLength/yScale+1; i++) {
    rect(width/2, spacing*i, 7, 2.3);
  }
  
  
}
