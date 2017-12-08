// piechart class taking slices across dimensions
class PieChart extends Viz
{
  ArrayList<Slice> slices = new ArrayList();
  float grandTotal = 0;
  float radius = width/4;
  color whiteColor = color(#FFFFFF);
  PieChart()
  {
    construct(this.slices, "Concussion_Totals");
  }
  
 
  void construct(ArrayList array, String column, String column2){
  }
  
  void construct(ArrayList array, String column){
    
    for (TableRow row : data.rows())
    {
      grandTotal += row.getFloat(column);
    }
    
    float lastAngle = 0;
    for (TableRow row : data.rows())
    {
      float ratio = (row.getFloat(column) / grandTotal) * 100;
      String category = row.getString("Sport");
      color sColor = color(random(255), random(255), random(255));
      float angle = lastAngle + radians(ratio * 3.6);
      while(sColor == whiteColor)
      {
        sColor = color(random(255), random(255), random(255));
      }
      Slice slice = new Slice(width,height,radius,ratio, sColor, category, angle, lastAngle);
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
    markers.displayTitle("Concussion Ratio Per Team vs Total Concussions");
  }
  
  void run(){
    display();
  }
}