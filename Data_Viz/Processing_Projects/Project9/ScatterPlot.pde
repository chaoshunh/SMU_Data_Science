// this class creates a ScatterPlot with Bubbles based on rates of concussions for competition vs practice
class ScatterPlot extends Markers implements Viz
{
  // frields
  ArrayList<Bubble> bubbles = new ArrayList();
  String chartName = "Scatter Plot";
  String chartTitle = "";
  
  // cstrs
  ScatterPlot(){}
  
  // methods
  void construct(Table data, String chartTitle, String measure, String category)
    {println("not a valid construct method for ScatterPlot() void construct(Table data, String chartTitle, String measure, String measure2, String category)");}
  
  void construct(Table data, String chartTitle, String measure, String measure2, String category)
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
    
    this.minXPt = min(xPos);
    this.maxXPt = max(xPos);
    this.minYPt = min(yPos);
    this.maxYPt = max(yPos);
    counter = 0;
   
    String[] measureLabels = {e.getFile().retTable().getColumnTitle(e.getFile().retTable().getColumnIndex(measure)), 
                              e.getFile().retTable().getColumnTitle(e.getFile().retTable().getColumnIndex(measure2))};
    
    for (TableRow row : data.rows())
    {
      float[] cols = {row.getFloat(measure), row.getFloat(measure2)};
      this.bubbles.add(new Bubble(map(xPos[counter], minXPt, maxXPt, xLBound, xUBound) 
                                  , map(yPos[counter], minYPt, maxYPt, yUBound, yLBound) 
                                  , color(random(255), random(255), random(255))
                                  , cols 
                                  , row.getString(category)
                                  , measureLabels));
      counter++;
    }
    // establish the markers object for the scatterPlot based on bounds, data:
    getMarks(minXPt, maxXPt, minYPt, maxYPt);
  }
 
 void display()
  {
    for (int i = 0; i < bubbles.size(); i++)
    {
      Bubble bubble = bubbles.get(i);
      bubble.display();
    }
    displayMarkers(chartTitle, true);
  }
  
  String getChartName(){
    return chartName;
  }
  
}