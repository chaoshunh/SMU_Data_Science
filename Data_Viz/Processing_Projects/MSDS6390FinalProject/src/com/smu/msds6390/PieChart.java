package com.smu.msds6390;

import java.util.ArrayList;
import processing.data.TableRow;
import processing.data.Table;
import processing.core.*;

// piechart class taking slices across dimensions
class PieChart extends Markers implements Viz
{
  
  // fields
  ArrayList<Slice> slices = new ArrayList<>();
  float grandTotal = 0;
  float radius;
  int whiteColor = 0xFFFFFF;
  String chartName = "Pie Chart";
  String chartTitle = "";
  
  // cstrs
  PieChart(VizApplet applet){
	  super(applet);
	  radius = applet.width/4;
  }
  
  @Override
  public void construct(Table data, String chartTitle, String measure, String measure2, String category)
    {System.out.println("not a valid constructor method for PieChart() void construct(Table data, String chartTitle, String measure, String category)");}
  
  @Override
  public void construct(Table data, String chartTitle, String measure, String category){
    this.chartTitle = chartTitle;
    
    grandTotal = 0;
    slices.clear();
    
    for (TableRow row : data.rows())
    {
      grandTotal += row.getFloat(measure);
    }
    
    float lastAngle = 0;
    for (TableRow row : data.rows())
    {
      float ratio = (row.getFloat(measure) / grandTotal) * 100;
      String subCat = row.getString(category);
      int sColor = applet.color(applet.random(255), applet.random(255), applet.random(255));
      float angle = lastAngle + PApplet.radians(ratio * 3.6f);
      while(sColor == whiteColor)
      {
        sColor = applet.color(applet.random(255), applet.random(255), applet.random(255));
      }
      Slice slice = new Slice(applet
                              , radius
                              , ratio 
                              , sColor 
                              , subCat 
                              , angle 
                              , lastAngle);
      slices.add(slice);
      lastAngle += PApplet.radians(ratio * 3.6f);
    }
  }
  
  @Override
  public void display(){
    for(Slice slice : slices)
    {
      slice.display();
      if(slice.isMouseInTheArc()) {
        slice.displayLabels();
      }
    }
    displayTitle(chartTitle);
  }
  
  @Override
  public String getChartName(){
    return chartName;
  } 
}