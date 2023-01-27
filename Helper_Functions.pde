// Checks if a string is a number
boolean isNumber(String c) {
  try {
    Float.parseFloat(c);
    return true;
  } 
  
  catch (Exception e) {
    return false;
  }
}


// Rounds float numbers 
float roundFloat(float n, int decimalPlaces) {
  int iterations = 0;

  // If the number is greater than 0
  if(n > 1) {
    // Round to the desired number of decimal places and convert the number back 
    n = round(n*pow(10, decimalPlaces)) / pow(10, decimalPlaces);
  }
  
  // If the number is less than 0
  else {
    
    // While the number is less than 1, multiply it by 10
    while(n < 1) {
      iterations++;
      n *= 10;
    }
    
    // Round to the desired number of decimal places and convert the number back
    n = round(n*pow(10, decimalPlaces)) / pow(10, iterations + decimalPlaces);
  }
  
  return n;
}


// Updates the adjustmentx and adjustmenty coordinates which are responsible for shifting the origin point of the coordinate axis
// Thia makes sure that points are drawn on the right places on screen
void updateAdjustment() {
  if(xMin > 0) {
    adjustmentx = xMin * coordinateAxis.spacingXtick / xScale;
  }
  
  else if (xMax < 0) {
    adjustmentx = xMax * coordinateAxis.spacingXtick / xScale;
  }
  
  if(yMin > 0) {
    adjustmenty = yMin * coordinateAxis.spacingYtick / yScale;
  }
  
  else if (yMax < 0) {
    adjustmenty = yMax * coordinateAxis.spacingYtick / yScale;
  }
}
