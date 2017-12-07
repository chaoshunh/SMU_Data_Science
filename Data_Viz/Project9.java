import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import javax.swing.*; 
import java.io.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Project9 extends PApplet {

// MSDS 6390 - Project 9
// Shazia Zaman and Cory Nichols

 


Engine e;
int arrayIndex = 0;

public void setup()
{ 
  e = new Engine();
  
  e.cp5 = new ControlP5(this);
  e.run();
}

public void draw()
{
  background(255);
  e.showBackground();
  e.vizArray.get(arrayIndex).display();
  
}
// Bar object as part of the BarChart viz class
class Bar extends ChartElement
{
  float hLabel; // grab actual #'s instead of mapped totals
  
  // cstrs
  Bar(){}
  
  Bar(float x, float y, float w, float h, float hLabel, int fillCol, String category, String measureLabel)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.hLabel = hLabel;
    this.fillCol = fillCol;
    this.category = category;
    this.measureLabel = measureLabel;
  }
  
  // methods
  public void display()
  {
    if(mouseX < this.x + this.w && mouseX > this.x && mouseY > this.y-this.h && mouseY < this.y) 
    {
      fill(150);
    } else {
      fill(fillCol, 175);
    }    
    stroke(0.5f);
    rect(x, y, w, -h);
    noStroke();
  }
 
   public void displayLabels()
   {
     
     if(mouseX < this.x + this.w && mouseX > this.x && mouseY > this.y-this.h && mouseY < this.y)
     {
       textFont(e.fonts[0], 12);
       String txt = measureLabel + "\n" + category + "\n" + nf(hLabel, 0, 2);
       Label label = new Label(txt, mouseX, mouseY-height*.05f);
       label.display();
     }
   }

}
class BarChart extends Markers implements Viz
{
  // fields - barcharts need uniform space b/w bars, and height driven by and mapped to a measure
  float h, barSpace;
  ArrayList<Bar> bars = new ArrayList();
  String chartName = "Bar Chart";
  String chartTitle = "";
  
  //cstrs
  BarChart(){}
  
  // methods
  public void construct(Table data, String chartTitle, String measure, String measure2, String category)
    {println("not a valid construct method for BarChart(): void construct(Table data, String chartTitle, String measure, String category)");}
  
  public void construct(Table data, String chartTitle, String measure, String category)
  {
    this.chartTitle = chartTitle;
    data.setColumnType(measure, Table.FLOAT);
    data.sortReverse(measure);
    float[] yPos = new float[data.getRowCount()];
    int counter = 0;
    bars.clear();
    // establish bar spacing between visual boundaries
    barSpace = (xUBound - xLBound) / data.getRowCount();
    
    for (TableRow row : data.rows())
    {
      yPos[counter] = row.getFloat(measure);
      counter++;
    }
    
    this.minYPt = min(yPos);
    this.maxYPt = max(yPos);
    float spacer = 0;

    for (TableRow row : data.rows())
    {
      float hLabel = row.getFloat(measure);
      h = map(row.getFloat(measure), minYPt, maxYPt, yLBound, yUBound-yLBound);
      bars.add(new Bar(  xLBound+spacer 
                       , yUBound 
                       , (yUBound - yLBound)/data.getRowCount() 
                       , h 
                       , hLabel 
                       , color(random(255), random(255), random(255))
                       , row.getString(category)
                       , measure));
      // increment spaces between bars with barSpace
      spacer += barSpace;
      getMarks(minYPt, maxYPt);
    }
  }
  
  public void display()
  {
   for (int i = 0; i < bars.size(); i++)
    {
      Bar bar = bars.get(i);
      bar.display();
      bar.displayLabels(); 
    }
    displayMarkers(chartTitle, false);
  }
  
  public String getChartName(){
    return chartName;
  } 
}
// Bubble object as part of the scatterplot viz class
class Bubble extends ChartElement
{
  // fields
  float[] radius;
  
  // cstrs
  Bubble(){}
  
  // methods
  Bubble(float x, float y, int fillCol, float[] radius, String category, String[] measureLabels) // add in labels for sport to pass over to displayLabels() method
  {
    this.x = x;
    this.y = y;
    this.fillCol = fillCol;
    this.radius = radius;
    this.category = category;
    this.measureLabels = measureLabels;
  }
  
