void sepia(PImage img){
  
  color[] palette = new color[256];
  int r = 255;
  int g = 240;
  int b = 192;
  img.loadPixels();
  
  for(int i = 0; i < palette.length; i++){
    palette[i] = color(r*i/255, g*i/255, b*i/255);
  }
  
  for(int i = 0; i < img.pixels.length; i++){
    color c = img.pixels[i];
    float gray = red(c)*0.3+green(c)*0.59+blue(c)*0.11;
    img.pixels[i] = palette[int(gray)];
  }
  
  img.updatePixels();
}
