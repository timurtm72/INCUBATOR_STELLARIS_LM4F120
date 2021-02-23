#line 1 "D:/ALL_PROJECTS/INKUBATOR/inkubator_func.c"
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
#line 5 "D:/ALL_PROJECTS/INKUBATOR/inkubator_func.c"
void Read_sensor()
{
 static unsigned char read_sensor_count=0;
 if((++read_sensor_count)==20)
 {
 read_sensor_count=0;

 DisableInterrupts();
 if (AM2302_Read(&rel_humidity, &temperature) == 1)
 {
 set_fault(4);
#line 19 "D:/ALL_PROJECTS/INKUBATOR/inkubator_func.c"
 }
 EnableInterrupts();
 }

}

void out_data_to_lcd()
{
 static unsigned char count_data=0;
 if((++count_data)>=10)
 {
 count_data=0;
 Out_data_in_lcd();
 }


}

void Out_data_in_lcd()
{
 Lcd_Out(1,1,"Tr");
 sprintf(Data_Str,"%-2.1fC",temperature);
 Lcd_Out(1,3,Data_Str);

 sprintf(Data_Str,"%-1.1fC%-2.0f%%  ",temperature-parameters_t.set_temperatura,rel_humidity-parameters_t.set_humidity);

 Lcd_Out(2,8,Data_Str);

 Lcd_Out(1,9,"M");
 if(flag_t.start_fan== 1 ) Lcd_Out(1,10,"+");
 if(flag_t.start_fan== 0 ) Lcd_Out(1,10,"-");

 Lcd_Out(1,12,"P");
 if(flag_t.start_process== 1 ) Lcd_Out(1,13,"+");
 if(flag_t.start_process== 0 ) Lcd_Out(1,13,"-");

 Lcd_Out(1,15,"K");
 if(flag_t.cover_status== 1 ) Lcd_Out(1,16,"+");
 if(flag_t.cover_status== 0 ) Lcd_Out(1,16,"-");
 Lcd_Out(2,1,"Vr");

 sprintf(Data_Str,"%-2.1f%%",rel_humidity);
 Lcd_Out(2,3,Data_Str);





}

unsigned char key_code_pressed()
{
 unsigned char key_value=0;
 if(PIN_UP== 0 )
 {
 key_value=key_up;
 }
 if(PIN_DOWN== 0 )
 {
 key_value=key_down;
 }
 if(PIN_ENTER== 0 )
 {
 key_value=key_enter;
 }
 if(PIN_BACK== 0 )
 {
 key_value=key_back;
 }
 return (key_value);
}

void set_temperature()
{
 char kp=0;
 char go=0;
 unsigned char key_code=0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,3,"TEMPERATURA");
 sprintf(Data_Str,"%-2.1f C",parameters_t.set_temperatura);
 Lcd_Out(2,6,Data_Str);
 key_value=0;
 while(kp==0)
 {
 if(flag_t.status_in_menu== 0 )
 {
 key_value=key_back;
 }
 switch(key_value)
 {
 case key_up: key_value=0; parameters_t.set_temperatura=parameters_t.set_temperatura+0.1;
 if(parameters_t.set_temperatura>=40.0)
 {
 parameters_t.set_temperatura=40.0;
 }
 sprintf(Data_Str,"%-2.1f C",parameters_t.set_temperatura);
 Lcd_Out(2,6,Data_Str); break;

 case key_down: key_value=0;parameters_t.set_temperatura=parameters_t.set_temperatura-0.1;
 if(parameters_t.set_temperatura<=34.0)
 {
 parameters_t.set_temperatura=34.0;
 }
 sprintf(Data_Str,"%-2.1f C",parameters_t.set_temperatura);
 Lcd_Out(2,6,Data_Str); break;
 case key_enter: key_value=0;go=1;kp=1; break;
 case key_back: key_value=0;kp=1; Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF); break;
 }

 }
 if(go== 1 )set_humidity();

}


