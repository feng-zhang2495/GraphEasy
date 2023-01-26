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
