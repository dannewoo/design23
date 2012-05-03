import controlP5.*;
import processing.pdf.*;

ArrayList<CBDataObjects> cbdataList = new ArrayList();

CBDataObjects vo;
Table myTable;
CBDataBin bin;

ControlP5 controlP5;
ControlWindow controlWindow;
ColorPicker cp;

public int ChartWidth = 268;
public int ChartHeight = 546;
public int ChartYPos = 152;
public int ChartXPos = 147;
public float XAxisLineWeight = 0.5;
public float BarHeight = 4.0;
public float MapCircleDiameter = 135;
public float MapCircleWeight = 0.5;
public int MapCircleYPos = 63;
public int MapCircleXPos = 0;
public int MapTextYPos = 21;
public int MapYPos = 48;
public int HeaderYPos = 84;
public int HeaderXPos = 35;
public int HeaderWidth = 540;
public int TitleXPos = 92;
public int TitleTextBoxW = 350;
public float HeaderLineWeight = 0.5;

PShape states, statesOutline, alabama, alaska, arizona, arkansas, california, colorado, 
connecticut, delaware, florida, georgia, hawaii, idaho, illinois, indiana, iowa, kansas, 
kentucky, louisiana, maine, maryland, massachusetts, michigan, minnesota, mississippi, 
missouri, montana, nebraska, nevada, newHampshire, newJersey, newMexico, newYork, northCarolina, 
northDakota, ohio, oklahoma, oregon, pennsylvania, rhodeIsland, southCarolina, southDakota, 
tennessee, texas, utah, vermont, virginia, washington, westVirginia, wisconsin, wyoming;

int chartWidth, chartHeight;
int chartYPos, chartXPos;
int xAxisLineHeight;
float xAxisLineWeight;

int barColor;
float barHeight;
int xAxisLineColor;
int textColor;
int sectionColor;
int mapBelowColor;

float mapCircleDiameter;
float mapCircleXPos, mapCircleYPos;
float mapCircleWeight;
float mapCircleOutlineColor;
float mapTextYPos;
float mapXPos, mapYPos;
int mapLightGray;

int headerYPos, headerXPos;
int headerWidth;
int titleXPos;
float headerLineWeight;
int titleTextBoxW;
int titleColor;
int sourceColor;

PFont universCNBold, universCN, serifaBold, serifaRoman;

boolean recording = false;

