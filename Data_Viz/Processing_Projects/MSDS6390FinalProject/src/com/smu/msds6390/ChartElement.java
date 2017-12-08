package com.smu.msds6390;

// abstract chart element class providing common methods and fields for different chart objects

abstract class ChartElement
{
 float x, y, w, h;
 String category, measureLabel, measureLabel2;
 String[] measureLabels;
 int fillCol;
 Label label;
 
 abstract void display();
 
 abstract void displayLabels();
 
}