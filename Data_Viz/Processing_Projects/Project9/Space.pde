// space is a chart element used to create "Spaces" or squares in the heatmap
class Space extends ChartElement
{ 
  // fields
  float colorScale;
  float _minCol, _maxCol;
  
  // cstrs
  Space(){}
  
  Space(float x, float y, float w, float h, float colorScale, String measureLabel, String category)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.colorScale = colorScale;
    this.measureLabel = measureLabel;
    this.category = category;
    this._minCol = min(e.getFile().retTable().getFloatColumn(measureLabel));
    this._maxCol = max(e.getFile().retTable().getFloatColumn(measureLabel));
  }
  
  // methods
  void display()
  {
    if(dist(mouseX, mouseY, (x+w/2), (y+h/2)) < h/2)
    {
      fill(255);
    } else {
      
      
      fill(color(map(colorScale, _minCol, _maxCol, 0, 255),
                 map(colorScale, _minCol, _maxCol, 255, 0), 0), 150);
    }    
    rect(x, y, w, h);
    displayLabels();
  }
  
   void displayLabels()
   {
     if(dist(mouseX, mouseY, (x+w/2), (y+h/2)) < h/2)
     {
       textFont(e.fonts[0], 12);
       String txt = category + "\n" + nf(colorScale, 0, 2);
       Label label = new Label(txt, mouseX, mouseY);
       label.display();
     }
   }
  
}