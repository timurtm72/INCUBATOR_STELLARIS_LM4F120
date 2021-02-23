#include"inkubator_def.h"


//==============================================================================
void Read_sensor()
{
  static unsigned char read_sensor_count=0;
     if((++read_sensor_count)==20)
         {
            read_sensor_count=0;
            //Read_SHT11(&temperature, &rel_humidity);
             DisableInterrupts();
            if (AM2302_Read(&rel_humidity, &temperature) == 1)                 // Display AM2302_Read sensor values via TFT
              {
                   set_fault(4);
                  /*Lcd_Cmd(_LCD_CLEAR);               // Clear display
                   Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
                   Lcd_Out(1,1,"Sboy svaziy...");*/
              }
            EnableInterrupts();
         }

}
//==============================================================================
void out_data_to_lcd()
{
   static unsigned char count_data=0;
     if((++count_data)>=10)
         {
            count_data=0;
            Out_data_in_lcd();
         }


}
//==============================================================================
void Out_data_in_lcd()
{
  Lcd_Out(1,1,"Tr");
  sprintf(Data_Str,"%-2.1fC",temperature);
  Lcd_Out(1,3,Data_Str);

  sprintf(Data_Str,"%-1.1fC%-2.0f%%  ",temperature-parameters_t.set_temperatura,rel_humidity-parameters_t.set_humidity);
  //sprintf(Data_Str,"%6.1f   ",out_reg_value);
  Lcd_Out(2,8,Data_Str);

  Lcd_Out(1,9,"M");
  if(flag_t.start_fan==SET) Lcd_Out(1,10,"+");
  if(flag_t.start_fan==RESET) Lcd_Out(1,10,"-");

  Lcd_Out(1,12,"P");
  if(flag_t.start_process==SET) Lcd_Out(1,13,"+");
  if(flag_t.start_process==RESET) Lcd_Out(1,13,"-");

  Lcd_Out(1,15,"K");
  if(flag_t.cover_status==SET) Lcd_Out(1,16,"+");
  if(flag_t.cover_status==RESET) Lcd_Out(1,16,"-");
  Lcd_Out(2,1,"Vr");
  //sprintf(Data_Str,"%-3u   ",rel_humidity);
  sprintf(Data_Str,"%-2.1f%%",rel_humidity);
  Lcd_Out(2,3,Data_Str);

  //Lcd_Out(2,9,"Vu");
  //sprintf(Data_Str,"%-2.1f%%",parameters_t.set_humidity);
  //Lcd_Out(2,11,Data_Str);

}
//==============================================================================
unsigned char key_code_pressed()
{
  unsigned char key_value=0;
      if(PIN_UP==RESET)
       {
         key_value=key_up;
       }
        if(PIN_DOWN==RESET)
         {
           key_value=key_down;
         }
          if(PIN_ENTER==RESET)
           {
             key_value=key_enter;
           }
            if(PIN_BACK==RESET)
             {
               key_value=key_back;
             }
       return (key_value);
}
//==============================================================================
void set_temperature()
{
  char kp=0;
  char go=0;
  unsigned char key_code=0;
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  Lcd_Out(1,3,"TEMPERATURA");
  sprintf(Data_Str,"%-2.1f C",parameters_t.set_temperatura);
  Lcd_Out(2,6,Data_Str);
  key_value=0;
  while(kp==0)
  {
    if(flag_t.status_in_menu==RESET)
     {
      key_value=key_back;
     }
    switch(key_value)
     {
      case key_up:           key_value=0; parameters_t.set_temperatura=parameters_t.set_temperatura+0.1;
                                          if(parameters_t.set_temperatura>=40.0)
                                            {
                                              parameters_t.set_temperatura=40.0;
                                            }
                                            sprintf(Data_Str,"%-2.1f C",parameters_t.set_temperatura);
                                            Lcd_Out(2,6,Data_Str); break;

      case key_down:            key_value=0;parameters_t.set_temperatura=parameters_t.set_temperatura-0.1;
                                          if(parameters_t.set_temperatura<=34.0)
                                            {
                                              parameters_t.set_temperatura=34.0;
                                            }
                                            sprintf(Data_Str,"%-2.1f C",parameters_t.set_temperatura);
                                            Lcd_Out(2,6,Data_Str); break;
      case key_enter:           key_value=0;go=1;kp=1;    break;
      case key_back:           key_value=0;kp=1; Lcd_Cmd(_LCD_CLEAR);               // Clear display
                               Lcd_Cmd(_LCD_CURSOR_OFF);         break;
     }

  }
  if(go==SET)set_humidity();

}

