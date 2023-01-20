class Graph {
  // FIELDS 
  String equation;
  ArrayList<String> equationCopy;
  ArrayList<String> parsedEquation;
  ArrayList<Point> points;
  // Hash map that stores the values of the previously parsed equations to avoid parsing the same x-value multiple times. 
  private HashMap<Float, ArrayList<String>> previousParsedEquations = new HashMap<>();
  private HashMap<Float, Float> graphCoordinates = new HashMap<>();
  
  
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
    parseEquation();
    
    pushMatrix();
    translate(coordinateAxis.yAxisCoordinate, coordinateAxis.xAxisCoordinate);
    
    // Draws the points on the screen
    for (int i = 0; i < points.size(); i++) {
      float xCoordinate = points.get(i).coordinates.x * coordinateAxis.spacingXtick / xScale;
      float yCoordinate = -points.get(i).coordinates.y * coordinateAxis.spacingYtick / yScale;
      circle(xCoordinate, yCoordinate, 5);
    }
    popMatrix();
    
    points = new ArrayList<Point>();
  }
  
  // Parses the equation by replacing the variable x with numbers in the range of xMin to xMax
  void parseEquation() {
    float s = abs(xMax-xMin)/width;
    
    // Goes through j width amount of times
    for(int j = 0; j < width; j++) {
      
      // The x-coordinate of the current point 
      float xValue = xMin+s*j;
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
                if (parsedEquation.get(i-1).equals("-") && isNumber(parsedEquation.get(i-2)) == false) {
                  parsedEquation.add(i-1, "-1");
                  parsedEquation.add(i, "*");
                  parsedEquation.add(i+1, str(xValue));
                  
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
              }
            }
            previousParsedEquations.put(xValue, parsedEquation);
          }
        }
        yValue = shuntingAlgorithm(parsedEquation);
        graphCoordinates.put(xValue, yValue);
      }
      
           
      //println("PARSED EQUATION", parsedEquation);
      Point point = new Point(new PVector(xValue, yValue));
      points.add(point);
    }   
  }
}