  public void display()
  {
    if (dist(mouseX, mouseY, x, y) <= radius[0] * 2) {
      fill(150);
    } else {
      fill(fillCol, 200);
    }    
    ellipse(x, y, radius[0]*4, radius[0]*4);
    displayLabels();
  }
  
  public void displayLabels()
   {
     if(dist(mouseX, mouseY, x, y) <= radius[0]*2)
     {
       textFont(e.fonts[0],12);
       String txt = category + "\n" + measureLabels[0] + ": " + nf(radius[0], 0, 2) + "\n" + measureLabels[1] + ": " + nfs(radius[1],0,2);
       Label label = new Label(txt, mouseX, mouseY);
       label.display();
     }
   }
}
// abstract chart element class providing common methods and fields for different chart objects

abstract class ChartElement
{
 float x, y, w, h;
 String category, measureLabel, measureLabel2;
 String[] measureLabels;
 int fillCol;
 Label label;
 
 public abstract void display();
 
 public abstract void displayLabels();
 
}
// Control function handles switching between visualizations
public void controlEvent(ControlEvent theEvent) {
  if(theEvent.isFrom(e.controlBar.radioButton)) {
    for(int i=0; i < theEvent.getGroup().getArrayValue().length;i++) {
        int value = PApplet.parseInt(theEvent.getGroup().getArrayValue()[i]);
        if(value > 0) 
        {
          arrayIndex = i;
         }
      }
    }
  }
// ControlBar sets the GUI on the dashboard to switch between visualizations
// engine passes to ControlBar to initialize menu
class ControlBar
{  
  ControlP5 cp5;
  RadioButton radioButton;
  int radioButtonCount = 0;
  
  //cstrs
  ControlBar(){}
  
  ControlBar(ControlP5 cp5, ArrayList<String> radioButtonNames) {
    this.cp5 = cp5;
    radioButtonCount = radioButtonNames.size();
    createRadioButton(radioButtonNames);
  }

  // methods
  public void createRadioButton(ArrayList<String> radioButtonNames)
  {
    radioButton = cp5.addRadioButton("radioButton")
      .setPosition(width*.22f, height*.02f)
      .setSize(PApplet.parseInt(width*.05f), PApplet.parseInt(height*.05f))
      .setSpacingColumn(PApplet.parseInt(width*.12f))
      .setColorLabel(color(0xff0A0101))
      .setColorForeground(color(120))
      .setItemsPerRow(radioButtonNames.size());
      
    int index = 0;
    for(String name: radioButtonNames)
    {
      radioButton.addItem(name, ++index);
    }
 
    for (Toggle t : radioButton.getItems()) {
      t.getCaptionLabel().setColorBackground(color(255, 80));
      t.getCaptionLabel().getStyle().moveMargin(-7, 0, 0, -3);
      t.getCaptionLabel().getStyle().movePadding(7, 0, 0, 3);
      t.getCaptionLabel().getStyle().backgroundWidth = 45;
      t.getCaptionLabel().getStyle().backgroundHeight = 13;
    }
  }

