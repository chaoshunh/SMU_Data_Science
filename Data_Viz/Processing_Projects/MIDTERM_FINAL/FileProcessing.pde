// fileProcessing handles flat file data and allows the user to add attributes
class FileProcessing
{
  Table table;
  String[] colNames;
  boolean totalsRates = true;
  
  FileProcessing()
  {
  }
  
  FileProcessing(String tablename, String[] colNames, boolean totalsRates)
  {
    this.colNames = colNames;
    this.totalsRates = totalsRates;
    table = loadTable(tablename, "header");
    
    if (totalsRates)
    {
      for (int i = 0; i < colNames.length; i++)
      {
        table.addColumn(colNames[i], table.FLOAT);
      }
      
      for (TableRow row : table.rows())
      {
        row.setFloat("Concussion_Totals", row.getFloat("Concussion_Competition")+row.getFloat("Concussion_Practice"));
        row.setFloat("Exposure_Totals", row.getFloat("Exposure_Competition")+row.getFloat("Exposure_Practice"));
        row.setFloat("Competition_Rate_Per_10K_Exposures", row.getFloat("Concussion_Competition") / row.getFloat("Exposure_Competition") * 10000);
        row.setFloat("Practice_Rate_Per_10K_Exposures", row.getFloat("Concussion_Practice") / row.getFloat("Exposure_Practice") * 10000);
        row.setFloat("Total_Rate_Per_10K_Exposures", row.getFloat("Concussion_Totals") / row.getFloat("Exposure_Totals") * 10000);
      }
    }
  }
  
  void saveFile(String directory)
  {
    saveTable(table, directory);
  }  
  
  Table retTable()
  {
    return table;
  }
}