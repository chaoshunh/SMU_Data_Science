package com.smu.msds6390;

import java.util.ArrayList;

import processing.core.PApplet;
import processing.data.Table;
import processing.data.TableRow;

// this class creates a ScatterPlot with Bubbles based on rates of concussions for competition vs practice
class ScatterPlot extends Markers implements Viz
{
  // frields
  ArrayList<Bubble> bubbles = new ArrayList<>();
  String chartName = "Scatter Plot";
  String chartTitle = "";
  
  // cstrs
  ScatterPlot(VizApplet applet){
	  super(applet);
  }
  
  // methods
  @Override
  public void construct(Table data, String chartTitle, String measure, String category)
    {System.out.println("not a valid construct method for ScatterPlot() void construct(Table data, String chartTitle, String measure, String measure2, String category)");}
  
  @Override
  public void construct(Table data, String chartTitle, String measure, String measure2, String category)
  {
    this.chartTitle = chartTitle;
    data.setColumnType(measure, Table.FLOAT);
    data.sortReverse(measure);
    float[] xPos = new float[data.getRowCount()];
    float[] yPos = new float[data.getRowCount()];
    int counter = 0;
    bubbles.clear();
    for (TableRow row : data.rows())
    {
      yPos[counter] = row.getFloat(measure);
      xPos[counter] = row.getFloat(measure2);
      counter++;
    }
    
    this.minXPt = PApplet.min(xPos);
    this.maxXPt = PApplet.max(xPos);
    this.minYPt = PApplet.min(yPos);
    this.maxYPt = PApplet.max(yPos);
    counter = 0;
   
    String[] measureLabels = {applet.e.getFile().retTable().getColumnTitle(applet.e.getFile().retTable().getColumnIndex(measure)), 
                              applet.e.getFile().retTable().getColumnTitle(applet.e.getFile().retTable().getColumnIndex(measure2))};
    
    for (TableRow row : data.rows())
    {
      float[] cols = {row.getFloat(measure), row.getFloat(measure2)};
      this.bubbles.add(new Bubble(PApplet.map(xPos[counter], minXPt, maxXPt, xLBound, xUBound) 
                                  , PApplet.map(yPos[counter], minYPt, maxYPt, yUBound, yLBound) 
                                  , applet.color(applet.random(255), applet.random(255), applet.random(255))
                                  , cols 
                                  , row.getString(category)
                                  , measureLabels, applet));
      counter++;
    }
    // establish the markers object for the scatterPlot based on bounds, data:
    getMarks(minXPt, maxXPt, minYPt, maxYPt);
  }
 
  @Override
  public void display()
  {
    for (int i = 0; i < bubbles.size(); i++)
    {
      Bubble bubble = bubbles.get(i);
      bubble.display();
    }
    displayMarkers(chartTitle, true);
  }
  
  @Override
  public String getChartName(){
    return chartName;
  }
  
}