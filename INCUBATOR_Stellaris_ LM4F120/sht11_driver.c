//SHT11 connections
extern sfr sbit SDA_pin;          // Serial data pin
extern sfr sbit SCL_pin;          // Serial clock pin
extern sfr sbit SDA_pin_DIR;      // Serial data pin direction
extern sfr sbit SCL_pin_DIR;      // Serial clock pin direction

// constants for calculating temperature and humidity

//- Module constants, see SHT1x datasheet for more information ------------------------------------
const float C1=-4.0;              // for 12 Bit
const float C2=+0.0405;           // for 12 Bit
const float C3=-0.0000028;        // for 12 Bit
const float Temp1=+0.01;          // for 14 Bit
const float Temp2=+0.00008;       // for 14 Bit

// SHT1x definitions
#define noACK 0
#define ACK   1
                            //adr  command  r/w
#define STATUS_REG_W 0x06   //000   0011    0
#define STATUS_REG_R 0x07   //000   0011    1
#define MEASURE_TEMP 0x03   //000   0001    1
#define MEASURE_HUMI 0x05   //000   0010    1
#define RESET        0x1e   //000   1111    0

//- Module variables -------------------------------------------------------------------------------
unsigned char ucSens_Error;

int iSHT_Temp;
int iSHT_Humi;

/**************************************************************************************************
* SHT11 Functions
**************************************************************************************************/

/**************************************************************************************************
* Generates a transmission start
*       _____         ________
* DATA:      |_______|
*           ___     ___
* SCK : ___|   |___|   |______
**************************************************************************************************/
void s_transstart()
{
  //Initial state
  SDA_pin_DIR = 0;        //release DATA-line
  SCL_pin = 0;            // SCL Low

  Delay_uS(10);
  SCL_pin = 1;
  Delay_uS(10);

  SDA_pin_DIR = 1;        // DATA as output
  SDA_pin = 0;            // SDA low
  Delay_uS(10);
  SCL_pin = 0;
  Delay_uS(30);
  SCL_pin = 1;
  Delay_uS(10);

  SDA_pin_DIR = 0;        //release DATA-line
  Delay_uS(10);
  SCL_pin = 0;
}

/**************************************************************************************************
* Reads a byte form the Sensibus and gives an acknowledge in case of "ack=1"
**************************************************************************************************/
unsigned char s_read_byte(unsigned char ack)
{
  unsigned char i=0x80;
  unsigned char val=0;

  //Initial state
  SDA_pin_DIR = 0;        //release DATA-line
  SCL_pin = 0;            // SCL Low

  while(i)                //shift bit for masking
  {
    SCL_pin = 1;          //clk for SENSI-BUS
    Delay_uS(10);
    if (SDA_pin == 1)
    {
      val=(val | i);      //read bit
    }
    SCL_pin = 0;
    Delay_uS(10);
    i=(i>>1);
  }

  SDA_pin_DIR = 1;        // DATA as output
  if (ack)
  {
    //in case of "ack==1" pull down DATA-Line
    SDA_pin = 0;
  }
  else
  {
    SDA_pin = 1;
  }

  SCL_pin = 1;            //clk #9 for ack
  Delay_uS(30);
  SCL_pin = 0;
  Delay_uS(10);

  SDA_pin_DIR = 0;        //release DATA-line
  return (val);
}

/**************************************************************************************************
* Writes a byte on the Sensibus and checks the acknowledge.
**************************************************************************************************/
unsigned char s_write_byte(unsigned char value)
{
  unsigned char i=0x80;
  unsigned char error=0;

  SDA_pin_DIR = 1;        // DATA as output
  while(i)
  { //shift bit for masking
    if (i & value)
    {
      SDA_pin = 1;        //masking value with i , write to SENSI-BUS
    }
    else
    {
      SDA_pin = 0;
    }

    SCL_pin = 1;          //clk for SENSI-BUS
    Delay_uS(30);
    SCL_pin = 0;
    Delay_uS(30);
    i=(i>>1);
  }

  SDA_pin_DIR = 0;        //release DATA-line

  SCL_pin = 1;            //clk #9 for ack
  Delay_uS(30);
  if (SDA_pin == 1)  error = 1; //check ack (DATA will be pulled down by SHT11)
  Delay_uS(10);
  SCL_pin = 0;

  return(error); //error=1 in case of no acknowledge
}

