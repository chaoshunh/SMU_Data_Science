// Project 3 - The Birth of The Universe
// MSDS 6390 - Visualization of Information
// Cory Nichols and Shazia Zaman

// initialize global variables and arrays
color fillColor = 255; // fill color to start
float colorInc = 1; // color incrementer for fade to black effect
int numShapes = 8; // number of shapes to create, planets in this case
float shapeCountCurrent = 0; // shapeCount incrementer to control flow of creation of planets
float shapeRate = 0.02; // the actual rate to create the shapes
float sunDiameter = 125; // sun size

// define and declare length of arrays to be used in draw
float[] theta = new float[numShapes]; // create an array
float[] radX = new float[numShapes]; // x coordinates to create shapes at
float[] radY = new float[numShapes]; // y coordinates to create shapes at
float[] fillCol = new float[numShapes]; // fill color for shapes
float[] sizes = new float[numShapes]; // sizes of shapes
float[] distances = new float[numShapes]; // distances of shapes
float[] speed =new float[numShapes]; // speed of shapes

void setup() {
  size(1000, 800); // size of frame
  frameRate(60); // framerate
  smooth(8); // antialiasing
  float initTheta = 0; // set initial speed variable
  float distanceFromSun = sunDiameter/2 + 5; // set default distance from sun (/2 outside edge)
  float planetSize = 10; // set default planet size
  
  // initialize arrays
  for (int i = 0; i < numShapes; i++) {
    theta[i] = initTheta + random(0,360); // set random initial start location angles
    speed[i] = random(0.005, 0.02); // set random start speeds of orbit
    radX[i] = 0; // set the x position to 0
    radY[i] = 0;  // set y position to 0
    sizes[i] = planetSize; // default planet size used for first planet
    planetSize += random(5,10); // increment planet size to ensure larger planets in outer orbit
    distances[i] = distanceFromSun + sizes[i] + 2; // ensure sun and planets don't collide
    distanceFromSun = distances[i]; // ensure next distance is incremented appropriately, away from other planets
  }
    // sort planet size and distances so planets farther from sun are bigger
    sizes = sort(sizes);
    distances = sort(distances);
    // sort speed so planets closer to sun move faster
    speed = sort(speed);
    speed = reverse(speed);

    // identify colors for each planet
    fillCol[0] = color(175, 81, 34); //mercury
    fillCol[1] = color(219, 211, 203); //venus
    fillCol[2] = color(58, 216, 15); //earth
    fillCol[3] = color(232, 26, 26); //mars
    fillCol[4] = color(234, 116, 19); //jupiter
    fillCol[5] = color(221, 36, 234); //saturn
    fillCol[6] = color(14, 237, 190); //uranus
    fillCol[7] = color(2, 228, 237); //neptune
}

void draw() { 
  // draw fade to black, bright white indicating "big bang"
  fill(fillColor, 20);
  rect(0, 0, width, height);
  if (fillColor > 0) fillColor -= colorInc; 
  
  // randomly place blinking stars throughout galaxy
  drawStars(4,float(height/100), height/100*.5);
  
  // build planets, still ensuring zero collisions by incrementing x and y
  for (int i = 0; i < shapeCountCurrent; i++) { 
    noStroke();
    if (radX[i] < distances[i]) {
      radX[i] += sizes[i]/10; // make shape travel to final distance 
      radY[i] += sizes[i]/10;
    }
    else {
      radX[i] = distances[i]; // arrive at final destination
      radY[i] = distances[i];
    }
    // create planets and sun based on assigned thetas, x,y, colors and size
    drawPlanets(radX[i], radY[i], theta[i], int(fillCol[i]), sizes[i], i);
    theta[i] = (theta[i] + speed[i]) % TAU;
    drawSun(sunDiameter);
  }
  
 // slow planet creation
 if (shapeCountCurrent < numShapes - shapeRate) {
    shapeCountCurrent += shapeRate;
  }
}