void curveCircle(int pts, float radius, float tightness, color fillColor)
{
  float theta = 0;
  float cx = 0, cy = 0;
  float ax = 0, ay = 0;
  float rot = TWO_PI/pts;
  
  curveTightness(tightness);
  beginShape();
  for(int i = 0; i < pts; i++)
    {
      if (i == 0)
      {
        cx = cos(theta-rot)*radius;
        cy = sin(theta-rot)*radius;
        ax = cos(theta)*radius;
        ay = sin(theta)*radius;
        curveVertex(cx,cy);
        curveVertex(ax, ay);
      }
      else
      {
        ax = cos(theta)*radius;
        ay = sin(theta)*radius;
        curveVertex(ax, ay);
      }
      if (i == pts-1)
      {
        cx = cos(theta+rot)*radius;
        cy = sin(theta+rot)*radius;
        ax = cos(theta + rot*2)*radius;
        ay = sin(theta + rot*2)*radius;
        curveVertex(cx,cy);
        curveVertex(ax, ay);
      }
      
      theta += rot;
    }
    if (red(fillColor) > 100)
      {
      fill(random(250,255),0,0,random(4,8));
      }
      else
      {
      fill(0,0,random(250,255),random(4,8));
      }
      
    noStroke();
    endShape();
}
