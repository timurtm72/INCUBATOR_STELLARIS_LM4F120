#line 1 "D:/ALL_PROJECTS/INKUBATOR/SHT11_Inkubator.c"
#line 1 "d:/all_projects/inkubator/inkubator_def.h"
#line 1 "d:/all_projects/inkubator/stdint.h"
#line 1 "c:/program files (x86)/mikroelektronika/mikroc pro for arm/include/stddef.h"



typedef long ptrdiff_t;


 typedef unsigned long size_t;

typedef unsigned long wchar_t;
#line 26 "d:/all_projects/inkubator/stdint.h"
typedef signed char int8_t;
typedef unsigned char uint8_t;
typedef signed short int16_t;
typedef unsigned short uint16_t;
typedef signed long int32_t;
typedef unsigned long uint32_t;
typedef signed long long int64_t;
typedef unsigned long long uint64_t;


typedef signed char int_least8_t;
typedef unsigned char uint_least8_t;
typedef signed short int_least16_t;
typedef unsigned short uint_least16_t;
typedef signed long int_least32_t;
typedef unsigned long uint_least32_t;
typedef signed long long int_least64_t;
typedef unsigned long long uint_least64_t;
#line 49 "d:/all_projects/inkubator/stdint.h"
typedef signed char int_fast8_t;
typedef unsigned char uint_fast8_t;
typedef signed short int_fast16_t;
typedef unsigned short uint_fast16_t;
typedef signed long int_fast32_t;
typedef unsigned long uint_fast32_t;
typedef signed long long int_fast64_t;
typedef unsigned long long uint_fast64_t;







typedef signed long long intmax_t;
typedef unsigned long long uintmax_t;
#line 23 "d:/all_projects/inkubator/inkubator_def.h"
extern sfr sbit LED_RED;
extern sfr sbit LED_BLUE;
extern sfr sbit LED_GREEN;
extern struct flag flag_t;


extern char errors[255];

extern unsigned long ee_Data[ 10 ];




extern char *message[9];
extern sfr sbit PIN_UP;
extern sfr sbit PIN_DOWN;
extern sfr sbit PIN_ENTER;
extern sfr sbit PIN_BACK;
extern sfr sbit IN_ZCD;

extern sfr sbit RELE_FAN;
extern sfr sbit RELE_COVER;
extern sfr sbit RELE_ROTATION;
extern sfr sbit RELE_ALARM;
extern sfr sbit RELE_ALARM_TRIAC;
extern sfr sbit RELE_HUMIDITI;
extern sfr sbit TRIAC_OUT;
extern sfr sbit BLED;

enum key_number {key_up=1,key_down,key_enter,key_back};
struct parameters
{
 float set_temperatura;
 float set_humidity;
 float set_turn_time;
 float temperatura_delta__alarm_level;
 float humidity_delta_alarm_level;
 float control_humidity;
};
extern struct parameters parameters_t;


struct Spid
{
 float dState;
 float iState;
 float iMax, iMin;

 float iGain,
 pGain,
 dGain;
};
extern struct Spid Rpid;

struct flag
{
 main_timer_ovf : 1;
 temperatura_alarm : 1;
 temperatura_alarm_cover : 1;
 humidity_alarm : 1;
 temperatura_triac_alarm : 1;
 cover_status : 1;
 start_fan : 1;
 start_process : 1;
 data_save : 1;
 status_in_menu : 1;
 first_start_t : 1;
 first_start_h : 1;
 humidity_cover_status : 1;
 humidity_alarm_cover : 1;
 control_humidity : 1;
};
#line 100 "d:/all_projects/inkubator/inkubator_def.h"
typedef struct PID_DATA{

 int16_t lastProcessValue;

 int32_t sumError;

 int16_t P_Factor;

 int16_t I_Factor;

 int16_t D_Factor;

 int16_t maxError;

 int32_t maxSumError;
} pidData_t;
#line 130 "d:/all_projects/inkubator/inkubator_def.h"
void pid_Init(int16_t p_factor, int16_t i_factor, int16_t d_factor, struct PID_DATA *pid);
int16_t pid_Controller(int16_t setPoint, int16_t processValue, struct PID_DATA *pid_st);
void pid_Reset_Integrator(pidData_t *pid_st);


extern float out_reg_value;

extern float temperature;
extern float rel_humidity;
extern char Data_Str[12];
extern volatile unsigned char key_value;

void Init_Gpio();
void InitTimer0A();
void Read_SHT11(float *fT, float *fRH);
void Init_ext_int();
void StartTimer1A_10ms(unsigned long interval);
void StopTimer1A_10ms();



void Read_sensor();
unsigned char Key_code_pressed();
void Out_data_in_lcd();
unsigned char Return_key();
void set_humidity();
void set_temperature();
unsigned char key_code_pressed();
void set_temperature_gist();
void set_humidity_gist();
void set_turn_time();
void read_key();



void control_temperature();
void control_temperature_triac();
void control_humidity();
void temperature_cover_open_close();
void control_outs();
void control_temperature_cover();
void save_data_exit();
void save_data();
char save_data_to_eeprom();
char read_data_in_eeprom();
void set_default_parameters();
void Load();
void out_lcd_errors(unsigned char position);
void set_errors();
void reset_error_message();
void set_fault(char error_code);
void rotation();
void Beep();
void Get_key();
void control_menu();
void control_first_start();
void impulse();
void reset_flags();
void control_cover_humidity();
void humidity_cover_open_close();
void out_data_to_lcd();
char AM2302_Read(float *humidity, float *temperature);
float UpdatePID(struct SPid pid, float error, float position);
void init_pid();
void set_humidity_control();
void start_eeprom();
void Init_flags();
#line 1 "d:/all_projects/inkubator/stdint.h"
#line 3 "D:/ALL_PROJECTS/INKUBATOR/SHT11_Inkubator.c"
sbit LED_RED at GPIO_PORTF_DATA.B1;
sbit LED_BLUE at GPIO_PORTF_DATA.B2;
sbit LED_GREEN at GPIO_PORTF_DATA.B3;