void set_humidity()
{
 char kp=0;
 char go=0;
 unsigned char key_code=0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,5,"VLAJNOST");
 sprintf(Data_Str,"%-2.1f %%",parameters_t.set_humidity);
 Lcd_Out(2,6,Data_Str);
 key_value=0;
 while(kp==0)
 {
 if(flag_t.status_in_menu== 0 )
 {
 key_value=key_back;
 }
 switch(key_value)
 {
 case key_up: key_value=0; parameters_t.set_humidity=parameters_t.set_humidity+10.0;
 if(parameters_t.set_humidity>=90.0)
 {
 parameters_t.set_humidity=90.0;
 }
 sprintf(Data_Str,"%-2.1f %%",parameters_t.set_humidity);
 Lcd_Out(2,6,Data_Str); break;

 case key_down: key_value=0;parameters_t.set_humidity=parameters_t.set_humidity-10.0;
 if(parameters_t.set_humidity<=10.0)
 {
 parameters_t.set_humidity=10.0;
 }
 sprintf(Data_Str,"%-2.1f %%",parameters_t.set_humidity);
 Lcd_Out(2,6,Data_Str); break;
 case key_enter: key_value=0; go=1; kp=1; break;
 case key_back: key_value=0;kp=1; Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF); break;
 }

 }
 if(go== 1 ) set_temperature_gist();
}



void set_temperature_gist()
{
 char kp=0;
 char go=0;
 unsigned char key_code=0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,1,"TEMPERATURA GIST");
 sprintf(Data_Str,"%-2.1f C",parameters_t.temperatura_delta__alarm_level);
 Lcd_Out(2,6,Data_Str);
 key_value=0;
 while(kp==0)
 {
 if(flag_t.status_in_menu== 0 )
 {
 key_value=key_back;
 }
 switch(key_value)
 {
 case key_up: key_value=0; parameters_t.temperatura_delta__alarm_level=parameters_t.temperatura_delta__alarm_level+1.0;
 if(parameters_t.temperatura_delta__alarm_level>=5.0)
 {
 parameters_t.temperatura_delta__alarm_level=5.0;
 }
 sprintf(Data_Str,"%-2.1f C",parameters_t.temperatura_delta__alarm_level);
 Lcd_Out(2,6,Data_Str); break;

 case key_down: key_value=0;parameters_t.temperatura_delta__alarm_level=parameters_t.temperatura_delta__alarm_level-1.0;
 if(parameters_t.temperatura_delta__alarm_level<=1.0)
 {
 parameters_t.temperatura_delta__alarm_level=1.0;
 }
 sprintf(Data_Str,"%-2.1f C",parameters_t.temperatura_delta__alarm_level);
 Lcd_Out(2,6,Data_Str); break;
 case key_enter: key_value=0; go=1; kp=1; break;
 case key_back: key_value=0;kp=1; Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF); break;
 }

 }
 if(go== 1 ) set_humidity_gist();
}



void set_humidity_gist()
{
 char kp=0;
 char go=0;
 unsigned char key_code=0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,3,"VLAJNOST GIST");
 sprintf(Data_Str,"%-2.1f %%",parameters_t.humidity_delta_alarm_level);
 Lcd_Out(2,6,Data_Str);
 key_value=0;
 while(kp==0)
 {
 if(flag_t.status_in_menu== 0 )
 {
 key_value=key_back;
 }
 switch(key_value)
 {
 case key_up: key_value=0; parameters_t.humidity_delta_alarm_level=parameters_t.humidity_delta_alarm_level+10.0;
 if(parameters_t.humidity_delta_alarm_level>=90.0)
 {
 parameters_t.humidity_delta_alarm_level=90.0;
 }
 sprintf(Data_Str,"%-2.1f %%",parameters_t.humidity_delta_alarm_level);
 Lcd_Out(2,6,Data_Str); break;

 case key_down: key_value=0;parameters_t.humidity_delta_alarm_level=parameters_t.humidity_delta_alarm_level-10.0;
 if(parameters_t.humidity_delta_alarm_level<=10.0)
 {
 parameters_t.humidity_delta_alarm_level=10.0;
 }
 sprintf(Data_Str,"%-2.1f %%",parameters_t.humidity_delta_alarm_level);
 Lcd_Out(2,6,Data_Str); break;
 case key_enter: key_value=0; go=1; kp=1; break;
 case key_back: key_value=0;kp=1; Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF); break;
 }

 }
 if(go== 1 ) set_turn_time();
}