  public void activateRadioButton(char radioKey)
  {
    int keyValue = Character.getNumericValue(radioKey);
    if(keyValue == 0 || keyValue > radioButtonCount) {
      radioButton.deactivateAll();
    }
    else 
    {
      radioButton.activate(keyValue-1);
    }
  }
}
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
    this.p.resize(PApplet.parseInt(width*.11f), PApplet.parseInt(height*.0625f));
    this.fonts[0] = loadFont("MyriadSet-Text-24.vlw"); 
    this.fonts[1] = loadFont("Helvetica-Bold-24.vlw");
  }
  
  // methods
  public void buildCharts()
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
  public void buildGUI()
  {
    //set radio button names based on chart names
    for (Viz viz : this.vizArray)
    {
      this.radioButtonNames.add(viz.getChartName());
    }
    // create control bar based on charts to create radio buttons
      this.controlBar = new ControlBar(cp5, radioButtonNames);
  }
  
  public void keyPressed() {controlBar.activateRadioButton(key); }
  
  public void showBackground()
  {
    fill(245);
    rect(width * .1f, height * .09f, width - (width*.2f), height - (height*.22f), 20, 20, 20, 20);
    image(p, width*.18f, height-height*.1f);
    textFont(fonts[0]);
    fill(0);
    textSize(width * .03f);
    text("DATA VISUALIZATION: THE TABLEAUIZER", width*.31f, height-height*.06f);
    fill(150, 75);
    rect(0, 0, width*.2f, height*.05f, 0, 0, 10, 0);
    fill(0);
    textSize(width*.015f);
    text("DATA SOURCE:\n" + file.fileName.toUpperCase(), width*.02f, width*.02f);
  }
  
  // fileGrabber allows the user to specify what file he or she wishes to visualits
  public String fileGrabber()
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
  
  public void run()
  {
    buildCharts();
    buildGUI();
    showCharts();
  }
 
}
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
  public void saveFile(String directory)
  {
    saveTable(table, directory);
  }  
  
  
  public Table retTable()
  {
    return table;
  }
}
// heatmap chart taking spaces to form a red to green heatmap across dimensions
class Heatmap extends Markers implements Viz
{
  // fields
    // rectSize now adjusts for bounds of screen, no longer hard coded
  float rectSize = floor(sqrt(((xUBound - xLBound) * (yUBound - yLBound)) / (e.getFile().retTable().getRowCount())));
  ArrayList<Space> spaces = new ArrayList();
  String chartName = "Heat Map";
  String chartTitle = "";
  
  // cstrs
  Heatmap(){}
  
  //  methods

  public void construct(Table data, String chartTitle, String measure, String measure2, String category)
    {println("not a valid construct method for HeatMap() void construct(Table data, String chartTitle, String measure, String category)");}
  
  public void construct(Table data, String chartTitle, String measure, String category)
  {
    this.chartTitle = chartTitle;
    float xSpacer = 0;
    float ySpacer = 0;
    float counter = 0;
    spaces.clear();
    data.setColumnType(measure, Table.FLOAT);
    data.sortReverse(measure);
    
    for (TableRow row : data.rows())
    {
      // Space(float x, float y, float w, float h, float measure, String measureLabel, String category)
      this.spaces.add(new Space(xLBound + xSpacer
                                , yLBound + ySpacer
                                , rectSize 
                                , rectSize 
                                , row.getFloat(measure)
                                , measure
                                , row.getString(category)));
      xSpacer += rectSize;
      counter += 1;
      if(counter % 5 == 0)  
      {
        ySpacer += rectSize;
        xSpacer = 0;
      }
    }
  }
  
  public void display()
  {
    Space space;
    for (int i = 0; i < spaces.size(); i++)
    {
      space = spaces.get(i);
      space.display();
    }
    displayTitle(chartTitle);
  }
  
  public String getChartName(){
    return chartName;
  }
  
}
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
    
    if(this.x + labelW + width*.025f > width)
    {
      this.x -= labelW + width*.025f;
    }
  }
  
  //  methods
  public void display()
  {
    fill(0);
    text(txt, this.x+width*.01f, this.y-height*.005f);
  }  
}
// markers is an independent class that sets the bounds and axes for all visualizations
class Markers
{
  // fields
  float numRows = e.getFile().retTable().getColumnCount();
  
  // dimensions of x and y axes:
  float minXPt, maxXPt, minYPt, maxYPt;
  // bounds of all visualizations:
  float xLBound = width*.2f;
  float xUBound = width-xLBound;
  float yLBound = height*.2f;
  float yUBound = height-yLBound;
  
  // cstrs
  Markers(){}
 
 
 // methods
 
 // get marks for double axis charts
  public void getMarks(float minXPt, float maxXPt, float minYPt, float maxYPt)
  {
    this.maxYPt = maxYPt;
    this.minYPt = minYPt;
    this.minXPt = minXPt;
    this.maxXPt = maxXPt;
  }
    
  // get marks for single axis charts  
  public void getMarks(float minYPt, float maxYPt)
  {
    this.minYPt = minYPt;
    this.maxYPt = maxYPt;
  }  
    
