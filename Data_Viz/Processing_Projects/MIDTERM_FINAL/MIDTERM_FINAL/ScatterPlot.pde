// this class creates a ScatterPlot with Bubbles based on rates of concussions for competition vs practice
class ScatterPlot extends Viz
{
  ArrayList<Bubble> bubbles = new ArrayList();

  ScatterPlot()
  {
    // create the bubbles
    construct(bubbles, "Competition_Rate_Per_10K_Exposures", "Practice_Rate_Per_10K_Exposures");
  }
  
  // allow user to create own scatterplot
  ScatterPlot(String col1, String col2)
  {
    construct(bubbles, col1, col2);
  }
  
  void construct(ArrayList bubbles, String column){}
  
  void construct(ArrayList bubbles, String column, String column2)
  {
    float[] xPos = new float[data.getRowCount()];
    float[] yPos = new float[data.getRowCount()];
    int counter = 0;
    
    for (TableRow row : data.rows())
    {
      yPos[counter] = row.getFloat(column);
      xPos[counter] = row.getFloat(column2);
      counter++;
    }
    
    this.minXPt = min(xPos);
    this.maxXPt = max(xPos);
    this.minYPt = min(yPos);
    this.maxYPt = max(yPos);
    counter = 0;
    
    for (TableRow row : data.rows())
    {
      float[] cols = {row.getFloat(column), row.getFloat(column2)};
      this.bubbles.add(new Bubble(map(xPos[counter], minXPt, maxXPt, xLBound, xUBound), 
                             map(yPos[counter], minYPt, maxYPt, yUBound, yLBound), 
                             color(random(255), random(255), random(255)),
                             cols, row.getString("Sport")));
      counter++;
    }
    // establish the markers object for the scatterPlot based on bounds, data:
    markers.getMarks(minXPt, maxXPt, minYPt, maxYPt);
  }
 
 void display()
  {
    for (int i = 0; i < bubbles.size(); i++)
    {
      Bubble bubble = bubbles.get(i);
      bubble.display();
      markers.displayMarkers("Concussion Rates: Practice (X-Axis) vs Competition (Y-Axis)", true);
    }
  }
  
  void run()
  {
    display();
  } 
}