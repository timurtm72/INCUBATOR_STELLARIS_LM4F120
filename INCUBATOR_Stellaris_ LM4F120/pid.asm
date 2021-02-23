_UpdatePID:
;pid.c,2 :: 		float UpdatePID(struct SPid pid, float error, float position)
; position start address is: 4 (R1)
; error start address is: 0 (R0)
VMOV.F32	S2, S0
VMOV.F32	S3, S1
; position end address is: 4 (R1)
; error end address is: 0 (R0)
; error start address is: 8 (R2)
; position start address is: 12 (R3)
;pid.c,6 :: 		pTerm = pid.pGain * error;    // calculate the proportional term
VLDR	#1, S0, [SP, #20]
VMUL.F32	S0, S0, S2
; pTerm start address is: 16 (R4)
VMOV.F32	S4, S0
;pid.c,7 :: 		pid.iState += error;          // calculate the integral state with appropriate limiting
VLDR	#1, S0, [SP, #4]
VADD.F32	S1, S0, S2
; error end address is: 8 (R2)
VSTR	#1, S1, [SP, #4]
;pid.c,9 :: 		if (pid.iState > pid.iMax)
VLDR	#1, S0, [SP, #8]
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	LE
BLE	L_UpdatePID0
;pid.c,10 :: 		pid.iState = pid.iMax;
VLDR	#1, S0, [SP, #8]
VSTR	#1, S0, [SP, #4]
IT	AL
BAL	L_UpdatePID1
L_UpdatePID0:
;pid.c,11 :: 		else if (pid.iState < pid.iMin)
VLDR	#1, S1, [SP, #12]
VLDR	#1, S0, [SP, #4]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	GE
BGE	L_UpdatePID2
;pid.c,12 :: 		pid.iState = pid.iMin;
VLDR	#1, S0, [SP, #12]
VSTR	#1, S0, [SP, #4]
L_UpdatePID2:
L_UpdatePID1:
;pid.c,13 :: 		iTerm = pid.iGain * pid.iState;    // calculate the integral term
VLDR	#1, S1, [SP, #4]
VLDR	#1, S0, [SP, #16]
VMUL.F32	S2, S0, S1
;pid.c,14 :: 		dTerm = pid.dGain * (position - pid.dState);
VLDR	#1, S0, [SP, #0]
VSUB.F32	S1, S3, S0
VLDR	#1, S0, [SP, #24]
VMUL.F32	S1, S0, S1
;pid.c,15 :: 		pid.dState = position;
VSTR	#1, S3, [SP, #0]
; position end address is: 12 (R3)
;pid.c,16 :: 		return (pTerm + iTerm - dTerm);
VADD.F32	S0, S4, S2
; pTerm end address is: 16 (R4)
VSUB.F32	S0, S0, S1
;pid.c,17 :: 		}
L_end_UpdatePID:
BX	LR
; end of _UpdatePID
_init_pid:
;pid.c,19 :: 		void init_pid()
;pid.c,21 :: 		Rpid.dState=0;
MOV	R0, #0
VMOV	S0, R0
MOVW	R0, #lo_addr(_Rpid+0)
MOVT	R0, #hi_addr(_Rpid+0)
VSTR	#1, S0, [R0, #0]
;pid.c,22 :: 		Rpid.iState=0;
MOV	R0, #0
VMOV	S0, R0
MOVW	R0, #lo_addr(_Rpid+4)
MOVT	R0, #hi_addr(_Rpid+4)
VSTR	#1, S0, [R0, #0]
;pid.c,23 :: 		Rpid.iMax=100;
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
MOVW	R0, #lo_addr(_Rpid+8)
MOVT	R0, #hi_addr(_Rpid+8)
VSTR	#1, S0, [R0, #0]
;pid.c,24 :: 		Rpid.iMin=0;
MOV	R0, #0
VMOV	S0, R0
MOVW	R0, #lo_addr(_Rpid+12)
MOVT	R0, #hi_addr(_Rpid+12)
VSTR	#1, S0, [R0, #0]
;pid.c,25 :: 		Rpid.iGain=0.5;
VMOV.F32	S0, #0.5
MOVW	R0, #lo_addr(_Rpid+16)
MOVT	R0, #hi_addr(_Rpid+16)
VSTR	#1, S0, [R0, #0]
;pid.c,26 :: 		Rpid.pGain=10.0;
VMOV.F32	S0, #10
MOVW	R0, #lo_addr(_Rpid+20)
MOVT	R0, #hi_addr(_Rpid+20)
VSTR	#1, S0, [R0, #0]
;pid.c,27 :: 		Rpid.dGain=5.0;
VMOV.F32	S0, #5
MOVW	R0, #lo_addr(_Rpid+24)
MOVT	R0, #hi_addr(_Rpid+24)
VSTR	#1, S0, [R0, #0]
;pid.c,28 :: 		}
L_end_init_pid:
BX	LR
; end of _init_pid
