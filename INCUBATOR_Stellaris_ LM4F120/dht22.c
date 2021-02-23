#include"inkubator_def.h"
#include "stdint.h"
// AM2302 module connections
sbit AM2302_Bus_Out at GPIO_PORTB_DATA.B3;
sbit AM2302_Bus_In  at GPIO_PORTB_DATA.B3;
sbit AM2302_pin_DIR at GPIO_PORTB_DIR3_bit;

//SHT11 connections
/*sbit SDA_pin  at GPIO_PORTB_DATA.B3;         // Serial data pin
sbit SCL_pin  at GPIO_PORTB_DATA.B2;         // Serial clock pin
sbit SDA_pin_DIR at GPIO_PORTB_DIR3_bit;     // Serial data pin direction
sbit SCL_pin_DIR at GPIO_PORTB_DIR2_bit;     // Serial clock pin direction*/

char AM2302_Data[5] = {0, 0, 0, 0, 0};
//unsigned humidity_int = 0, temperature_int = 0;

//Get Sensor values
char AM2302_Read(float *humidity, float *temperature) {
  char i = 0, j = 1;
  char timeout = 0;
  char sensor_byte;
  int t=0;
  int h=0;
 // GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_13);  //Set GPIOD pin 13 as digital input
  GPIO_Config(&GPIO_PORTB, _GPIO_PINMASK_3, _GPIO_DIR_INPUT, _GPIO_CFG_DIGITAL_ENABLE , _GPIO_PINCODE_NONE);
//  GPIO_Digital_Output(&GPIOD_BASE, _GPIO_PINMASK_13); //Set GPIOD pin 13 as digital output
  GPIO_Config(&GPIO_PORTB, _GPIO_PINMASK_3, _GPIO_DIR_OUTPUT, _GPIO_CFG_DIGITAL_ENABLE | _GPIO_CFG_OPEN_DRAIN, _GPIO_PINCODE_NONE);
  AM2302_Bus_Out = 1;                                 //Set GPIOD pin 13 HIGH for 100 milliseconds
  Delay_ms(100);                                      //Delay 100ms
  AM2302_Bus_Out = 0;                                 //Host the start signal down time min: 0.8ms, typ: 1ms, max: 20ms
  Delay_ms(2);                                        //Delay 2ms
  AM2302_Bus_Out = 1;                                 //Set GPIOD pin 13 HIGH
 
 // GPIO_Digital_Input(&GPIOD_BASE, _GPIO_PINMASK_13);  //Set GPIOD pin 13 as digital input
  GPIO_Config(&GPIO_PORTB, _GPIO_PINMASK_3, _GPIO_DIR_INPUT, _GPIO_CFG_DIGITAL_ENABLE, _GPIO_PINCODE_NONE);
  // Bus master has released time min: 20us, typ: 30us, max: 200us
  timeout = 200;
  while (AM2302_Bus_In) {
    Delay_us(1);
    if (!timeout--) {
      return 1;
    } //ERROR: Sensor not responding
  }

  // AM2302 response signal min: 75us, typ: 80us, max: 85us
  while (!AM2302_Bus_In) { //response to low time
    Delay_us(1);
  }

  while (AM2302_Bus_In) { //response to high time
    Delay_us(1);
  }

  /*
   * time in us:            min  typ  max
   * signal 0 high time:    22   26   30 (bit=0)
   * signal 1 high time:    68   70   75 (bit=1)
   * signal 0,1 down time:  48   50   55
   */

  i = 0; //get 5 byte
  for (i = 0; i < 5; i++) {
    j = 1;
    for (j = 1; j <= 8; j++) { //get 8 bits from sensor
      while (!AM2302_Bus_In) { //signal "0", "1" low time
        Delay_us(1);
      }
      Delay_us(30);
      sensor_byte <<= 1;       //add new lower byte
      if (AM2302_Bus_In) {     //if sda high after 30us => bit=1 else bit=0
        sensor_byte |= 1;
        delay_us(45);
        while (AM2302_Bus_In) {
          Delay_us(1);
        }
      }
    }
    AM2302_Data[i] = sensor_byte;
  }

  h= (AM2302_Data[0] << 8) + AM2302_Data[1];
  t = (AM2302_Data[2] << 8) + AM2302_Data[3];
  *humidity=    (float)h / 10.0;
  *temperature= (float)t/10.0;
  return 0;
}