//==============================================================================
void set_humidity()
{
  char kp=0;
  char go=0;
  unsigned char key_code=0;
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  Lcd_Out(1,5,"VLAJNOST");
  sprintf(Data_Str,"%-2.1f %%",parameters_t.set_humidity);
  Lcd_Out(2,6,Data_Str);
  key_value=0;
  while(kp==0)
  {
    if(flag_t.status_in_menu==RESET)
     {
      key_value=key_back;
     }
    switch(key_value)
     {
      case key_up:           key_value=0; parameters_t.set_humidity=parameters_t.set_humidity+10.0;
                                          if(parameters_t.set_humidity>=90.0)
                                            {
                                              parameters_t.set_humidity=90.0;
                                            }
                                            sprintf(Data_Str,"%-2.1f %%",parameters_t.set_humidity);
                                            Lcd_Out(2,6,Data_Str); break;

      case key_down:            key_value=0;parameters_t.set_humidity=parameters_t.set_humidity-10.0;
                                          if(parameters_t.set_humidity<=10.0)
                                            {
                                              parameters_t.set_humidity=10.0;
                                            }
                                            sprintf(Data_Str,"%-2.1f %%",parameters_t.set_humidity);
                                            Lcd_Out(2,6,Data_Str); break;
      case key_enter:           key_value=0;  go=1; kp=1; break;
      case key_back:           key_value=0;kp=1; Lcd_Cmd(_LCD_CLEAR);               // Clear display
                               Lcd_Cmd(_LCD_CURSOR_OFF);                break;
     }

  }
  if(go==SET)  set_temperature_gist();
}


//==============================================================================
void set_temperature_gist()
{
  char kp=0;
  char go=0;
  unsigned char key_code=0;
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  Lcd_Out(1,1,"TEMPERATURA GIST");
  sprintf(Data_Str,"%-2.1f C",parameters_t.temperatura_delta__alarm_level);
  Lcd_Out(2,6,Data_Str);
  key_value=0;
  while(kp==0)
  {
    if(flag_t.status_in_menu==RESET)
     {
      key_value=key_back;
     }
    switch(key_value)
     {
      case key_up:           key_value=0; parameters_t.temperatura_delta__alarm_level=parameters_t.temperatura_delta__alarm_level+1.0;
                                          if(parameters_t.temperatura_delta__alarm_level>=5.0)
                                            {
                                              parameters_t.temperatura_delta__alarm_level=5.0;
                                            }
                                            sprintf(Data_Str,"%-2.1f C",parameters_t.temperatura_delta__alarm_level);
                                            Lcd_Out(2,6,Data_Str); break;

      case key_down:            key_value=0;parameters_t.temperatura_delta__alarm_level=parameters_t.temperatura_delta__alarm_level-1.0;
                                          if(parameters_t.temperatura_delta__alarm_level<=1.0)
                                            {
                                              parameters_t.temperatura_delta__alarm_level=1.0;
                                            }
                                            sprintf(Data_Str,"%-2.1f C",parameters_t.temperatura_delta__alarm_level);
                                            Lcd_Out(2,6,Data_Str); break;
      case key_enter:           key_value=0;  go=1; kp=1; break;
      case key_back:           key_value=0;kp=1;  Lcd_Cmd(_LCD_CLEAR);               // Clear display
                               Lcd_Cmd(_LCD_CURSOR_OFF);               break;
     }

  }
  if(go==SET)  set_humidity_gist();
}


//==============================================================================
void set_humidity_gist()
{
  char kp=0;
  char go=0;
  unsigned char key_code=0;
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  Lcd_Out(1,3,"VLAJNOST GIST");
  sprintf(Data_Str,"%-2.1f %%",parameters_t.humidity_delta_alarm_level);
  Lcd_Out(2,6,Data_Str);
  key_value=0;
  while(kp==0)
  {
    if(flag_t.status_in_menu==RESET)
     {
      key_value=key_back;
     }
    switch(key_value)
     {
      case key_up:           key_value=0; parameters_t.humidity_delta_alarm_level=parameters_t.humidity_delta_alarm_level+10.0;
                                          if(parameters_t.humidity_delta_alarm_level>=90.0)
                                            {
                                              parameters_t.humidity_delta_alarm_level=90.0;
                                            }
                                            sprintf(Data_Str,"%-2.1f %%",parameters_t.humidity_delta_alarm_level);
                                            Lcd_Out(2,6,Data_Str); break;

      case key_down:            key_value=0;parameters_t.humidity_delta_alarm_level=parameters_t.humidity_delta_alarm_level-10.0;
                                          if(parameters_t.humidity_delta_alarm_level<=10.0)
                                            {
                                              parameters_t.humidity_delta_alarm_level=10.0;
                                            }
                                            sprintf(Data_Str,"%-2.1f %%",parameters_t.humidity_delta_alarm_level);
                                            Lcd_Out(2,6,Data_Str); break;
      case key_enter:           key_value=0;  go=1; kp=1; break;
      case key_back:           key_value=0;kp=1; Lcd_Cmd(_LCD_CLEAR);               // Clear display
                                                 Lcd_Cmd(_LCD_CURSOR_OFF);                break;
     }

  }
  if(go==SET)  set_turn_time();
}

