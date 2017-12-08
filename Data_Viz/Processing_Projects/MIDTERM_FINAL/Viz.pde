// this abstract class forms the foundation for all visualizations
// it also inherits fields and methods from Markers, which establishes the legends, x, y axes markers and bounds
// of each viz

abstract class Viz extends Markers
{
  FileProcessing file;
  Markers markers = new Markers();
  Table data = new Table();
  float x, y, w, h;
  color fillCol;
 
  Viz()
  {
    this.file = new FileProcessing("concussions.csv", colNames, true);
    this.data = file.retTable();
  }
  
  Viz(float x, float y, color fillCol)
  {
    this.x = x;
    this.y = y;
    this.fillCol = fillCol;
  }
  
  abstract void construct(ArrayList array, String column, String column2);
  
  abstract void construct(ArrayList array, String column);
  
  abstract void display();
  
  abstract void run();
  
}
  