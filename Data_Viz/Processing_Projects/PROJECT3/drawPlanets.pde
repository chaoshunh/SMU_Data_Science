void drawPlanets(float radX, float radY, float theta, color fillCol, float sizes, int i){
  float x2 = 0, y2 = 0;
  
  x2 = cos(theta) * radX; // identify x coordinate
  y2 = sin(theta) * radY; // identify y coordinate
  
  pushMatrix(); // ensure origin is reset
  translate(width/2, height/2); // translate to start from middle of pane
  fill(fillCol);
  if(millis()< 8000){
    ellipse(x2, y2, random(10,30), random(10,30));
  } else {
    if(i == 5){
      ellipse(x2, y2, sizes, sizes);
      fill(#ECED18);
      // create saturns' ring
      ellipse(x2, y2, sizes+sizes/3, sizes/15);
    } else if(i == 6){
      ellipse(x2, y2, sizes, sizes);
      fill(255);
      // create uranus' rings
      ellipse(x2, y2+sizes/20, sizes+sizes/3, sizes/20);
      ellipse(x2, y2-sizes/20, sizes+sizes/3, sizes/20);
    } else {
      ellipse(x2, y2, sizes, sizes);
    }
  }
  popMatrix(); 
}