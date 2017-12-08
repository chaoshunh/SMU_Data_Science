// Bar object as part of the BarChart viz class
class Bar extends ChartElement
{
  float hLabel; // grab actual #'s instead of mapped totals
  
  // cstrs
  Bar(){}
  
  Bar(float x, float y, float w, float h, float hLabel, color fillCol, String category, String measureLabel)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.hLabel = hLabel;
    this.fillCol = fillCol;
    this.category = category;
    this.measureLabel = measureLabel;
  }
  
  // methods
  void display()
  {
    if(mouseX < this.x + this.w && mouseX > this.x && mouseY > this.y-this.h && mouseY < this.y) 
    {
      fill(150);
    } else {
      fill(fillCol, 175);
    }    
    stroke(0.5);
    rect(x, y, w, -h);
    noStroke();
  }
 
   void displayLabels()
   {
     
     if(mouseX < this.x + this.w && mouseX > this.x && mouseY > this.y-this.h && mouseY < this.y)
     {
       textFont(e.fonts[0], 12);
       String txt = measureLabel + "\n" + category + "\n" + nf(hLabel, 0, 2);
       Label label = new Label(txt, mouseX, mouseY-height*.05);
       label.display();
     }
   }

}