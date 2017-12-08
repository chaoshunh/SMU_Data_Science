package com.smu.msds6390;

import processing.core.PApplet;
import processing.data.Table;
import processing.data.TableRow;

import java.util.ArrayList;

class BarChart extends Markers implements Viz
{
  // fields - barcharts need uniform space b/w bars, and height driven by and mapped to a measure
  float h, barSpace;
  ArrayList<Bar> bars = new ArrayList<>();
  String chartName = "Bar Chart";
  String chartTitle = "";
  
  //cstrs
  BarChart(VizApplet applet){
	  super(applet);
  }
  
  // methods
  @Override
  public void construct(Table data, String chartTitle, String measure, String measure2, String category)
    {System.out.println("not a valid construct method for BarChart(): void construct(Table data, String chartTitle, String measure, String category)");}
  
  @Override
  public void construct(Table data, String chartTitle, String measure, String category)
  {
    this.chartTitle = chartTitle;
    data.setColumnType(measure, Table.FLOAT);
    data.sortReverse(measure);
    float[] yPos = new float[data.getRowCount()];
    int counter = 0;
    bars.clear();
    // establish bar spacing between visual boundaries
    barSpace = (xUBound - xLBound) / data.getRowCount();
    
    for (TableRow row : data.rows())
    {
      yPos[counter] = row.getFloat(measure);
      counter++;
    }
    
    this.minYPt = PApplet.min(yPos);
    this.maxYPt = PApplet.max(yPos);
    float spacer = 0;

    for (TableRow row : data.rows())
    {
      float hLabel = row.getFloat(measure);
      h = PApplet.map(row.getFloat(measure), minYPt, maxYPt, yLBound, yUBound-yLBound);
      bars.add(new Bar(  xLBound+spacer 
                       , yUBound 
                       , (yUBound - yLBound)/data.getRowCount() 
                       , h 
                       , hLabel 
                       , applet.color(applet.random(255), applet.random(255), applet.random(255))
                       , row.getString(category)
                       , measure, applet));
      // increment spaces between bars with barSpace
      spacer += barSpace;
      getMarks(minYPt, maxYPt);
    }
  }
  
  @Override
  public void display()
  {
   for (int i = 0; i < bars.size(); i++)
    {
      Bar bar = bars.get(i);
      bar.display();
      bar.displayLabels(); 
    }
    displayMarkers(chartTitle, false);
  }
  
  @Override
  public String getChartName(){
    return chartName;
  } 
}