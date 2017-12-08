// slice object as part of the piechart viz class
class Slice extends ChartElement {
  // fields
  float ratio = 0;
  float radius = 0;
  float angle = 0;
  float lastAngle = 0;
  
  // cstrs
  Slice(){}
  
  Slice(float xVal, float yVal, float radiusValue, float ratioValue, color sColor, String sCategory, float sAngle, float sLastAngle)
  {
     x = xVal;
     y = yVal;
     ratio = ratioValue;
     radius = radiusValue;
     fillCol = sColor;
     category = sCategory;
     angle = sAngle;
     lastAngle = sLastAngle;
  }
  
  // methods
  void display(){
    fill(fillCol, 150);
    arc(x/2, y/2, 2*radius, 2*radius, lastAngle, angle);
  }
 
  void displayLabels(){
       textFont(e.fonts[0], 12);
       String txt = "Percentage " + category + " : " + nf(ratio, 0, 2) + "%";
       Label label = new Label(txt, mouseX, mouseY);
       label.display();
   }
   
   boolean isMouseInTheArc()
   {
     boolean flag = false;
     boolean flag2 = false;
     float actualRadius = sqrt(sq(mouseX - x/2) + sq(mouseY - y/2));
     if ( actualRadius <= radius){
         flag = true;
     } 
     
     float mouseAngle = acos((mouseX- x/2)/actualRadius);
     float mouseYAngle = asin((mouseY- y/2)/actualRadius);
     if(mouseYAngle < 0)
     {
        mouseAngle = mouseAngle + PI; 
     }
     
     if( mouseAngle >= lastAngle && mouseAngle <= angle){
       
       //System.out.println("category: " + category + " | mouseAngle: " + mouseAngle 
       //+ " | mouseYAngle: " + mouseYAngle + " | angle: " + angle 
       //+ " | lastAngle: " + lastAngle
       //+ " | radius : " + radius + " | actualRadius: " + actualRadius);
       
       flag2 = true;
     }

     return flag && flag2;
     
   }
}