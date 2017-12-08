// abstract chart element class providing common methods and fields
abstract class ChartElement
{
 float x, y, data;
 color fillCol;
 Label label;
 String category;
 
 abstract void display();
 
 abstract void displayLabels();
 
}