  public void displayTitle(String title)
  {
    fill(0);
    textFont(e.fonts[0], 20);
    text(title, yLBound, yLBound-height*.075f);
  }
  
  // assume y is default axis, allow boolean inclusion of x axis
  public void displayMarkers(String title, Boolean multipleAxes)
   {
    fill(0);
    textFont(e.fonts[0],12);
    
    // if two axes, create X
    if(multipleAxes)
    {
      for (float i = minXPt; i <= maxXPt + (maxXPt *.01f); i += (maxXPt - minXPt) / 10)
      {
       float x = map(i, minXPt, maxXPt, xLBound, xUBound);
       float textW = textWidth(nf(i,0,1));
       float textH = textAscent();
       text(nf(i,0,1), x, yUBound + textH * 4);
       line(x + textW/2, yUBound + textH * 1.5f, x + textW/2, yUBound + textH);
      }
    }
    
    for (float i = minYPt; i <= maxYPt + (maxYPt * .01f) ; i+= (maxYPt - minYPt) / 10)
    {
     float y = map(i, minYPt, maxYPt, yUBound, yLBound);
     float textH = textAscent();
     float textW = textWidth(nf(1, 5, 2));
     if(maxYPt > 1000000){text(nf(i/1000000, 0, 1), xLBound - textW, y); }
     else{text(nf(i,0,1), xLBound - textW, y);}
     line(xLBound - textH * 1.75f, y-textH/2, yLBound-textH * 1.5f, y - textH/2);
    }
    
    textFont(e.fonts[0], 20);
    
    if(maxYPt > 1000000){text(title + " in MM", yLBound, yLBound-height*.075f);}
    else{text(title, yLBound, yLBound-height*.075f);}
   }
}
// piechart class taking slices across dimensions
class PieChart extends Markers implements Viz
{
  
  // fields
  ArrayList<Slice> slices = new ArrayList();
  float grandTotal = 0;
  float radius = width/4;
  int whiteColor = color(0xffFFFFFF);
  String chartName = "Pie Chart";
  String chartTitle = "";
  
  // cstrs
  PieChart(){}
  
  // methods
  public void construct(Table data, String chartTitle, String measure, String measure2, String category)
    {println("not a valid constructor method for PieChart() void construct(Table data, String chartTitle, String measure, String category)");}
  
  public void construct(Table data, String chartTitle, String measure, String category){
    this.chartTitle = chartTitle;
    
    grandTotal = 0;
    slices.clear();
    
    for (TableRow row : data.rows())
    {
      grandTotal += row.getFloat(measure);
    }
    
    float lastAngle = 0;
    for (TableRow row : data.rows())
    {
      float ratio = (row.getFloat(measure) / grandTotal) * 100;
      String subCat = row.getString(category);
      int sColor = color(random(255), random(255), random(255));
      float angle = lastAngle + radians(ratio * 3.6f);
      while(sColor == whiteColor)
      {
        sColor = color(random(255), random(255), random(255));
      }
      Slice slice = new Slice(width 
                              , height
                              , radius
                              , ratio 
                              , sColor 
                              , subCat 
                              , angle 
                              , lastAngle);
      slices.add(slice);
      lastAngle += radians(ratio * 3.6f);
    }
  }
  
  public void display(){
    for(Slice slice : slices)
    {
      slice.display();
      if(slice.isMouseInTheArc()) {
        slice.displayLabels();
      }
    }
    displayTitle(chartTitle);
  }
  
  public String getChartName(){
    return chartName;
  } 
}
// this class creates a ScatterPlot with Bubbles based on rates of concussions for competition vs practice
class ScatterPlot extends Markers implements Viz
{
  // frields
  ArrayList<Bubble> bubbles = new ArrayList();
  String chartName = "Scatter Plot";
  String chartTitle = "";
  
  // cstrs
  ScatterPlot(){}
  
  // methods
  public void construct(Table data, String chartTitle, String measure, String category)
    {println("not a valid construct method for ScatterPlot() void construct(Table data, String chartTitle, String measure, String measure2, String category)");}
  