void set_turn_time()
{
 char kp=0;
 char go=0;
 unsigned char key_code=0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,6,"VREMYA");
 sprintf(Data_Str,"%-3.1f min",parameters_t.set_turn_time);
 Lcd_Out(2,5,Data_Str);
 key_value=0;
 while(kp==0)
 {
 if(flag_t.status_in_menu== 0 )
 {
 key_value=key_back;
 }
 switch(key_value)
 {
 case key_up: key_value=0; parameters_t.set_turn_time=parameters_t.set_turn_time+10.0;
 if(parameters_t.set_turn_time>=120.0)
 {
 parameters_t.set_turn_time=120.0;
 }
 sprintf(Data_Str,"%-3.1f min  ",parameters_t.set_turn_time);
 Lcd_Out(2,5,Data_Str); break;

 case key_down: key_value=0;parameters_t.set_turn_time=parameters_t.set_turn_time-10.0;
 if(parameters_t.set_turn_time<=10.0)
 {
 parameters_t.set_turn_time=10.0;
 }
 sprintf(Data_Str,"%-3.1f min  ",parameters_t.set_turn_time);
 Lcd_Out(2,5,Data_Str); break;
 case key_enter: key_value=0; go=1; kp=1; break;
 case key_back: key_value=0;kp=1; Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF); break;
 }

 }
 if(go== 1 ) set_humidity_control();
}

void set_humidity_control()
{
 char kp=0;
 char go=0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,3,"CTRL VLAJNOSTY");
 if(parameters_t.control_humidity==0.0)
 {
 flag_t.control_humidity= 0 ;
 Lcd_Out(2,7,"NET.  ");
 }
 if(parameters_t.control_humidity==1.0)
 {
 flag_t.control_humidity= 1 ;
 Lcd_Out(2,7,"DA .  ");
 }
 key_value=0;
while(kp==0)
 {
 if(flag_t.status_in_menu== 0 )
 {
 key_value=key_back;
 }
 switch(key_value)
 {
 case key_up: key_value=0; Lcd_Out(2,7,"DA .  "); flag_t.control_humidity= 1 ;parameters_t.control_humidity=1.0; break;
 case key_down: key_value=0; Lcd_Out(2,7,"NET.  "); flag_t.control_humidity= 0 ; parameters_t.control_humidity=0.0; break;
 case key_enter: key_value=0;go=1;kp=1; break;
 case key_back: key_value=0;kp=1; Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF); break;
 }
 }
 if(go== 1 ) save_data();
}

void save_data_exit()
{
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 save_data_to_eeprom();
 Delay_ms(1000);
 Lcd_Out(1,6,"DANYE");
 Lcd_Out(2,5,"ZAPISANY");
 Delay_ms(1000);
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
}

void save_data()
{
 char kp=0;
 char go=0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,3,"ZAPIS DANYH");
 Lcd_Out(2,7,"NET.  ");
 flag_t.data_save= 0 ;
 key_value=0;
while(kp==0)
 {
 if(flag_t.status_in_menu== 0 )
 {
 key_value=key_back;
 }
 switch(key_value)
 {
 case key_up: key_value=0; Lcd_Out(2,7,"DA .  "); flag_t.data_save= 1 ; break;
 case key_down: key_value=0; Lcd_Out(2,7,"NET.  "); flag_t.data_save= 0 ; break;
 case key_enter: key_value=0;go=1;kp=1; break;
 case key_back: key_value=0;kp=1; Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF); break;
 }
 }
 if(flag_t.data_save== 1 )
 {
 save_data_exit();
 }
 if(go== 1 ) set_errors();
}

