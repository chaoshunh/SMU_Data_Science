package com.smu.msds6390;

import processing.core.PApplet;

// markers is an independent class that sets the bounds and axes for all visualizations
class Markers
{
  // fields
  float numRows;
  
  // dimensions of x and y axes:
  float minXPt, maxXPt, minYPt, maxYPt;
  // bounds of all visualizations:
  float xLBound;
  float xUBound;
  float yLBound;
  float yUBound;
  
  VizApplet applet;
  
  // cstrs
  Markers(VizApplet applet){
	  this.applet = applet;
	  numRows = applet.e.getFile().retTable().getColumnCount();
	  xLBound = applet.width * .2f;
	  xUBound = applet.width - xLBound;
	  yLBound = applet.height * .2f;
	  yUBound = applet.height - yLBound;
  }
 
 
 // methods
 
 // get marks for double axis charts
  public void getMarks(float minXPt, float maxXPt, float minYPt, float maxYPt)
  {
    this.maxYPt = maxYPt;
    this.minYPt = minYPt;
    this.minXPt = minXPt;
    this.maxXPt = maxXPt;
  }
    
  // get marks for single axis charts  
  public void getMarks(float minYPt, float maxYPt)
  {
    this.minYPt = minYPt;
    this.maxYPt = maxYPt;
  }  
    
  public void displayTitle(String title)
  {
    applet.fill(0);
    applet.textFont(applet.e.fonts[0], 20);
    applet.text(title, yLBound, yLBound-applet.height*.075f);
  }
  
  // assume y is default axis, allow boolean inclusion of x axis
  public void displayMarkers(String title, Boolean multipleAxes)
   {
    applet.fill(0);
    applet.textFont(applet.e.fonts[0],12);
    
    // if two axes, create X
    if(multipleAxes)
    {
      for (float i = minXPt; i <= maxXPt + (maxXPt *.01); i += (maxXPt - minXPt) / 10)
      {
       float x = PApplet.map(i, minXPt, maxXPt, xLBound, xUBound);
       float textW = applet.textWidth(PApplet.nf(i,0,1));
       float textH = applet.textAscent();
       applet.text(PApplet.nf(i,0,1), x, yUBound + textH * 4);
       applet.line(x + textW/2, yUBound + textH * 1.5f, x + textW/2, yUBound + textH);
      }
    }
    
    for (float i = minYPt; i <= maxYPt + (maxYPt * .01) ; i+= (maxYPt - minYPt) / 10)
    {
     float y = PApplet.map(i, minYPt, maxYPt, yUBound, yLBound);
     float textH = applet.textAscent();
     float textW = applet.textWidth(PApplet.nf(1, 5, 2));
     if(maxYPt > 1000000){applet.text(PApplet.nf(i/1000000, 0, 1), xLBound - textW, y); }
     else{applet.text(PApplet.nf(i,0,1), xLBound - textW, y);}
     applet.line(xLBound - textH * 1.75f, y-textH/2, yLBound- textH * 1.5f, y - textH/2);
    }
    
    applet.textFont(applet.e.fonts[0], 20);
    
    if(maxYPt > 1000000){applet.text(title + " in MM", yLBound, yLBound- applet.height*.075f);}
    else{applet.text(title, yLBound, yLBound- applet.height*.075f);}
   }
}