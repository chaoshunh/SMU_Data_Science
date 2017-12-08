package com.smu.msds6390;

import processing.core.PApplet;

// Bubble object as part of the scatterplot viz class
class Bubble extends ChartElement
{
  // fields
  float[] radius;
  VizApplet applet;
  
  // cstrs
  Bubble(VizApplet applet){
	  this.applet = applet;
  }
  
  // methods
  Bubble(float x, float y, int fillCol, float[] radius, String category, String[] measureLabels, VizApplet applet) // add in labels for sport to pass over to displayLabels() method
  {
	this.applet = applet;
    this.x = x;
    this.y = y;
    this.fillCol = fillCol;
    this.radius = radius;
    this.category = category;
    this.measureLabels = measureLabels;
  }
  
  @Override
  public void display()
  {
    if (PApplet.dist(applet.mouseX, applet.mouseY, x, y) <= radius[0] * 2) {
      applet.fill(150);
    } else {
      applet.fill(fillCol, 200);
    }    
    applet.ellipse(x, y, radius[0]*4, radius[0]*4);
    displayLabels();
  }
  
  @Override
  public void displayLabels()
   {
     if(PApplet.dist(applet.mouseX, applet.mouseY, x, y) <= radius[0]*2)
     {
       applet.textFont(applet.e.fonts[0],12);
       String txt = category + "\n" + measureLabels[0] + ": " + PApplet.nf(radius[0], 0, 2) + "\n" + measureLabels[1] + ": " + PApplet.nfs(radius[1],0,2);
       Label label = new Label(txt, applet.mouseX, applet.mouseY, applet);
       label.display();
     }
   }
}