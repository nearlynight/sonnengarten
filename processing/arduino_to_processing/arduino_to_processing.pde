import processing.serial.*;
import oscP5.*;
import netP5.*;

Serial myPort;  // Create object from Serial class
int val;     // Data received from the serial port
String time;
boolean my_touch = false;
int SerialPortNumber=2;
String[] ArrayOfPorts=new String[SerialPortNumber]; 

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600); 

  // start osc
  oscP5 = new OscP5(this, 7700);
  myRemoteLocation = new NetAddress("127.0.0.1", 7700);
}


// CHAR 1 = DEC 49
void draw()
{
  //if ( myPort.available() > 0) {  
    // If data is available,
    
    val = myPort.read();         // read it and store it in val
    time = hour() + ":" +  minute() + ":" + second();
    //int foo = Integer.parseInt(val);
    if (val == 49) {
      OscMessage myMessage_1 = new OscMessage(1);
      myMessage_1.add(1); // add an int to the osc message
      oscP5.send(myMessage_1, myRemoteLocation); // send the message
      println(time + " 1 touch");
    } 
    if (val == 50) {
      OscMessage myMessage_2 = new OscMessage(2);
      myMessage_2.add(2); // add an int to the osc message
      oscP5.send(myMessage_2, myRemoteLocation); // send the message
      println(time + " 2 touch");
    } 
    if (val == 51) {
      OscMessage myMessage_3 = new OscMessage(3);
      myMessage_3.add(3); // add an int to the osc message
      oscP5.send(myMessage_3, myRemoteLocation); // send the message
      println(time + " 3 touch");
    } 
    
    
    if (val == 97) {
      OscMessage myMessage_91 = new OscMessage(91);
      myMessage_91.add(91); // add an int to the osc message
      oscP5.send(myMessage_91, myRemoteLocation); // send the message  
      println(time + " 1 released");
    }
    if (val == 98) {
      OscMessage myMessage_92 = new OscMessage(92);
      myMessage_92.add(92); // add an int to the osc message
      oscP5.send(myMessage_92, myRemoteLocation); // send the message  
      println(time + " 2 released");
    }
    if (val == 99 ) {
      OscMessage myMessage_93 = new OscMessage(93);
      myMessage_93.add(93); // add an int to the osc message
      oscP5.send(myMessage_93, myRemoteLocation); // send the message  
      println(time + " 3 released");
    }
  if (val != -1 ){
    println(time + " " + val); //print it out in the console
  }
}