//==============================================================================
void set_turn_time()
{
  char kp=0;
  char go=0;
  unsigned char key_code=0;
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  Lcd_Out(1,6,"VREMYA");
  sprintf(Data_Str,"%-3.1f min",parameters_t.set_turn_time);
  Lcd_Out(2,5,Data_Str);
  key_value=0;
  while(kp==0)
  {
    if(flag_t.status_in_menu==RESET)
     {
      key_value=key_back;
     }
    switch(key_value)
     {
      case key_up:           key_value=0; parameters_t.set_turn_time=parameters_t.set_turn_time+10.0;
                                          if(parameters_t.set_turn_time>=120.0)
                                            {
                                              parameters_t.set_turn_time=120.0;
                                            }
                                            sprintf(Data_Str,"%-3.1f min  ",parameters_t.set_turn_time);
                                            Lcd_Out(2,5,Data_Str); break;

      case key_down:            key_value=0;parameters_t.set_turn_time=parameters_t.set_turn_time-10.0;
                                          if(parameters_t.set_turn_time<=10.0)
                                            {
                                              parameters_t.set_turn_time=10.0;
                                            }
                                            sprintf(Data_Str,"%-3.1f min  ",parameters_t.set_turn_time);
                                            Lcd_Out(2,5,Data_Str); break;
      case key_enter:           key_value=0;  go=1; kp=1; break;
      case key_back:           key_value=0;kp=1; Lcd_Cmd(_LCD_CLEAR);               // Clear display
                                                 Lcd_Cmd(_LCD_CURSOR_OFF);                break;
     }

  }
  if(go==SET) set_humidity_control();
}
//==============================================================================
void set_humidity_control()
{
  char kp=0;
  char go=0;
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  Lcd_Out(1,3,"CTRL VLAJNOSTY");
  if(parameters_t.control_humidity==0.0)
 {
   flag_t.control_humidity=RESET;
   Lcd_Out(2,7,"NET.  ");
 }
   if(parameters_t.control_humidity==1.0)
    {
      flag_t.control_humidity=SET;
      Lcd_Out(2,7,"DA .  ");
    }
  key_value=0;
while(kp==0)
  {
    if(flag_t.status_in_menu==RESET)
     {
      key_value=key_back;
     }
    switch(key_value)
     {
      case key_up:          key_value=0; Lcd_Out(2,7,"DA .  "); flag_t.control_humidity=SET;parameters_t.control_humidity=1.0;     break;
      case key_down:        key_value=0; Lcd_Out(2,7,"NET.  ");  flag_t.control_humidity=RESET; parameters_t.control_humidity=0.0; break;
      case key_enter:       key_value=0;go=1;kp=1;                                                                               break;
      case key_back:        key_value=0;kp=1;    Lcd_Cmd(_LCD_CLEAR);
                                                 Lcd_Cmd(_LCD_CURSOR_OFF);                                                       break;
     }
  }
  if(go==SET) save_data();
}
//==============================================================================
void save_data_exit()
{
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  save_data_to_eeprom();
  Delay_ms(1000);
  Lcd_Out(1,6,"DANYE");
  Lcd_Out(2,5,"ZAPISANY");
  Delay_ms(1000);
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Cmd(_LCD_CURSOR_OFF);
}
//==============================================================================
void save_data()
{
  char kp=0;
  char go=0;
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  Lcd_Out(1,3,"ZAPIS DANYH");
  Lcd_Out(2,7,"NET.  ");
  flag_t.data_save=RESET;
  key_value=0;
while(kp==0)
  {
    if(flag_t.status_in_menu==RESET)
     {
      key_value=key_back;
     }
    switch(key_value)
     {
      case key_up:          key_value=0; Lcd_Out(2,7,"DA .  "); flag_t.data_save=SET;                      break;
      case key_down:        key_value=0; Lcd_Out(2,7,"NET.  ");  flag_t.data_save=RESET;                   break;
      case key_enter:       key_value=0;go=1;kp=1;                                                       break;
      case key_back:        key_value=0;kp=1;    Lcd_Cmd(_LCD_CLEAR);
                                                 Lcd_Cmd(_LCD_CURSOR_OFF);                               break;
     }
  }
  if(flag_t.data_save==SET)
    {
      save_data_exit();
    }
  if(go==SET) set_errors();
}
//==============================================================================
unsigned long ee_data[DATA_SIZE];
char save_data_to_eeprom()
{
  char position=0;
  unsigned long temp=0,adress=0;

  for(position=0;position<DATA_SIZE;position++)
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
  // clear all memory, reset password settings
  EEPROM_MassErase();
  EEPROM_Program(ee_data, START_ADDRESS, BLOCK_SIZE);
  EnableInterrupts();
  return read_data_in_eeprom();
}
//==============================================================================

