class Graph {
  // FIELDS 
  String equation;
  ArrayList<String> equationCopy;
  ArrayList<String> parsedEquation;
  ArrayList<PVector> points;
  float yCoordinateGraph1;
  float yCoordinateGraph2;
  float xCoordinateGraph1;
  float xCoordinateGraph2;
  float mouseCoordinateX1;
  float mouseCoordinateX2;
  float yCoordinate1;
  float yCoordinate2;
  float slope;
  // Hash map that stores the values of the previously parsed equations to avoid parsing the same x-value multiple times. 
  private HashMap<Float, ArrayList<String>> previousParsedEquations = new HashMap<Float, ArrayList<String>>();
  private HashMap<Float, Float> graphCoordinates = new HashMap<Float, Float>();
  
  
  // CONSTRUCTOR
  Graph(String e) {
    this.equation = e;
    this.parsedEquation = new ArrayList<String>();
    equationCopy = new ArrayList<String>();
    
    // Adds all the characters in the equation variable into the parsedEquation ArrayList
    for(int i = 0; i < equation.length(); i++) {
      if(equation.charAt(i) != ' ')
        equationCopy.add(str(equation.charAt(i)));
    }
    
    points = new ArrayList<PVector>();
  }
  
  // METHODS
  void drawGraph() {
    // Calculates the spacing between each of the points
    float s = abs(xMax-xMin) / (width/3);
    
    // Finds width / 4 number of coordinate pairs 
    for(int j = 0; j < width/3; j++) {
      
      // The x-coordinate of the current point 
      float xValue = xMin+s*j;
      
      // Adds the coordinate pair to the points arrayList
      points.add(new PVector(xValue, parseEquation(xValue)));
    }   
    
    // Draws the points on the screen
    for (int i = 1; i < points.size(); i++) {
      float pointX1 = coordinateAxis.yAxisCoordinate + points.get(i).x * coordinateAxis.spacingXtick / xScale - adjustmentx;
      float pointY1 = coordinateAxis.xAxisCoordinate - points.get(i).y * coordinateAxis.spacingYtick / yScale + adjustmenty;
      float pointX2 = coordinateAxis.yAxisCoordinate + points.get(i-1).x * coordinateAxis.spacingXtick / xScale - adjustmentx;
      float pointY2 = coordinateAxis.xAxisCoordinate - points.get(i-1).y * coordinateAxis.spacingYtick / yScale + adjustmenty;
      
      stroke(0);
      strokeWeight(5);
      
      // Only draw the line if the line isn't a asymptote. 
      if (abs(pointY1 - pointY2) < 10000) {
        line(pointX1, pointY1, pointX2, pointY2);
      }
    }
    
    points = new ArrayList<PVector>();
  }
  
  
  // Parses the equation by replacing the variable x with numbers in the range of xMin to xMax
  float parseEquation(float xValue) {
    float yValue;
    parsedEquation = new ArrayList<String>();
    
    // If the x-value and y-value coordinates already exist in the hashmap dont recalculate.
    if (graphCoordinates.containsKey(xValue)) {
      yValue = graphCoordinates.get(xValue);
    }
    
    // If the x-coordinate of the current point is already in the hashmap, don't recalculate it
    else {
      if (previousParsedEquations.containsKey(xValue)) {
        parsedEquation = previousParsedEquations.get(xValue);
      }
      
      // If the x-coordinate of the current point isnt in the hashmaps, calculate it
      else {
        
        // Copy the equation into the parsedEquation ArrayList
        for(String p : equationCopy) {
          parsedEquation.add(p);
        }      
        
        // While there is still an x variable in the equation
        for(int i = 0; i < parsedEquation.size(); i++) {
          
          
          // Replace x with the point value 
          if(parsedEquation.get(i).equals("x")) {
            
            parsedEquation.remove(i);
            
            if(i != 0) {
              // If there is a coefficient in front of the x, multiply it by x
              if(isNumber(parsedEquation.get(i-1))) {
                parsedEquation.add(i, "*");
                parsedEquation.add(i+1, str(xValue));
              }
              
              
              // If there is just a negative sign in front of the x
              if (parsedEquation.get(i-1).equals("-")) {
                //if (i == 1) {
                //  parsedEquation.add(i-1, "-1");
                //  parsedEquation.add(i, "*");
                //  parsedEquation.add(i+1, str(xValue));
                //} 
                
                if (isNumber(parsedEquation.get(i-2)) == false) {
                  parsedEquation.remove(i-1);
                  parsedEquation.add(i-1, "-1");
                  parsedEquation.add(i, "*");
                  parsedEquation.add(i+1, str(xValue));
                }
              } 
            
              
              // If there are no exceptions
              else {
                parsedEquation.add(i, str(xValue));
              }
            }
          }
          
          // If the character being read is not x
          else {
            
            // The case where there is a negative number at the beginning (ex. -5) 
            if(i == 0 && parsedEquation.get(i).equals("-") && parsedEquation.size() > 0) {
              
              if(isNumber(parsedEquation.get(i+1))) {
                
                int pos = i+1;
                // If the next character is still a number or a decimal character, continue to the next character
                while (isNumber(parsedEquation.get(pos)) || parsedEquation.get(pos).equals(".")) {
                  pos++;
        
                  if (pos == parsedEquation.size()) {
                    break;
                  }
                }
        
                // Add the whole number to the output queue
                String output = "";
                
                for (int m = i; m < pos; m++) {
                  output += parsedEquation.get(m);
                }
                
                for(int l = 0; l < pos - i; l++) {
                  parsedEquation.remove(0);
                }

                parsedEquation.add(0, output);
                i = pos-1;
              }
              
              // If the next character is x, for example -x
              else if (parsedEquation.get(i+1).equals("x")) {

                parsedEquation.remove(i);
                parsedEquation.remove(i);
                parsedEquation.add(i, "-1");
                parsedEquation.add(i+1, "*");
                parsedEquation.add(i+2, str(xValue));
                i = i + 2;
              }
            }
            
            // If the constant "e" exists in the equation
            else if(parsedEquation.get(i).equals("e")) {
              parsedEquation.remove(i);
              parsedEquation.add(i, "2.7182818");
            }
          }
          previousParsedEquations.put(xValue, parsedEquation);
        }
      }
      //println("PARSED EQUATION", parsedEquation);
      yValue = shuntingAlgorithm(parsedEquation);
      graphCoordinates.put(xValue, yValue);
    }
    
    return yValue;
  }
  
