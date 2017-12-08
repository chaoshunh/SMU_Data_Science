package com.smu.msds6390;

// Label creates labels for each object in the visualization
class Label
{
  // fields
  float x, y;
  String txt;
  VizApplet applet;
  // cstrs
  Label(VizApplet applet){
	  this.applet = applet;
  }
  
  Label(String txt, float x, float y, VizApplet applet)
  {
	this.applet = applet;
    this.txt = txt;
    this.x = x;
    this.y = y;
    
    float labelW = applet.textWidth(this.txt);
    
    if(this.x + labelW + applet.width*.025 > applet.width)
    {
      this.x -= labelW + applet.width*.025;
    }
  }
  
  //  methods
  void display()
  {
    applet.fill(0);
    applet.text(txt, this.x + applet.width*.01f, this.y - applet.height*.005f);
  }  
}