char read_data_in_eeprom()
{
 unsigned long temp=0,temp1=0;
 char position=0;
  DisableInterrupts();
  for(position=0;position<DATA_SIZE;position++)
   {
     ee_data[position]=0;
   }
  
  // read DATA_SIZE words of data from eeprom starting from START_ADDRESS
  EEPROM_Read(ee_Data, START_ADDRESS, BLOCK_SIZE);
  EnableInterrupts();
  for(position=0;position<8;position++)
    {
      temp1+=ee_data[position];
    }
     temp=ee_data[8];

  if(temp==temp1)
    {
      parameters_t.set_temperatura=                                             (float)((float)ee_data[0]/100.0);
      parameters_t.set_humidity=                                                (float)((float)ee_data[1]/100.0);
      parameters_t.set_turn_time=                                               (float)((float)ee_data[2]/100.0);
      parameters_t.temperatura_delta__alarm_level=                              (float)((float)ee_data[3]/100.0);
      parameters_t.humidity_delta_alarm_level=                                  (float)((float)ee_data[4]/100.0);
      parameters_t.control_humidity=                                            (float)((float)ee_data[5]/100.0);
      //parameters_t.control_m4_4_1=        _data[6];
      //parameters_t.control_m4_4_2=        _data[7];
      return 0;
    }
    if(temp!=temp1)
    {
     return 1;
    }
}
//==============================================================================
void read_key()
{
  static char count_key=0;
 if(PIN_UP==RESET||PIN_DOWN==RESET||PIN_ENTER==RESET||PIN_BACK==RESET)
  {
    count_key++;
    if(count_key==10)
     {
       count_key=0;
       if(PIN_UP==RESET||PIN_DOWN==RESET||PIN_ENTER==RESET||PIN_BACK==RESET)
        {
          Beep();
          key_value=key_code_pressed();

        }
     }
  }
}
//==============================================================================
void Beep()
{
  Sound_Play(1000,100);
}
//==============================================================================

/*! \brief Initialisation of PID controller parameters.
 *
 *  Initialise the variables used by the PID algorithm.
 *
 *  \param p_factor  Proportional term.
 *  \param i_factor  Integral term.
 *  \param d_factor  Derivate term.
 *  \param pid  Struct with PID status.
 */
void pid_Init(int16_t p_factor, int16_t i_factor, int16_t d_factor, struct PID_DATA *pid)
// Set up PID controller parameters
{
  // Start values for PID controller
  pid->sumError = 0;
  pid->lastProcessValue = 0;
  // Tuning constants for PID loop
  pid->P_Factor = p_factor;
  pid->I_Factor = i_factor;
  pid->D_Factor = d_factor;
  // Limits to avoid overflow
  pid->maxError = MAX_INT / (pid->P_Factor + 1);
  pid->maxSumError = MAX_I_TERM / (pid->I_Factor + 1);
}


/*! \brief PID control algorithm.
 *
 *  Calculates output from setpoint, process value and PID status.
 *
 *  \param setPoint  Desired value.
 *  \param processValue  Measured value.
 *  \param pid_st  PID status struct.
 */
