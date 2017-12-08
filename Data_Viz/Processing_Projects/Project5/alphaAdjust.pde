// alpha adjustment for each image's edges to ensure blending to frame shows frame completely
// easier way to do this, but want to use blend function and access pixels around image directly

void alphaAdjust(PImage img){
  img.loadPixels(); 
// used to brighten image edges to ensure blend works properly, pictures kept inside of frame

  // right side of frame
  for(int i = 0; i < img.height; i++){ // rows 
    for(int j = 0; j < img.width*.09; j++){ // frame column width 9% of image size
      img.pixels[((img.width*img.height)-1) - (img.width * i) - j ] = color(255,255,255);
    }
  }
 
  // top of frame
   for (int i = 0; i < img.height * .12; i++){  // frame column height 12% of image size
      for(int j = 0; j < img.width; j++){ 
        if(j < 1 || i < 1){img.pixels[img.width * i + j] = color(0,0,0);  // color edges dark to blend with background
        } else {
          img.pixels[img.width*i+j] = color(255,255,255);
      }
    }
  }  
  
  // left side of frame
   for (int i = 0; i < img.height; i++){  
      for(int j = 0; j < img.width * .09; j++){
        if(i < 1 || j < 1){img.pixels[img.width * i + j] = color(0,0,0);
      } else {
        img.pixels[img.width * i + j] = color(255,255,255);
      }
    }
  }

  // bottom of frame
   for (int i = 0; i < img.height*.12; i++){  
      for(int j = 0; j < img.width-1; j++){
        if(i < 1 || j < 1){img.pixels[img.width*img.height-1 - (img.width*i)-j] = color(0,0,0);
        } else {
          img.pixels[img.width *img.height - 1 - (img.width*i)-j] = color(255,255,255);
       }
     }
  }
  
  img.updatePixels();
}
