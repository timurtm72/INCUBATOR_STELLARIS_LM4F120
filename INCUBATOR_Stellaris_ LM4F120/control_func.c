#include "inkubator_def.h"

#define FS_DELAY                        40
#define DELAY                           20
//==============================================================================
void control_first_start()
{
  static char count_first_start=0,count_first_start1=0;
  
  if(temperature>=(parameters_t.set_temperatura-parameters_t.temperatura_delta__alarm_level))
     {
        if((++count_first_start)>=FS_DELAY)
         {
           count_first_start=0;
           if(temperature>=(parameters_t.set_temperatura-parameters_t.temperatura_delta__alarm_level))
             {
               flag_t.first_start_t=SET;
             }
         }
     }
  if(rel_humidity>=(parameters_t.set_humidity-(parameters_t.humidity_delta_alarm_level-5)))
     {
        if((++count_first_start1)>=FS_DELAY)
         {
           count_first_start1=0;
           if(rel_humidity>=(parameters_t.set_humidity-(parameters_t.humidity_delta_alarm_level-5)))
             {
               flag_t.first_start_h=SET;
             }
         }
     }

}
//==============================================================================
void control_temperature()
{
  static char count_temp=0,count_temp1=0;
     if((temperature>=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level+0.5)||(temperature<=parameters_t.set_temperatura-parameters_t.temperatura_delta__alarm_level-0.5))
     {
        if((++count_temp)>=DELAY)
         {
            count_temp1=0;
            count_temp=0;
            if((temperature>=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level+0.5)||(temperature<=parameters_t.set_temperatura-parameters_t.temperatura_delta__alarm_level-0.5))
             {

               if(flag_t.first_start_t==SET)
                {
                  flag_t.temperatura_alarm=SET;
                  set_fault(1);
                }

             }
         }
     }
//------------------------------------------------------------------------------
    if((temperature<=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level-0.5)&&(temperature>=parameters_t.set_temperatura-parameters_t.temperatura_delta__alarm_level+0.5))
     {
        if((++count_temp1)>=DELAY)
         {
            count_temp1=0;
            count_temp=0;
            if((temperature<=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level-0.5)&&(temperature>=parameters_t.set_temperatura-parameters_t.temperatura_delta__alarm_level+0.5))
             {

               flag_t.temperatura_alarm=RESET;
             }
         }
     }
}
//==============================================================================
void control_temperature_cover()
{
  static char count_temp_c=0,count_temp_c1=0;
     if(temperature>=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level)
     {
        if((++count_temp_c)>=DELAY)
         {
            count_temp_c1=0;
            count_temp_c=0;
            if(temperature>=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level)
             {

               flag_t.temperatura_alarm_cover=SET;
             }
         }
     }
//------------------------------------------------------------------------------
    if(temperature<=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level/4)
     {
        if((++count_temp_c1)>=DELAY)
         {
            count_temp_c1=0;
            count_temp_c=0;
            if(temperature<=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level/4)
             {

               flag_t.temperatura_alarm_cover=RESET;
             }
         }
     }
}
//==============================================================================
void control_temperature_triac()
{
  static char count_temp2=0,count_temp3=0;
  if(temperature>=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level+10.0)
     {
        if((++count_temp2)>=DELAY)
         {
            count_temp2=0;
            count_temp3=0;
            if(temperature>=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level+10.0)
             {

               flag_t.temperatura_triac_alarm=SET;
               set_fault(3);
             }
         }
     }
//------------------------------------------------------------------------------
if(temperature<=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level+5.0)
     {
        if((++count_temp3)>=DELAY)
         {
            count_temp2=0;
            count_temp3=0;
            if(temperature<=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level+5.0)
             {

               flag_t.temperatura_triac_alarm=RESET;
             }
         }
     }
}
//==============================================================================
void temperature_cover_open_close()
{
  static char count_cover=0,count_cover1=0;
  if(flag_t.temperatura_alarm_cover==SET)
          {

            if(flag_t.cover_status==RESET)
             {

               if((++count_cover)>=(DELAY+30))
                {
                  count_cover1=0;
                  count_cover=0;
                  flag_t.cover_status=SET;
                }
             }

            if(flag_t.cover_status==SET)
             {

               if((++count_cover1)>=DELAY)
                {
                  count_cover1=0;
                  count_cover=0;
                  flag_t.cover_status=RESET;
                }
             }
          }
  if(flag_t.temperatura_alarm_cover==RESET)
   {
    flag_t.cover_status=RESET;
   }
}
//==============================================================================
void control_humidity()
{
    static char count_hum=0,count_hum1=0;
    if((rel_humidity>=parameters_t.set_humidity+parameters_t.humidity_delta_alarm_level+0.5)||(rel_humidity<=parameters_t.set_humidity-parameters_t.humidity_delta_alarm_level-0.5))
     {
        if((++count_hum)>=DELAY)
         {
            count_hum=0;
            count_hum1=0;
            if((rel_humidity>=parameters_t.set_humidity+parameters_t.humidity_delta_alarm_level+0.5)||(rel_humidity<=parameters_t.set_humidity-parameters_t.humidity_delta_alarm_level-0.5))
             {

             if(flag_t.first_start_h==SET)
               {
                flag_t.humidity_alarm=SET;
                set_fault(2);
               }

             }
         }
     }
//------------------------------------------------------------------------------
    if((rel_humidity<=parameters_t.set_humidity+parameters_t.humidity_delta_alarm_level-0.5)&&(rel_humidity>=parameters_t.set_humidity-parameters_t.humidity_delta_alarm_level+0.5))
     {
        if((++count_hum1)>=DELAY)
         {
            count_hum=0;
            count_hum1=0;
            if((rel_humidity<=parameters_t.set_humidity+parameters_t.humidity_delta_alarm_level-0.5)&&(rel_humidity>=parameters_t.set_humidity-parameters_t.humidity_delta_alarm_level+0.5))
             {

               flag_t.humidity_alarm=RESET;
             }
         }
     }

}
//==============================================================================
void control_cover_humidity()
{
  static char  count_humi=0,count_humi1=0;
  if(rel_humidity<=parameters_t.set_humidity-(parameters_t.humidity_delta_alarm_level-5))
     {
        if((++count_humi)>=DELAY)
         {
           count_humi=0;
           count_humi1=0;
           if(rel_humidity<=parameters_t.set_humidity-(parameters_t.humidity_delta_alarm_level-5))
             {

               flag_t.humidity_alarm_cover=SET;
             }
         }
     }
  if(rel_humidity>=parameters_t.set_humidity+(parameters_t.humidity_delta_alarm_level-5))
     {
        if((++count_humi1)>=DELAY)
         {
           count_humi1=0;
           count_humi=0;
           if(rel_humidity>=parameters_t.set_humidity+(parameters_t.humidity_delta_alarm_level-5))
             {

               flag_t.humidity_alarm_cover=RESET;
             }
         }
     }
}
//==============================================================================
void humidity_cover_open_close()
{
  static char count_cover_h=0,count_cover_h1=0;
  if(flag_t.humidity_alarm_cover==SET)
          {

            if(flag_t.humidity_cover_status==RESET)
             {

               if((++count_cover_h)>=(DELAY+30))
                {
                  count_cover_h1=0;
                  count_cover_h=0;
                  flag_t.humidity_cover_status=SET;
                }
             }

            if(flag_t.humidity_cover_status==SET)
             {

               if((++count_cover_h1)>=DELAY)
                {
                  count_cover_h1=0;
                  count_cover_h=0;
                  flag_t.humidity_cover_status=RESET;
                }
             }
          }
  if(flag_t.humidity_alarm_cover==RESET)
   {
    flag_t.humidity_cover_status=RESET;
   }
}

//==============================================================================