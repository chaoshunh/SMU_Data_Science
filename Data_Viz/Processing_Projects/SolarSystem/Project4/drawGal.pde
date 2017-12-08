void drawGal(){
  
int num_stars = 2000; 
int galWidth = 500; 
float speed = 0.02;  
 
float eRatio= 0.85; // sourced from OpenProcessing example
float etwist= 9.0/galWidth; // sourced from OpenProcessing example
 
float []angle = new float[num_stars];
float []radius = new float[num_stars];

stroke(color(255,255,192,100));

// initialize angles and radii for individual stars within max radius
for (int i = 0; i < num_stars; i++){
    angle[i] = random(0,TAU);
    radius[i]= random(1,galWidth);
  }

for (int i =0; i < num_stars; i++){
    float x = sin(angle[i])* radius[i] + speed;
    float y = (cos(angle[i])*radius[i]) * eRatio; // multiplying Y coordinate by a ratio clumps together
    float z = radius[i] * etwist; 
    float s = sin(z);
    float c = cos(z);
    pushMatrix();
    translate(width/2, height/2);
    point(s*x + c*y, c*x - s*y);
    popMatrix();
  }
}
