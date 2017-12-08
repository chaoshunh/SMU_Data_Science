package com.smu.msds6390;

import processing.core.*; 
import controlP5.ControlEvent;; 

public class VizApplet extends PApplet {

// MSDS 6390 - Final Project
// Shazia Zaman and Cory Nichols

public Engine e;
public int arrayIndex = 0;

public void setup()
{ 
  e = new Engine(this);
  e.run();
}

public void draw()
{
  background(255);
  e.showBackground();
  e.vizArray.get(arrayIndex).display();
}

// Control function handles switching between visualizations
public void controlEvent(ControlEvent theEvent) {
  if(theEvent.isFrom(e.controlBar.radioButton)) {
    for(int i=0; i < theEvent.getGroup().getArrayValue().length;i++) {
        int value = PApplet.parseInt(theEvent.getGroup().getArrayValue()[i]);
        if(value > 0) 
        {
          arrayIndex = i;
         }
      }
    }
  }

public void settings() {  
	size(800, 800); 
}

static public void main(String[] passedArgs) {
	PApplet.main(new String[] {"com.smu.msds6390.VizApplet"});
  }
}
