// Label creates labels for each object in the visualization
class Label
{
  float x, y;
  String txt;

  Label()
  {
  }
  
  Label(String txt, float x, float y)
  {
    this.txt = txt;
    this.x = x;
    this.y = y;
    
    float labelW = textWidth(this.txt);
    
    if(this.x + labelW + 20 > width)
    {
      this.x -= labelW + 20;
    }
    
    fill(255,0);
    noStroke();
    rect(this.x+10, this.y-30, labelW + 10, 22);  
  }
  
  void display()
  {
    fill(0);
    text(txt, this.x+15, this.y-15);
  }  
}