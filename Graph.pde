class Graph {
  // FIELDS
  float xAxisLength;
  float yAxisLength;
  float spacingXtick, spacingYtick;
  float yAxisCoordinate, xAxisCoordinate;
  float textPosition;
  
  // CONSTRUCTOR
  Graph() {
    this.xAxisLength = xMax - xMin;
    this.yAxisLength = yMax - yMin;
    this.spacingXtick = width/(this.xAxisLength/xScale);
    this.spacingYtick = height/(this.yAxisLength/yScale);
    this.yAxisCoordinate = abs(xMin)*this.spacingXtick/xScale;
    this.xAxisCoordinate = abs(yMax)*this.spacingYtick/yScale;
  }
  
  // METHODS
  // Updates the variables used in the class
  void updateValues() {
    this.xAxisLength = xMax - xMin;
    this.yAxisLength = yMax - yMin;
    this.spacingXtick = width/(this.xAxisLength/xScale);
    this.spacingYtick = height/(this.yAxisLength/yScale);
    this.yAxisCoordinate = abs(xMin)*this.spacingXtick/xScale;
    this.xAxisCoordinate = abs(yMax)*this.spacingYtick/yScale;
    
    if (yMin > 0) {
      this.xAxisCoordinate = height-20;
    }

    if (yMax < 0) {
      this.xAxisCoordinate = 5;
    }
    
    if (xMin > 0) {
      this.yAxisCoordinate = 7;
    }
    
    if (xMax < 0) {
      this.yAxisCoordinate = width-5;
    }
  }
  
  // Draws the coordinate axis 
  void drawAxis() {
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
  
    noStroke();
    fill(0);
    
    
    // DRAWS THE TICKS ON THE X-AXIS
    textAlign(CENTER, TOP);
    
    // If the origin is included in the range of xMin to xMax
    if (xMin < 0 && xMax > 0) {
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
    }
    
    // If the origin is not included in the range of xMin to xMax
    else {
      
      if(xMin > 0) {
        // DRAWS TICKS TO THE RIGHT OF THE Y AXIS
        for(int i = 0; i < (xAxisLength / xScale) + 1; i++) {
          
          float xPositionOfTick = yAxisCoordinate + (ceil(xMin/xScale) * xScale - xMin)/xScale * spacingXtick + spacingXtick*i;
          rect(xPositionOfTick, xAxisCoordinate, 2.3, 5);
          text(str(ceil(xMin/xScale) * xScale * (i+1)), xPositionOfTick, xAxisCoordinate);
        }
      }
      
      if(xMax < 0) {
        // DRAWS TICKS TO THE LEFT OF THE Y AXIS
        for(int i = 0; i < (xAxisLength / xScale) + 1; i++) {   
          
          float xPositionOfTick = yAxisCoordinate - (ceil(abs(xMax)/xScale) * xScale - abs(xMax))/xScale * spacingXtick + spacingXtick*-i;
          rect(xPositionOfTick, xAxisCoordinate, 2.3, 5);
          text(str(floor(xMax/xScale)* xScale + xScale * -i), xPositionOfTick, xAxisCoordinate);
        }
      }
    }
    
    
    // DRAWS THE TICKS ON THE Y-AXIS 
    if(xMax > 0) {
      this.textPosition = 10;
      textAlign(TOP, CENTER);
    }
    
    else {
      this.textPosition = -5;
      textAlign(RIGHT, CENTER);
    }
    
    // If the origin is included in the range of yMin and yMax
    if (yMin < 0 && yMax > 0) {
      // DRAWS TICKS ABOVE THE ORIGIN
      for(int i = 0; i < (yAxisLength - abs(yMin) / yScale) / yScale + 1; i++) {
        rect(yAxisCoordinate, xAxisCoordinate + spacingYtick*-i, 5, 2.3);
        
        // Prevents it from drawing 0 twice
        if(yScale * -i != 0) {
          text(str(yScale * i), yAxisCoordinate + textPosition, xAxisCoordinate + spacingYtick*-i);
        }
      }
      
      // DRAWS TICKS BELOW THE ORIGIN
      for(int i = 0; i < (yAxisLength - abs(yMax) / yScale) / yScale + 1; i++) {
        rect(yAxisCoordinate, xAxisCoordinate + spacingYtick*i, 5, 2.3);
        
        // Prevents it from drawing 0 twice
        if(yScale * i != 0) {
          text(str(yScale * -i), yAxisCoordinate + textPosition, xAxisCoordinate + spacingYtick*i);
        }
      }
    }
    
    // If the origin is not included in the range of yMin to yMax
    else {
      if (yMin > 0) {
        // DRAWS TICKS ABOVE THE X AXIS 
        for(int i = 0; i < (yAxisLength / yScale) + 1; i++) {
            
          float yPositionOfTick = xAxisCoordinate - (ceil(yMin/yScale) * yScale - yMin)/yScale * spacingYtick - spacingYtick*i;
          rect(yAxisCoordinate, yPositionOfTick, 5, 2.3);
          text(str(ceil(yMin/yScale)*yScale + yScale * (i)), yAxisCoordinate + textPosition, yPositionOfTick);
        }
      }
      
      else if (yMax < 0) {
        // DRAWS TICKS BELOW THE X AXIS 
        for(int i = 0; i < (yAxisLength / yScale) + 1; i++) {
          
          float yPositionOfTick = xAxisCoordinate - (floor(yMax/yScale) * yScale - yMax)/yScale * spacingYtick + spacingYtick*i;
          rect(yAxisCoordinate, yPositionOfTick, 5, 2.3);
          text(str(floor(yMax/yScale) * yScale - yScale * (i)), yAxisCoordinate + textPosition, yPositionOfTick);
        }
      }
    }  
  }
}
