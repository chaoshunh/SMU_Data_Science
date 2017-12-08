// abstract chart element class providing common methods and fields for different chart objects

abstract class ChartElement
{
 float x, y, w, h;
 String category, measureLabel, measureLabel2;
 String[] measureLabels;
 color fillCol;
 Label label;
 
 abstract void display();
 
 abstract void displayLabels();
 
}