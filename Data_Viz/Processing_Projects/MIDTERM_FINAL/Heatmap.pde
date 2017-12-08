// heatmap chart taking spaces to form a red to green heatmap across dimensions
class Heatmap extends Viz
{
  float rectSize = (xUBound - xLBound) / 4;
  ArrayList<Space> spaces = new ArrayList();
  
  
  Heatmap()
  {
    construct(spaces, "Competition_Rate_Per_10K_Exposures");
  }
  
  // allow user to create one-d heatmap
  Heatmap(String col1)
  {
    construct(spaces, col1);
  }
  

  void construct(ArrayList spaces, String column, String column2){}
  
  void construct(ArrayList spaces, String column)
  {
    float xSpacer = 0;
    float ySpacer = 0;
    float counter = 0;
    for (TableRow row : data.rows())
    {
      this.spaces.add(new Space(xLBound + xSpacer, yLBound + ySpacer, rectSize, rectSize, row.getFloat(column), row.getString("Sport")));
      xSpacer += rectSize;
      counter += 1;
      if(counter % 4 == 0)  
      {
        ySpacer += rectSize;
        xSpacer = 0;
      }
    }
  }
  
 void display()
  {
    for (int i = 0; i < spaces.size(); i++)
    {
      Space space = spaces.get(i);
      space.display();
      markers.displayTitle("Competition Concussion Rates Heatmap");
    }
  }
  
  void run()
  {
    display();
  }
  

  
}