// Bubble object as part of the scatterplot viz class
class Bubble extends ChartElement
{
  // fields
  float[] radius;
  
  // cstrs
  Bubble(){}
  
  // methods
  Bubble(float x, float y, color fillCol, float[] radius, String category, String[] measureLabels) // add in labels for sport to pass over to displayLabels() method
  {
    this.x = x;
    this.y = y;
    this.fillCol = fillCol;
    this.radius = radius;
    this.category = category;
    this.measureLabels = measureLabels;
  }
  
  void display()
  {
    if (dist(mouseX, mouseY, x, y) <= radius[0] * 2) {
      fill(150);
    } else {
      fill(fillCol, 200);
    }    
    ellipse(x, y, radius[0]*4, radius[0]*4);
    displayLabels();
  }
  
  void displayLabels()
   {
     if(dist(mouseX, mouseY, x, y) <= radius[0]*2)
     {
       textFont(e.fonts[0],12);
       String txt = category + "\n" + measureLabels[0] + ": " + nf(radius[0], 0, 2) + "\n" + measureLabels[1] + ": " + nfs(radius[1],0,2);
       Label label = new Label(txt, mouseX, mouseY);
       label.display();
     }
   }
}