int16_t pid_Controller(int16_t setPoint, int16_t processValue, struct PID_DATA *pid_st)
{
  int16_t error, p_term, d_term;
  int32_t i_term, ret, temp;

  error = setPoint - processValue;

  // Calculate Pterm and limit error overflow
  if (error > pid_st->maxError){
    p_term = MAX_INT;
  }
  else if (error < -pid_st->maxError){
    p_term = -MAX_INT;
  }
  else{
    p_term = pid_st->P_Factor * error;
  }

  // Calculate Iterm and limit integral runaway
  temp = pid_st->sumError + error;
  if(temp > pid_st->maxSumError){
    i_term = MAX_I_TERM;
    pid_st->sumError = pid_st->maxSumError;
  }
  else if(temp < -pid_st->maxSumError){
    i_term = -MAX_I_TERM;
    pid_st->sumError = -pid_st->maxSumError;
  }
  else{
    pid_st->sumError = temp;
    i_term = pid_st->I_Factor * pid_st->sumError;
  }

  // Calculate Dterm
  d_term = pid_st->D_Factor * (pid_st->lastProcessValue - processValue);

  pid_st->lastProcessValue = processValue;

  ret = (p_term + i_term + d_term) / SCALING_FACTOR;
  if(ret > MAX_INT){
    ret = MAX_INT;
  }
  else if(ret < -MAX_INT){
    ret = -MAX_INT;
  }

  return((int16_t)ret);
}

/*! \brief Resets the integrator.
 *
 *  Calling this function will reset the integrator in the PID regulator.
 */
void pid_Reset_Integrator(pidData_t *pid_st)
{
  pid_st->sumError = 0;
}
//==============================================================================
void control_outs()
{
   RELE_ALARM             = flag_t.temperatura_alarm||flag_t.humidity_alarm;
   LED_RED                = flag_t.temperatura_alarm||flag_t.humidity_alarm;
   
   RELE_ALARM_TRIAC       = flag_t.temperatura_triac_alarm;
   LED_BLUE               = flag_t.temperatura_triac_alarm;
   
   RELE_FAN               = flag_t.start_fan;
   
   RELE_COVER             = flag_t.cover_status;
   
   RELE_HUMIDITI          = flag_t.humidity_cover_status;
   LED_GREEN              = flag_t.humidity_cover_status;
}
//==============================================================================
void reset_flags()
{
  flag_t.temperatura_alarm=0;
  flag_t.temperatura_triac_alarm=0;
  flag_t.cover_status=0;
  flag_t.humidity_alarm=0;
  flag_t.humidity_cover_status=0;
  flag_t.control_humidity=0;
}

//==============================================================================
void set_default_parameters()
{
  parameters_t.set_temperatura=37.5;
  parameters_t.set_humidity=50.0;
  parameters_t.set_turn_time=60.0;
  parameters_t.temperatura_delta__alarm_level=2.0;
  parameters_t.humidity_delta_alarm_level=10.0;
  parameters_t.control_humidity=0.0;
}
//==============================================================================
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
//==============================================================================

          /*1-   temperatura
            2-    vlajnost
            3-    kluch probit
            4-
            5-    */
//==============================================================================

void rotation()
{
  static unsigned long  count_rotations=0;
     if(++count_rotations>=((unsigned long)parameters_t.set_turn_time*1200))
      {
        RELE_ROTATION^=1;
        count_rotations=0;
      }
}
//==============================================================================
void Get_key()
{
   switch(key_value)
        {
          case  key_up   :   key_value=0;flag_t.start_fan^=1;                                   break;
          case  key_down :   key_value=0;flag_t.start_process^=1;
                             if(flag_t.start_process==SET)
                              {
                                flag_t.first_start_t=RESET;
                                flag_t.first_start_h=RESET;
                              }
                                                                                                break;
          case  key_enter:   key_value=0;flag_t.status_in_menu=SET; set_temperature();          break;
          case  key_back :   key_value=0;                                                       break;
        }

}
//==============================================================================
void control_menu()
{
 static unsigned int  count_processed=0;
 static unsigned int sec=120;
 if(flag_t.status_in_menu==SET)
   {
     if((++count_processed)>=(sec*20))   //20 count 1 second
       {
         count_processed=0;
         flag_t.status_in_menu=RESET;
       }
   }
}
//==============================================================================
void impulse()
{
  //LED_BLUE=1;
  TRIAC_OUT=1;
  Delay_us(500);
  //LED_BLUE=0;
  TRIAC_OUT=0;
}
//==============================================================================
void start_eeprom()
{
 EEPROM_Init();
if(read_data_in_eeprom()==SET)
  {
   set_default_parameters();
  }
  if(parameters_t.control_humidity==0.0)
   {
     flag_t.control_humidity=RESET;
   }
     if(parameters_t.control_humidity==1.0)
      {
        flag_t.control_humidity=SET;
      }

}
//==============================================================================