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
    //println(val);
    val = myPort.read();         // read it and store it in val
    time = hour() + ":" +  minute() + ":" + second();
    //int foo = Integer.parseInt(val);
    if (val == 49) {
      OscMessage myMessage_1 = new OscMessage(1);
      myMessage_1.add(1); // add an int to the osc message
      oscP5.send(myMessage_1, myRemoteLocation); // send the message
      println(time + " 1 sent");
    } 
    if (my_touch && val == 50) {
      OscMessage myMessage_2 = new OscMessage(2);
      myMessage_2.add(2); // add an int to the osc message
      oscP5.send(myMessage_2, myRemoteLocation); // send the message
      println(time + " 2 sent");
      my_touch = false;
    } 
    if (my_touch && val == 51) {
      OscMessage myMessage_3 = new OscMessage(3);
      myMessage_3.add(3); // add an int to the osc message
      oscP5.send(myMessage_3, myRemoteLocation); // send the message
      println(time + " 3 sent");
      my_touch = false;
    } 
    
    
    if (!my_touch && val == 1047) {
      //OscMessage myMessage_2 = new OscMessage(999);
      //myMessage_2.add(999); // add an int to the osc message
      //oscP5.send(myMessage_2, myRemoteLocation); // send the message  
      //println(time + " 999 sent");
      OscMessage myMessage_3 = new OscMessage(1);
      myMessage_3.add(1); // add an int to the osc message
      oscP5.send(myMessage_3, myRemoteLocation); // send the message  
      println(time + " off 1 sent");
      my_touch = true;
    }
  //println(time + " " + val); //print it out in the console
}