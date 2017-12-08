class Coordinates {
  public float xAxis;
  public float yAxis;
  
  Coordinates(float xValue, float yValue) {
    xAxis = xValue;
    yAxis = yValue;
  }
  
  void addToCoordinates(float xValue, float yValue) {
     xAxis += xValue;
     yAxis += yValue;
  }
  
  void setCoordinates(float xValue, float yValue) {
     xAxis = xValue;
     yAxis = yValue;
  }
  
  //generate string of coordinates as (x,y)
  String toString(){
    return "(" + xAxis +"," + yAxis + ")";
  }
}