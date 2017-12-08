// markers is an independent class that sets the bounds and axes for all visualizations
class Markers
{
  // dimensions of x and y axes:
  float minXPt, maxXPt, minYPt, maxYPt;
  // bounds of all visualizations:
  float xLBound = width*.2;
  float xUBound = width-width*.2;
  float yLBound = height*.2;
  float yUBound = height-height*.2;
  
  Markers(){}
 
 // get marks for double axis charts
  void getMarks(float minXPt, float maxXPt, float minYPt, float maxYPt)
  {
    this.minXPt = minXPt;
    this.maxXPt = maxXPt;
    this.minYPt = minYPt;
    this.maxYPt = maxYPt;
  }
    
  // get marks for single axis charts  
  void getMarks(float minYPt, float maxYPt)
  {
    this.minYPt = minYPt;
    this.maxYPt = maxYPt;
  }  
    
  void displayTitle(String title)
  {
    fill(0);
    stroke(0);
    textFont(font, 20);
    text(title, yLBound, yLBound-height*.075);
  }
  
  void displayMarkers(String title, Boolean multipleAxes)
   {
    fill(0);
    stroke(0);
    textFont(font, 12);
    
    if(multipleAxes)
    {
      for (float i = minXPt; i <= maxXPt + maxXPt*.1; i+= .2)
      {
       float x = map(i, minXPt, maxXPt, xLBound, xUBound);
       text(nf(i, 0, 1), x, xUBound+width*.04);
       line(x+width*.01, xUBound+width*.01, x+width*.01, xUBound);
      }
    }
    
    for (float i = minYPt; i <= maxYPt+maxYPt*.1; i++)
    {
     float y = map(i, minYPt, maxYPt, yUBound, yLBound);
     text(round(i), yLBound-height*.05, y);
     line(yLBound-height*.02, y-height*.005, yLBound-height*.03, y-height*.005);
    }
    textFont(font, 20);
    text(title, yLBound, yLBound-height*.075);
   }
}