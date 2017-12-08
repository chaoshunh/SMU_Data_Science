// ControlBar sets the GUI on the dashboard to switch between visualizations
// engine passes to ControlBar to initialize menu
class ControlBar
{  
  ControlP5 cp5;
  RadioButton radioButton;
  int radioButtonCount = 0;
  
  //cstrs
  ControlBar(){}
  
  ControlBar(ControlP5 cp5, ArrayList<String> radioButtonNames) {
    this.cp5 = cp5;
    radioButtonCount = radioButtonNames.size();
    createRadioButton(radioButtonNames);
  }

  // methods
  void createRadioButton(ArrayList<String> radioButtonNames)
  {
    radioButton = cp5.addRadioButton("radioButton")
      .setPosition(width*.22, height*.02)
      .setSize(int(width*.05), int(height*.05))
      .setSpacingColumn(int(width*.12))
      .setColorLabel(color(#0A0101))
      .setColorForeground(color(120))
      .setItemsPerRow(radioButtonNames.size());
      
    int index = 0;
    for(String name: radioButtonNames)
    {
      radioButton.addItem(name, ++index);
    }
 
    for (Toggle t : radioButton.getItems()) {
      t.getCaptionLabel().setColorBackground(color(255, 80));
      t.getCaptionLabel().getStyle().moveMargin(-7, 0, 0, -3);
      t.getCaptionLabel().getStyle().movePadding(7, 0, 0, 3);
      t.getCaptionLabel().getStyle().backgroundWidth = 45;
      t.getCaptionLabel().getStyle().backgroundHeight = 13;
    }
  }

  void activateRadioButton(char radioKey)
  {
    int keyValue = Character.getNumericValue(radioKey);
    if(keyValue == 0 || keyValue > radioButtonCount) {
      radioButton.deactivateAll();
    }
    else 
    {
      radioButton.activate(keyValue-1);
    }
  }
}