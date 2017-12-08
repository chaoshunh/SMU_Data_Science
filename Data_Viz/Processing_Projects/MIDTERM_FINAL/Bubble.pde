// Bubble object as part of the scatterplot viz class
class Bubble extends ChartElement
{
  float[] radius;
  
  Bubble()
  {
  }
  
  Bubble(float x, float y, color fillCol, float[] radius, String category) // add in labels for sport to pass over to displayLabels() method
  {
    this.x = x;
    this.y = y;
    this.fillCol = fillCol;
    this.radius = radius;
    this.category = category;
  }
  
  void display()
  {
    if (dist(mouseX, mouseY, x, y) <= radius[0] * 2) {
      fill(0);
    } else {
      fill(fillCol);
    }    
    noStroke();
    ellipse(x, y, radius[0]*4, radius[0]*4);
    displayLabels();
  }
  
  void displayLabels()
   {
     if(dist(mouseX, mouseY, x, y) <= radius[0]*2)
     {
       textFont(font,12);
       String txt = category + "\nComp Rate/10K: " + nf(radius[0], 0, 2) + " -- Practice Rate/10K: " + nfs(radius[1],0,2);
       Label label = new Label(txt, mouseX, mouseY);
       label.display();
     }
   }
}