// PROJECT 5 - The American Dream
// Shazia Zaman and Cory Nichols

PImage[] p = new PImage[6];
float[] rotFactor = new float[6];
float[] fallFactor = new float[6];
float y = 0;
float y2 = 0;
float speed = 0.05;
float speed2 = 0.05;
float shake = 5;
float shake2 = 5;
float drop1 = 8000;
float drop2 = 12000;

void setup(){
  size(1000, 600);
  PImage frame = loadImage("Frame.jpg");
  PFont f = loadFont("Stencil-48.vlw");
  float fall = 0;
  
  textFont(f);
  noStroke();
  frame.resize(int(width/6), int(height/3.5));
  
  // load and resize images, adjust alpha for blend, blend frames onto pictures
  for(int i = 0; i < p.length; i++){
    p[i] = loadImage("b"+ str(i+1) + ".jpg");
    if(i == 0){
      blur(p[i], 5);
    }
    if(i == 1){
      gray(p[i]);
      p[i].filter(ERODE);
    }
    if(i == 2){
      p[i].filter(THRESHOLD);
    }
    if(i == 3){ 
      blur(p[i], 3);
      p[i].filter(POSTERIZE, 2);
    }
    if(i == 4){
     blur(p[i], 5);
     p[i].filter(ERODE);
    }
    if(i == 5){
     blur(p[i], 5);
     sepia(p[i]);
     p[i].filter(ERODE);
    }
    
    p[i].resize(int(width/6), int(height/3.5));
    alphaAdjust(p[i]);
    rotFactor[i] = random(-TAU/60, TAU/60);
    fallFactor[i] = fall;
    fall += height *.008;
    p[i].blend(frame, 0, 0, p[i].width, p[i].height, 0, 0, frame.width, frame.height, DARKEST);
  }
}

void draw(){
  float radius = width *.015;
  float defSpace = width *.025;
  float spacer = width *.028;
  background(0,5);
  
  textAlign(CENTER);
  text("THE AMERICAN DREAM", width/2, 50);
  
  for(int i = 0; i < p.length; i++){
    // draw hangers
      ellipse(i * p[i].width + p[i].width/2, height/5, 5, 5);
    // draw first 5 pictures and frames
      if( i < 5 && millis() <= drop2) {
        pushMatrix();
        translate(i * p[i].width, height/7 + fallFactor[i]);
        rotate(rotFactor[i]);
        image(p[i], 0, 0);
        popMatrix();
      }
       else if(i == 5 && millis() <= drop1){  
          image(p[i], i * p[i].width, height/7);
         } 
         
       else if (i == 5 && millis() > drop1){
          image(p[i], random(i*p[i].width, i * p[i].width+shake), height/(7-y));
            shake -= speed*3;
            y += speed;
              } if(i == 5 && y >= 5 ){
                speed = 0;
              }
         
      else if(i < 5 && millis() > drop2){
         image(p[i], random(i*p[i].width, i * p[i].width+shake2), height/(7-y2));
          shake2 -= speed2;
          y2 += speed2/3;
            } if(i < 5 && y2 >= 5 ){
               speed2 = 0;
               }         
      }

  // draw picket fence
  fill(255);
  rect(radius, height/2 + radius/1.5, width-radius*2, radius);
  rect(radius, height/1.35, width-radius*2, radius); 
  for(int i = 0; i < (width-defSpace*2)/defSpace; i++){
    rect(spacer, height/2, radius, height/3.55);
    triangle(spacer, height/2, spacer+radius/2, height/2.1, spacer+radius, height/2);
    spacer += (width*.025);  
  }  

}