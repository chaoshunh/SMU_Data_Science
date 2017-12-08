// heatmap chart taking spaces to form a red to green heatmap across dimensions
class Heatmap extends Markers implements Viz
{
  // fields
    // rectSize now adjusts for bounds of screen, no longer hard coded
  float rectSize = floor(sqrt(((xUBound - xLBound) * (yUBound - yLBound)) / (e.getFile().retTable().getRowCount())));
  ArrayList<Space> spaces = new ArrayList();
  String chartName = "Heat Map";
  String chartTitle = "";
  
  // cstrs
  Heatmap(){}
  
  //  methods

  void construct(Table data, String chartTitle, String measure, String measure2, String category)
    {println("not a valid construct method for HeatMap() void construct(Table data, String chartTitle, String measure, String category)");}
  
  void construct(Table data, String chartTitle, String measure, String category)
  {
    this.chartTitle = chartTitle;
    float xSpacer = 0;
    float ySpacer = 0;
    float counter = 0;
    spaces.clear();
    data.setColumnType(measure, Table.FLOAT);
    data.sortReverse(measure);
    
    for (TableRow row : data.rows())
    {
      // Space(float x, float y, float w, float h, float measure, String measureLabel, String category)
      this.spaces.add(new Space(xLBound + xSpacer
                                , yLBound + ySpacer
                                , rectSize 
                                , rectSize 
                                , row.getFloat(measure)
                                , measure
                                , row.getString(category)));
      xSpacer += rectSize;
      counter += 1;
      if(counter % 5 == 0)  
      {
        ySpacer += rectSize;
        xSpacer = 0;
      }
    }
  }
  
  void display()
  {
    Space space;
    for (int i = 0; i < spaces.size(); i++)
    {
      space = spaces.get(i);
      space.display();
    }
    displayTitle(chartTitle);
  }
  
  String getChartName(){
    return chartName;
  }
  
}