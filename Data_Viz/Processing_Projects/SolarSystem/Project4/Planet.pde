class Planet extends SpaceParticle {
  Moon[] moons = new Moon[3];
  Ring rings = new Ring();
  Star star;
  float speed;
  float theta;
  float distanceFromStar;

  void updateCoordinates() {
    if (coordinates.xAxis < distanceFromStar) {
      coordinates.addToCoordinates(diameter/10, diameter/10);
    } else {
      coordinates.setCoordinates(distanceFromStar, distanceFromStar);
    }
    theta = (theta + speed) % TAU;
    System.out.println(this.toString());
  }
  
  void drawPlanet(int i) {
    float x = 0, y = 0;

    x = cos(theta) * coordinates.xAxis; // identify x coordinate
    y = sin(theta) * coordinates.yAxis; // identify y coordinate
    
    pushMatrix(); 
    translate(star.coordinates.xAxis, star.coordinates.yAxis); 
    fill(pColor);
    if (millis()< 8000) {
      ellipse(x, y, random(5, 10), random(5, 10));
    } else {
      ellipse(x, y, diameter, diameter); 
      noStroke(); 
      for(int j = 0; j < moons.length; j++){
        if(moons[j] == null){
          continue;
        } else {
        Moon aMoon = moons[j];
        aMoon.drawMoon(x, y, diameter, j);
        }
      }
     // }
      // draw rings
      if(rings.numRings()[i] == 1){
      rings.ringAround(x, y, diameter);
        } 
    }
    popMatrix();
  }  
  // Generate string with some attributes of Planet
  String toString() {
    // goes to parent class, space particle using super, override function toString() to add more variables
    return super.toString() + " | Speed:" + speed + " | Star: " + star.name + " | Distance from Star:" + distanceFromStar + " | Theta:" + theta;
  }
}
