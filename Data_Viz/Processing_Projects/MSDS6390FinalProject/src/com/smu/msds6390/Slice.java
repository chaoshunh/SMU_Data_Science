package com.smu.msds6390;

import processing.core.PApplet;

// slice object as part of the piechart viz class
class Slice extends ChartElement {
  // fields
  float ratio = 0;
  float radius = 0;
  float angle = 0;
  float lastAngle = 0;
  VizApplet applet;
  
  // cstrs
  Slice(){}
  
  Slice(VizApplet applet, float radiusValue, float ratioValue, int sColor, String sCategory, float sAngle, float sLastAngle)
  {
	 this.applet = applet;
     x = applet.width;
     y = applet.height;
     ratio = ratioValue;
     radius = radiusValue;
     fillCol = sColor;
     category = sCategory;
     angle = sAngle;
     lastAngle = sLastAngle;
  }
  
  // methods
  void display(){
    applet.fill(fillCol, 150);
    applet.arc(x/2, y/2, 2*radius, 2*radius, lastAngle, angle);
  }
 
  void displayLabels(){
       applet.textFont(applet.e.fonts[0], 12);
       String txt = "Percentage " + category + " : " + PApplet.nf(ratio, 0, 2) + "%";
       Label label = new Label(txt, applet.mouseX, applet.mouseY, applet);
       label.display();
   }
   
   boolean isMouseInTheArc()
   {
     boolean flag = false;
     boolean flag2 = false;
     float actualRadius = PApplet.sqrt(PApplet.sq(applet.mouseX - x/2) + PApplet.sq(applet.mouseY - y/2));
     if ( actualRadius <= radius){
         flag = true;
     } 
     
     float mouseAngle = PApplet.acos((applet.mouseX- x/2)/actualRadius);
     float mouseYAngle = PApplet.asin((applet.mouseY- y/2)/actualRadius);
     if(mouseYAngle < 0)
     {
        mouseAngle = mouseAngle + PApplet.PI; 
     }
     
     if( mouseAngle >= lastAngle && mouseAngle <= angle){
       
       //System.out.println("category: " + category + " | mouseAngle: " + mouseAngle 
       //+ " | mouseYAngle: " + mouseYAngle + " | angle: " + angle 
       //+ " | lastAngle: " + lastAngle
       //+ " | radius : " + radius + " | actualRadius: " + actualRadius);
       
       flag2 = true;
     }

     return flag && flag2;
     
   }
}