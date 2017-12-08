package com.smu.msds6390;

// Engine organizes most classes and establish run environment
import java.io.File;

import controlP5.*;
import processing.core.*;

import java.util.ArrayList;

import javax.swing.JOptionPane;
import javax.swing.UIManager;

class Engine 
{
  // fields
  // GUI CP5 and ControlBar fields
  ControlP5 cp5;
  public ControlBar controlBar;
  File dir; 
  File[] files;
  String fHolder;
  
  // Background and text fields
  PFont[] fonts = new PFont[2];
  PImage p;
  
  // Base file field
  FileProcessing file;
  
  // Viz fields
  ArrayList<Viz> vizArray = new ArrayList<>();
  ArrayList<String> radioButtonNames = new ArrayList<>();
  Viz scatter, bar, heatmap, piechart;
  
  VizApplet applet;
  
  // cstrs
  Engine(VizApplet applet)
  { 
	this.applet = applet;
	this.cp5 = new ControlP5(applet);
    // give user viz options in a list, next step would be to allow user defined charts directly in GUI
    dir = new File(applet.dataPath(""));
    files = dir.listFiles();
    this.fHolder = "";
    for(File file : files)
    {
      String fName = file.getName();
      if(fName.contains(".csv"))
      {
        fHolder += fName + " | ";
      }
    }
    // get file from data folder
    this.file = new FileProcessing(fileGrabber(), applet);
    // set up images and fonts
    this.p = applet.loadImage("mustang.png");
    this.p.resize((int)(applet.width*.11), (int)(applet.height*.0625));
    this.fonts[0] = applet.loadFont("MyriadSet-Text-24.vlw"); 
    this.fonts[1] = applet.loadFont("Helvetica-Bold-24.vlw");
  }
  
  // methods
  public void buildCharts()
  {
    try{
        // create chart objects
        this.heatmap = new Heatmap(applet);
        this.scatter = new ScatterPlot(applet);
        this.bar = new BarChart(applet);
        this.piechart = new PieChart(applet);
    
        // add charts to an array list
        this.vizArray.add(bar);
        this.vizArray.add(scatter);
        this.vizArray.add(piechart);
        this.vizArray.add(heatmap);
    }
    catch(Exception e)
    {
        e.printStackTrace();
        System.exit(0);
    }  
  }
  
  // show charts constructs the viz, working with two data sets, need to work in dynamic file selections
  // allow user to dynamically select fields -- starting to get into tableau land if we build pills to drag....
  public void showCharts()
  {
    if(this.file.fileName.equals("concussions.csv"))
     {
      this.bar.construct(file.retTable()
        , "Concussions: Concussion Rates by Sport"
        , "Competition_Rate_Per_10K_Exposures"
        , "Sport");
        
      this.heatmap.construct(file.retTable()
        , "Concussions: Competition Concussion Rates Heatmap"
        , "Competition_Rate_Per_10K_Exposures"
        , "Sport");
      
      this.scatter.construct(file.retTable()
        , "Concussions: Concussion Rates: Practice (X) vs Competition (Y)"
        , "Competition_Rate_Per_10K_Exposures"
        , "Practice_Rate_Per_10K_Exposures"
        , "Sport");
      
      this.piechart.construct(file.retTable()
        , "Concussions: Concussion Ratio Per Team vs Total Concussions"
        , "Concussion_Totals"
        , "Sport");
     }
     
   if(this.file.fileName.equals("tours.csv"))
     {
      this.bar.construct(file.retTable()
        , "Tour Rankings: Inflation Adjusted Gross"
        , "Inf_Adj_Amt"
        , "Artist & Tour");
       
      this.heatmap.construct(file.retTable()
        , "Tour Rankings: Average Attendance"
        , "Avg_Attendance"
        , "Artist & Tour");
      
      this.scatter.construct(file.retTable()
        , "Tour Rankings: Avg Gross Earnings vs # Of Shows"
        , "Avg_Gross_MM"
        , "Shows"
        , "Artist & Tour");
      
      this.piechart.construct(file.retTable()
        , "Tour Rankings: Total Attendance"
        , "Avg_Gross_MM"
        , "Artist & Tour");
        
     }
  
   if(this.file.fileName.equals("hockey.csv"))
       {
        this.scatter.construct(file.retTable()
          , "NHL Hockey: Goals For Per Game vs Goals Against Per Game"
          , "GFG"
          , "GAG"
          , "TEAM");
      
         this.bar.construct(file.retTable()
          , "NHL Hockey: Total Goals Per Team"
          , "G"
          , "TEAM");
      
        this.piechart.construct(file.retTable()
          , "NHL Hockey: Goals Per Team"
          , "G"
          , "TEAM");
          
        this.heatmap.construct(file.retTable()
          , "NHL Hockey: Goals For Per Game"
          , "GFG"
          , "TEAM");
         }
  }
  
  // set up GUI and GUI interaction
  void buildGUI()
  {
    //set radio button names based on chart names
    for (Viz viz : this.vizArray)
    {
      this.radioButtonNames.add(viz.getChartName());
    }
    // create control bar based on charts to create radio buttons
      this.controlBar = new ControlBar(cp5, radioButtonNames, applet);
  }
  
  public void keyPressed() {controlBar.activateRadioButton(applet.key); }
  
  public void showBackground()
  {
    applet.fill(245);
    applet.rect(applet.width * .1f, applet.height * .09f, applet.width - applet.width*.2f, applet.height - applet.height*.22f, 20, 20, 20, 20);
    applet.image(p, applet.width*.18f, applet.height-applet.height*.1f);
    applet.textFont(fonts[0]);
    applet.fill(0);
    applet.textSize((float)(applet.width * .03));
    applet.text("DATA VISUALIZATION: THE TABLEAUIZER", applet.width*.31f, applet.height-applet.height*.06f);
    applet.fill(150, 75);
    applet.rect(0, 0, applet.width*.2f, applet.height*.05f, 0, 0, 10, 0);
    applet.fill(0);
    applet.textSize((float)(applet.width*.015));
    applet.text("DATA SOURCE:\n" + file.fileName.toUpperCase(), applet.width*.02f, applet.width*.02f);
  }
  
  // fileGrabber allows the user to specify what file he or she wishes to visualits
  String fileGrabber()
  {
    try 
    { 
      UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    } 
    catch (Exception e) 
    { 
      e.printStackTrace();
    } 
    
    String preset = "concussions.csv";
    String stringName = JOptionPane.showInputDialog( applet.frame, "Files Available: " + this.fHolder + 
                                                      "\n\nPlease Enter Your File Name From Available Files\n", preset);
    
    return stringName;
  }
  
  // getters and setters, share file in engine across other classes
  public FileProcessing getFile()
  {
    return this.file;
  }
  
  public void run()
  {
    buildCharts();
    buildGUI();
    showCharts();
  }
 
}