package com.smu.msds6390;

import processing.data.Table;

// this interface forms the foundation for all visualizations

interface Viz 
{
  abstract void construct(Table data, String chartTitle, String measure, String category);
  
  abstract void construct(Table data, String chartTitle, String measure, String measure2, String category);
  
  abstract void display();
  
  abstract String getChartName();
  
}
  