unsigned long ee_data[ 10 ];
char save_data_to_eeprom()
{
 char position=0;
 unsigned long temp=0,adress=0;

 for(position=0;position< 10 ;position++)
 {
 ee_data[position]=0;
 }
 ee_data[0]=(unsigned long)(parameters_t.set_temperatura*100.0);
 ee_data[1]=(unsigned long)(parameters_t.set_humidity*100.0);
 ee_data[2]=(unsigned long)(parameters_t.set_turn_time*100.0);
 ee_data[3]=(unsigned long)(parameters_t.temperatura_delta__alarm_level*100.0);
 ee_data[4]=(unsigned long)(parameters_t.humidity_delta_alarm_level*100.0);
 ee_data[5]=(unsigned long)(parameters_t.control_humidity*100.0);
 ee_data[6]=0;
 ee_data[7]=0;
 for(position=0;position<8;position++)
 {
 temp+=ee_data[position];
 }
 ee_data[8]=temp;
 DisableInterrupts();

 EEPROM_MassErase();
 EEPROM_Program(ee_data,  0 ,  64 );
 EnableInterrupts();
 return read_data_in_eeprom();
}


char read_data_in_eeprom()
{
 unsigned long temp=0,temp1=0;
 char position=0;
 DisableInterrupts();
 for(position=0;position< 10 ;position++)
 {
 ee_data[position]=0;
 }


 EEPROM_Read(ee_Data,  0 ,  64 );
 EnableInterrupts();
 for(position=0;position<8;position++)
 {
 temp1+=ee_data[position];
 }
 temp=ee_data[8];

 if(temp==temp1)
 {
 parameters_t.set_temperatura= (float)((float)ee_data[0]/100.0);
 parameters_t.set_humidity= (float)((float)ee_data[1]/100.0);
 parameters_t.set_turn_time= (float)((float)ee_data[2]/100.0);
 parameters_t.temperatura_delta__alarm_level= (float)((float)ee_data[3]/100.0);
 parameters_t.humidity_delta_alarm_level= (float)((float)ee_data[4]/100.0);
 parameters_t.control_humidity= (float)((float)ee_data[5]/100.0);


 return 0;
 }
 if(temp!=temp1)
 {
 return 1;
 }
}

void read_key()
{
 static char count_key=0;
 if(PIN_UP== 0 ||PIN_DOWN== 0 ||PIN_ENTER== 0 ||PIN_BACK== 0 )
 {
 count_key++;
 if(count_key==10)
 {
 count_key=0;
 if(PIN_UP== 0 ||PIN_DOWN== 0 ||PIN_ENTER== 0 ||PIN_BACK== 0 )
 {
 Beep();
 key_value=key_code_pressed();

 }
 }
 }
}

void Beep()
{
 Sound_Play(1000,100);
}
#line 497 "D:/ALL_PROJECTS/INKUBATOR/inkubator_func.c"
void pid_Init(int16_t p_factor, int16_t i_factor, int16_t d_factor, struct PID_DATA *pid)

{

 pid->sumError = 0;
 pid->lastProcessValue = 0;

 pid->P_Factor = p_factor;
 pid->I_Factor = i_factor;
 pid->D_Factor = d_factor;

 pid->maxError =  32767  / (pid->P_Factor + 1);
 pid->maxSumError =  ( 2147483647  / 2)  / (pid->I_Factor + 1);
}
#line 521 "D:/ALL_PROJECTS/INKUBATOR/inkubator_func.c"
int16_t pid_Controller(int16_t setPoint, int16_t processValue, struct PID_DATA *pid_st)
{
 int16_t error, p_term, d_term;
 int32_t i_term, ret, temp;

 error = setPoint - processValue;


 if (error > pid_st->maxError){
 p_term =  32767 ;
 }
 else if (error < -pid_st->maxError){
 p_term = - 32767 ;
 }
 else{
 p_term = pid_st->P_Factor * error;
 }


 temp = pid_st->sumError + error;
 if(temp > pid_st->maxSumError){
 i_term =  ( 2147483647  / 2) ;
 pid_st->sumError = pid_st->maxSumError;
 }
 else if(temp < -pid_st->maxSumError){
 i_term = - ( 2147483647  / 2) ;
 pid_st->sumError = -pid_st->maxSumError;
 }
 else{
 pid_st->sumError = temp;
 i_term = pid_st->I_Factor * pid_st->sumError;
 }


 d_term = pid_st->D_Factor * (pid_st->lastProcessValue - processValue);

 pid_st->lastProcessValue = processValue;

 ret = (p_term + i_term + d_term) /  128.0 ;
 if(ret >  32767 ){
 ret =  32767 ;
 }
 else if(ret < - 32767 ){
 ret = - 32767 ;
 }

 return((int16_t)ret);
}
#line 574 "D:/ALL_PROJECTS/INKUBATOR/inkubator_func.c"
void pid_Reset_Integrator(pidData_t *pid_st)
{
 pid_st->sumError = 0;
}

