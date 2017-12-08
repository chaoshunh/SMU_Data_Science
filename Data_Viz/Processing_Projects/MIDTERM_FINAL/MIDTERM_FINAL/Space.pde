// space is a chart element used to create "Spaces" or squares in the heatmap
class Space extends ChartElement
{ 
  float w, h;
  
  Space()
  {
  }
  
  Space(float x, float y, float w, float h, float data, String category)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.data = data;
    this.category = category;
  }
  
  void display()
  {
    if(dist(mouseX, mouseY, (x+w/2), (y+h/2)) < h/2)
    {
      fill(255);
    } else {
      fill(color(map(data, 0, 23, 0, 255), map(data,0, 23, 255, 0), 0));
    }    
    noStroke();
    rect(x, y, w, h);
    displayLabels();
  }
  
     void displayLabels()
   {
     if(dist(mouseX, mouseY, (x+w/2), (y+h/2)) < h/2)
     {
       textFont(font,12);
       String txt = "Comp Rate/10K: \n" + category + "\n" + nf(data, 0, 2);
       Label label = new Label(txt, mouseX, mouseY);
       label.display();
     }
   }
  
}