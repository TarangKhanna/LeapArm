LeapArm
=======
The goal of this project was to understand how to use the leap motion sensor with the arduino and robotic arm. I use the Arduino mega for controlling the servos on the robotic arm. 

Used in the design and technology lab of YCIS currently to teach about different ways of robotic interactions. 

The code consists of two parts, processing IDE and arduino IDE. 
Parts used:

1)Leap motion sensor 

2)Arduino Mega 2560

3)Robotic arm with 5 Degrees of freedom (5 servo motors- rotation from 0 to 180 degrees). 

SETUP:
Download the code here and then be sure to have the PROCESSING IDE and ARDUINO IDE to run the code. Attach the leap motion sensor to the computer and the arduino to the computer. The setup of arduino to the robotics arm is shown in the images(just connect the pins to the servos and change the arduino code to represent the correct digital pin number). Description is given below.

=======


Project details:

Rationale: Controlling a robotic arm with a leap motion provides a natural interface as it lets the user control it by moving their hand. Making this project will take learning a new programming interface and applying what I have learned in the IB computer science. It will help gain a deeper understanding of robots, and the whole field of computer science. People need to see the end result of what they are learning in classes such as D&T and computer science. Making a robotic arm follow a humans hand seems very futuristic and will be sure to attract students to take up such fields. Ways that would be helpful in getting people interested in D&T, and would teach them about the design process and different usage of robots in the world.

Client- The client is the Head of the Design and Technology department at my school. He wants different ways to control the robotic arm for the D&T lab. 


The proposed solution was to control it with the Kinect, which was available to consumers at the time the solution was proposed. Since then I have decided to you the leap motion controller as it is much more accurate and is a more intuitive interface for controlling a robotic arm. The robotic arm provided is shown below. I have attached its servo motors to a breadboard which is attached to the Arduino Mega 2560.

Solution overview:

First I received the robotic arm from the D&T lab, I found out that it is based on a lynx motion kit (5 Degrees of Freedom).
Used an Arduino and replaced the default servo controller that came with the Lynx motion kit, as Arduino is compatible with the Kinect and also with the leap motion controller. 
After figuring out the servo it uses, the power each of it requires, I drew up a schematic to use power from the USB port and an external power source. The power source (Gives me 9VDC) plugged into the Vin and Gnd of the Arduino, the output plugged out from Vout and Gnd, this was attached to the rails on the breadboard. 

Learnt how to program an Arduino, using the Arduino IDE (Programming language used- C++) and Processing IDE (Programming language used- Java). Then I figured out how to use the leap motion controller with the Arduino board, luckily there was a library called leapmotion available for the Arduino, which gave me access to all the features of the Arduino such as finger ID, positions, rotation, etc. With this people will be able to use a robotic arm lying in the D&T lab intuitively. This will help the learning experience of computer science as well as D&T. 
After some feedback from people about not wanting to use a mouse click to initiate the grabber (5th servo motor), I decided to integrate a gesture to make it possible. The gesture is circling in a circle to trigger the movement of the grabber servo by toggling between 180 degrees and 0 degrees. 

Testing:

As I changed my approach to solving the clients problem, I have updated success criteria is as follows- 

Intuitive interface
Gestures to unlock interface
Data shown to user
Smooth response 
Flexible arm 
Able to pick up materials
=======

Development:

The schematic of the connections is reflected in the Arudino IDE by adding the code. 

  servo[0].attach(1);// Attaching to Arduino PWM pin 1
  servo[1].attach(2);//pin 2
  servo[2].attach(3);
  servo[3].attach(4);
  servo[4].attach(5);

The Arduino IDE is where we write the code which goes into the Arduino, here I use the serial processing library to create a serial connection between Arduino and a computer. 

void parseCommand(){
  // print the string when a newline arrives:
  if (stringComplete) {
    inputString.trim();
    //Serial.println(inputString);
    int separatorIndex = inputString.indexOf(',');
    servoString=inputString.substring(0,1);
    commandString=inputString.substring(separatorIndex+1);
    int servoNum = servoString.toInt();
    int servoPos = commandString.toInt();

    servo[servoNum].write(servoPos);
    inputString = "";
    servoString = "";
    commandString = "";
    stringComplete = false;
  }
}
Using this piece of code I was able to create a format which specifies how the Arduino will be able to read the serial. What this does is that with the processing IDE I will be able to send a string such as (“the servo number”+the desired angle+”/n to indicate a new line”)

First I tried integration with Kinect, which worked until the kinect was having problems with the communication protocols, and I found out that the user interface for controlling a robotic arm with their shoulders and full arms isn't practical even though it is intuitive. 

Then I found out about the leap motion sensor, which can precisely track finger movements and based upon this I started programming with the leap motion. 
Working up from basic finger tracking examples to create and understand leap motion programs.

For the interaction I opted for relative motion of the hands instead of calculating the position of 
So that the robot remains in sync with the hands no matter in which position the robot is in. 

The robotic-leap motion program is made up of two parts one on the Arduino side (with the Arduino IDE) and the other on the processing side (which handles the leap motion data). The Arduino IDE program is uploaded to the Arduino and this program:

Waits for serial data based upon a customized format (ID number of the servo motor, angle to move in degrees), this data comes from the processing IDE which is running on the computer, the program provides data to the specified serial port in this format. The processing IDE uses the leap motion library (for getting data from the leap motion) and the controlp5 library (for graphical user interface creation). First the libraries are imported, 
import de.voidplus.leapmotion.*;
import controlp5.*;
import processing.serial.*;
Serial myPort;
String s="";
LeapMotion leap;
I used the internet for referring to the usage of each library and their respective syntax. 

  leap = new LeapMotion(this);
  String portName = Serial.list()[0];After we have the hand positions we can calculate their movement with vectors. 

The leap motion controller and serial port are initialized and frames are taken to be processed.


In these frames we extract the finger positions and their relative movements, and create vectors. Then using inverse kinematic algorithms:


we map and emulate these vectors into movements for the servo motor. 

GUI is created using the controlP5 library, coded it as follows:

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
              
=======

For gesture recognition:

The main program is the same with using serial library and GUI presentation. 
The gesture works by making a cuircular hand movement over the leap motion. This is detected by using the database of gestures situated in the leap library, it is the same concept as machine learning where the gestures are compared with the huge database to identify different gestures. The code for detecting the gesture and then controlling the grabber is:

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
      myPort.clear(); //
      myPort.write("5,"+180+"\n"); // this is the format the Arduino serial connection is waiting for
      delay (20)  // so that the motor would stay open for 20 seconds, which is a fair amount of      //time for grabbing an object

      break;
  }
myPort.write("5,"+0+ "\n"); // write to the motor- the 5th motor is the grabber
}

=======
Explanation:

Using switch case we are able to invoke the servo motor to move by writing to the serial port, which is defined earlier in the program. We write 180 to open the grabber fully (in case 3), we include if the gesture is not detected the motor will stay close, by writing 0 degree angle to the same motor. Other things should be explained in comments.

=======

Recommendations for further improvement:

Requires a more fluent movement which can be solved by using computers with higher processing power, or by running the code on the GPU instead of its CPU, which would give parallel processing power.

A larger scaled robotic arm.

Add more DOF arms.

Manipulate robotic fingers. 


 






