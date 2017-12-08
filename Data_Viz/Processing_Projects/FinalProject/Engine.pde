// Engine organizes most classes and establish run environment

class Engine 
{
  // fields
  // GUI CP5 and ControlBar fields
  ControlP5 cp5;
  ControlBar controlBar;
  File dir; 
  File[] files;
  String fHolder;
  
  // Background and text fields
  PFont[] fonts = new PFont[2];
  PImage p;
  
  // Base file field
  FileProcessing file;
  
  // Viz fields
  ArrayList<Viz> vizArray = new ArrayList();
  ArrayList<String> radioButtonNames = new ArrayList();
  Viz scatter, bar, heatmap, piechart;
  
  // cstrs
  Engine()
  { 
    // give user viz options in a list, next step would be to allow user defined charts directly in GUI
    dir = new File(dataPath(""));
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
    this.file = new FileProcessing(fileGrabber());
    // set up images and fonts
    this.p = loadImage("mustang.png");
    this.p.resize(int(width*.11), int(height*.0625));
    this.fonts[0] = loadFont("MyriadSet-Text-24.vlw"); 
    this.fonts[1] = loadFont("Helvetica-Bold-24.vlw");
  }
  
  // methods
  void buildCharts()
  {
    try{
        // create chart objects
        this.heatmap = new Heatmap();
        this.scatter = new ScatterPlot();
        this.bar = new BarChart();
        this.piechart = new PieChart();
    
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
  void showCharts()
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
      this.controlBar = new ControlBar(cp5, radioButtonNames);
  }
  
  void keyPressed() {controlBar.activateRadioButton(key); }
  
  void showBackground()
  {
    fill(245);
    rect(width * .1, height * .09, width - (width*.2), height - (height*.22), 20, 20, 20, 20);
    image(p, width*.18, height-height*.1);
    textFont(fonts[0]);
    fill(0);
    textSize(width * .03);
    text("DATA VISUALIZATION: THE TABLEAUIZER", width*.31, height-height*.06);
    fill(150, 75);
    rect(0, 0, width*.2, height*.05, 0, 0, 10, 0);
    fill(0);
    textSize(width*.015);
    text("DATA SOURCE:\n" + file.fileName.toUpperCase(), width*.02, width*.02);
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
    String stringName = JOptionPane.showInputDialog( frame, "Files Available: " + this.fHolder + 
                                                      "\n\nPlease Enter Your File Name From Available Files\n", preset);
    
    return stringName;
  }
  
  // getters and setters, share file in engine across other classes
  public FileProcessing getFile()
  {
    return this.file;
  }
  
  void run()
  {
    buildCharts();
    buildGUI();
    showCharts();
  }
 
}