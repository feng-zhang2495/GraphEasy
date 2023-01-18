void mousePressed() {
  mouseDown = true;
  initialCoordinates = new PVector(mouseX, mouseY);
}

void mouseDragged() {
  if (mouseDown == true) {
    displacement = PVector.sub(initialCoordinates, finalCoordinates);
    //println(initialCoordinates, finalCoordinates, displacement);
    
    finalCoordinates = initialCoordinates;
    initialCoordinates = new PVector(mouseX, mouseY);
  }

  // Changes the xMin and xMax values when the mouse drag 
  xMin -= displacement.x / xScale;
  xMax -= displacement.x / xScale;
  
  yMin += displacement.y / yScale;
  yMax += displacement.y / yScale;
}


void mouseReleased() {
  mouseDown = false;
}
