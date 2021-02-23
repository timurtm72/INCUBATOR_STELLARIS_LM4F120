#include "inkubator_def.h"

//=======================functions release======================================
 void Init_Gpio()
 {
   //led digital out
   GPIO_Config(&GPIO_PORTF, _GPIO_PINMASK_1|_GPIO_PINMASK_2|_GPIO_PINMASK_3 , _GPIO_DIR_OUTPUT, _GPIO_CFG_DIGITAL_ENABLE| _GPIO_CFG_DRIVE_8mA , _GPIO_PINCODE_NONE);
   //rele digital out
   GPIO_Config(&GPIO_PORTA, _GPIO_PINMASK_3|_GPIO_PINMASK_4|_GPIO_PINMASK_5 , _GPIO_DIR_OUTPUT, _GPIO_CFG_DIGITAL_ENABLE| _GPIO_CFG_DRIVE_8mA , _GPIO_PINCODE_NONE);
   GPIO_Config(&GPIO_PORTB, _GPIO_PINMASK_5|_GPIO_PINMASK_6|_GPIO_PINMASK_7 , _GPIO_DIR_OUTPUT, _GPIO_CFG_DIGITAL_ENABLE| _GPIO_CFG_DRIVE_8mA , _GPIO_PINCODE_NONE);
   GPIO_Config(&GPIO_PORTE, _GPIO_PINMASK_0 , _GPIO_DIR_OUTPUT, _GPIO_CFG_DIGITAL_ENABLE| _GPIO_CFG_DRIVE_8mA  , _GPIO_PINCODE_NONE);
   // dht22 pin conections
   GPIO_Config(&GPIO_PORTB, _GPIO_PINMASK_3, _GPIO_DIR_INPUT, _GPIO_CFG_DIGITAL_ENABLE, _GPIO_PINCODE_NONE);
   //BLED output
   GPIO_Config(&GPIO_PORTA, _GPIO_PINMASK_2, _GPIO_DIR_OUTPUT, _GPIO_CFG_DIGITAL_ENABLE| _GPIO_CFG_DRIVE_8mA , _GPIO_PINCODE_NONE);
   //Buzzer init
   Sound_Init(&GPIO_PORTE_DATA, 1);
   //zerro cros detector in
   GPIO_Config(&GPIO_PORTD,_GPIO_PINMASK_6,_GPIO_DIR_INPUT,_GPIO_CFG_DIGITAL_ENABLE,_GPIO_PINCODE_NONE);
   //triac out
   GPIO_Config(&GPIO_PORTB, _GPIO_PINMASK_2 ,_GPIO_DIR_OUTPUT, _GPIO_CFG_DIGITAL_ENABLE, _GPIO_PINCODE_NONE);
   //GPIO_Config(&GPIO_PORTD,_GPIO_PINMASK_7,_GPIO_DIR_OUTPUT,_GPIO_CFG_DIGITAL_ENABLE,_GPIO_PINCODE_NONE);
   //key in
   GPIO_Config(&GPIO_PORTD,_GPIO_PINMASK_0|_GPIO_PINMASK_1|_GPIO_PINMASK_2|_GPIO_PINMASK_3,_GPIO_DIR_INPUT,_GPIO_CFG_DIGITAL_ENABLE,_GPIO_PINCODE_NONE);
   //start sht11 pin
 }
//==============================================================================
void Init_ext_int()
{
  GPIO_PORTD_AFSEL = _GPIO_PINMASK_6;    // Enable alternate pin functions
  GPIO_PORTD_IS = 0;                     // Edge sensitive
  GPIO_PORTD_IBE = 0;                    // Edge/Level detection triggers interrupt
  GPIO_PORTD_IEV = _GPIO_PINMASK_6;      // Rising Edge will trigger interrupt
  GPIO_PORTD_IM = _GPIO_PINMASK_6;       // Set mask to pin6
  NVIC_IntEnable(IVT_INT_GPIOD);         // Enable GPIOD interrupt

}
//==============================================================================
//Timer0 Prescaler :63; Preload = 62500; Actual Interrupt Time = 50 ms; Mode: 16bit
void InitTimer0A(){
  SYSCTL_RCGCTIMER_R0_bit = 1;
  EnableInterrupts();
  TIMER_CTL_TAEN_bit = 0;
  TIMER0_CFG   = 4;
  TIMER0_TAMR |= 2;
  TIMER0_TAPR  = 63;
  TIMER0_TAILR = 62500;
  NVIC_IntEnable(IVT_INT_TIMER0A_16_32_bit);
  TIMER_IMR_TATOIM_bit = 1;
  TIMER_CTL_TAEN_bit   = 1;
}
//==============================================================================
//Timer1 Prescaler :15; Preload = 50000; Actual Interrupt Time = 10 ms; Mode: 16bit

//Place/Copy this part in declaration section
void StartTimer1A_10ms(unsigned long interval){ //50000=>10ms
  SYSCTL_RCGCTIMER_R1_bit = 1;
  TIMER_CTL_TAEN_TIMER1_CTL_bit = 0;
  TIMER1_CFG   = 4;
  TIMER1_TAMR |= 2;
  TIMER1_TAPR  = 15;
  TIMER1_TAILR = interval;//50000;
  NVIC_IntEnable(IVT_INT_TIMER1A_16_32_bit);
  TIMER_IMR_TATOIM_TIMER1_IMR_bit = 1;
  TIMER_CTL_TAEN_TIMER1_CTL_bit = 1;
}
//==============================================================================
void StopTimer1A_10ms(){
  TIMER_CTL_TAEN_TIMER1_CTL_bit = 0;
  TIMER1_CFG   = 0;
  TIMER1_TAMR  = 0;
  TIMER1_TAPR  = 0;
  TIMER1_TAILR = 0;
  //NVIC_IntEnable(IVT_INT_TIMER1A_16_32_bit);
  TIMER_IMR_TATOIM_TIMER1_IMR_bit = 0;
  TIMER_CTL_TAEN_TIMER1_CTL_bit = 0;
}
//==============================================================================
void Init_flags()
{
  flag_t.main_timer_ovf                 = 0;
  flag_t.temperatura_alarm              = 0;
  flag_t.temperatura_alarm_cover        = 0;
  flag_t.humidity_alarm                 = 0;
  flag_t.temperatura_triac_alarm        = 0;
  flag_t.cover_status                   = 0;
  flag_t.start_fan                      = 0;
  flag_t.start_process                  = 0;
  flag_t.data_save                      = 0;
  flag_t.status_in_menu                 = 0;
  flag_t.first_start_t                  = 0;
  flag_t.first_start_h                  = 0;
  flag_t.humidity_cover_status          = 0;
  flag_t.humidity_alarm_cover           = 0;
  flag_t.control_humidity               = 0;
}
//==============================================================================