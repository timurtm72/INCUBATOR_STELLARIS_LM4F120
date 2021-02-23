#include "inkubator_def.h"
float UpdatePID(struct SPid pid, float error, float position)
{
  float pTerm, dTerm, iTerm;

  pTerm = pid.pGain * error;    // calculate the proportional term
  pid.iState += error;          // calculate the integral state with appropriate limiting

  if (pid.iState > pid.iMax)
      pid.iState = pid.iMax;
  else if (pid.iState < pid.iMin)
      pid.iState = pid.iMin;
  iTerm = pid.iGain * pid.iState;    // calculate the integral term
  dTerm = pid.dGain * (position - pid.dState);
  pid.dState = position;
  return (pTerm + iTerm - dTerm);
}
//==============================================================================
void init_pid()
{
   Rpid.dState=0;
   Rpid.iState=0;
   Rpid.iMax=100;
   Rpid.iMin=0;
   Rpid.iGain=0.5;
   Rpid.pGain=10.0;
   Rpid.dGain=5.0;
}
//==============================================================================