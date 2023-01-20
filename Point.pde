class Point {
  // FIELDS
  PVector coordinates;
  
  // CONSTRUCTOR
  Point(PVector c) {
    this.coordinates = c;
  }
  
  // METHODS
  void drawPoint() {
    circle(coordinates.x, coordinates.y, 5);
  }
}
