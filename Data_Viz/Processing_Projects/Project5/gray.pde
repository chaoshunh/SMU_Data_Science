// custom grayscale function
// get pixel color, adjust using grayscale products

void gray(PImage img){
  img.loadPixels();
  for(int i = 0; i < img.pixels.length; i++){
    color c = img.pixels[i];
    img.pixels[i] = color(red(c)*0.3 + green(c)*0.59 + blue(c)*0.11);
  }
  
  updatePixels();
}
