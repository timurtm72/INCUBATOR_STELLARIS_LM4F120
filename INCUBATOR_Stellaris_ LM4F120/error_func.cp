#line 1 "D:/ALL_PROJECTS/INKUBATOR/error_func.c"
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
#line 4 "D:/ALL_PROJECTS/INKUBATOR/error_func.c"
void set_errors()
{
 char kp=0;
 char go=0;
 unsigned char position=0,pos=0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,4,"OSHIBKI");
 out_lcd_errors(position);
 while(kp==0)
 {
 if(flag_t.status_in_menu== 0 )
 {
 key_value=key_back;
 }
 switch(key_value)
 {
 case key_up: key_value=0;
 if(position==0)
 {
 position=0;
 }
 else
 {
 position--;
 }
 out_lcd_errors(position); break;

 case key_down: key_value=0; position++;
 if(errors[position]==0)
 {
 position=position;
 }
 if(position==255)
 {
 for(pos=0;pos<255;pos++)
 {
 errors[pos]=0;
 }
 pos=0;
 }
 out_lcd_errors(position);
 break;
 case key_enter: key_value=0; for(pos=0;pos<255;pos++)
 {
 errors[pos]=0;
 }
 pos=0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,2,"OSHIBKI STERTY");
 Delay_ms(1000);
 go=1;kp=1; break;
 case key_back: key_value=0; kp=1; Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF); break;
 }
 }
 if(go== 1 ) set_temperature();
}

void out_lcd_errors(unsigned char position)
{
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,6,"OSHIBKI");
 if(errors[position]==0)
 {
 Lcd_Out(2,1,"NET OSHIBOK...");
 }
 else
 {
 Lcd_Out(2,1,message[errors[position]]);
 }
}

void reset_error_message()
{
 unsigned char count_err=0;
 for(count_err=0;count_err<255;count_err++)
 {
 errors[count_err]=0;
 }
 count_err=0;

}

void set_fault(char error_code)
{
 static unsigned char count_error1=0;
 errors[count_error1++]=error_code;
 if(count_error1>=255)
 {
 for(count_error1=0;count_error1<255;count_error1++)
 {
 errors[count_error1]=0;
 }
 count_error1=0;
 }

}
