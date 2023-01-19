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
  println(e);
}
