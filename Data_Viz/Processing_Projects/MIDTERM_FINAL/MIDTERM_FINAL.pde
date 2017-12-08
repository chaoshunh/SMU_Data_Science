// MSDS 6390 - Midterm Project: Eat Your Heart Out Tableau
// Shazia Zaman and Cory Nichols

import controlP5.*;
ControlP5 cp5;

PFont font;
FileProcessing file;
Viz scatter;
Viz bar;
Viz heatmap;
Viz piechart;
RadioButton radioButton;
Viz[] vizArray = new Viz[4];
int arrayIndex = 0;
String[] colNames = {"Concussion_Totals", "Exposure_Totals", 
                     "Competition_Rate_Per_10K_Exposures", 
                     "Practice_Rate_Per_10K_Exposures", "Total_Rate_Per_10K_Exposures"};
void setup()
{
  size(800,800);
  cp5 = new ControlP5(this);
  createRadioButton();
  heatmap = new Heatmap();
  scatter = new ScatterPlot();
  bar = new BarChart();
  piechart = new PieChart();
  font = loadFont("MyriadSet-Text-48.vlw");
  vizArray[0] = bar;
  vizArray[1] = scatter;
  vizArray[2] = piechart;
  vizArray[3] = heatmap;
  
  background(255);
}


void draw()
{
  background(255);
  vizArray[arrayIndex].run();
}