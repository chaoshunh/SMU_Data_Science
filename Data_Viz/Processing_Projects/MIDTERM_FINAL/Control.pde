// control with CP5

void createRadioButton()
{
   radioButton = cp5.addRadioButton("radioButton")
   .setPosition(178,20)
   .setSize(40,40)
   .setItemsPerRow (4)
   .setSpacingColumn(100)
   .setColorLabel(color(#0A0101))
   .setColorForeground(color(120))
   .addItem("Bar Chart",1)
   .addItem("Scatter Plot",2)
   .addItem("Pie Chart",3)
   .addItem("Heat Map",4);
   
    for(Toggle t:radioButton.getItems()) {
       t.getCaptionLabel().setColorBackground(color(255,80));
       t.getCaptionLabel().getStyle().moveMargin(-7,0,0,-3);
       t.getCaptionLabel().getStyle().movePadding(7,0,0,3);
       t.getCaptionLabel().getStyle().backgroundWidth = 45;
       t.getCaptionLabel().getStyle().backgroundHeight = 13;
     }
}

void keyPressed() {
  switch(key) {
    case('0'): radioButton.deactivateAll(); break;
    case('1'): radioButton.activate(0); break;
    case('2'): radioButton.activate(1); break;
    case('3'): radioButton.activate(2); break;
    case('4'): radioButton.activate(3); break;
  }  
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isFrom(radioButton)) {
    for(int i=0;i<theEvent.getGroup().getArrayValue().length;i++) {
      int value = int(theEvent.getGroup().getArrayValue()[i]);
      if(value > 0) {
        arrayIndex = i;
      }
    }
  }
}