sbit BUZZER at GPIO_PORTE_DATA.B1;
sbit BLED at GPIO_PORTA_DATA.B2;

sbit PIN_UP at GPIO_PORTD_DATA.B0;
sbit PIN_DOWN at GPIO_PORTD_DATA.B1;
sbit PIN_ENTER at GPIO_PORTD_DATA.B2;
sbit PIN_BACK at GPIO_PORTD_DATA.B3;


sbit LCD_RS at GPIO_PORTE_DATA.B2;
sbit LCD_EN at GPIO_PORTE_DATA.B3;
sbit LCD_D4 at GPIO_PORTC_DATA.B4;
sbit LCD_D5 at GPIO_PORTC_DATA.B5;
sbit LCD_D6 at GPIO_PORTC_DATA.B6;
sbit LCD_D7 at GPIO_PORTC_DATA.B7;

sbit LCD_RS_Direction at GPIO_PORTE_DIR.B2;
sbit LCD_EN_Direction at GPIO_PORTE_DIR.B3;
sbit LCD_D4_Direction at GPIO_PORTC_DIR.B4;
sbit LCD_D5_Direction at GPIO_PORTC_DIR.B5;
sbit LCD_D6_Direction at GPIO_PORTC_DIR.B6;
sbit LCD_D7_Direction at GPIO_PORTC_DIR.B7;


sbit RELE_FAN at GPIO_PORTA_DATA.B3;
sbit RELE_COVER at GPIO_PORTA_DATA.B4;
sbit RELE_ROTATION at GPIO_PORTA_DATA.B5;
sbit RELE_ALARM at GPIO_PORTB_DATA.B6;
sbit RELE_ALARM_TRIAC at GPIO_PORTB_DATA.B5;
sbit RELE_HUMIDITI at GPIO_PORTE_DATA.B0;


sbit IN_ZCD at GPIO_PORTD_DATA.B6;
sbit TRIAC_OUT at GPIO_PORTB_DATA.B2;
#line 51 "D:/ALL_PROJECTS/INKUBATOR/SHT11_Inkubator.c"
char *message[]={".................","TEMPERATYRA","VLAJNOST","KLUCH PROBIT","DATCHIK"};
char errors[255];
#line 66 "D:/ALL_PROJECTS/INKUBATOR/SHT11_Inkubator.c"
struct PID_DATA pidData;
struct Spid Rpid;


char Data_Str[12];


float temperature;
float rel_humidity;


volatile float out_reg_value=0;
volatile unsigned char key_value=0;

struct parameters parameters_t;
struct flag flag_t={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};


void Timer0A_interrupt() iv IVT_INT_TIMER0A_16_32_bit ics ICS_AUTO {
 TIMER_ICR_TATOCINT_bit = 1;
 flag_t.main_timer_ovf= 1 ;
 read_key();

 control_menu();
}

void Zero_cross_detector_int() iv IVT_INT_GPIOD ics ICS_AUTO
{
 unsigned long temp=0;
 GPIO_PORTD_ICR = _GPIO_PINMASK_6;
 if(flag_t.start_process== 1 )
 {
 temp=(unsigned long)(100.0*out_reg_value);
 if(temp> 50000 ) temp= 50000 ;
 switch(temp)
 {
 case 0: TRIAC_OUT= 0 ; break;
 case 1: TRIAC_OUT= 0 ; break;
 case 2: TRIAC_OUT= 0 ; break;
 case  50000 -2: TRIAC_OUT= 1 ; break;
 case  50000 -1: TRIAC_OUT= 1 ; break;
 case  50000 : TRIAC_OUT= 1 ; break;
 default: StartTimer1A_10ms(temp);break;
 }


 }

}

void Timer1A_interrupt() iv IVT_INT_TIMER1A_16_32_bit ics ICS_AUTO
{
 TIMER_ICR_TATOCINT_TIMER1_ICR_bit = 1;
 StopTimer1A_10ms();
 impulse();
}

volatile unsigned char code_key=0;
void main()
{
 Init_flags();
 Init_Gpio();
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 init_pid();
 start_eeprom();
 reset_error_message();
 BLED= 1 ;
 Load();
 Init_ext_int();
 InitTimer0A();
 EnableInterrupts();

 while( 1 )
 {
 if(flag_t.main_timer_ovf== 1 )
 {

 flag_t.main_timer_ovf= 0 ;
 if(flag_t.start_process== 1 )
 {
 rotation();

 out_reg_value=fabs(UpdatePID(Rpid,(parameters_t.set_temperatura-temperature),temperature));
 out_reg_value=(parameters_t.set_temperatura*5)-out_reg_value;
 if(out_reg_value<0) out_reg_value=0;
 }
#line 159 "D:/ALL_PROJECTS/INKUBATOR/SHT11_Inkubator.c"
 Get_key();
 Read_sensor();


 if(flag_t.start_process== 1 )
 {
 control_first_start();
 control_temperature();
 control_temperature_triac();
 temperature_cover_open_close();
 control_temperature_cover();
 if(flag_t.control_humidity== 1 )
 {
 control_humidity();
 control_cover_humidity();
 humidity_cover_open_close();
 }
 if(flag_t.control_humidity== 0 )
 {
 flag_t.humidity_cover_status= 0 ;
 }
 }
 if(flag_t.start_process== 0 )
 {
 reset_flags();
 }
 control_outs();
 out_data_to_lcd();

 }
 }
}
