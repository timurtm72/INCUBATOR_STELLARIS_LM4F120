#include "inkubator_def.h"


void set_errors()
{
 char kp=0;
 char go=0;
 unsigned char position=0,pos=0;
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  Lcd_Out(1,4,"OSHIBKI");
  out_lcd_errors(position);
  while(kp==0)
  {
    if(flag_t.status_in_menu==RESET)
     {
      key_value=key_back;
     }
    switch(key_value)
     {
      case key_up:          key_value=0;
                            if(position==0)
                             {
                               position=0;
                             }
                               else
                               {
                                  position--;
                               }
                                 out_lcd_errors(position);                    break;

      case key_down:        key_value=0; position++;
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
      case key_enter:       key_value=0;   for(pos=0;pos<255;pos++)
                                              {
                                               errors[pos]=0;
                                              }
                                             pos=0;
                                             Lcd_Cmd(_LCD_CLEAR);               // Clear display
                                             Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
                                             Lcd_Out(1,2,"OSHIBKI STERTY");
                                             Delay_ms(1000);
                                             go=1;kp=1;             break;
      case key_back:        key_value=0; kp=1;   Lcd_Cmd(_LCD_CLEAR);
                                                 Lcd_Cmd(_LCD_CURSOR_OFF);                              break;
     }
  }
   if(go==SET) set_temperature();
}
//==============================================================================
void out_lcd_errors(unsigned char position)
{
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
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
//==============================================================================
void reset_error_message()
{
  unsigned char count_err=0;
  for(count_err=0;count_err<255;count_err++)
      {
        errors[count_err]=0;
      }
     count_err=0;

}
//==============================================================================
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
//==============================================================================