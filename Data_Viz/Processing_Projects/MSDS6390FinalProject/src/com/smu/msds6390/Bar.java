package com.smu.msds6390;

import processing.core.PApplet;

// Bar object as part of the BarChart viz class
class Bar extends ChartElement
{
  float hLabel; // grab actual #'s instead of mapped totals
  VizApplet applet;
  
  // cstrs
  Bar(VizApplet applet){
	  this.applet = applet;
  }
  
  Bar(float x, float y, float w, float h, float hLabel, int fillCol, String category, String measureLabel, VizApplet applet)
  {
	this.applet = applet;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.hLabel = hLabel;
    this.fillCol = fillCol;
    this.category = category;
    this.measureLabel = measureLabel;
  }
  
  // methods
  @Override
  public void display()
  {
    if(applet.mouseX < this.x + this.w && applet.mouseX > this.x && applet.mouseY > this.y-this.h && applet.mouseY < this.y) 
    {
      applet.fill(150);
    } else {
      applet.fill(fillCol, 175);
    }    
//    applet.stroke(0);
    applet.rect(x, y, w, -h);
    applet.noStroke();
  }
 
  @Override
   public void displayLabels()
   {
     
     if(applet.mouseX < this.x + this.w && applet.mouseX > this.x && applet.mouseY > this.y-this.h && applet.mouseY < this.y)
     {
       applet.textFont(applet.e.fonts[0], 12);
       String txt = measureLabel + "\n" + category + "\n" + PApplet.nf(hLabel, 0, 2);
       Label label = new Label(txt, applet.mouseX, applet.mouseY-(int)(applet.height*.05), applet);
       label.display();
     }
   }

}