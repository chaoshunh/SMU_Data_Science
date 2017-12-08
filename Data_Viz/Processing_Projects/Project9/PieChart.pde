// piechart class taking slices across dimensions
class PieChart extends Markers implements Viz
{
  
  // fields
  ArrayList<Slice> slices = new ArrayList();
  float grandTotal = 0;
  float radius = width/4;
  color whiteColor = color(#FFFFFF);
  String chartName = "Pie Chart";
  String chartTitle = "";
  
  // cstrs
  PieChart(){}
  
  // methods
  void construct(Table data, String chartTitle, String measure, String measure2, String category)
    {println("not a valid constructor method for PieChart() void construct(Table data, String chartTitle, String measure, String category)");}
  
  void construct(Table data, String chartTitle, String measure, String category){
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
      color sColor = color(random(255), random(255), random(255));
      float angle = lastAngle + radians(ratio * 3.6);
      while(sColor == whiteColor)
      {
        sColor = color(random(255), random(255), random(255));
      }
      Slice slice = new Slice(width 
                              , height
                              , radius
                              , ratio 
                              , sColor 
                              , subCat 
                              , angle 
                              , lastAngle);
      slices.add(slice);
      lastAngle += radians(ratio * 3.6);
    }
  }
  
  void display(){
    for(Slice slice : slices)
    {
      slice.display();
      if(slice.isMouseInTheArc()) {
        slice.displayLabels();
      }
    }
    displayTitle(chartTitle);
  }
  
  String getChartName(){
    return chartName;
  } 
}