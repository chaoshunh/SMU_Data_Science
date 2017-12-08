// fileProcessing handles flat file data and allows the user to add attributes
// create a method here to allow for data manipulation of the flat file more directly
class FileProcessing
{
  // fields
  String fileName;
  Table table;
  String[] colNames;
  
  // cstrs
  FileProcessing(){}
  
  FileProcessing(String fileName)
  {
    try
    {
    this.fileName = fileName;
    this.table = loadTable(fileName, "header");
    }
    catch(Exception e)
    {
      e.printStackTrace();
      System.exit(0);
    }
  }
  
  // constructor to add columns to table
  FileProcessing(String tablename, String[] colNames)
  {
    this.colNames = colNames;
    this.table = loadTable(tablename, "header");
   
      for (int i = 0; i < colNames.length; i++)
      {
        table.addColumn(colNames[i]);
      }
    }
  
  // methods
  void saveFile(String directory)
  {
    saveTable(table, directory);
  }  
  
  
  Table retTable()
  {
    return table;
  }
}