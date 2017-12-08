// custom convolution filter to blur image with much commentary

void blur(PImage img, int kernel){
  
  int counter, stepper;
  if(kernel == 5){ counter = 2; } else { counter = 1; };
  if(kernel == 5){ stepper = 1; } else { stepper = 0; };
  
  // create RGB blur effect
  float avg3 = 1.0/9.0;
  float avg5 = 1.0/16.0;
  // matrix with blur effect
  float[][][] Matrix = {
                      {{avg3, avg3, avg3},
                      {avg3, avg3, avg3},
                      {avg3, avg3, avg3}},
                      {{avg5, avg5, avg5, avg5, avg5},
                      {avg5, avg5, avg5, avg5, avg5},
                      {avg5, avg5, avg5, avg5, avg5},
                      {avg5, avg5, avg5, avg5, avg5},
                      {avg5, avg5, avg5, avg5, avg5},
                      {avg5, avg5, avg5, avg5, avg5}}
                       
                      };
                   
  // for each pixel on the screen except for top, bottom, sides to avoid OutofBounds error when applying matrix
  for(int i = counter; i < img.height - counter; i++){
    for(int j = counter; j < img.width - counter; j++){ 
      float[] sum = new float[3]; // placeholder for sum of matrix values for each RGB color
      // for each cell in the matrix (capture values of adjacent pixels in a 3x3 matrix/kernel on screen)
      // ensure -1 to 1 -- confirms a 3x3 square matrix moves around screen for each pixel position
      for (int l = -counter; l <= counter; l++){ 
        for (int m = -counter; m <= counter; m++){ 
          int k = (i + l) * img.width + (j + m); // one-d array position of pixels with neighbor stepping accounted for
          float val[] = {red(img.pixels[k]), green(img.pixels[k]), blue(img.pixels[k])}; // capture RGB values in 1D array
          for(int n = 0; n < val.length; n++){ // for each item in val array, in matrix position, multiply value by matrix value
            sum[n] += Matrix[stepper][l+counter][m+counter] * val[n]; // + 1 to account for negative variables in l and m and prevent OutofBounds error
        }
       } 
      }
     img.pixels[i*img.width+j] = color(sum[0],sum[1],sum[2]); // after looping through matrix, isolate pixel, recolor it based on averaged color elements from each neighboring pixel
    }
  }
img.updatePixels();
}
