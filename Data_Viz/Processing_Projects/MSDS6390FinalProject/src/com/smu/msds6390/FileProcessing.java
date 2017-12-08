package com.smu.msds6390;

import processing.core.PApplet;
import processing.data.Table;

// fileProcessing handles flat file data and allows the user to add attributes
// create a method here to allow for data manipulation of the flat file more directly
class FileProcessing
{
  // fields
  String fileName;
  Table table;
  String[] colNames;
  PApplet applet;
  
  // cstrs
  FileProcessing(PApplet applet){
	  this.applet = applet;
  }
  
  FileProcessing(String fileName, PApplet applet)
  {
	this.applet = applet;
    try
    {
    this.fileName = fileName;
    this.table = applet.loadTable(fileName, "header");
    }
    catch(Exception e)
    {
      e.printStackTrace();
      System.exit(0);
    }
  }
  
  // constructor to add columns to table
  FileProcessing(String tablename, String[] colNames, PApplet applet)
  {
	this.applet = applet;
    this.colNames = colNames;
    this.table = applet.loadTable(tablename, "header");
   
      for (int i = 0; i < colNames.length; i++)
      {
        table.addColumn(colNames[i]);
      }
    }
  
  // methods
  void saveFile(String directory)
  {
    applet.saveTable(table, directory);
  }  
  
  
  public Table retTable()
  {
    return table;
  }
}