class SpaceParticle {
  Coordinates coordinates;
  color pColor;
  float diameter;
  String name;
  
  String toString() {
    return "Name: " + name + " | Coordinates: " + coordinates.toString() + " | Diameter:" + diameter;
  }
}