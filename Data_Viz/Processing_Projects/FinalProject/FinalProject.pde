// MSDS 6390 - Final Project
// Shazia Zaman and Cory Nichols
import controlP5.*;
import javax.swing.*; 
import java.io.*;

Engine e;
int arrayIndex = 0;

void setup()
{ 
  e = new Engine();
  size(800, 800);
  e.cp5 = new ControlP5(this);
  e.run();
}

void draw()
{
  background(255);
  e.showBackground();
  e.vizArray.get(arrayIndex).display();
  
}