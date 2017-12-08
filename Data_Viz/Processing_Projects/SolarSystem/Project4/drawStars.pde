// draw stars randomly throughout screen
// adapted from Processing - Creative Coding and Generative Art In Processing
void drawStars(int pointCount, float innerRadius, float outerRadius){
  float theta = 0.0;
  int vertCount = pointCount * 2;
  float thetaRot = TWO_PI/vertCount;
  float tempRadius = 0.0;
  float x, y;
  
  fill(255);
  pushMatrix();
  translate(random(width),random(height));
  beginShape();
  for (int i=0; i< pointCount; i++){
    for (int j=0; j < 2; j++){
      tempRadius = innerRadius;
      
      if (j%2==0){
        tempRadius = outerRadius;
      }
      
      x = cos(theta)*tempRadius;
      y = sin(theta)*tempRadius;
      vertex(x,y);
      theta += thetaRot;
    }  
  }
  
  endShape(CLOSE);
  popMatrix();
} // end star