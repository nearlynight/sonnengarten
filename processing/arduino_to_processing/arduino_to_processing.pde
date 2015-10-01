import processing.serial.*;
import oscP5.*;
import netP5.*;

Serial myPort;  // Create object from Serial class
int val;     // Data received from the serial port
String time;
String date;
boolean my_touch = false;
int SerialPortNumber=2;
String[] ArrayOfPorts=new String[SerialPortNumber]; 

OscP5 oscP5;
NetAddress myRemoteLocation;

PrintWriter output;

void setup() {
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600); 

  // start osc
  oscP5 = new OscP5(this, 7700);
  myRemoteLocation = new NetAddress("127.0.0.1", 7700);
  
  // create text file
  String filename = day() + "" + month() + "" + year() + "_" + hour() + "" + minute() + "" + second() + ".txt";
  output = createWriter(filename); 
}


// CHAR 1 = DEC 49
void draw()
{
  //if ( myPort.available() > 0) {  
    // If data is available,

    
    val = myPort.read();         // read it and store it in val
    time = hour() + ":" +  minute() + ":" + second();
    date = day() + "." + month() + "." + year() + "  "; 
    //int foo = Integer.parseInt(val);
    
    //OscMessage myMessage_1 = new OscMessage(1);
    
    if (val == 49) {
      OscMessage m = new OscMessage("/touch/1");
      int a = 1;
      m.add(a);
      oscP5.send(m,myRemoteLocation);  
      println(time + " 1 touch");
      output.println(date + time + " 1 touched");
    } 
    if (val == 50) {
      OscMessage m = new OscMessage("/touch/2");
      int b = 2;
      m.add(b);
      oscP5.send(m,myRemoteLocation); 
      println(time + " 2 touch");
      output.println(date + time + " 2 touched");
    } 
    if (val == 51) {
      OscMessage m = new OscMessage("/touch/3");
      int c = 3;
      m.add(c);
      oscP5.send(m,myRemoteLocation); 
      println(time + " 3 touch");
      output.println(date + time + " 3 touched");
    } 
    if (val == 52) {
      OscMessage m = new OscMessage("/touch/4");
      int d = 4;
      m.add(d);
      oscP5.send(m,myRemoteLocation); 
      println(time + " 4 touch");
      output.println(date + time + " 4 touched");
    } 
       
    if (val == 97) {
      OscMessage m = new OscMessage("/touch/1");
      int a = 1;
      m.add(a);
      oscP5.send(m,myRemoteLocation); 
      println(time + " 1 released");
      output.println(date + time + " 1 released");
    }
    if (val == 98) {
      OscMessage m = new OscMessage("/touch/2");
      int b = 2;
      m.add(b);
      oscP5.send(m,myRemoteLocation); 
      println(time + " 2 released");
      output.println(date + time + " 2 released");
    }
    if (val == 99 ) {
      OscMessage m = new OscMessage("/touch/3");
      int c = 3;
      m.add(c);
      oscP5.send(m,myRemoteLocation); 
      println(time + " 3 released");
      output.println(date + time + " 3 released");
    }
    if (val == 100 ) {
      OscMessage m = new OscMessage("/touch/4");
      int d = 4;
      m.add(d);
      oscP5.send(m,myRemoteLocation); 
      println(time + " 4 released");
      output.println(date + time + " 4 released");
    }
  //if (val != -1 ){
  //  println(time + " " + val); //print it out in the console
  //}
  output.flush();
}