void setup () {
  background(255);
  size(612, 792);
  controlP5 = new ControlP5(this);
  controlP5.setAutoDraw(false);
  controlWindow = controlP5.addControlWindow("controlP5window", 0, 0, 400, 600);
  controlWindow.hideCoordinates();

  // Bar chart sliders
  controlWindow.setBackground(color(0));
  Controller chartWidth = controlP5.addSlider("ChartWidth", 0, 1000, 10, 10, 250, 10);
  chartWidth.setWindow(controlWindow);
  Controller chartHeight = controlP5.addSlider("ChartHeight", 0, 1000, 10, 20, 250, 10);
  chartHeight.setWindow(controlWindow);
  Controller chartYPos = controlP5.addSlider("ChartYPos", 0, 1000, 10, 30, 250, 10);
  chartYPos.setWindow(controlWindow);
  Controller chartXPos = controlP5.addSlider("ChartXPos", 0, 1000, 10, 40, 250, 10);
  chartXPos.setWindow(controlWindow);
  Controller xAxisLineWeight = controlP5.addSlider("XAxisLineWeight", 0.0, 5.0, 10, 50, 250, 10);
  xAxisLineWeight.setWindow(controlWindow);
  Controller barHeight = controlP5.addSlider("BarHeight", 0.0, 10.0, 10, 60, 250, 10);
  barHeight.setWindow(controlWindow);

  // Map sliders
  Controller mapCircleDiameter = controlP5.addSlider("MapCircleDiameter", 0, 400, 10, 80, 250, 10);
  mapCircleDiameter.setWindow(controlWindow);
  Controller mapCircleWeight = controlP5.addSlider("MapCircleWeight", 0.0, 10.0, 10, 90, 250, 10);
  mapCircleWeight.setWindow(controlWindow);
  Controller mapCircleYPos = controlP5.addSlider("MapCircleYPos", 0, 1000, 10, 100, 250, 10);
  mapCircleYPos.setWindow(controlWindow);
  Controller mapCircleXPos = controlP5.addSlider("MapCircleXPos", -800, 200, 10, 110, 250, 10);
  mapCircleXPos.setWindow(controlWindow);
  Controller mapTextYPos = controlP5.addSlider("MapTextYPos", 0, 200, 10, 120, 250, 10);
  mapTextYPos.setWindow(controlWindow);
  Controller mapYPos = controlP5.addSlider("MapYPos", 0, 200, 10, 130, 250, 10);
  mapYPos.setWindow(controlWindow);

  // Header controls
  Controller headerYPos = controlP5.addSlider("HeaderYPos", 0, 1000, 10, 150, 250, 10);
  headerYPos.setWindow(controlWindow);
  Controller headerXPos = controlP5.addSlider("HeaderXPos", 0, 500, 10, 160, 250, 10);
  headerXPos.setWindow(controlWindow);
  Controller headerWidth = controlP5.addSlider("HeaderWidth", 0, 1000, 10, 170, 250, 10);
  headerWidth.setWindow(controlWindow);
  Controller titleXPos = controlP5.addSlider("TitleXPos", 0, 1000, 10, 180, 250, 10);
  titleXPos.setWindow(controlWindow);
  Controller titleTextBoxW = controlP5.addSlider("TitleTextBoxW", 0, 1000, 10, 190, 250, 10);
  titleTextBoxW.setWindow(controlWindow);
  Controller headerLineWeight = controlP5.addSlider("HeaderLineWeight", 0.0, 10.0, 10, 200, 250, 10);
  headerLineWeight.setWindow(controlWindow);
  
  // Section color selector
  //cp = controlP5.addColorPicker("picker",0,0,255,20);
  //cp.setWindow(controlWindow);

  // File selection
  Controller fileName = controlP5.addTextfield("File Name",10,220,250,20);
  fileName.setWindow(controlWindow);


  controlWindow.setTitle("Control Panel");

  noStroke();
  smooth();
  colorMode(RGB);
  statesOutline = loadShape("map_outline.svg");
  states = loadShape("map.svg");
  alabama = states.getChild("AL");
  alaska = states.getChild("AK");
  arizona = states.getChild("AZ");
  arkansas = states.getChild("AR");
  california = states.getChild("CA");
  colorado = states.getChild("CO");
  connecticut = states.getChild("CT");
  delaware = states.getChild("DE");
  florida = states.getChild("FL");
  georgia = states.getChild("GA");
  hawaii = states.getChild("HI");
  idaho = states.getChild("ID");
  illinois = states.getChild("IL");
  indiana = states.getChild("IN");
  iowa = states.getChild("IA");
  kansas = states.getChild("KS");
  kentucky = states.getChild("KY");
  louisiana = states.getChild("LA");
  maine = states.getChild("ME");
  maryland = states.getChild("MD");
  massachusetts = states.getChild("Mass");
  michigan = states.getChild("MI");
  minnesota = states.getChild("MN");
  mississippi = states.getChild("MS");
  missouri = states.getChild("MO");
  montana = states.getChild("MT");
  nebraska = states.getChild("NE");
  nevada = states.getChild("NV");
  newHampshire = states.getChild("NH");
  newJersey = states.getChild("NJ");
  newMexico = states.getChild("NM");
  newYork = states.getChild("NY");
  northCarolina = states.getChild("NC");
  northDakota = states.getChild("ND");
  ohio = states.getChild("OH");
  oklahoma = states.getChild("OK");
  oregon = states.getChild("OR");
  pennsylvania = states.getChild("PA");
  rhodeIsland = states.getChild("RI");
  southCarolina = states.getChild("SC");
  southDakota = states.getChild("SD");
  tennessee = states.getChild("TN");
  texas = states.getChild("TX");
  utah = states.getChild("UT");
  vermont = states.getChild("VT");
  virginia = states.getChild("VA");
  washington = states.getChild("WA");
  westVirginia = states.getChild("WV");
  wisconsin = states.getChild("WI");
  wyoming = states.getChild("WY");
  
  universCNBold = loadFont("UniversCom-67BoldCond-48.vlw");
  universCN = loadFont("UniversCom-57Condensed-48.vlw");
  serifaBold = loadFont("SerifaStd-Bold-14.vlw");
  serifaRoman = loadFont("SerifaStd-Bold-14.vlw");


  myTable = new Table(this, "1_1c_barchart.csv");

}

