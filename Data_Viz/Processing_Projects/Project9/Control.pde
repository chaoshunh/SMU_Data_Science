// Control function handles switching between visualizations
void controlEvent(ControlEvent theEvent) {
  if(theEvent.isFrom(e.controlBar.radioButton)) {
    for(int i=0; i < theEvent.getGroup().getArrayValue().length;i++) {
        int value = int(theEvent.getGroup().getArrayValue()[i]);
        if(value > 0) 
        {
          arrayIndex = i;
         }
      }
    }
  }