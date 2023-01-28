float zoomOutFactor = 0.025;

void mousePressed() {
  mouseDown = true;
  graphClicked = true;
  initialCoordinates = new PVector(mouseX, mouseY);
}

// Moves the coordinate axis around
void mouseDragged() {
  graphClicked = false;
  
  if (mouseDown == true) {
    if (finalCoordinates != null) {
      displacement = PVector.sub(initialCoordinates, finalCoordinates);

      // Changes the xMin and xMax values when the mouse drags
      xMin -= (displacement.x / coordinateAxis.spacingXtick * xScale);
      xMax -= (displacement.x / coordinateAxis.spacingXtick * xScale);

      yMin += displacement.y / coordinateAxis.spacingYtick * yScale;
      yMax += displacement.y / coordinateAxis.spacingYtick * yScale;
      
      // If the tangent is locked to the screen, make sure the tangent stays at the same spot on the graph
      if (tangentLocked) {
        graph.xCoordinateGraph1 -= displacement.x / coordinateAxis.spacingXtick * xScale - adjustmentx;
        graph.xCoordinateGraph2 -= displacement.x / coordinateAxis.spacingXtick * xScale - adjustmentx;
      }
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
  
  // If the user just clicked the graph to lock the tangent line in place
  if (graphClicked == true) {
    graphClicked = false;
    tangentLocked = !tangentLocked;
  }
  
  // Update the GUI values
  updateGUIvalues();
}

// ZOOM IN / ZOOM OUT
void mouseWheel(MouseEvent event) {
  float e = event.getCount();

  // ZOOM OUT
  if (e == 1) 
    zoomOut();
  

  // ZOOM IN
  else if (e == -1) {
    zoomIn();
  }
}

// Function that is called with key pressed 
void keyPressed() {
  if(key == CODED) {
    
    // ZOOM OUT
    if(keyCode == SHIFT) {
      zoomOut();
    }
    
    // ZOOM IN
    else if(keyCode == CONTROL) {
      zoomIn();
    }
  }
}

// Zoom In Function
void zoomIn() {
  xMin += coordinateAxis.xAxisLength*zoomOutFactor;
  xMax -= coordinateAxis.xAxisLength*zoomOutFactor;
  yMin += coordinateAxis.yAxisLength*zoomOutFactor;
  yMax -= coordinateAxis.yAxisLength*zoomOutFactor;

  if (coordinateAxis.spacingXtick > 120) {
    xScale /= 2;
    
    //// Gets rid of the decimals on the xScale number when it is really small
    //if (xScale < 1) {
    //  for(int i = 0; i < str(xScale).length(); i++) {
    //    if (str(xScale).charAt(i) != '0' && i+2 < str(xScale).length()) {
    //      xScale = float(str(xScale).substring(0, i+2));
    //    }
    //  }
    //}
  }

  if (coordinateAxis.spacingYtick > 120) {
    yScale /= 2;
    
    // Gets rid of the decimals on the yScale number when it is really small
    
  }
  
  // Updates the GUI values
  updateGUIvalues();
}


// Zoom Out function
void zoomOut() {
  xMin -= coordinateAxis.xAxisLength*zoomOutFactor;
  xMax += coordinateAxis.xAxisLength*zoomOutFactor;
  yMin -= coordinateAxis.yAxisLength*zoomOutFactor;
  yMax += coordinateAxis.yAxisLength*zoomOutFactor;

  if (coordinateAxis.spacingXtick < 60) {
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
  
  if (coordinateAxis.spacingYtick < 60) {
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
  
  // Updates the GUI values
  updateGUIvalues();
}
