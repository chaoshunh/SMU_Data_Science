// Label creates labels for each object in the visualization
class Label
{
  // fields
  float x, y;
  String txt;

  // cstrs
  Label(){}
  
  Label(String txt, float x, float y)
  {
    this.txt = txt;
    this.x = x;
    this.y = y;
    
    float labelW = textWidth(this.txt);
    
    if(this.x + labelW + width*.025 > width)
    {
      this.x -= labelW + width*.025;
    }
  }
  
  //  methods
  void display()
  {
    fill(0);
    text(txt, this.x+width*.01, this.y-height*.005);
  }  
}