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
    points = new ArrayList<Point>();
  }
  
  // METHODS
  void drawGraph() {
    parseEquation();
    
    pushMatrix();
    translate(coordinateAxis.yAxisCoordinate, coordinateAxis.xAxisCoordinate);
    
    for (Point p : points) {
      float xCoordinate = p.coordinates.x*coordinateAxis.spacingXtick/xScale;
      point(xCoordinate, p.coordinates.y);
      
      
    }
    popMatrix();
  }
  
  // Parses the equation by replacing the variable x with numbers in the range of xMin to xMax
  void parseEquation() {
    
    // Adds all the characters in the equation variable into the parsedEquation ArrayList
    for(int i = 0; i < equation.length(); i++) {
      if(equation.charAt(i) != ' ')
        equationCopy.add(str(equation.charAt(i)));
    }
    
    // Draw 100 points
    float s = abs(xMax-xMin)/100;
    
    
    for(int j = 0; j < 100; j++) {
      parsedEquation = new ArrayList<String>();
      for(String p : equationCopy) {
        parsedEquation.add(p);
      }
      
      
      // While there is still an x variable in the equation
      for(int i = 0; i < parsedEquation.size(); i++) {
        
        // Replace x with the point value 
        if(parsedEquation.get(i).equals("x")) {
          parsedEquation.remove(i);
          parsedEquation.add(i, str(xMin+s*j));
        }
      }
      
      // Add the characters in parsed equation into one string and call shunting algorithm
      String parsedString = "";
      for(int i = 0; i < parsedEquation.size(); i++) {
        parsedString += parsedEquation.get(i);
      }
      
      Point point = new Point(new PVector(xMin+j*s, shuntingAlgorithm(parsedString)));
      points.add(point);
    }   
  }
}
