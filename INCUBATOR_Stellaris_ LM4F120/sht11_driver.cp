#line 1 "D:/ALL_PROJECTS/INKUBATOR/sht11_driver.c"

extern sfr sbit SDA_pin;
extern sfr sbit SCL_pin;
extern sfr sbit SDA_pin_DIR;
extern sfr sbit SCL_pin_DIR;




const float C1=-4.0;
const float C2=+0.0405;
const float C3=-0.0000028;
const float Temp1=+0.01;
const float Temp2=+0.00008;
#line 27 "D:/ALL_PROJECTS/INKUBATOR/sht11_driver.c"
unsigned char ucSens_Error;

int iSHT_Temp;
int iSHT_Humi;
#line 43 "D:/ALL_PROJECTS/INKUBATOR/sht11_driver.c"
void s_transstart()
{

 SDA_pin_DIR = 0;
 SCL_pin = 0;

 Delay_uS(10);
 SCL_pin = 1;
 Delay_uS(10);

 SDA_pin_DIR = 1;
 SDA_pin = 0;
 Delay_uS(10);
 SCL_pin = 0;
 Delay_uS(30);
 SCL_pin = 1;
 Delay_uS(10);

 SDA_pin_DIR = 0;
 Delay_uS(10);
 SCL_pin = 0;
}
#line 69 "D:/ALL_PROJECTS/INKUBATOR/sht11_driver.c"
unsigned char s_read_byte(unsigned char ack)
{
 unsigned char i=0x80;
 unsigned char val=0;


 SDA_pin_DIR = 0;
 SCL_pin = 0;

 while(i)
 {
 SCL_pin = 1;
 Delay_uS(10);
 if (SDA_pin == 1)
 {
 val=(val | i);
 }
 SCL_pin = 0;
 Delay_uS(10);
 i=(i>>1);
 }

 SDA_pin_DIR = 1;
 if (ack)
 {

 SDA_pin = 0;
 }
 else
 {
 SDA_pin = 1;
 }

 SCL_pin = 1;
 Delay_uS(30);
 SCL_pin = 0;
 Delay_uS(10);

 SDA_pin_DIR = 0;
 return (val);
}
#line 114 "D:/ALL_PROJECTS/INKUBATOR/sht11_driver.c"
unsigned char s_write_byte(unsigned char value)
{
 unsigned char i=0x80;
 unsigned char error=0;

 SDA_pin_DIR = 1;
 while(i)
 {
 if (i & value)
 {
 SDA_pin = 1;
 }
 else
 {
 SDA_pin = 0;
 }

 SCL_pin = 1;
 Delay_uS(30);
 SCL_pin = 0;
 Delay_uS(30);
 i=(i>>1);
 }

 SDA_pin_DIR = 0;

 SCL_pin = 1;
 Delay_uS(30);
 if (SDA_pin == 1) error = 1;
 Delay_uS(10);
 SCL_pin = 0;

 return(error);
}
#line 155 "D:/ALL_PROJECTS/INKUBATOR/sht11_driver.c"
unsigned char s_measure(unsigned int *p_value, unsigned char mode)
{
 unsigned char i=0;
 unsigned char msb,lsb;
 unsigned char checksum;

 *p_value=0;
 s_transstart();

 if(mode)
 {
 mode =  0x05 ;
 }
 else
 {
 mode =  0x03 ;
 }

 if (s_write_byte(mode)) return(1);


 SDA_pin_DIR = 0;

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


 if(i) return(2);

 msb=s_read_byte( 1 );
 lsb=s_read_byte( 1 );
 checksum=s_read_byte( 0 );

 *p_value=(msb<<8)|(lsb);

 return(0);
}
#line 208 "D:/ALL_PROJECTS/INKUBATOR/sht11_driver.c"
float calc_sth11_temp(unsigned int t)
{
 float t_out;
 t_out = t*0.01 - 40;

 return t_out;
}
#line 221 "D:/ALL_PROJECTS/INKUBATOR/sht11_driver.c"
 float rh_lin;
 float rh_true;
 float t_C;
float calc_sth11_humi(unsigned int h, int t)
{
 t_C=t*0.01 - 40;
 rh_lin=C3*h*h + C2*h + C1;
 rh_true=(t_C-25)*(Temp1+Temp2*h)+rh_lin;








 if(rh_true>100)rh_true=100;
 if(rh_true<0.1)rh_true=0.1;

 return rh_true;
}
#line 246 "D:/ALL_PROJECTS/INKUBATOR/sht11_driver.c"
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
#line 269 "D:/ALL_PROJECTS/INKUBATOR/sht11_driver.c"
char s_read_statusreg(unsigned char *p_value)
{
 unsigned char checksum = 0;

 s_transstart();
 if(s_write_byte( 0x07 )) return 1;
 *p_value=s_read_byte( 1 );
 checksum=s_read_byte( 0 );

 return 0;
}
#line 286 "D:/ALL_PROJECTS/INKUBATOR/sht11_driver.c"
char s_write_statusreg(unsigned char value)
{
 s_transstart();
 if(s_write_byte( 0x06 )) return 1;
 if(s_write_byte(value)) return 1;

 return 0;
}
#line 302 "D:/ALL_PROJECTS/INKUBATOR/sht11_driver.c"
void s_connectionreset()
{
 unsigned char i;
 SDA_pin_DIR = 0;
 SCL_pin = 0;

 for(i=0; i<9; i++)
 {
 SCL_pin = 1;
 Delay_uS(30);
 SCL_pin = 0;
 Delay_uS(30);
 }

 s_transstart();
}
#line 322 "D:/ALL_PROJECTS/INKUBATOR/sht11_driver.c"
unsigned char s_softreset(void)
{
 s_connectionreset();

 return (s_write_byte( 0x1e ));
}
