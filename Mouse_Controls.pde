float zoomOutFactor = 0.025;

void mousePressed() {
  mouseDown = true;
  initialCoordinates = new PVector(mouseX, mouseY);
}

// Moves the coordinate axis around
void mouseDragged() {
  if (mouseDown == true) {
    if (finalCoordinates != null) {
      displacement = PVector.sub(initialCoordinates, finalCoordinates);

      // Changes the xMin and xMax values when the mouse drags
      xMin -= displacement.x / coordinateAxis.spacingXtick * xScale;
      xMax -= displacement.x / coordinateAxis.spacingXtick * xScale;

      yMin += displacement.y / coordinateAxis.spacingYtick * yScale;
      yMax += displacement.y / coordinateAxis.spacingYtick * yScale;
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
  if (e == 1) {
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
  }

  // ZOOM IN
  else if (e == -1) {
    xMin += coordinateAxis.xAxisLength*zoomOutFactor;
    xMax -= coordinateAxis.xAxisLength*zoomOutFactor;
    yMin += coordinateAxis.yAxisLength*zoomOutFactor;
    yMax -= coordinateAxis.yAxisLength*zoomOutFactor;

    if (coordinateAxis.spacingXtick > 120) {
      xScale /= 2;

      // Reduces the xScale number to a nice number if it is too large
      //int x = 0;
      //while (xScale < 10) {
      //  xScale *= 10;
      //  x++;

      //  if (xScale > 10) {
      //    xScale = int(xScale)*pow(10, -x);
      //    break;
      //  }
      //}
    }

    if (coordinateAxis.spacingYtick > 120) {
      yScale /= 2.0;
      //println(yScale);
      
      // Reduces the yScale number to a nice number if it is too large
      //int x = 0;
      //while (yScale < 10) {
      //  yScale *= 10;
      //  x++;

      //  if (yScale > 10) {
      //    yScale = int(yScale)*pow(10, -x);
      //    break;
      //  }
      //}
    }
  }
}