  // Draws the equation of the graph
  void drawLabel() {
    textAlign(TOP, CENTER);
    text("y = " + equation, 20, 20);
  }
  
  
  // Draws the derivative at the xCoordinate of the mouse 
  void drawDerivative() {
    
    
    // Changes the output string to avoid errors such as 4*x+-5
    //if(b > 0) {
    //  operation = "*x+";
    //}
    
    //else {
    //  operation = "*x";
    //}
    
    //println("EQUATION OF TANGENT", str(slope) + operation +str(b));

    stroke(255, 0, 0);
    
    // If the tangent is not locked, update the values of the graph
    if (tangentLocked == false) {
      slope = (yCoordinate2 - yCoordinate1) / (mouseCoordinateX2 - mouseCoordinateX1);
      // Gets the xCoordinate of wherever your mouse is 
      mouseCoordinateX1 = mouseX * xScale / coordinateAxis.spacingXtick + xMin;
      mouseCoordinateX2 = (mouseX + 3) * xScale / coordinateAxis.spacingXtick + xMin;
      
      yCoordinate1 = parseEquation(mouseCoordinateX1);
      yCoordinate2 = parseEquation(mouseCoordinateX2);
    }
    
    // The y intercept of the line
    float b = yCoordinate1 - slope*mouseCoordinateX1;    
    
    yCoordinateGraph1 = coordinateAxis.xAxisCoordinate - (slope*xMin + b) * coordinateAxis.spacingYtick / yScale + adjustmenty;
    yCoordinateGraph2 = coordinateAxis.xAxisCoordinate - (slope*xMax + b) * coordinateAxis.spacingYtick / yScale + adjustmenty;
    xCoordinateGraph1 = coordinateAxis.yAxisCoordinate + xMin * coordinateAxis.spacingXtick / xScale - adjustmentx;
    xCoordinateGraph2 = coordinateAxis.yAxisCoordinate + xMax * coordinateAxis.spacingXtick / xScale - adjustmentx;
    
    // Draws the tangent line
    line(xCoordinateGraph1, yCoordinateGraph1, xCoordinateGraph2, yCoordinateGraph2);
  }
  
  
  void displayMousePosition() {
    textAlign(TOP, CENTER);
    String output = "(" + str(mouseCoordinateX1) + ", " + str(yCoordinate1) + ")";
    text(output, 15, height-15);    
  }
}
