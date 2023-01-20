class Graph {
  // FIELDS 
  String equation;
  ArrayList<String> equationCopy;
  ArrayList<String> parsedEquation;
  ArrayList<Point> points;
  
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
    
    for (Point p : this.points) {
      float xCoordinate = p.coordinates.x * coordinateAxis.spacingXtick / xScale;
      float yCoordinate = -p.coordinates.y * coordinateAxis.spacingYtick / yScale;
      circle(xCoordinate, yCoordinate, 5);

    }
    popMatrix();
    
    points = new ArrayList<Point>();
  }
  
  // Parses the equation by replacing the variable x with numbers in the range of xMin to xMax
  void parseEquation() {
    
    
    
    // Draw 100 points
    float s = abs(xMax-xMin)/width;
    
    
    for(int j = 0; j < width; j++) {
      parsedEquation = new ArrayList<String>();
      
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
              parsedEquation.add(i+1, str(xMin+s*j));
            }
            
            // If there is just a negative sign in front of the x
            if (parsedEquation.get(i-1).equals("-") && isNumber(parsedEquation.get(i-2)) == false) {
              parsedEquation.add(i-1, "-1");
              parsedEquation.add(i, "*");
              parsedEquation.add(i+1, str(xMin+s*j));
              
            }
                        
            else {
              parsedEquation.add(i, str(xMin+s*j));
            }
          }
          
          else {
            parsedEquation.add(i, str(xMin+s*j));
          }
          
        }
      }
      
      //println("PARSED EQUATION", parsedEquation);
      Point point = new Point(new PVector(xMin+j*s, shuntingAlgorithm(parsedEquation)));
      points.add(point);
    }   
  }
}