void control_outs()
{
 RELE_ALARM = flag_t.temperatura_alarm||flag_t.humidity_alarm;
 LED_RED = flag_t.temperatura_alarm||flag_t.humidity_alarm;

 RELE_ALARM_TRIAC = flag_t.temperatura_triac_alarm;
 LED_BLUE = flag_t.temperatura_triac_alarm;

 RELE_FAN = flag_t.start_fan;

 RELE_COVER = flag_t.cover_status;

 RELE_HUMIDITI = flag_t.humidity_cover_status;
 LED_GREEN = flag_t.humidity_cover_status;
}

void reset_flags()
{
 flag_t.temperatura_alarm=0;
 flag_t.temperatura_triac_alarm=0;
 flag_t.cover_status=0;
 flag_t.humidity_alarm=0;
 flag_t.humidity_cover_status=0;
 flag_t.control_humidity=0;
}


void set_default_parameters()
{
 parameters_t.set_temperatura=37.5;
 parameters_t.set_humidity=50.0;
 parameters_t.set_turn_time=60.0;
 parameters_t.temperatura_delta__alarm_level=2.0;
 parameters_t.humidity_delta_alarm_level=10.0;
 parameters_t.control_humidity=0.0;
}

void Load()
{
 char i=0;
 unsigned int tone=0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(2,1,"SYSTEMA STARTUET");
 for(i=0,tone=500;i<17;i++,tone+=80)
 {
 Lcd_Out(1,i,">");
 Delay_ms(300);
 Sound_Play(tone,100);
 }
 Lcd_Cmd(_LCD_CLEAR);
}
#line 639 "D:/ALL_PROJECTS/INKUBATOR/inkubator_func.c"
void rotation()
{
 static unsigned long count_rotations=0;
 if(++count_rotations>=((unsigned long)parameters_t.set_turn_time*1200))
 {
 RELE_ROTATION^=1;
 count_rotations=0;
 }
}

void Get_key()
{
 switch(key_value)
 {
 case key_up : key_value=0;flag_t.start_fan^=1; break;
 case key_down : key_value=0;flag_t.start_process^=1;
 if(flag_t.start_process== 1 )
 {
 flag_t.first_start_t= 0 ;
 flag_t.first_start_h= 0 ;
 }
 break;
 case key_enter: key_value=0;flag_t.status_in_menu= 1 ; set_temperature(); break;
 case key_back : key_value=0; break;
 }

}

void control_menu()
{
 static unsigned int count_processed=0;
 static unsigned int sec=120;
 if(flag_t.status_in_menu== 1 )
 {
 if((++count_processed)>=(sec*20))
 {
 count_processed=0;
 flag_t.status_in_menu= 0 ;
 }
 }
}

void impulse()
{

 TRIAC_OUT=1;
 Delay_us(500);

 TRIAC_OUT=0;
}

void start_eeprom()
{
 EEPROM_Init();
if(read_data_in_eeprom()== 1 )
 {
 set_default_parameters();
 }
 if(parameters_t.control_humidity==0.0)
 {
 flag_t.control_humidity= 0 ;
 }
 if(parameters_t.control_humidity==1.0)
 {
 flag_t.control_humidity= 1 ;
 }

}
