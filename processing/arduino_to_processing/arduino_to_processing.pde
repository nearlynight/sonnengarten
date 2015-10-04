import processing.serial.*;
import oscP5.*;
import netP5.*;

Serial myPort_1;  // Create object from Serial class
Serial myPort_2;  // Create object from Serial class
Serial myPort_3;
int val_1;     // Data received from the serial port
int val_2;
int val_3;
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
  String port_1 = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort_1 = new Serial(this, port_1, 9600); 
  String port_2 = Serial.list()[1]; //change the 0 to a 1 or 2 etc. to match your port
  myPort_2 = new Serial(this, port_2, 9600);
  String port_3 = Serial.list()[2]; //change the 0 to a 1 or 2 etc. to match your port
  myPort_3 = new Serial(this, port_3, 9600);

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

    
    val_1 = myPort_1.read();         // read it and store it in val
    val_2 = myPort_2.read();         // read it and store it in val
    val_3 = myPort_3.read();
    time = hour() + ":" +  minute() + ":" + second();
    date = day() + "." + month() + "." + year() + "  "; 
    //int foo = Integer.parseInt(val);
    
    //OscMessage myMessage_1 = new OscMessage(1);
    
    // TOUCH
    if (val_1 == 49 || val_2 == 49 || val_3 == 49) {
      OscMessage m = new OscMessage("/touch/1");
      int a = 1;
      m.add(a);
      oscP5.send(m,myRemoteLocation);  
      println(time + " 1 touch");
      output.println(date + time + " 1 touched");
    } 
    if (val_1 == 50 || val_2 == 50 || val_3 == 50) {
      OscMessage m = new OscMessage("/touch/2");
      int b = 2;
      m.add(b);
      oscP5.send(m,myRemoteLocation); 
      println(time + " 2 touch");
      output.println(date + time + " 2 touched");
    } 
    if (val_1 == 51 || val_2 == 51 || val_3 == 51) {
      OscMessage m = new OscMessage("/touch/3");
      int c = 3;
      m.add(c);
      oscP5.send(m,myRemoteLocation); 
      println(time + " 3 touch");
      output.println(date + time + " 3 touched");
    } 
    if (val_1 == 52) {
      OscMessage m = new OscMessage("/touch/4");
      int d = 4;
      m.add(d);
      oscP5.send(m,myRemoteLocation); 
      println(time + " 4 touch");
      output.println(date + time + " 4 touched");
    } 
    if (val_1 == 53) {
      OscMessage m = new OscMessage("/touch/5");
      int e = 5;
      m.add(e);
      oscP5.send(m,myRemoteLocation); 
      println(time + " 5 touch");
      output.println(date + time + " 5 touched");
    } 
       
       
    // RELEASE   
    if (val_1 == 97 || val_2 == 97 || val_3 == 97) {
      OscMessage m = new OscMessage("/touch/1");
      int a = 1;
      m.add(a);
      oscP5.send(m,myRemoteLocation); 
      println(time + " 1 released");
      output.println(date + time + " 1 released");
    }
    if (val_1 == 98 || val_2 == 98 || val_3 == 98) {
      OscMessage m = new OscMessage("/touch/2");
      int b = 2;
      m.add(b);
      oscP5.send(m,myRemoteLocation); 
      println(time + " 2 released");
      output.println(date + time + " 2 released");
    }
    if (val_1 == 99 || val_2 == 99 || val_3 == 99) {
      OscMessage m = new OscMessage("/touch/3");
      int c = 3;
      m.add(c);
      oscP5.send(m,myRemoteLocation); 
      println(time + " 3 released");
      output.println(date + time + " 3 released");
    }
    if (val_2 == 100 ) {
      OscMessage m = new OscMessage("/touch/4");
      int d = 4;
      m.add(d);
      oscP5.send(m,myRemoteLocation); 
      println(time + " 4 released");
      output.println(date + time + " 4 released");
    }
    if (val_2 == 101 ) {
      OscMessage m = new OscMessage("/touch/5");
      int e = 5;
      m.add(e);
      oscP5.send(m,myRemoteLocation); 
      println(time + " 5 released");
      output.println(date + time + " 5 released");
    }
  //if (val != -1 ){
  //  println(time + " " + val); //print it out in the console
  //}
  output.flush();
}