class Graph {
  // FIELDS
  float xAxisLength;
  float yAxisLength;
  float spacingXtick, spacingYtick;
  float yAxisCoordinate, xAxisCoordinate;
  
  // CONSTRUCTOR
  Graph() {
    this.xAxisLength = xMax - xMin;
    this.yAxisLength = yMax - yMin;
    this.spacingXtick = width/( this.xAxisLength/xScale);
    this.spacingYtick = height/(this.yAxisLength/yScale);
    this.yAxisCoordinate = abs(xMin)*this.spacingXtick/xScale;
    this.xAxisCoordinate = abs(yMax)*this.spacingYtick/yScale;
  }
  
  // METHODS
  void updateValues() {
    this.xAxisLength = xMax - xMin;
    this.yAxisLength = yMax - yMin;
    this.spacingXtick = width/(this.xAxisLength/xScale);
    this.spacingYtick = height/(this.yAxisLength/yScale);
    
    if (xMin < 0 && xMax > 0 && yMin < 0 && yMax > 0) {
      this.yAxisCoordinate = abs(xMin)*this.spacingXtick/xScale;
      this.xAxisCoordinate = abs(yMax)*this.spacingYtick/yScale;
    }
    
    if (yMin > 0) {
      this.xAxisCoordinate = height-20;
    }
    //println(yMin, yMax);
    if (yMax < 0) {
      this.xAxisCoordinate = 10;
    }
  }
  
  // Draws the coordinate axis 
  void drawAxis() {
    println( xMin, xMax);
    updateValues();
    strokeWeight(2);
    stroke(255, 0, 0);
   
      
    // X-axis
    line(0, xAxisCoordinate, width, xAxisCoordinate); 
    fill(255, 0, 0);
    textAlign(RIGHT);
    text("x", width-10, xAxisCoordinate-3);
    
    // Y-axis
    line(yAxisCoordinate, 0, yAxisCoordinate, height);
    textAlign(UP);
    text("y", yAxisCoordinate+3, 10);
    
    // Draws the triangles on the ends of the axis  
    //triangle(width/2, 0, width/2-5, 10, width/2+5, 10);
    //triangle(width/2, height, width/2-5, height-10, width/2+5, height-10);
    //triangle(0, height/2, 10, height/2-5, 10, height/2+5);
    //triangle(width, height/2, width-10, height/2-5, width-10, height/2+5);
  
  
  noStroke();
  fill(0);
  
  // DRAWS THE TICKS ON THE X-AXIS
  textAlign(CENTER, TOP);
  
  // DRAWS TICKS TO THE RIGHT OF THE ORIGIN
  for(int i = 0; i < (xAxisLength - abs(xMin) / xScale) / xScale + 1; i++) {
    rect(yAxisCoordinate + spacingXtick * i, xAxisCoordinate, 2.3, 5);
    text(str(xScale*i), yAxisCoordinate + spacingXtick * i, xAxisCoordinate);
  }
  
  // DRAWS TICKS TO THE LEFT OF THE ORIGIN
  for(int i = 0; i < (xAxisLength - abs(xMax) / xScale) / xScale + 1; i++) {
    rect(yAxisCoordinate + spacingXtick * -i, xAxisCoordinate, 2.3, 5);
    text(str(xScale * -i), yAxisCoordinate + spacingXtick * -i, xAxisCoordinate);
  }
  
  // DRAWS THE TICKS ON THE Y-AXIS 
  textAlign(TOP, CENTER);
  
  // DRAWS TICKS ABOVE THE ORIGIN
  for(int i = 0; i < (yAxisLength - abs(yMin) / yScale) / yScale + 1; i++) {
    rect(yAxisCoordinate, xAxisCoordinate + spacingYtick*-i, 5, 2.3);
    
    // Prevents it from drawing 0 twice
    if(yScale * -i != 0) {
      text(str(yScale * i), yAxisCoordinate+10, xAxisCoordinate + spacingYtick*-i);
    }
  }
  
  // DRAWS TICKS BELOW THE ORIGIN
  for(int i = 0; i < (yAxisLength - abs(yMax) / yScale) / yScale + 1; i++) {
    rect(yAxisCoordinate, xAxisCoordinate + spacingYtick*i, 5, 2.3);
    
    // Prevents it from drawing 0 twice
    if(yScale * i != 0) {
      text(str(yScale * -i), yAxisCoordinate+10, xAxisCoordinate + spacingYtick*i);
    }
  }
  }
    
  
  
}
