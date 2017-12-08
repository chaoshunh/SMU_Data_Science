// sub class of Planet
class Ring extends SpaceParticle{
 
    // draw rings around planets
    void ringAround(float locX, float locY, float diameter) {
      fill(#F7FF17);
      ellipse(locX, locY, diameter*1.25, diameter/15);
    }  

    int[] numRings() {
        int[] a = {0,0,0,0,0,1,1,0};
    return a; 
    }

}

    
  
  
