void mousePressed() {
  mouseDown = true;
  initialCoordinates = new PVector(mouseX, mouseY);
}

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


void mouseReleased() {
  mouseDown = false;
  initialCoordinates = null;
  finalCoordinates = null;
}
