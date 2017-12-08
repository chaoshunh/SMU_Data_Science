// Project 4 - The Birth of The Universe
// MSDS 6390 - Visualization of Information
// Cory Nichols and Shazia Zaman

// initialize global variables and arrays / objects
color fillColor = 255; 
float shapeCountCurrent = 0; 
float shapeRate = 0.03; 
float colorInc = 1; 
// create planet objects
Planet   mercury = new Planet(), venus = new Planet(), earth = new Planet(), mars = new Planet(),
         jupiter = new Planet(), saturn = new Planet(), uranus = new Planet(), neptune = new Planet();
Planet[] planetsList = {mercury, venus, earth, mars, jupiter, saturn, uranus, neptune};
Moon     luna  = new Moon(),  deimos = new Moon(), europa = new Moon(),  titan = new Moon(), ariel = new Moon();
Moon[][]  moonsList = {{}, {}, {luna}, {}, {europa, titan}, {}, {}, {ariel}};

Star sun;

void setup() {
  size(1100, 900);
  smooth(8); 
  // identify colors for each planet
  color[] planetColors = {color(175, 81, 34), color(219, 211, 203), color(58, 216, 15), 
                          color(232, 26, 26), color(234, 116, 19), color(221, 36, 234),
                          color(14, 237, 190), color(2, 228, 237)};
  float planetSize = 10; 
  float planetSpeed = 0.02; // initial planet speed
  float initTheta = 0; // default theta start
  String[] planetNames = {"Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"};
  
  
  // Create and initialize Sun
  sun = new Star();
  sun.coordinates = new Coordinates(width/2,height/2);
  sun.diameter = 125;
  sun.name = "Sun";
  sun.pColor = color(random(250,255), random(250,255), 0);
  sun.planets = planetsList;
  
  // set default distance from sun
  float distanceFromSun = sun.diameter/2 ; 
  
  // Create and initialize planet objects
  for(int i = 0; i < planetsList.length; i++){
      planetsList[i].coordinates = new Coordinates(0,0); // use constructor to establish base coordinates
      planetsList[i].diameter = planetSize;
      planetsList[i].name = planetNames[i];
      planetsList[i].pColor = planetColors[i];
      // planet is associated with star sun
      planetsList[i].star = sun;
      planetsList[i].speed = planetSpeed;
      planetsList[i].theta = initTheta + random(0,TAU);
      planetsList[i].distanceFromStar = distanceFromSun + planetsList[i].diameter + planetsList[i].diameter/3 + 10;
      //reset distanceFromSun to calculate new distance for next planet to add until we plugin actual values
      distanceFromSun = planetsList[i].distanceFromStar;
      //reset planetSize to calculate size for next planet until we plugin actual values
      planetSize += random(2,6);
      planetSpeed -= random(.002,.003);
      // Add planets to sun
      sun.planets[i] = planetsList[i];
      for(int j = 0; j < moonsList[i].length; j++){
          planetsList[i].moons = moonsList[i];  
          }
      
      // Add moons to planets
      System.out.println(sun.toString());
      System.out.println(planetsList[i].toString());
  }
      
}
  

void draw() { 
  // draw fade to black, bright white indicating "big bang"'
  fill(fillColor, 20);
  rect(0, 0, width, height);
  if (fillColor > 0) fillColor -= colorInc; 
  
  // randomly place blinking stars throughout galaxy
  drawStars(4,float(height/175), height/100*.2);
  drawGal();
  sun.drawStar();
  
 // slow planet creation
  if (shapeCountCurrent < planetsList.length - shapeRate) {
   shapeCountCurrent += shapeRate;
  }
}