  public void construct(Table data, String chartTitle, String measure, String measure2, String category)
  {
    this.chartTitle = chartTitle;
    data.setColumnType(measure, Table.FLOAT);
    data.sortReverse(measure);
    float[] xPos = new float[data.getRowCount()];
    float[] yPos = new float[data.getRowCount()];
    int counter = 0;
    bubbles.clear();
    for (TableRow row : data.rows())
    {
      yPos[counter] = row.getFloat(measure);
      xPos[counter] = row.getFloat(measure2);
      counter++;
    }
    
    this.minXPt = min(xPos);
    this.maxXPt = max(xPos);
    this.minYPt = min(yPos);
    this.maxYPt = max(yPos);
    counter = 0;
   
    String[] measureLabels = {e.getFile().retTable().getColumnTitle(e.getFile().retTable().getColumnIndex(measure)), 
                              e.getFile().retTable().getColumnTitle(e.getFile().retTable().getColumnIndex(measure2))};
    
    for (TableRow row : data.rows())
    {
      float[] cols = {row.getFloat(measure), row.getFloat(measure2)};
      this.bubbles.add(new Bubble(map(xPos[counter], minXPt, maxXPt, xLBound, xUBound) 
                                  , map(yPos[counter], minYPt, maxYPt, yUBound, yLBound) 
                                  , color(random(255), random(255), random(255))
                                  , cols 
                                  , row.getString(category)
                                  , measureLabels));
      counter++;
    }
    // establish the markers object for the scatterPlot based on bounds, data:
    getMarks(minXPt, maxXPt, minYPt, maxYPt);
  }
 
 public void display()
  {
    for (int i = 0; i < bubbles.size(); i++)
    {
      Bubble bubble = bubbles.get(i);
      bubble.display();
    }
    displayMarkers(chartTitle, true);
  }
  
  public String getChartName(){
    return chartName;
  }
  
}
// slice object as part of the piechart viz class
class Slice extends ChartElement {
  // fields
  float ratio = 0;
  float radius = 0;
  float angle = 0;
  float lastAngle = 0;
  
  // cstrs
  Slice(){}
  
  Slice(float xVal, float yVal, float radiusValue, float ratioValue, int sColor, String sCategory, float sAngle, float sLastAngle)
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
  public void display(){
    fill(fillCol, 150);
    arc(x/2, y/2, 2*radius, 2*radius, lastAngle, angle);
  }
 
  public void displayLabels(){
       textFont(e.fonts[0], 12);
       String txt = "Percentage " + category + " : " + nf(ratio, 0, 2) + "%";
       Label label = new Label(txt, mouseX, mouseY);
       label.display();
   }
   
   public boolean isMouseInTheArc()
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
// space is a chart element used to create "Spaces" or squares in the heatmap
class Space extends ChartElement
{ 
  // fields
  float colorScale;
  float _minCol, _maxCol;
  
  // cstrs
  Space(){}
  
  Space(float x, float y, float w, float h, float colorScale, String measureLabel, String category)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.colorScale = colorScale;
    this.measureLabel = measureLabel;
    this.category = category;
    this._minCol = min(e.getFile().retTable().getFloatColumn(measureLabel));
    this._maxCol = max(e.getFile().retTable().getFloatColumn(measureLabel));
  }
  
  // methods
  public void display()
  {
    if(dist(mouseX, mouseY, (x+w/2), (y+h/2)) < h/2)
    {
      fill(255);
    } else {
      
      
      fill(color(map(colorScale, _minCol, _maxCol, 0, 255),
                 map(colorScale, _minCol, _maxCol, 255, 0), 0), 150);
    }    
    rect(x, y, w, h);
    displayLabels();
  }
  
   public void displayLabels()
   {
     if(dist(mouseX, mouseY, (x+w/2), (y+h/2)) < h/2)
     {
       textFont(e.fonts[0], 12);
       String txt = category + "\n" + nf(colorScale, 0, 2);
       Label label = new Label(txt, mouseX, mouseY);
       label.display();
     }
   }
  
}
// this interface forms the foundation for all visualizations

interface Viz 
{
  public abstract void construct(Table data, String chartTitle, String measure, String category);
  
  public abstract void construct(Table data, String chartTitle, String measure, String measure2, String category);
  
  public abstract void display();
  
  public abstract String getChartName();
  
}
  
  public void settings() {  size(800, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Project9" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
