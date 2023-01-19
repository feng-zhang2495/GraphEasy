float zoomOutFactor = 0.025;

void mousePressed() {
  mouseDown = true;
  initialCoordinates = new PVector(mouseX, mouseY);
}

// Moves the coordinate axis around
void mouseDragged() {
  if (mouseDown == true) {
    if(finalCoordinates != null) {
      displacement = PVector.sub(initialCoordinates, finalCoordinates);
      
      // Changes the xMin and xMax values when the mouse drags
      xMin -= displacement.x / graph.spacingXtick * xScale;
      xMax -= displacement.x / graph.spacingXtick * xScale;
      
      yMin += displacement.y / graph.spacingYtick * yScale;
      yMax += displacement.y / graph.spacingYtick * yScale;
    }
    
    finalCoordinates = initialCoordinates;
    initialCoordinates = new PVector(mouseX, mouseY);
  }
}

// Once the mouse is released, set the initial and final coordinates to null
void mouseReleased() {
  mouseDown = false;
  initialCoordinates = null;
  finalCoordinates = null;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  
  // ZOOM OUT
  if(e == 1) {
    xMin -= graph.xAxisLength*zoomOutFactor;
    xMax += graph.xAxisLength*zoomOutFactor;  
    yMin -= graph.yAxisLength*zoomOutFactor;
    yMax += graph.yAxisLength*zoomOutFactor;
    
    if(graph.spacingXtick < 80) {
      xScale *= 2;
      
      // Reduces the xScale number to a nice number if it is too large 
      int x = 0;
      while (xScale > 10) {
        xScale /= 10;
        x++;
       
        if (xScale < 10) {
          xScale = int(xScale)*pow(10, x);
          break;
        }
      }
    }
    
    if(graph.spacingYtick < 80) {
      yScale *= 2;
      
      // Reduces the yScale number to a nice number if it is too large 
      int x = 0;
      while (yScale > 10) {
        yScale /= 10;
        x++;
       
        if (yScale < 10) {
          yScale = int(yScale)*pow(10, x);
          break;
        }
      }
    }
  }
  
  // ZOOM IN
  else if (e == -1) {
    println("bru");
  }
}
