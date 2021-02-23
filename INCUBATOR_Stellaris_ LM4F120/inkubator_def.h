#include "stdint.h"
#define TRUE                    1
#define FALSE                   0
#define SET                     1
#define RESET                   0
#define KEY_PORT                GPIO_PORTD_DATA
#define SCALING_FACTOR          128.0
#define PER_TIM_ZCD             50000
//==============================================================================
#define BLOCK_SIZE 64                // block size in bytes
#define DATA_SIZE BLOCK_SIZE/4       // block size in words (unsigned long)
#define PASS_SIZE 2
#define START_ADDRESS 0
#define OFFSET 0x10

#define HIDE_ADDRESS 128
#define LOCK_ADDRESS 256
#define HIDE_BLOCK_NUMBER HIDE_ADDRESS/BLOCK_SIZE
#define LOCK_BLOCK_NUMBER LOCK_ADDRESS/BLOCK_SIZE
#define DATA_SIZE       10

//==============================================================================
extern sfr sbit LED_RED;
extern sfr sbit LED_BLUE;
extern sfr sbit LED_GREEN;
extern struct flag flag_t;
//===========================Functions declarations=============================
//extern char *message[]={".................","TEMPERATYRA","VLAJNOST","KLUCH PROBIT"};
extern char errors[255];
//==============================================================================
extern unsigned long ee_Data[DATA_SIZE];
//extern unsigned long ee_readData[DATA_SIZE];
//unsigned long password[PASS_SIZE];
//==============================================================================
//extern char errors[255];
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
//==============================================================================
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
//extern struct flag flag_t;
//==============================================================================
struct  Spid
{
  float dState;                  // Last position input
  float iState;                  // Integrator state
  float iMax, iMin;
  // Maximum and minimum allowable integrator state
  float    iGain,        // integral gain
            pGain,        // proportional gain
             dGain;         // derivative gain
};
extern struct Spid Rpid;
//==============================================================================
struct flag
{
  main_timer_ovf          : 1;
  temperatura_alarm       : 1;
  temperatura_alarm_cover : 1;
  humidity_alarm          : 1;
  temperatura_triac_alarm : 1;
  cover_status            : 1;
  start_fan               : 1;
  start_process           : 1;
  data_save               : 1;
  status_in_menu          : 1;
  first_start_t           : 1;
  first_start_h           : 1;
  humidity_cover_status   : 1;
  humidity_alarm_cover    : 1;
  control_humidity        : 1;
};
//==============================================================================
/*! \brief PID Status
 *
 * Setpoints and data used by the PID control algorithm
 */
typedef struct PID_DATA{
  //! Last process value, used to find derivative of process value.
  int16_t lastProcessValue;
  //! Summation of errors, used for integrate calculations
  int32_t sumError;
  //! The Proportional tuning constant, multiplied with SCALING_FACTOR
  int16_t P_Factor;
  //! The Integral tuning constant, multiplied with SCALING_FACTOR
  int16_t I_Factor;
  //! The Derivative tuning constant, multiplied with SCALING_FACTOR
  int16_t D_Factor;
  //! Maximum allowed error, avoid overflow
  int16_t maxError;
  //! Maximum allowed sumerror, avoid overflow
  int32_t maxSumError;
} pidData_t;

/*! \brief Maximum values
 *
 * Needed to avoid sign/overflow problems
 */
// Maximum value of variables
#define MAX_INT         INT16_MAX
#define MAX_LONG        INT32_MAX
#define MAX_I_TERM      (MAX_LONG / 2)

// Boolean values
#define FALSE           0
#define TRUE            1

void pid_Init(int16_t p_factor, int16_t i_factor, int16_t d_factor, struct PID_DATA *pid);
int16_t pid_Controller(int16_t setPoint, int16_t processValue, struct PID_DATA *pid_st);
void pid_Reset_Integrator(pidData_t *pid_st);


extern float out_reg_value;
//==============================================================================
extern float temperature;
extern float rel_humidity;
extern char Data_Str[12];
extern volatile unsigned char key_value;
//==============================================================================
void Init_Gpio();
void InitTimer0A();
void Read_SHT11(float *fT, float *fRH);
void Init_ext_int();
void StartTimer1A_10ms(unsigned long interval);
void StopTimer1A_10ms();

//void InitTimer1();
//void void Read_SHT11(float *fT, float *fRH);
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
//void Init_ext_int();
//void start_timer0(unsigned char ocr);
//void stop_timer0();
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