void draw () {
  if (recording) {
    beginRecord(PDF, "frame-####.pdf");
  }
  background(255);
  chartWidth = ChartWidth;
  chartHeight = ChartHeight;
  chartYPos = ChartYPos;
  chartXPos = ChartXPos;
  xAxisLineHeight = chartHeight + chartYPos;
  xAxisLineWeight = XAxisLineWeight;
  barHeight = BarHeight;

  barColor = color(#B2B4B6);
  xAxisLineColor = color(#A7A9AC);
  textColor = color(#6D6E70);
  sectionColor = color(#E89419);
  mapBelowColor = color(#A6A6A6);

  mapCircleDiameter = MapCircleDiameter;
  mapCircleXPos = chartWidth + chartXPos + MapCircleXPos + (mapCircleDiameter / 2);
  mapCircleYPos = chartYPos + MapCircleYPos + (mapCircleDiameter / 2);
  mapCircleWeight = MapCircleWeight;
  mapTextYPos = mapCircleYPos + MapTextYPos;
  mapXPos = mapCircleXPos - 66;
  mapYPos = mapCircleYPos - MapYPos;
  mapLightGray = color(#B2B4B6);
  mapCircleOutlineColor = color(#A7A9AC);

  headerYPos = HeaderYPos;
  headerXPos = HeaderXPos;
  headerWidth = HeaderWidth;
  titleXPos = HeaderXPos + TitleXPos;
  headerLineWeight = HeaderLineWeight;
  titleTextBoxW = TitleTextBoxW;
  titleColor = color(#231F20);
  sourceColor = color(#6D6E70);



  xAxis();
  getCBChart();
  headerDottedLine();
  mapCircle();
  shape(statesOutline, mapXPos, mapYPos);
  
  if (recording) {
    endRecord();
    recording = false;
  } 
  //println(frameRate);
}

void getCBChart () {

  float avgVal = 0; // pulled from data
  int avgCount = 0;

  // Table for all the data

  for (int i = 1; i < myTable.getRowCount(); i++) {
    String state =  myTable.getString(i, 0);
    if (state.equals("UNITED STATES")) {
      avgVal = myTable.getFloat(i, 1);
      avgCount = i;
    }
  }

  //  int naValue = 0;
  //  String naLabel;
  //  
  //  for (int i = 1; i < myTable.getRowCount(); i++) {
  //    String na = myTable.getString(i, 1);
  //    if (na.equals("na")) {
  //      naLabel = myTable.getString(i, 1);
  //      naValue = 0;
  //    }
  //  }

  for (int i = 1; i < myTable.getRowCount(); i++) {
    try {
      vo = new CBDataObjects();

      vo.cbdataState = myTable.getString(i, 0);
      vo.numPercent = myTable.getFloat(i, 1);
      vo.sectionColor = myTable.getFloat(i, 2);
      vo.chartID = myTable.getString(i, 3);
      vo.chartTitle = myTable.getString(i, 4);
      vo.chartSource = myTable.getString(i, 5);

      //if (naLabel == "na") vo.numPercent = 0;

      boolean usAverage = vo.cbdataState.equals("UNITED STATES");
      boolean alabamaCheck = vo.cbdataState.equals("Alabama");
      boolean alaskaCheck = vo.cbdataState.equals("Alaska");
      boolean arizonaCheck = vo.cbdataState.equals("Arizona");
      boolean arkansasCheck = vo.cbdataState.equals("Arkansas");
      boolean californiaCheck = vo.cbdataState.equals("California");
      boolean coloradoCheck = vo.cbdataState.equals("Colorado");
      boolean connecticutCheck = vo.cbdataState.equals("Connecticut");
      boolean delawareCheck = vo.cbdataState.equals("Delaware");
      boolean floridaCheck = vo.cbdataState.equals("Florida");
      boolean georgiaCheck = vo.cbdataState.equals("Georgia");
      boolean hawaiiCheck = vo.cbdataState.equals("Hawaii");
      boolean idahoCheck = vo.cbdataState.equals("Idaho");
      boolean illinoisCheck = vo.cbdataState.equals("Illinois");
      boolean indianaCheck = vo.cbdataState.equals("Indiana");
      boolean iowaCheck = vo.cbdataState.equals("Iowa");
      boolean kansasCheck = vo.cbdataState.equals("Kansas");
      boolean kentuckyCheck = vo.cbdataState.equals("Kentucky");
      boolean louisianaCheck = vo.cbdataState.equals("Louisiana");
      boolean maineCheck = vo.cbdataState.equals("Maine");
      boolean marylandCheck = vo.cbdataState.equals("Maryland");
      boolean massachusettsCheck = vo.cbdataState.equals("Massachusetts");
      boolean michiganCheck = vo.cbdataState.equals("Michigan");
      boolean minnesotaCheck = vo.cbdataState.equals("Minnesota");
      boolean mississippiCheck = vo.cbdataState.equals("Mississippi");
      boolean missouriCheck = vo.cbdataState.equals("Missouri");
      boolean montanaCheck = vo.cbdataState.equals("Montana");
      boolean nebraskaCheck = vo.cbdataState.equals("Nebraska");
      boolean nevadaCheck = vo.cbdataState.equals("Nevada");
      boolean newHampshireCheck = vo.cbdataState.equals("New Hampshire");
      boolean newJerseyCheck = vo.cbdataState.equals("New Jersey");
      boolean newMexicoCheck = vo.cbdataState.equals("New Mexico");
      boolean newYorkCheck = vo.cbdataState.equals("New York");
      boolean northCarolinaCheck = vo.cbdataState.equals("North Carolina");
      boolean northDakotaCheck = vo.cbdataState.equals("North Dakota");
      boolean ohioCheck = vo.cbdataState.equals("Ohio");
      boolean oklahomaCheck = vo.cbdataState.equals("Oklahoma");
      boolean oregonCheck = vo.cbdataState.equals("Oregon");
      boolean pennsylvaniaCheck = vo.cbdataState.equals("Pennsylvania");
      boolean rhodeIslandCheck = vo.cbdataState.equals("Rhode Island");
      boolean southCarolinaCheck = vo.cbdataState.equals("South Carolina");
      boolean southDakotaCheck = vo.cbdataState.equals("South Dakota");
      boolean tennesseeCheck = vo.cbdataState.equals("Tennessee");
      boolean texasCheck = vo.cbdataState.equals("Texas");
      boolean utahCheck = vo.cbdataState.equals("Utah");
      boolean vermontCheck = vo.cbdataState.equals("Vermont");
      boolean virginiaCheck = vo.cbdataState.equals("Virginia");
      boolean washingtonCheck = vo.cbdataState.equals("Washington");
      boolean westVirginiaCheck = vo.cbdataState.equals("West Virginia");
      boolean wisconsinCheck = vo.cbdataState.equals("Wisconsin");
      boolean wyomingCheck = vo.cbdataState.equals("Wyoming");

      float numbers = vo.numPercent;
      float w = map(numbers, 0, 100, 0, chartWidth - 7);
      float barY = map(i, 0, 51, 0, chartHeight - 25);
      float aboveAverage = map(avgVal, 0, 100, 0, chartWidth - 7);

      // Map ----------------------------------------------------------

      // States
      if (alabamaCheck && i < avgCount) {
        alabama.disableStyle();
        fill(sectionColor);
        shape(alabama, mapXPos, mapYPos);
      } 
      else {
        shape(alabama, mapXPos, mapYPos);
      }
      if (alaskaCheck && i < avgCount) {
        alaska.disableStyle();
        fill(sectionColor);
        shape(alaska, mapXPos, mapYPos);
      } 
      else {
        shape(alaska, mapXPos, mapYPos);
      }
      if (arizonaCheck && i < avgCount) {
        arizona.disableStyle();
        fill(sectionColor);
        shape(arizona, mapXPos, mapYPos);
      } 
      else {
        shape(arizona, mapXPos, mapYPos);
      }
      if (arkansasCheck && i < avgCount) {
        arkansas.disableStyle();
        fill(sectionColor);
        shape(arkansas, mapXPos, mapYPos);
      } 
      else {
        shape(arkansas, mapXPos, mapYPos);
      }
      if (californiaCheck && i < avgCount) {
        california.disableStyle();
        fill(sectionColor);
        shape(california, mapXPos, mapYPos);
      } 
      else {
        shape(california, mapXPos, mapYPos);
      }
      if (coloradoCheck && i < avgCount) {
        colorado.disableStyle();
        fill(sectionColor);
        shape(colorado, mapXPos, mapYPos);
      } 
      else {
        shape(colorado, mapXPos, mapYPos);
      }
      if (connecticutCheck && i < avgCount) {
        connecticut.disableStyle();
        fill(sectionColor);
        shape(connecticut, mapXPos, mapYPos);
      } 
      else {
        shape(connecticut, mapXPos, mapYPos);
      }
      if (delawareCheck && i < avgCount) {
        delaware.disableStyle();
        fill(sectionColor);
        shape(delaware, mapXPos, mapYPos);
      } 
      else {
        shape(delaware, mapXPos, mapYPos);
      }
      if (floridaCheck && i < avgCount) {
        florida.disableStyle();
        fill(sectionColor);
        shape(florida, mapXPos, mapYPos);
      } 
      else {
        shape(florida, mapXPos, mapYPos);
      }
      if (georgiaCheck && i < avgCount) {
        georgia.disableStyle();
        fill(sectionColor);
        shape(georgia, mapXPos, mapYPos);
      } 
      else {
        shape(georgia, mapXPos, mapYPos);
      }
      if (hawaiiCheck && i < avgCount) {
        hawaii.disableStyle();
        fill(sectionColor);
        shape(hawaii, mapXPos, mapYPos);
      } 
      else {
        shape(hawaii, mapXPos, mapYPos);
      }
      if (idahoCheck && i < avgCount) {
        idaho.disableStyle();
        fill(sectionColor);
        shape(idaho, mapXPos, mapYPos);
      } 
      else {
        shape(idaho, mapXPos, mapYPos);
      }
      if (illinoisCheck && i < avgCount) {
        illinois.disableStyle();
        fill(sectionColor);
        shape(illinois, mapXPos, mapYPos);
      } 
      else {
        shape(illinois, mapXPos, mapYPos);
      }
      if (indianaCheck && i < avgCount) {
        indiana.disableStyle();
        fill(sectionColor);
        shape(indiana, mapXPos, mapYPos);
      } 
      else {
        shape(indiana, mapXPos, mapYPos);
      }
      if (iowaCheck && i < avgCount) {
        iowa.disableStyle();
        fill(sectionColor);
        shape(iowa, mapXPos, mapYPos);
      } 
      else {
        shape(iowa, mapXPos, mapYPos);
      }
      if (kansasCheck && i < avgCount) {
        kansas.disableStyle();
        fill(sectionColor);
        shape(kansas, mapXPos, mapYPos);
      } 
      else {
        shape(kansas, mapXPos, mapYPos);
      }
      if (kentuckyCheck && i < avgCount) {
        kentucky.disableStyle();
        fill(sectionColor);
        shape(kentucky, mapXPos, mapYPos);
      } 
      else {
        shape(kentucky, mapXPos, mapYPos);
      }
      if (louisianaCheck && i < avgCount) {
        louisiana.disableStyle();
        fill(sectionColor);
        shape(louisiana, mapXPos, mapYPos);
      } 
      else {
        shape(louisiana, mapXPos, mapYPos);
      }
      if (maineCheck && i < avgCount) {
        maine.disableStyle();
        fill(sectionColor);
        shape(maine, mapXPos, mapYPos);
      } 
      else {
        shape(maine, mapXPos, mapYPos);
      }
      if (marylandCheck && i < avgCount) {
        maryland.disableStyle();
        fill(sectionColor);
        shape(maryland, mapXPos, mapYPos);
      } 
      else {
        shape(maryland, mapXPos, mapYPos);
      }
      if (massachusettsCheck && i < avgCount) {
        massachusetts.disableStyle();
        fill(sectionColor);
        shape(massachusetts, mapXPos, mapYPos);
      } 
      else {
        shape(massachusetts, mapXPos, mapYPos);
      }
      if (michiganCheck && i < avgCount) {
        michigan.disableStyle();
        fill(sectionColor);
        shape(michigan, mapXPos, mapYPos);
      } 
      else {
        shape(michigan, mapXPos, mapYPos);
      }
      if (minnesotaCheck && i < avgCount) {
        minnesota.disableStyle();
        fill(sectionColor);
        shape(minnesota, mapXPos, mapYPos);
      } 
      else {
        shape(minnesota, mapXPos, mapYPos);
      }
      if (mississippiCheck && i < avgCount) {
        mississippi.disableStyle();
        fill(sectionColor);
        shape(mississippi, mapXPos, mapYPos);
      } 
      else {
        shape(mississippi, mapXPos, mapYPos);
      }
      if (missouriCheck && i < avgCount) {
        missouri.disableStyle();
        fill(sectionColor);
        shape(missouri, mapXPos, mapYPos);
      } 
      else {
        shape(missouri, mapXPos, mapYPos);
      }
      if (montanaCheck && i < avgCount) {
        montana.disableStyle();
        fill(sectionColor);
        shape(montana, mapXPos, mapYPos);
      } 
      else {
        shape(montana, mapXPos, mapYPos);
      }
      if (nebraskaCheck && i < avgCount) {
        nebraska.disableStyle();
        fill(sectionColor);
        shape(nebraska, mapXPos, mapYPos);
      } 
      else {
        shape(nebraska, mapXPos, mapYPos);
      }
      if (nevadaCheck && i < avgCount) {
        nevada.disableStyle();
        fill(sectionColor);
        shape(nevada, mapXPos, mapYPos);
      } 
      else {
        shape(nevada, mapXPos, mapYPos);
      }
      if (newHampshireCheck && i < avgCount) {
        newHampshire.disableStyle();
        fill(sectionColor);
        shape(newHampshire, mapXPos, mapYPos);
      } 
      else {
        shape(newHampshire, mapXPos, mapYPos);
      }
      if (newJerseyCheck && i < avgCount) {
        newJersey.disableStyle();
        fill(sectionColor);
        shape(newJersey, mapXPos, mapYPos);
      } 
      else {
        shape(newJersey, mapXPos, mapYPos);
      }
      if (newMexicoCheck && i < avgCount) {
        newMexico.disableStyle();
        fill(sectionColor);
        shape(newMexico, mapXPos, mapYPos);
      } 
      else {
        shape(newMexico, mapXPos, mapYPos);
      }
      if (newYorkCheck && i < avgCount) {
        newYork.disableStyle();
        fill(sectionColor);
        shape(newYork, mapXPos, mapYPos);
      } 
      else {
        shape(newYork, mapXPos, mapYPos);
      }
      if (northCarolinaCheck && i < avgCount) {
        northCarolina.disableStyle();
        fill(sectionColor);
        shape(northCarolina, mapXPos, mapYPos);
      } 
      else {
        shape(northCarolina, mapXPos, mapYPos);
      }
      if (northDakotaCheck && i < avgCount) {
        northDakota.disableStyle();
        fill(sectionColor);
        shape(northDakota, mapXPos, mapYPos);
      } 
      else {
        shape(northDakota, mapXPos, mapYPos);
      }
      if (ohioCheck && i < avgCount) {
        ohio.disableStyle();
        fill(sectionColor);
        shape(ohio, mapXPos, mapYPos);
      } 
      else {
        shape(ohio, mapXPos, mapYPos);
      }
      if (oklahomaCheck && i < avgCount) {
        oklahoma.disableStyle();
        fill(sectionColor);
        shape(oklahoma, mapXPos, mapYPos);
      } 
      else {
        shape(oklahoma, mapXPos, mapYPos);
      }
      if (oregonCheck && i < avgCount) {
        oregon.disableStyle();
        fill(sectionColor);
        shape(oregon, mapXPos, mapYPos);
      } 
      else {
        shape(oregon, mapXPos, mapYPos);
      }
      if (pennsylvaniaCheck && i < avgCount) {
        pennsylvania.disableStyle();
        fill(sectionColor);
        shape(pennsylvania, mapXPos, mapYPos);
      } 
      else {
        shape(pennsylvania, mapXPos, mapYPos);
      }
      if (rhodeIslandCheck && i < avgCount) {
        rhodeIsland.disableStyle();
        fill(sectionColor);
        shape(rhodeIsland, mapXPos, mapYPos);
      } 
      else {
        shape(rhodeIsland, mapXPos, mapYPos);
      }
      if (southCarolinaCheck && i < avgCount) {
        southCarolina.disableStyle();
        fill(sectionColor);
        shape(southCarolina, mapXPos, mapYPos);
      } 
      else {
        shape(southCarolina, mapXPos, mapYPos);
      }
      if (southDakotaCheck && i < avgCount) {
        southDakota.disableStyle();
        fill(sectionColor);
        shape(southDakota, mapXPos, mapYPos);
      } 
      else {
        shape(southDakota, mapXPos, mapYPos);
      }
      if (tennesseeCheck && i < avgCount) {
        tennessee.disableStyle();
        fill(sectionColor);
        shape(tennessee, mapXPos, mapYPos);
      } 
      else {
        shape(tennessee, mapXPos, mapYPos);
      }
      if (texasCheck && i < avgCount) {
        texas.disableStyle();
        fill(sectionColor);
        shape(texas, mapXPos, mapYPos);
      } 
      else {
        shape(texas, mapXPos, mapYPos);
      }
      if (utahCheck && i < avgCount) {
        utah.disableStyle();
        fill(sectionColor);
        shape(utah, mapXPos, mapYPos);
      } 
      else {
        shape(utah, mapXPos, mapYPos);
      }
      if (vermontCheck && i < avgCount) {
        vermont.disableStyle();
        fill(sectionColor);
        shape(vermont, mapXPos, mapYPos);
      } 
      else {
        shape(vermont, mapXPos, mapYPos);
      }
      if (virginiaCheck && i < avgCount) {
        virginia.disableStyle();
        fill(sectionColor);
        shape(virginia, mapXPos, mapYPos);
      } 
      else {
        shape(virginia, mapXPos, mapYPos);
      }
      if (washingtonCheck && i < avgCount) {
        washington.disableStyle();
        fill(sectionColor);
        shape(washington, mapXPos, mapYPos);
      } 
      else {
        shape(washington, mapXPos, mapYPos);
      }
      if (westVirginiaCheck && i < avgCount) {
        westVirginia.disableStyle();
        fill(sectionColor);
        shape(westVirginia, mapXPos, mapYPos);
      } 
      else {
        shape(westVirginia, mapXPos, mapYPos);
      }
      if (wisconsinCheck && i < avgCount) {
        wisconsin.disableStyle();
        fill(sectionColor);
        shape(wisconsin, mapXPos, mapYPos);
      } 
      else {
        shape(wisconsin, mapXPos, mapYPos);
      }
      if (wyomingCheck && i < avgCount) {
        wyoming.disableStyle();
        fill(sectionColor);
        shape(wyoming, mapXPos, mapYPos);
      } 
      else {
        shape(wyoming, mapXPos, mapYPos);
      }

      // Circle
      if (usAverage) {
        // Circle text above average
        fill(sectionColor);
        textAlign(CENTER);
        textFont(serifaRoman, 11); 
        text(i-1, mapCircleXPos, mapTextYPos);

        fill(mapLightGray);
        textFont(serifaRoman, 11); 
        text(52-i, mapCircleXPos, mapTextYPos + 36);
      }

      // Chart ------------------------------------------------------

      // Barchart
      fill(barColor);
      noStroke();
      rect(chartXPos, barY + chartYPos + 5, w, barHeight);

      // Average line
      if (usAverage) {
        stroke(sectionColor);
        strokeWeight(xAxisLineWeight);
        line(chartXPos + w, chartYPos + 10, chartXPos + w, xAxisLineHeight);
        noStroke();
        fill(sectionColor);
        ellipse(chartXPos + w, xAxisLineHeight, 42, 42);
        fill(#ffffff);
        textAlign(CENTER);
        //AVG text
        textFont(universCNBold, 6);
        text("AVG", chartXPos + w, xAxisLineHeight - 11);
        //Average percent
        textFont(universCNBold, 15);
        text(vo.numPercent + "", chartXPos + w, xAxisLineHeight + 5);
        //%
        textFont(universCNBold, 8);
        text("%", chartXPos + w, xAxisLineHeight + 16);
      }

      // Average bars
      if (i <= avgCount) {
        fill(sectionColor);
        noStroke();
        rect(chartXPos + aboveAverage, barY + chartYPos + 5, w - aboveAverage, barHeight);
      }

      if (vo.numPercent > 0) {
        // States
        textAlign(RIGHT);
        if (usAverage) {
          fill(sectionColor); 
          textFont(universCNBold, 8);
        } 
        else {
          fill(textColor);
          textFont(universCN, 7);
        }
        text(vo.cbdataState, chartXPos - 27, barY + chartYPos+10);

        // Percentage
        textAlign(LEFT);
        if (usAverage) {
          fill(sectionColor); 
          textFont(universCNBold, 8);
        } 
        else {
          fill(textColor);
          textFont(universCN, 7);
        }
        text(vo.numPercent + "%", chartXPos - 23, barY + chartYPos+10);
      }

      // Chart Header ---------------------------------------------------------

      // Chart ID
      fill(sectionColor);
      textAlign(LEFT, TOP);
      textFont(serifaBold, 14); 
      text(vo.chartID, headerXPos, headerYPos + 10, 50, 50);

      // Title
      fill(titleColor);
      textAlign(LEFT, TOP);
      textFont(serifaBold, 11); 
      text(vo.chartTitle, titleXPos, headerYPos + 10, titleTextBoxW, 50);

      // Source
      fill(sourceColor);
      textAlign(LEFT, TOP);
      textFont(universCN, 7); 
      text(vo.chartSource, titleXPos, headerYPos + 40, titleTextBoxW, 50);
    }
    catch(Exception e) {
    }
  }
}

void mapCircle () {
  noFill();
  strokeWeight(mapCircleWeight);
  stroke(#A7A9AC);
  ellipse(mapCircleXPos, mapCircleYPos, mapCircleDiameter, mapCircleDiameter);

  textAlign(CENTER);
  fill(sectionColor);
  textFont(serifaRoman, 5.6); 
  text("States", mapCircleXPos, mapTextYPos + 7);

  textFont(serifaBold, 6); 
  text("U.S. Average", mapCircleXPos, mapTextYPos + 19);

  fill(mapLightGray);
  textFont(serifaRoman, 5.6); 
  text("States", mapCircleXPos, mapTextYPos + 42);

  pushMatrix();
  translate(mapCircleXPos, mapTextYPos + 23);
  triangleArrowDown();
  popMatrix();

  pushMatrix();
  translate(mapCircleXPos, mapTextYPos + 10);
  triangleArrowUp();
  popMatrix();
}

void triangleArrowUp () {
  int sectionColor = color(#E89419);
  noStroke();
  fill(sectionColor);
  triangle(0, 2.6, 1.4, 0, 2.8, 2.6);
  stroke(sectionColor);
  strokeWeight(0.5);
  translate(-16, 0);
  line(0, 2.6, 34, 2.6);
}

void triangleArrowDown () {
  int downArrowColor = color(#B2B4B6);
  noStroke();
  fill(downArrowColor);
  triangle(0, 0, 1.4, 2.6, 2.8, 0);
  stroke(downArrowColor);
  strokeWeight(0.5);
  translate(-16, 0);
  line(0, 0, 34, 0);
}

void xAxis () {
  // X-Axis numbers
  int xAxisNum = 0;
  float xAxisDottedLine = chartYPos;
  for (int j = 0; j < chartWidth; j += chartWidth/10) {
    for (xAxisDottedLine = chartYPos; xAxisDottedLine < xAxisLineHeight; xAxisDottedLine += 3) {
      stroke(xAxisLineColor);
      strokeWeight(xAxisLineWeight);
      line(chartXPos + j, xAxisDottedLine, chartXPos + j, xAxisDottedLine + 0.5);
    }

    fill(textColor);
    textFont(universCN, 7);
    textAlign(LEFT);
    text(xAxisNum, chartXPos + j + 4, chartYPos + 5);

    xAxisNum += 10;
  }
  stroke(xAxisLineColor);
  strokeWeight(xAxisLineWeight);
  line(chartXPos, chartYPos, chartXPos, xAxisLineHeight);
}

void headerDottedLine () {
  pushMatrix();
  translate(headerXPos, 0);
  for (int dottedLine = 0; dottedLine < headerWidth; dottedLine += 4) {
    stroke(sectionColor);
    strokeWeight(headerLineWeight);
    line(dottedLine, headerYPos, dottedLine + 2, headerYPos);
  }
  popMatrix();
}

void keyPressed() {
  if (key=='h') controlP5.window("controlP5window").hide();
  if (key=='s') controlP5.window("controlP5window").show();
  if (key=='p') {
    recording = true;
    //endRecord();
    //exit();
  }
}

