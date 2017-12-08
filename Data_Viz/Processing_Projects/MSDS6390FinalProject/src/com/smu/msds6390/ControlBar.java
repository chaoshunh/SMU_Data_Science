package com.smu.msds6390;

import controlP5.*;

import java.util.ArrayList;

// ControlBar sets the GUI on the dashboard to switch between visualizations
// engine passes to ControlBar to initialize menu
class ControlBar
{  
  ControlP5 cp5;
  public RadioButton radioButton;
  int radioButtonCount = 0;
  VizApplet applet;
  
  //cstrs
  ControlBar(VizApplet applet){
	  this.applet = applet;
  }
  
  ControlBar(ControlP5 cp5, ArrayList<String> radioButtonNames, VizApplet applet) {
	this.applet = applet;
    this.cp5 = cp5;
    radioButtonCount = radioButtonNames.size();
    createRadioButton(radioButtonNames);
  }

  // methods
  void createRadioButton(ArrayList<String> radioButtonNames)
  {
    radioButton = cp5.addRadioButton("radioButton")
      .setPosition(applet.width*.22f, applet.height*.02f)
      .setSize((int)(applet.width*.05), (int)(applet.height*.05))
      .setSpacingColumn((int)(applet.width*.12))
      .setColorLabel(applet.color(0x0A0101))
      .setColorForeground(applet.color(120))
      .setItemsPerRow(radioButtonNames.size());
      
    int index = 0;
    for(String name: radioButtonNames)
    {
      radioButton.addItem(name, ++index);
    }
 
    for (Toggle t : radioButton.getItems()) {
      t.getCaptionLabel().setColorBackground(applet.color(255, 80));
      t.getCaptionLabel().getStyle().moveMargin(-7, 0, 0, -3);
      t.getCaptionLabel().getStyle().movePadding(7, 0, 0, 3);
      t.getCaptionLabel().getStyle().backgroundWidth = 45;
      t.getCaptionLabel().getStyle().backgroundHeight = 13;
    }
  }

  public void activateRadioButton(char radioKey)
  {
    int keyValue = Character.getNumericValue(radioKey);
    if(keyValue == 0 || keyValue > radioButtonCount) {
      radioButton.deactivateAll();
    }
    else 
    {
      radioButton.activate(keyValue-1);
    }
  }
}