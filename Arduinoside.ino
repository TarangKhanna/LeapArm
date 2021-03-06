#include <Servo.h>
#include <avr/pgmspace.h>

Servo servo[4];

String inputString = "";
String servoString = "";
String commandString = "";
boolean stringComplete = false;

void setup(){
  Serial.begin(9600);// check that this is similar with the processing side 
  Serial.println("Go...");

  inputString.reserve(10);
  servoString.reserve(10);
  commandString.reserve(10);

  servo[0].attach(2);
  delay(100);
  servo[1].attach(3);
  delay(100);
  servo[2].attach(4);
  delay(100);
  servo[3].attach(10);
  delay(100);
  servo[4].attach(11);
  delay(100);
  
  servo[0].write(90);
  delay(100);
  servo[1].write(90);
  delay(100);
  servo[2].write(90);
  delay(100);
  servo[3].write(90);
  delay(100);
  servo[4].write(90);
 
}

void loop(){
  parseCommand();
}

void finish(){
  while(true){
    ;
    ;
  }
}

void serialEvent() {
  while (Serial.available()) {
    // get the new byte:
    char inChar = (char)Serial.read(); 
    // add it to the inputString:
    inputString += inChar;
    // if the incoming character is a newline, set a flag
    // so the main loop can do something about it:
    if (inChar == '\n') {
      stringComplete = true;
    } 
  }
}

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
    // clear the string:
    inputString = "";
    servoString = "";
    commandString = "";
    stringComplete = false;
  }
}






