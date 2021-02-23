#include"inkubator_def.h"
#include "stdint.h"
sbit LED_RED    at GPIO_PORTF_DATA.B1;
sbit LED_BLUE   at GPIO_PORTF_DATA.B2;
sbit LED_GREEN  at GPIO_PORTF_DATA.B3;
//------------------------------------------------------------------------------
sbit BUZZER     at GPIO_PORTE_DATA.B1;
sbit BLED       at GPIO_PORTA_DATA.B2;
//------------------------------------------------------------------------------
sbit PIN_UP     at GPIO_PORTD_DATA.B0;
sbit PIN_DOWN   at GPIO_PORTD_DATA.B1;
sbit PIN_ENTER  at GPIO_PORTD_DATA.B2;
sbit PIN_BACK   at GPIO_PORTD_DATA.B3;
//==============================================================================
// LCD module connections
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
// End LCD module connections
//==============================================================================
sbit RELE_FAN           at GPIO_PORTA_DATA.B3;
sbit RELE_COVER         at GPIO_PORTA_DATA.B4;
sbit RELE_ROTATION      at GPIO_PORTA_DATA.B5;
sbit RELE_ALARM         at GPIO_PORTB_DATA.B6;
sbit RELE_ALARM_TRIAC   at GPIO_PORTB_DATA.B5;
sbit RELE_HUMIDITI      at GPIO_PORTE_DATA.B0;

//==============================================================================
sbit IN_ZCD             at GPIO_PORTD_DATA.B6;
sbit TRIAC_OUT          at GPIO_PORTB_DATA.B2;
//------------------------------------------------------------------------------
//SHT11 connections
/*sbit SCL_pin  at GPIO_PORTB_DATA.B2;         // Serial clock pin
sbit SDA_pin  at GPIO_PORTB_DATA.B3;         // Serial data pin

sbit SCL_pin_DIR at GPIO_PORTB_DIR2_bit;     // Serial clock pin direction
sbit SDA_pin_DIR at GPIO_PORTB_DIR3_bit;     // Serial data pin direction*/
//==============================================================================

//==============================================================================
char *message[]={".................","TEMPERATYRA","VLAJNOST","KLUCH PROBIT","DATCHIK"};
char errors[255];
//==============================================================================
/*! \brief P, I and D parameter values
 *
 * The K_P, K_I and K_D values (P, I and D gains)
 * need to be modified to adapt to the application at hand
 */
//! \xrefitem todo "Todo" "Todo list"
#define K_P     10.0
//! \xrefitem todo "Todo" "Todo list"
#define K_I     0.1
//! \xrefitem todo "Todo" "Todo list"
#define K_D     10.0
//! Parameters for regulator
struct PID_DATA pidData;
struct Spid Rpid;
//==============================================================================
//enum key_number {key_up=1,key_down,key_enter,key_back};
char Data_Str[12];
//==============================================================================
// global variables
float temperature;
float rel_humidity;
//static char read_sensor_count=0;
//float Tc;
volatile float out_reg_value=0;
volatile unsigned char key_value=0;
//==============================================================================
struct parameters parameters_t;
struct flag flag_t={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
//==============================================================================

void Timer0A_interrupt() iv IVT_INT_TIMER0A_16_32_bit ics ICS_AUTO {
  TIMER_ICR_TATOCINT_bit = 1;
  flag_t.main_timer_ovf=SET;
  read_key();
  //LED_RED^=1;
  control_menu();
}
//==============================================================================
void Zero_cross_detector_int() iv IVT_INT_GPIOD ics ICS_AUTO 
{
  unsigned long temp=0;
  GPIO_PORTD_ICR = _GPIO_PINMASK_6;      // clear ext interrupt flag
  if(flag_t.start_process==SET)
   {
     temp=(unsigned long)(100.0*out_reg_value);
     if(temp>PER_TIM_ZCD) temp=PER_TIM_ZCD;
     switch(temp)
      {
        case 0:                    TRIAC_OUT=RESET; break;
        case 1:                    TRIAC_OUT=RESET; break;
        case 2:                    TRIAC_OUT=RESET; break;
        case PER_TIM_ZCD-2:        TRIAC_OUT=SET;   break;
        case PER_TIM_ZCD-1:        TRIAC_OUT=SET;   break;
        case PER_TIM_ZCD:          TRIAC_OUT=SET;   break;
        default:                   StartTimer1A_10ms(temp);break;//PER_TIM_ZCD-temp); break;
      }
      //LED_GREEN^=1;

   }

}
//==============================================================================
void Timer1A_interrupt() iv IVT_INT_TIMER1A_16_32_bit ics ICS_AUTO 
{
  TIMER_ICR_TATOCINT_TIMER1_ICR_bit = 1;
  StopTimer1A_10ms();
  impulse();
}
//==============================================================================
volatile unsigned char code_key=0;
void main()
{
  Init_flags();
  Init_Gpio();
  Lcd_Init();                        // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  //pid_Init(K_P * SCALING_FACTOR, K_I * SCALING_FACTOR , K_D * SCALING_FACTOR , &pidData);
  init_pid();
  start_eeprom();
  reset_error_message();
  BLED=SET;
  Load();
  Init_ext_int();
  InitTimer0A();
  EnableInterrupts();
//==============================================================================
  while(TRUE) 
  {
   if(flag_t.main_timer_ovf==SET)
      {
//==============================================================================
        flag_t.main_timer_ovf=RESET;
        if(flag_t.start_process==SET)
         {
            rotation();
            //out_reg_value=pid_Controller((int16_t)parameters_t.set_temperatura, (int16_t)temperature, &pidData);
            out_reg_value=fabs(UpdatePID(Rpid,(parameters_t.set_temperatura-temperature),temperature));
            out_reg_value=(parameters_t.set_temperatura*5)-out_reg_value;
            if(out_reg_value<0) out_reg_value=0;
         }
           /*else
                {
                  out_reg_value=0;
                }*/
            Get_key();
            Read_sensor();

//==============================================================================
        if(flag_t.start_process==SET)
          {
             control_first_start();
             control_temperature();
             control_temperature_triac();
             temperature_cover_open_close();
             control_temperature_cover();
           if(flag_t.control_humidity==SET)
             {
               control_humidity();
               control_cover_humidity();
               humidity_cover_open_close();
             }
           if(flag_t.control_humidity==RESET)
             {
               flag_t.humidity_cover_status=RESET;
             }
          }
        if(flag_t.start_process==RESET)
          {
            reset_flags();
          }
           control_outs();
           out_data_to_lcd();
//==============================================================================
     }
  }
}