/**************************************************************************************************
* makes a measurement (humidity/temperature) with checksum
* p_value returns 2 bytes
* mode: 1=humidity 0=temperature
* return value: 0=ok, 1=write error, 2=timeout
**************************************************************************************************/
unsigned char s_measure(unsigned int *p_value, unsigned char mode)
{
  unsigned char i=0;
  unsigned char msb,lsb;
  unsigned char checksum;

  *p_value=0;
  s_transstart(); //transmission start

  if(mode)
  {
    mode = MEASURE_HUMI;
  }
  else
  {
    mode = MEASURE_TEMP;
  }

  if (s_write_byte(mode)) return(1);
  // normal delays: temp i=70, humi i=20

  SDA_pin_DIR = 0;           //release DATA-line

  while(i<240)
  {
    Delay_mS(1);
    Delay_mS(1);
    Delay_mS(1);
    if (SDA_pin == 0)
    {
      i=0;
      break;
    }
    i++;
  }

  // or timeout
  if(i) return(2);

  msb=s_read_byte(ACK); //read the first byte (MSB)
  lsb=s_read_byte(ACK); //read the second byte (LSB)
  checksum=s_read_byte(noACK);                //read checksum (8-bit)

  *p_value=(msb<<8)|(lsb);

  return(0);
}

/**************************************************************************************************
* calculates temperature [C]
* input : temp [Ticks] (14 bit)
* output: temp [C] times 10 (e.g 253 = 25.3'C)
**************************************************************************************************/
float calc_sth11_temp(unsigned int t)
{
  float t_out;
  t_out =  t*0.01 - 40;

  return t_out;
}

/**************************************************************************************************
* calculates humidity [%RH] with temperature compensation
* input : humi [Ticks] (12 bit), temperature in 'C * 100 (e.g 253 for 25.3'C)
* output: humi [%RH] (=integer value from 0 to 100)
**************************************************************************************************/
  float rh_lin;                             // rh_lin:  Humidity linear
  float rh_true;                            // rh_true: Temperature compensated humidity
  float t_C;                                // t_C   :  Temperature [°C]
float calc_sth11_humi(unsigned int h, int t)
{
  t_C=t*0.01 - 40;                          //calc. temperature from ticks to [°C]
  rh_lin=C3*h*h + C2*h + C1;                //calc. humidity from ticks to [%RH]
  rh_true=(t_C-25)*(Temp1+Temp2*h)+rh_lin;        //calc. temperature compensated humidity

  // now calc. Temperature compensated humidity [%RH]
  // the correct formula is:
  // rh_true=(t/10-25)*(0.01+0.00008*(sensor_val))+rh;
  // sensor_val ~= rh*30
  // we use:
  // rh_true=(t/10-25) * 1/8;

  if(rh_true>100)rh_true=100;               //cut if the value is outside of
  if(rh_true<0.1)rh_true=0.1;               //the physical possible range

  return rh_true;
}

/**************************************************************************************************
* reads temperature and humidity
**************************************************************************************************/
void Read_SHT11(float *fT, float *fRH)
{
  unsigned int t;
  unsigned int h;
  float value;

  ucSens_Error = 0;

  ucSens_Error = s_measure(&t, 0);
  iSHT_Temp = (int)(calc_sth11_temp(t) * 10);

  ucSens_Error = s_measure(&h, 1);
  iSHT_Humi = (int)(calc_sth11_humi(h, t) * 10);

  value = (float)iSHT_Temp;
  *fT = value / 10;
  value = (float)iSHT_Humi;
  *fRH = value / 10;
}

/**************************************************************************************************
* reads the status register with checksum (8-bit)
**************************************************************************************************/
char s_read_statusreg(unsigned char *p_value)
{
  unsigned char checksum = 0;

  s_transstart();                             //transmission start
  if(s_write_byte(STATUS_REG_R)) return 1;    //send command to sensor
  *p_value=s_read_byte(ACK);                  //read status register (8-bit)
  checksum=s_read_byte(noACK);                //read checksum (8-bit)

  return 0;
}

/**************************************************************************************************
* writes the status register with checksum (8-bit)
* input: status register value
* return value: 0=ok, 1=write error
**************************************************************************************************/
char s_write_statusreg(unsigned char value)
{
  s_transstart();                             //transmission start
  if(s_write_byte(STATUS_REG_W)) return 1;    //send command to sensor
  if(s_write_byte(value)) return 1;           //send value of status register

  return 0;
}

/**************************************************************************************************
* communication reset: DATA-line=1 and at least 9 SCK cycles followed by transstart
*       _____________________________________________________         ________
* DATA:                                                      |_______|
*          _    _    _    _    _    _    _    _    _        ___     ___
* SCK : __| |__| |__| |__| |__| |__| |__| |__| |__| |______|   |___|   |______
**************************************************************************************************/
void s_connectionreset()
{
  unsigned char i;
  SDA_pin_DIR = 0;                       //release DATA-line
  SCL_pin = 0;                           // SCL Low

  for(i=0; i<9; i++)                     //9 SCK cycles
  {
    SCL_pin = 1;
    Delay_uS(30);
    SCL_pin = 0;
    Delay_uS(30);
  }

  s_transstart();                        //transmission start
}

/**************************************************************************************************
* Resets the sensor by a softreset
**************************************************************************************************/
unsigned char s_softreset(void)
{
  s_connectionreset();                         //reset communication
                                               //send RESET-command to sensor
  return (s_write_byte(RESET));                //return=1 in case of no response form the sensor
}

/**************************************************************************************************
* End of File
**************************************************************************************************/