// Bar object as part of the BarChart viz class
class Bar extends ChartElement
{
  float w, h, hPos;
  
  Bar()
  {
  }
  
  // bars.add(new Bar(xLBound+spacer, xUBound, 15, col, color(random(255), random(255), random(255))));
  Bar(float x, float y, float w, float h, float hPos, color fillCol, String category)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.hPos = hPos;
    this.fillCol = fillCol;
    this.category = category;
  }
  
  void display()
  {
    if (dist(mouseX, mouseY, x+w, y-h) <= w) 
    {
      fill(0);
    } else {
      fill(fillCol);
    }    
    noStroke();
    rect(x, y, w, -h);
  }
 
   void displayLabels()
   {
     if(dist(mouseX, mouseY, x+w, y-h) <= w)
     {
       textFont(font,12);
       String txt = "Comp Rate/10K: \n" + category + "\n" + nf(hPos, 0, 2);
       Label label = new Label(txt, mouseX, mouseY-height*.05);
       label.display();
     }
   }

}