import de.voidplus.leapmotion.*;
import controlP5.*;
LeapMotion leap;
import g4p_controls.*;
Serial myPort;
import processing.serial.*;

String s="";
float A = 95.25; //millimeters
float B = 107.95;
float rtod = 57.295779;

float X = 85.0;
float Y = 85.0;
int Z = 90;
int G = 90;
int WR = 90;
float WA = 0;

float tmpx = 85.0;
float tmpy = 85.0;
int tmpz = 90;
int tmpg = 90;
int tmpwr = 90;
float tmpwa = 0;
ControlP5 cp5;

int myColorBackground = color(0, 0, 0);
int knobValue = 100;

Knob myKnobA;
Knob myKnobB;
Knob myKnobC;
Knob myKnobD;
Knob myKnobE;

void setup() {
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');
  
  size(700, 400);

  smooth();
  noStroke();
  leap = new LeapMotion(this).withGestures();
  cp5 = new ControlP5(this);

  myKnobA = cp5.addKnob("knob")
    .setRange(0, 180)
      .setValue(50)
        .setPosition(50, 50)
          .setRadius(50)
            .setDragDirection(Knob.VERTICAL)
              ;

  myKnobB = cp5.addKnob("knobB")
    .setRange(0, 180)
      .setValue(50)
        .setPosition(170, 250)
          .setRadius(50)
            .setDragDirection(Knob.VERTICAL)
              ;
  myKnobC = cp5.addKnob("knobC")
    .setRange(0, 180)
      .setValue(50)
        .setPosition(290, 50)
          .setRadius(50)
            .setDragDirection(Knob.VERTICAL)
              ;
  myKnobD = cp5.addKnob("knobD")
    .setRange(0, 180)
      .setValue(50)
        .setPosition(440, 250)
          .setRadius(50)
            .setDragDirection(Knob.VERTICAL)
              ;  

  myKnobE = cp5.addKnob("knobE")
    .setRange(0, 180)
      .setValue(50)
        .setPosition(550, 50)
          .setRadius(50)
            .setDragDirection(Knob.VERTICAL)
              ;
              
          
}

void draw() {
  background(myColorBackground);
  fill(knobValue);
  rect(0, height/2, width, height/2);
  fill(0, 100);
  int fps = leap.getFrameRate();
  ArrayList hands = leap.getHands();
  if (!hands.isEmpty()) {
    Hand hand1 = (Hand) hands.toArray()[0];
    //Hand hand2 = (Hand) hands.toArray()[1];

    //hand.draw();
    //int     hand_id          = hand.getId();
    PVector hand1_position    = hand1.getPosition();
    PVector hand1_stabilized  = hand1.getStabilizedPosition();
    float   hand1_roll        = hand1.getRoll();
    float   hand1_time        = hand1.getTimeVisible();
    if (hand1_time>1.0) {
      println("x: " +hand1_stabilized.x+" y: "+hand1_stabilized.y+" z:"+hand1_stabilized.z);
      float transHand1PosZ = map(hand1_stabilized.x, 150, 450, 50, 130);
      myKnobA.setValue(transHand1PosZ);
      float transHand1PosY = map(hand1_stabilized.y, 550, 300, 20, 130);
      myKnobB.setValue(transHand1PosY);
      float transHand1PosX = map(hand1_position.z, 30, 55, 20, 175);
     myKnobC.setValue(transHand1PosX);
      float transHand1Roll = map(hand1_roll, 30, -30, 45, -80);
       myKnobE.setValue(transHand1Roll);

    }
  }
}

    int Arm(float x, float y, float z, int g, float wa, int wr) {
      
        float M = sqrt((y*y)+(x*x));
        if (M <= 0)
          return 1;
        float A1 = atan(y/x);
        float A2 = acos((A*A-B*B+M*M)/((A*2)*M));
        float Elbow = acos((A*A+B*B-M*M)/((A*2)*B));
        float Shoulder = A1 + A2;
        Elbow = Elbow * rtod;
        Shoulder = Shoulder * rtod;
        while ( (int)Elbow <= 0 || (int)Shoulder <= 0)
          return 1;
        float Wris = abs(wa - Elbow - Shoulder) - 90;
        myKnobC.setValue(Shoulder);
        myKnobE.setValue(180-Elbow);
       // slider4.setValue(180-Wris);
        Y = tmpy;
        X = tmpx;
        Z = tmpz;
        WA = tmpwa;
        G = tmpg;
        WR = tmpwr;
        return 0;
      }
    
public void myKnobB(int theValue) {
  myPort.clear();
  myPort.write("0,"+theValue+"\n");
 }

public void knob(int theValue)
{
 println("www"+theValue); 
}

public void leapOnCircleGesture(CircleGesture g, int state){
  int       id               = g.getId();
  Finger    finger           = g.getFinger();
  PVector   position_center  = g.getCenter();
  float     radius           = g.getRadius();
  float     progress         = g.getProgress();
  long      duration         = g.getDuration();
  float     duration_seconds = g.getDurationInSeconds();

  switch(state){
    case 1: // Start
      break;
    case 2: // Update
      break;
    case 3: // Stop
      println("CircleGesture: "+id);
      myPort.clear();
      myPort.write("6,"180"\n");
      break;
  }
