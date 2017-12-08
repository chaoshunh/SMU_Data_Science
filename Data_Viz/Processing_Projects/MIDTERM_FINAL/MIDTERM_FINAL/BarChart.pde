class BarChart extends Viz
{
  float barSpace = (xUBound - xLBound) / data.getRowCount();
  ArrayList<Bar> bars = new ArrayList();
  
  BarChart()
  {
    construct(bars, "Competition_Rate_Per_10K_Exposures");
  }
  
  // allow user to create own barchart
  BarChart(String col1)
  {
    construct(bars, col1);
  }
  
  void construct(ArrayList bars, String column, String column2){}
  
  void construct(ArrayList bars, String column)
  {
    float[] yPos = new float[data.getRowCount()];
    int counter = 0;
    for (TableRow row : data.rows())
    {
      yPos[counter] = row.getFloat(column);
      counter++;
    }
    
    this.minYPt = min(yPos);
    this.maxYPt = max(yPos);
    float spacer = 0;
    
    for (TableRow row : data.rows())
    {
      float hPos = row.getFloat(column);
      h = map(row.getFloat(column), minYPt, maxYPt, yLBound, yUBound-yLBound);
      bars.add(new Bar(xLBound+spacer, yUBound, width*.025, h, hPos, color(random(255), random(255), random(255)), row.getString("Sport")));
      spacer += barSpace*1.25;
    }
    markers.getMarks(minYPt, maxYPt);
  }
  
  void display()
  {
   for (int i = 0; i < bars.size(); i++)
    {
      Bar bar = bars.get(i);
      bar.display();
      bar.displayLabels();
      markers.displayMarkers("Concussion Rates by Sport", false); 
    }
  }
  
 void run()
  {
    display();
  }
}