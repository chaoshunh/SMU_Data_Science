package com.smu.msds6390;

import processing.core.PApplet;

// space is a chart element used to create "Spaces" or squares in the heatmap
class Space extends ChartElement
{ 
  // fields
  float colorScale;
  float _minCol, _maxCol;
  VizApplet applet;
  
  // cstrs
  Space(VizApplet applet){
	  this.applet = applet;
  }
  
  Space(float x, float y, float w, float h, float colorScale, String measureLabel, String category, VizApplet applet)
  {
	this.applet = applet;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.colorScale = colorScale;
    this.measureLabel = measureLabel;
    this.category = category;
    this._minCol = PApplet.min(applet.e.getFile().retTable().getFloatColumn(measureLabel));
    this._maxCol = PApplet.max(applet.e.getFile().retTable().getFloatColumn(measureLabel));
  }
  
  // methods
  void display()
  {
    if(PApplet.dist(applet.mouseX, applet.mouseY, (x+w/2), (y+h/2)) < h/2)
    {
      applet.fill(255);
    } else {
      
      
      applet.fill(applet.color(PApplet.map(colorScale, _minCol, _maxCol, 0, 255),
                 PApplet.map(colorScale, _minCol, _maxCol, 255, 0), 0), 150);
    }    
    applet.rect(x, y, w, h);
    displayLabels();
  }
  
   void displayLabels()
   {
     if(PApplet.dist(applet.mouseX, applet.mouseY, (x+w/2), (y+h/2)) < h/2)
     {
       applet.textFont(applet.e.fonts[0], 12);
       String txt = category + "\n" + PApplet.nf(colorScale, 0, 2);
       Label label = new Label(txt, applet.mouseX, applet.mouseY, applet);
       label.display();
     }
   }
  
}