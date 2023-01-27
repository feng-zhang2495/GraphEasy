/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:window1:214566:
  appc.background(230);
} //_CODE_:window1:214566:

public void equationFieldChanged(GTextField source, GEvent event) { //_CODE_:equationField:202076:
  println("equationField - GTextField >> GEvent." + event + " @ " + millis());
  equation = equationField.getText();
  graph = new Graph(equation);
} //_CODE_:equationField:202076:

public void xMinFieldChanged(GTextField source, GEvent event) { //_CODE_:xMinField:825895:
  println("textfield1 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:xMinField:825895:

public void xMaxFieldChanged(GTextField source, GEvent event) { //_CODE_:xMaxField:867678:
  println("textfield2 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:xMaxField:867678:

public void yMinFieldChanged(GTextField source, GEvent event) { //_CODE_:yMinField:729765:
  println("textfield3 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:yMinField:729765:

public void yMaxFieldChanged(GTextField source, GEvent event) { //_CODE_:yMaxField:569604:
  println("textfield4 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:yMaxField:569604:

public void textfield5_change1(GTextField source, GEvent event) { //_CODE_:xScaleField:578600:
  println("textfield5 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:xScaleField:578600:

public void yScaleFieldChanged(GTextField source, GEvent event) { //_CODE_:yScaleField:359421:
  println("textfield6 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:yScaleField:359421:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  window1 = GWindow.getWindow(this, "Window title", 0, 0, 400, 400, JAVA2D);
  window1.noLoop();
  window1.setActionOnClose(G4P.KEEP_OPEN);
  window1.addDrawHandler(this, "win_draw1");
  equationField = new GTextField(window1, 20, 70, 120, 20, G4P.SCROLLBARS_NONE);
  equationField.setPromptText("Equation");
  equationField.setOpaque(false);
  equationField.addEventHandler(this, "equationFieldChanged");
  equationLabel = new GLabel(window1, 10, 40, 80, 20);
  equationLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  equationLabel.setText("Equation");
  equationLabel.setOpaque(true);
  xMinField = new GTextField(window1, 20, 140, 120, 30, G4P.SCROLLBARS_NONE);
  xMinField.setPromptText("xMin");
  xMinField.setOpaque(true);
  xMinField.addEventHandler(this, "xMinFieldChanged");
  xMinLabel = new GLabel(window1, 20, 120, 80, 20);
  xMinLabel.setText("xMin");
  xMinLabel.setOpaque(false);
  xMaxLabel = new GLabel(window1, 20, 190, 80, 20);
  xMaxLabel.setText("xMax");
  xMaxLabel.setOpaque(false);
  xMaxField = new GTextField(window1, 20, 210, 120, 30, G4P.SCROLLBARS_NONE);
  xMaxField.setPromptText("xMax");
  xMaxField.setOpaque(true);
  xMaxField.addEventHandler(this, "xMaxFieldChanged");
  yMinLabel = new GLabel(window1, 200, 120, 80, 20);
  yMinLabel.setText("yMin");
  yMinLabel.setOpaque(false);
  yMinField = new GTextField(window1, 200, 140, 120, 30, G4P.SCROLLBARS_NONE);
  yMinField.setPromptText("yMin");
  yMinField.setOpaque(true);
  yMinField.addEventHandler(this, "yMinFieldChanged");
  yMaxLabel = new GLabel(window1, 200, 190, 80, 20);
  yMaxLabel.setText("yMax");
  yMaxLabel.setOpaque(false);
  yMaxField = new GTextField(window1, 200, 210, 120, 30, G4P.SCROLLBARS_NONE);
  yMaxField.setOpaque(true);
  yMaxField.addEventHandler(this, "yMaxFieldChanged");
  xScaleLabel = new GLabel(window1, 20, 260, 80, 20);
  xScaleLabel.setText("x scale");
  xScaleLabel.setOpaque(false);
  yScaleLabel = new GLabel(window1, 200, 260, 80, 20);
  yScaleLabel.setText("y scale");
  yScaleLabel.setOpaque(false);
  xScaleField = new GTextField(window1, 20, 280, 120, 30, G4P.SCROLLBARS_NONE);
  xScaleField.setOpaque(true);
  xScaleField.addEventHandler(this, "textfield5_change1");
  yScaleField = new GTextField(window1, 200, 280, 120, 30, G4P.SCROLLBARS_NONE);
  yScaleField.setOpaque(true);
  yScaleField.addEventHandler(this, "yScaleFieldChanged");
  window1.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow window1;
GTextField equationField; 
GLabel equationLabel; 
GTextField xMinField; 
GLabel xMinLabel; 
GLabel xMaxLabel; 
GTextField xMaxField; 
GLabel yMinLabel; 
GTextField yMinField; 
GLabel yMaxLabel; 
GTextField yMaxField; 
GLabel xScaleLabel; 
GLabel yScaleLabel; 
GTextField xScaleField; 
GTextField yScaleField; 
