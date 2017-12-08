class Star extends SpaceParticle {
  Planet[] planets = new Planet[0];

  void drawStar()
  {
    for (int i = 0; i < shapeCountCurrent; i++) { 
      noStroke();
      Planet aPlanet = sun.planets[i];
      aPlanet.drawPlanet(i);
      aPlanet.updateCoordinates();
    }
    
    noStroke();
    pColor = color(random(245, 255), random(245, 255), 0);
    fill(pColor);
    ellipse(coordinates.xAxis, coordinates.yAxis, diameter, diameter);
  }
  
  //Generate string with some attributes of Star
  String toString() {
    return super.toString() + " | Planets: " + planets.length;
  }
}
