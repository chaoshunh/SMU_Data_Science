class Moon extends SpaceParticle{
  
    float speed = 0.05;
    float theta = random(0,PI);
    
    void drawMoon(float locX, float locY, float planetDiameter, int j) {
      float distanceFromPlanet = planetDiameter + j * 5;
      float x = cos(theta)*distanceFromPlanet + locX; 
      float y = sin(theta)*distanceFromPlanet + locY; 
      theta = (theta + speed) % TAU;
      fill(255);
      ellipse(x , y , 1.5, 1.5);
    }

}