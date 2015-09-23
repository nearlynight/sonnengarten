/*********************************************************
This is a library for the MPR121 12-channel Capacitive touch sensor

Designed specifically to work with the MPR121 Breakout in the Adafruit shop 
  ----> https://www.adafruit.com/products/

These sensors use I2C communicate, at least 2 pins are required 
to interface

Adafruit invests time and resources providing this open source code, 
please support Adafruit and open-source hardware by purchasing 
products from Adafruit!

Written by Limor Fried/Ladyada for Adafruit Industries.  
BSD license, all text above must be included in any redistribution
**********************************************************/

#include <Wire.h>

#include "Adafruit_MPR121.h"

// You can have up to 4 on one i2c bus but one is enough for testing!
Adafruit_MPR121 cap = Adafruit_MPR121();

// Keeps track of the last pins touched
// so we know when buttons are 'released'
uint16_t lasttouched = 0;
uint16_t currtouched = 0;

boolean one_is_touched = false;
boolean two_is_touched = false;
boolean three_is_touched = false;
boolean four_is_touched = false;

void setup() {
  while (!Serial);        // needed to keep leonardo/micro from starting too fast!

  Serial.begin(9600);
  Serial.println("Adafruit MPR121 Capacitive Touch sensor test"); 
  
  // Default address is 0x5A, if tied to 3.3V its 0x5B
  // If tied to SDA its 0x5C and if SCL then 0x5D
  if (!cap.begin(0x5A)) {
    Serial.println("MPR121 not found, check wiring?");
    while (1);
  }
  Serial.println("MPR121 found!");
}


int value_1 = 64;
int value_2 = 80;
int value_3 = 64;
int value_4 = 64;

int value_off_1 = 72;
int value_off_2 = 92;
int value_off_3 = 72;
int value_off_4 = 76;

void loop() {
  // Get the currently touched pads
  currtouched = cap.touched();
  
  // detect touch for each pin
  if(!one_is_touched && cap.baselineData(1) <= value_1) {
    //Serial.println("TOUCH 1");
    Serial.print(1);
    one_is_touched = true;
  }
  if(!two_is_touched && cap.baselineData(2) <= value_2) {
    //Serial.println("TOUCH 2");
    Serial.print(2);
    two_is_touched = true;
  }
  if(!three_is_touched && cap.baselineData(3) <= value_3) {
    //Serial.println("TOUCH 3");
    Serial.print(3);
    three_is_touched = true;
  }
  if(!four_is_touched && cap.baselineData(4) <= value_4) {
    //Serial.println("TOUCH 3");
    Serial.print(4);
    four_is_touched = true;
  }

  
  // detect it no touch
  if(one_is_touched && cap.baselineData(1) >= value_off_1) {
    Serial.print("a");
    one_is_touched = false;
  }
  if(two_is_touched && cap.baselineData(2) >= value_off_2) {
    Serial.print("b");
    two_is_touched = false;
  }
  if(three_is_touched && cap.baselineData(3) >= value_off_3) {
    Serial.print("c");
    three_is_touched = false;
  }
  if(four_is_touched && cap.baselineData(4) >= value_off_4) {
    Serial.print("d");
    four_is_touched = false;
  }

  //TODO: find out fitting off values!
  //Serial.println(cap.baselineData(4));
  
  
  
  /*
  for (uint8_t i=0; i<12; i++) {
    // it if *is* touched and *wasnt* touched before, alert!
    if ((currtouched & _BV(i)) && !(lasttouched & _BV(i)) ) {
      //Serial.print(i); Serial.println(" touched");
    }
    // if it *was* touched and now *isnt*, alert!
    if (!(currtouched & _BV(i)) && (lasttouched & _BV(i)) ) {
      //Serial.print(i); Serial.println(" released");
    }
  }
  */

  // reset our state
  lasttouched = currtouched;

  // comment out this line for detailed data from the sensor!
  return;
  
  // debugging info, what
  //Serial.print("\t\t\t\t\t\t\t\t\t\t\t\t\t 0x"); Serial.println(cap.touched(), HEX);
  //Serial.print("Filt: ");
  for (uint8_t i=0; i<12; i++) {
    //Serial.print(cap.filteredData(i)); Serial.print("\t");
  }
  //Serial.println();
  //Serial.print("Base: ");
  for (uint8_t i=0; i<12; i++) {
    //Serial.print(cap.baselineData(i)); Serial.print("\t");
  }
  //Serial.println();
  
  // put a delay so it isn't overwhelming
  delay(100);
}
