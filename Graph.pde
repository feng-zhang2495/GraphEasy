class Graph {
  // FIELDS 
  String equation;
  ArrayList<String> equationCopy;
  ArrayList<String> parsedEquation;
  ArrayList<Point> points;
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
    
    points = new ArrayList<Point>();
  }
  
  // METHODS
  void drawGraph() {
    // Displays the coordinates of where the mouse currently is
    displayMousePosition();
    
    // Calculates the spacing between each of the points
    float s = abs(xMax-xMin)/width;
    
    // Goes through j width amount of times
    for(int j = 0; j < width; j++) {
      
      // The x-coordinate of the current point 
      float xValue = xMin+s*j;
      parseEquation(xValue);
    }   
    
    
    pushMatrix();
    translate(coordinateAxis.yAxisCoordinate, coordinateAxis.xAxisCoordinate);
    
    // Adjusts the coordinate if yAxisCoordinate and xAxisCoordinate is NOT on the origin (0,0)
    float adjustmentx = 0;
    float adjustmenty = 0;
    
    // If the coordinate axis is off the origin (0,0)
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
      adjustmenty = yMax *coordinateAxis.spacingYtick / yScale;
    }
    
    // Draws the points on the screen
    for (int i = 0; i < points.size(); i++) {
      float xCoordinate = points.get(i).coordinates.x * coordinateAxis.spacingXtick / xScale - adjustmentx;
      float yCoordinate = -points.get(i).coordinates.y * coordinateAxis.spacingYtick / yScale + adjustmenty;
      circle(xCoordinate, yCoordinate, 5);
    }
    popMatrix();
    
    points = new ArrayList<Point>();
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
    
    Point point = new Point(new PVector(xValue, yValue));
    points.add(point);
    
    return yValue;
  }
  
  // Draws the equation of the graph
  void drawLabel() {
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
    
     // Adjusts the coordinate if yAxisCoordinate and xAxisCoordinate is NOT on the origin (0,0)
    float adjustmentx = 0;
    float adjustmenty = 0;
    
    // If the coordinate axis is off the origin (0,0)
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
      adjustmenty = yMax *coordinateAxis.spacingYtick / yScale;
    }
    
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
    
    yCoordinateGraph1 = slope*xMin + b;
    yCoordinateGraph2 = slope*xMax + b;
    xCoordinateGraph1 = xMin * coordinateAxis.spacingXtick / xScale - adjustmentx;
    xCoordinateGraph2 = xMax * coordinateAxis.spacingXtick / xScale - adjustmentx;
    
    // Draws the tangent line
    pushMatrix();
    translate(coordinateAxis.yAxisCoordinate, coordinateAxis.xAxisCoordinate);
    line(xCoordinateGraph1, -yCoordinateGraph1 * coordinateAxis.spacingYtick / yScale + adjustmenty, xCoordinateGraph2, -yCoordinateGraph2 * coordinateAxis.spacingYtick / yScale + adjustmenty);
    popMatrix();
    
    //Graph tangent = new Graph(str(slope) + operation +str(b));
    //tangent.drawGraph();
  }
  
  
  void displayMousePosition() {
    String output = "(" + str(mouseCoordinateX1) + ", " + str(yCoordinate1) + ")";
    text(output, 15, height-15);    
  }
}
