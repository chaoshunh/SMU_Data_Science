// markers is an independent class that sets the bounds and axes for all visualizations
class Markers
{
  // fields
  float numRows = e.getFile().retTable().getColumnCount();
  
  // dimensions of x and y axes:
  float minXPt, maxXPt, minYPt, maxYPt;
  // bounds of all visualizations:
  float xLBound = width*.2;
  float xUBound = width-xLBound;
  float yLBound = height*.2;
  float yUBound = height-yLBound;
  
  // cstrs
  Markers(){}
 
 
 // methods
 
 // get marks for double axis charts
  void getMarks(float minXPt, float maxXPt, float minYPt, float maxYPt)
  {
    this.maxYPt = maxYPt;
    this.minYPt = minYPt;
    this.minXPt = minXPt;
    this.maxXPt = maxXPt;
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
    textFont(e.fonts[0], 20);
    text(title, yLBound, yLBound-height*.075);
  }
  
  // assume y is default axis, allow boolean inclusion of x axis
  void displayMarkers(String title, Boolean multipleAxes)
   {
    fill(0);
    textFont(e.fonts[0],12);
    
    // if two axes, create X
    if(multipleAxes)
    {
      for (float i = minXPt; i <= maxXPt + (maxXPt *.01); i += (maxXPt - minXPt) / 10)
      {
       float x = map(i, minXPt, maxXPt, xLBound, xUBound);
       float textW = textWidth(nf(i,0,1));
       float textH = textAscent();
       text(nf(i,0,1), x, yUBound + textH * 4);
       line(x + textW/2, yUBound + textH * 1.5, x + textW/2, yUBound + textH);
      }
    }
    
    for (float i = minYPt; i <= maxYPt + (maxYPt * .01) ; i+= (maxYPt - minYPt) / 10)
    {
     float y = map(i, minYPt, maxYPt, yUBound, yLBound);
     float textH = textAscent();
     float textW = textWidth(nf(1, 5, 2));
     if(maxYPt > 1000000){text(nf(i/1000000, 0, 1), xLBound - textW, y); }
     else{text(nf(i,0,1), xLBound - textW, y);}
     line(xLBound - textH * 1.75, y-textH/2, yLBound-textH * 1.5, y - textH/2);
    }
    
    textFont(e.fonts[0], 20);
    
    if(maxYPt > 1000000){text(title + " in MM", yLBound, yLBound-height*.075);}
    else{text(title, yLBound, yLBound-height*.075);}
   }
}