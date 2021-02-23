_control_first_start:
;control_func.c,6 :: 		void control_first_start()
;control_func.c,10 :: 		if(temperature>=(parameters_t.set_temperatura-parameters_t.temperatura_delta__alarm_level))
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
VSUB.F32	S1, S0, S1
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	LT
BLT	L_control_first_start0
;control_func.c,12 :: 		if((++count_first_start)>=FS_DELAY)
MOVW	R1, #lo_addr(control_first_start_count_first_start_L0+0)
MOVT	R1, #hi_addr(control_first_start_count_first_start_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #40
IT	CC
BCC	L_control_first_start1
;control_func.c,14 :: 		count_first_start=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_first_start_count_first_start_L0+0)
MOVT	R0, #hi_addr(control_first_start_count_first_start_L0+0)
STRB	R1, [R0, #0]
;control_func.c,15 :: 		if(temperature>=(parameters_t.set_temperatura-parameters_t.temperatura_delta__alarm_level))
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
VSUB.F32	S1, S0, S1
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	LT
BLT	L_control_first_start2
;control_func.c,17 :: 		flag_t.first_start_t=SET;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;control_func.c,18 :: 		}
L_control_first_start2:
;control_func.c,19 :: 		}
L_control_first_start1:
;control_func.c,20 :: 		}
L_control_first_start0:
;control_func.c,21 :: 		if(rel_humidity>=(parameters_t.set_humidity-(parameters_t.humidity_delta_alarm_level-5)))
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S1, [R0, #0]
VMOV.F32	S0, #5
VSUB.F32	S1, S1, S0
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S0, [R0, #0]
VSUB.F32	S1, S0, S1
MOVW	R0, #lo_addr(_rel_humidity+0)
MOVT	R0, #hi_addr(_rel_humidity+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	LT
BLT	L_control_first_start3
;control_func.c,23 :: 		if((++count_first_start1)>=FS_DELAY)
MOVW	R1, #lo_addr(control_first_start_count_first_start1_L0+0)
MOVT	R1, #hi_addr(control_first_start_count_first_start1_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #40
IT	CC
BCC	L_control_first_start4
;control_func.c,25 :: 		count_first_start1=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_first_start_count_first_start1_L0+0)
MOVT	R0, #hi_addr(control_first_start_count_first_start1_L0+0)
STRB	R1, [R0, #0]
;control_func.c,26 :: 		if(rel_humidity>=(parameters_t.set_humidity-(parameters_t.humidity_delta_alarm_level-5)))
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S1, [R0, #0]
VMOV.F32	S0, #5
VSUB.F32	S1, S1, S0
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S0, [R0, #0]
VSUB.F32	S1, S0, S1
MOVW	R0, #lo_addr(_rel_humidity+0)
MOVT	R0, #hi_addr(_rel_humidity+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	LT
BLT	L_control_first_start5
;control_func.c,28 :: 		flag_t.first_start_h=SET;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;control_func.c,29 :: 		}
L_control_first_start5:
;control_func.c,30 :: 		}
L_control_first_start4:
;control_func.c,31 :: 		}
L_control_first_start3:
;control_func.c,33 :: 		}
L_end_control_first_start:
BX	LR
; end of _control_first_start
_control_temperature:
;control_func.c,35 :: 		void control_temperature()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;control_func.c,38 :: 		if((temperature>=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level+0.5)||(temperature<=parameters_t.set_temperatura-parameters_t.temperatura_delta__alarm_level-0.5))
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
VADD.F32	S1, S0, S1
VMOV.F32	S0, #0.5
VADD.F32	S1, S1, S0
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	GE
BGE	L__control_temperature71
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
VSUB.F32	S1, S0, S1
VMOV.F32	S0, #0.5
VSUB.F32	S1, S1, S0
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	LE
BLE	L__control_temperature70
IT	AL
BAL	L_control_temperature8
L__control_temperature71:
L__control_temperature70:
;control_func.c,40 :: 		if((++count_temp)>=DELAY)
MOVW	R1, #lo_addr(control_temperature_count_temp_L0+0)
MOVT	R1, #hi_addr(control_temperature_count_temp_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #20
IT	CC
BCC	L_control_temperature9
;control_func.c,42 :: 		count_temp1=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_temperature_count_temp1_L0+0)
MOVT	R0, #hi_addr(control_temperature_count_temp1_L0+0)
STRB	R1, [R0, #0]
;control_func.c,43 :: 		count_temp=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_temperature_count_temp_L0+0)
MOVT	R0, #hi_addr(control_temperature_count_temp_L0+0)
STRB	R1, [R0, #0]
;control_func.c,44 :: 		if((temperature>=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level+0.5)||(temperature<=parameters_t.set_temperatura-parameters_t.temperatura_delta__alarm_level-0.5))
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
VADD.F32	S1, S0, S1
VMOV.F32	S0, #0.5
VADD.F32	S1, S1, S0
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	GE
BGE	L__control_temperature73
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
VSUB.F32	S1, S0, S1
VMOV.F32	S0, #0.5
VSUB.F32	S1, S1, S0
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	LE
BLE	L__control_temperature72
IT	AL
BAL	L_control_temperature12
L__control_temperature73:
L__control_temperature72:
;control_func.c,47 :: 		if(flag_t.first_start_t==SET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_control_temperature13
;control_func.c,49 :: 		flag_t.temperatura_alarm=SET;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;control_func.c,50 :: 		set_fault(1);
MOVS	R0, #1
BL	_set_fault+0
;control_func.c,51 :: 		}
L_control_temperature13:
;control_func.c,53 :: 		}
L_control_temperature12:
;control_func.c,54 :: 		}
L_control_temperature9:
;control_func.c,55 :: 		}
L_control_temperature8:
;control_func.c,57 :: 		if((temperature<=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level-0.5)&&(temperature>=parameters_t.set_temperatura-parameters_t.temperatura_delta__alarm_level+0.5))
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
VADD.F32	S1, S0, S1
VMOV.F32	S0, #0.5
VSUB.F32	S1, S1, S0
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	GT
BGT	L__control_temperature77
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
VSUB.F32	S1, S0, S1
VMOV.F32	S0, #0.5
VADD.F32	S1, S1, S0
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	LT
BLT	L__control_temperature76
L__control_temperature67:
;control_func.c,59 :: 		if((++count_temp1)>=DELAY)
MOVW	R1, #lo_addr(control_temperature_count_temp1_L0+0)
MOVT	R1, #hi_addr(control_temperature_count_temp1_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #20
IT	CC
BCC	L_control_temperature17
;control_func.c,61 :: 		count_temp1=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_temperature_count_temp1_L0+0)
MOVT	R0, #hi_addr(control_temperature_count_temp1_L0+0)
STRB	R1, [R0, #0]
;control_func.c,62 :: 		count_temp=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_temperature_count_temp_L0+0)
MOVT	R0, #hi_addr(control_temperature_count_temp_L0+0)
STRB	R1, [R0, #0]
;control_func.c,63 :: 		if((temperature<=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level-0.5)&&(temperature>=parameters_t.set_temperatura-parameters_t.temperatura_delta__alarm_level+0.5))
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
VADD.F32	S1, S0, S1
VMOV.F32	S0, #0.5
VSUB.F32	S1, S1, S0
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	GT
BGT	L__control_temperature75
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
VSUB.F32	S1, S0, S1
VMOV.F32	S0, #0.5
VADD.F32	S1, S1, S0
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	LT
BLT	L__control_temperature74
L__control_temperature66:
;control_func.c,66 :: 		flag_t.temperatura_alarm=RESET;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;control_func.c,63 :: 		if((temperature<=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level-0.5)&&(temperature>=parameters_t.set_temperatura-parameters_t.temperatura_delta__alarm_level+0.5))
L__control_temperature75:
L__control_temperature74:
;control_func.c,68 :: 		}
L_control_temperature17:
;control_func.c,57 :: 		if((temperature<=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level-0.5)&&(temperature>=parameters_t.set_temperatura-parameters_t.temperatura_delta__alarm_level+0.5))
L__control_temperature77:
L__control_temperature76:
;control_func.c,70 :: 		}
L_end_control_temperature:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _control_temperature
_control_temperature_cover:
;control_func.c,72 :: 		void control_temperature_cover()
;control_func.c,75 :: 		if(temperature>=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level)
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
VADD.F32	S1, S0, S1
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	LT
BLT	L_control_temperature_cover21
;control_func.c,77 :: 		if((++count_temp_c)>=DELAY)
MOVW	R1, #lo_addr(control_temperature_cover_count_temp_c_L0+0)
MOVT	R1, #hi_addr(control_temperature_cover_count_temp_c_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #20
IT	CC
BCC	L_control_temperature_cover22
;control_func.c,79 :: 		count_temp_c1=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_temperature_cover_count_temp_c1_L0+0)
MOVT	R0, #hi_addr(control_temperature_cover_count_temp_c1_L0+0)
STRB	R1, [R0, #0]
;control_func.c,80 :: 		count_temp_c=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_temperature_cover_count_temp_c_L0+0)
MOVT	R0, #hi_addr(control_temperature_cover_count_temp_c_L0+0)
STRB	R1, [R0, #0]
;control_func.c,81 :: 		if(temperature>=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level)
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
VADD.F32	S1, S0, S1
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	LT
BLT	L_control_temperature_cover23
;control_func.c,84 :: 		flag_t.temperatura_alarm_cover=SET;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;control_func.c,85 :: 		}
L_control_temperature_cover23:
;control_func.c,86 :: 		}
L_control_temperature_cover22:
;control_func.c,87 :: 		}
L_control_temperature_cover21:
;control_func.c,89 :: 		if(temperature<=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level/4)
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
VMOV.F32	S0, #4
VDIV.F32	S1, S1, S0
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
VADD.F32	S1, S0, S1
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	GT
BGT	L_control_temperature_cover24
;control_func.c,91 :: 		if((++count_temp_c1)>=DELAY)
MOVW	R1, #lo_addr(control_temperature_cover_count_temp_c1_L0+0)
MOVT	R1, #hi_addr(control_temperature_cover_count_temp_c1_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #20
IT	CC
BCC	L_control_temperature_cover25
;control_func.c,93 :: 		count_temp_c1=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_temperature_cover_count_temp_c1_L0+0)
MOVT	R0, #hi_addr(control_temperature_cover_count_temp_c1_L0+0)
STRB	R1, [R0, #0]
;control_func.c,94 :: 		count_temp_c=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_temperature_cover_count_temp_c_L0+0)
MOVT	R0, #hi_addr(control_temperature_cover_count_temp_c_L0+0)
STRB	R1, [R0, #0]
;control_func.c,95 :: 		if(temperature<=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level/4)
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
VMOV.F32	S0, #4
VDIV.F32	S1, S1, S0
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
VADD.F32	S1, S0, S1
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	GT
BGT	L_control_temperature_cover26
;control_func.c,98 :: 		flag_t.temperatura_alarm_cover=RESET;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;control_func.c,99 :: 		}
L_control_temperature_cover26:
;control_func.c,100 :: 		}
L_control_temperature_cover25:
;control_func.c,101 :: 		}
L_control_temperature_cover24:
;control_func.c,102 :: 		}
L_end_control_temperature_cover:
BX	LR
; end of _control_temperature_cover
_control_temperature_triac:
;control_func.c,104 :: 		void control_temperature_triac()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;control_func.c,107 :: 		if(temperature>=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level+10.0)
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
VADD.F32	S1, S0, S1
VMOV.F32	S0, #10
VADD.F32	S1, S1, S0
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	LT
BLT	L_control_temperature_triac27
;control_func.c,109 :: 		if((++count_temp2)>=DELAY)
MOVW	R1, #lo_addr(control_temperature_triac_count_temp2_L0+0)
MOVT	R1, #hi_addr(control_temperature_triac_count_temp2_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #20
IT	CC
BCC	L_control_temperature_triac28
;control_func.c,111 :: 		count_temp2=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_temperature_triac_count_temp2_L0+0)
MOVT	R0, #hi_addr(control_temperature_triac_count_temp2_L0+0)
STRB	R1, [R0, #0]
;control_func.c,112 :: 		count_temp3=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_temperature_triac_count_temp3_L0+0)
MOVT	R0, #hi_addr(control_temperature_triac_count_temp3_L0+0)
STRB	R1, [R0, #0]
;control_func.c,113 :: 		if(temperature>=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level+10.0)
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
VADD.F32	S1, S0, S1
VMOV.F32	S0, #10
VADD.F32	S1, S1, S0
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	LT
BLT	L_control_temperature_triac29
;control_func.c,116 :: 		flag_t.temperatura_triac_alarm=SET;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;control_func.c,117 :: 		set_fault(3);
MOVS	R0, #3
BL	_set_fault+0
;control_func.c,118 :: 		}
L_control_temperature_triac29:
;control_func.c,119 :: 		}
L_control_temperature_triac28:
;control_func.c,120 :: 		}
L_control_temperature_triac27:
;control_func.c,122 :: 		if(temperature<=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level+5.0)
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
VADD.F32	S1, S0, S1
VMOV.F32	S0, #5
VADD.F32	S1, S1, S0
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	GT
BGT	L_control_temperature_triac30
;control_func.c,124 :: 		if((++count_temp3)>=DELAY)
MOVW	R1, #lo_addr(control_temperature_triac_count_temp3_L0+0)
MOVT	R1, #hi_addr(control_temperature_triac_count_temp3_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #20
IT	CC
BCC	L_control_temperature_triac31
;control_func.c,126 :: 		count_temp2=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_temperature_triac_count_temp2_L0+0)
MOVT	R0, #hi_addr(control_temperature_triac_count_temp2_L0+0)
STRB	R1, [R0, #0]
;control_func.c,127 :: 		count_temp3=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_temperature_triac_count_temp3_L0+0)
MOVT	R0, #hi_addr(control_temperature_triac_count_temp3_L0+0)
STRB	R1, [R0, #0]
;control_func.c,128 :: 		if(temperature<=parameters_t.set_temperatura+parameters_t.temperatura_delta__alarm_level+5.0)
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
VADD.F32	S1, S0, S1
VMOV.F32	S0, #5
VADD.F32	S1, S1, S0
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	GT
BGT	L_control_temperature_triac32
;control_func.c,131 :: 		flag_t.temperatura_triac_alarm=RESET;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;control_func.c,132 :: 		}
L_control_temperature_triac32:
;control_func.c,133 :: 		}
L_control_temperature_triac31:
;control_func.c,134 :: 		}
L_control_temperature_triac30:
;control_func.c,135 :: 		}
L_end_control_temperature_triac:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _control_temperature_triac
_temperature_cover_open_close:
;control_func.c,137 :: 		void temperature_cover_open_close()
;control_func.c,140 :: 		if(flag_t.temperatura_alarm_cover==SET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_temperature_cover_open_close33
;control_func.c,143 :: 		if(flag_t.cover_status==RESET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_temperature_cover_open_close34
;control_func.c,146 :: 		if((++count_cover)>=(DELAY+30))
MOVW	R1, #lo_addr(temperature_cover_open_close_count_cover_L0+0)
MOVT	R1, #hi_addr(temperature_cover_open_close_count_cover_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #50
IT	CC
BCC	L_temperature_cover_open_close35
;control_func.c,148 :: 		count_cover1=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(temperature_cover_open_close_count_cover1_L0+0)
MOVT	R0, #hi_addr(temperature_cover_open_close_count_cover1_L0+0)
STRB	R1, [R0, #0]
;control_func.c,149 :: 		count_cover=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(temperature_cover_open_close_count_cover_L0+0)
MOVT	R0, #hi_addr(temperature_cover_open_close_count_cover_L0+0)
STRB	R1, [R0, #0]
;control_func.c,150 :: 		flag_t.cover_status=SET;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;control_func.c,151 :: 		}
L_temperature_cover_open_close35:
;control_func.c,152 :: 		}
L_temperature_cover_open_close34:
;control_func.c,154 :: 		if(flag_t.cover_status==SET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_temperature_cover_open_close36
;control_func.c,157 :: 		if((++count_cover1)>=DELAY)
MOVW	R1, #lo_addr(temperature_cover_open_close_count_cover1_L0+0)
MOVT	R1, #hi_addr(temperature_cover_open_close_count_cover1_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #20
IT	CC
BCC	L_temperature_cover_open_close37
;control_func.c,159 :: 		count_cover1=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(temperature_cover_open_close_count_cover1_L0+0)
MOVT	R0, #hi_addr(temperature_cover_open_close_count_cover1_L0+0)
STRB	R1, [R0, #0]
;control_func.c,160 :: 		count_cover=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(temperature_cover_open_close_count_cover_L0+0)
MOVT	R0, #hi_addr(temperature_cover_open_close_count_cover_L0+0)
STRB	R1, [R0, #0]
;control_func.c,161 :: 		flag_t.cover_status=RESET;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;control_func.c,162 :: 		}
L_temperature_cover_open_close37:
;control_func.c,163 :: 		}
L_temperature_cover_open_close36:
;control_func.c,164 :: 		}
L_temperature_cover_open_close33:
;control_func.c,165 :: 		if(flag_t.temperatura_alarm_cover==RESET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_temperature_cover_open_close38
;control_func.c,167 :: 		flag_t.cover_status=RESET;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;control_func.c,168 :: 		}
L_temperature_cover_open_close38:
;control_func.c,169 :: 		}
L_end_temperature_cover_open_close:
BX	LR
; end of _temperature_cover_open_close
_control_humidity:
;control_func.c,171 :: 		void control_humidity()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;control_func.c,174 :: 		if((rel_humidity>=parameters_t.set_humidity+parameters_t.humidity_delta_alarm_level+0.5)||(rel_humidity<=parameters_t.set_humidity-parameters_t.humidity_delta_alarm_level-0.5))
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S0, [R0, #0]
VADD.F32	S1, S0, S1
VMOV.F32	S0, #0.5
VADD.F32	S1, S1, S0
MOVW	R0, #lo_addr(_rel_humidity+0)
MOVT	R0, #hi_addr(_rel_humidity+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	GE
BGE	L__control_humidity83
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S0, [R0, #0]
VSUB.F32	S1, S0, S1
VMOV.F32	S0, #0.5
VSUB.F32	S1, S1, S0
MOVW	R0, #lo_addr(_rel_humidity+0)
MOVT	R0, #hi_addr(_rel_humidity+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	LE
BLE	L__control_humidity82
IT	AL
BAL	L_control_humidity41
L__control_humidity83:
L__control_humidity82:
;control_func.c,176 :: 		if((++count_hum)>=DELAY)
MOVW	R1, #lo_addr(control_humidity_count_hum_L0+0)
MOVT	R1, #hi_addr(control_humidity_count_hum_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #20
IT	CC
BCC	L_control_humidity42
;control_func.c,178 :: 		count_hum=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_humidity_count_hum_L0+0)
MOVT	R0, #hi_addr(control_humidity_count_hum_L0+0)
STRB	R1, [R0, #0]
;control_func.c,179 :: 		count_hum1=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_humidity_count_hum1_L0+0)
MOVT	R0, #hi_addr(control_humidity_count_hum1_L0+0)
STRB	R1, [R0, #0]
;control_func.c,180 :: 		if((rel_humidity>=parameters_t.set_humidity+parameters_t.humidity_delta_alarm_level+0.5)||(rel_humidity<=parameters_t.set_humidity-parameters_t.humidity_delta_alarm_level-0.5))
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S0, [R0, #0]
VADD.F32	S1, S0, S1
VMOV.F32	S0, #0.5
VADD.F32	S1, S1, S0
MOVW	R0, #lo_addr(_rel_humidity+0)
MOVT	R0, #hi_addr(_rel_humidity+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	GE
BGE	L__control_humidity85
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S0, [R0, #0]
VSUB.F32	S1, S0, S1
VMOV.F32	S0, #0.5
VSUB.F32	S1, S1, S0
MOVW	R0, #lo_addr(_rel_humidity+0)
MOVT	R0, #hi_addr(_rel_humidity+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	LE
BLE	L__control_humidity84
IT	AL
BAL	L_control_humidity45
L__control_humidity85:
L__control_humidity84:
;control_func.c,183 :: 		if(flag_t.first_start_h==SET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_control_humidity46
;control_func.c,185 :: 		flag_t.humidity_alarm=SET;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;control_func.c,186 :: 		set_fault(2);
MOVS	R0, #2
BL	_set_fault+0
;control_func.c,187 :: 		}
L_control_humidity46:
;control_func.c,189 :: 		}
L_control_humidity45:
;control_func.c,190 :: 		}
L_control_humidity42:
;control_func.c,191 :: 		}
L_control_humidity41:
;control_func.c,193 :: 		if((rel_humidity<=parameters_t.set_humidity+parameters_t.humidity_delta_alarm_level-0.5)&&(rel_humidity>=parameters_t.set_humidity-parameters_t.humidity_delta_alarm_level+0.5))
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S0, [R0, #0]
VADD.F32	S1, S0, S1
VMOV.F32	S0, #0.5
VSUB.F32	S1, S1, S0
MOVW	R0, #lo_addr(_rel_humidity+0)
MOVT	R0, #hi_addr(_rel_humidity+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	GT
BGT	L__control_humidity89
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S0, [R0, #0]
VSUB.F32	S1, S0, S1
VMOV.F32	S0, #0.5
VADD.F32	S1, S1, S0
MOVW	R0, #lo_addr(_rel_humidity+0)
MOVT	R0, #hi_addr(_rel_humidity+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	LT
BLT	L__control_humidity88
L__control_humidity79:
;control_func.c,195 :: 		if((++count_hum1)>=DELAY)
MOVW	R1, #lo_addr(control_humidity_count_hum1_L0+0)
MOVT	R1, #hi_addr(control_humidity_count_hum1_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #20
IT	CC
BCC	L_control_humidity50
;control_func.c,197 :: 		count_hum=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_humidity_count_hum_L0+0)
MOVT	R0, #hi_addr(control_humidity_count_hum_L0+0)
STRB	R1, [R0, #0]
;control_func.c,198 :: 		count_hum1=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_humidity_count_hum1_L0+0)
MOVT	R0, #hi_addr(control_humidity_count_hum1_L0+0)
STRB	R1, [R0, #0]
;control_func.c,199 :: 		if((rel_humidity<=parameters_t.set_humidity+parameters_t.humidity_delta_alarm_level-0.5)&&(rel_humidity>=parameters_t.set_humidity-parameters_t.humidity_delta_alarm_level+0.5))
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S0, [R0, #0]
VADD.F32	S1, S0, S1
VMOV.F32	S0, #0.5
VSUB.F32	S1, S1, S0
MOVW	R0, #lo_addr(_rel_humidity+0)
MOVT	R0, #hi_addr(_rel_humidity+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	GT
BGT	L__control_humidity87
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S0, [R0, #0]
VSUB.F32	S1, S0, S1
VMOV.F32	S0, #0.5
VADD.F32	S1, S1, S0
MOVW	R0, #lo_addr(_rel_humidity+0)
MOVT	R0, #hi_addr(_rel_humidity+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	LT
BLT	L__control_humidity86
L__control_humidity78:
;control_func.c,202 :: 		flag_t.humidity_alarm=RESET;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;control_func.c,199 :: 		if((rel_humidity<=parameters_t.set_humidity+parameters_t.humidity_delta_alarm_level-0.5)&&(rel_humidity>=parameters_t.set_humidity-parameters_t.humidity_delta_alarm_level+0.5))
L__control_humidity87:
L__control_humidity86:
;control_func.c,204 :: 		}
L_control_humidity50:
;control_func.c,193 :: 		if((rel_humidity<=parameters_t.set_humidity+parameters_t.humidity_delta_alarm_level-0.5)&&(rel_humidity>=parameters_t.set_humidity-parameters_t.humidity_delta_alarm_level+0.5))
L__control_humidity89:
L__control_humidity88:
;control_func.c,207 :: 		}
L_end_control_humidity:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _control_humidity
_control_cover_humidity:
;control_func.c,209 :: 		void control_cover_humidity()
;control_func.c,212 :: 		if(rel_humidity<=parameters_t.set_humidity-(parameters_t.humidity_delta_alarm_level-5))
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S1, [R0, #0]
VMOV.F32	S0, #5
VSUB.F32	S1, S1, S0
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S0, [R0, #0]
VSUB.F32	S1, S0, S1
MOVW	R0, #lo_addr(_rel_humidity+0)
MOVT	R0, #hi_addr(_rel_humidity+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	GT
BGT	L_control_cover_humidity54
;control_func.c,214 :: 		if((++count_humi)>=DELAY)
MOVW	R1, #lo_addr(control_cover_humidity_count_humi_L0+0)
MOVT	R1, #hi_addr(control_cover_humidity_count_humi_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #20
IT	CC
BCC	L_control_cover_humidity55
;control_func.c,216 :: 		count_humi=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_cover_humidity_count_humi_L0+0)
MOVT	R0, #hi_addr(control_cover_humidity_count_humi_L0+0)
STRB	R1, [R0, #0]
;control_func.c,217 :: 		count_humi1=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_cover_humidity_count_humi1_L0+0)
MOVT	R0, #hi_addr(control_cover_humidity_count_humi1_L0+0)
STRB	R1, [R0, #0]
;control_func.c,218 :: 		if(rel_humidity<=parameters_t.set_humidity-(parameters_t.humidity_delta_alarm_level-5))
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S1, [R0, #0]
VMOV.F32	S0, #5
VSUB.F32	S1, S1, S0
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S0, [R0, #0]
VSUB.F32	S1, S0, S1
MOVW	R0, #lo_addr(_rel_humidity+0)
MOVT	R0, #hi_addr(_rel_humidity+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	GT
BGT	L_control_cover_humidity56
;control_func.c,221 :: 		flag_t.humidity_alarm_cover=SET;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;control_func.c,222 :: 		}
L_control_cover_humidity56:
;control_func.c,223 :: 		}
L_control_cover_humidity55:
;control_func.c,224 :: 		}
L_control_cover_humidity54:
;control_func.c,225 :: 		if(rel_humidity>=parameters_t.set_humidity+(parameters_t.humidity_delta_alarm_level-5))
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S1, [R0, #0]
VMOV.F32	S0, #5
VSUB.F32	S1, S1, S0
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S0, [R0, #0]
VADD.F32	S1, S0, S1
MOVW	R0, #lo_addr(_rel_humidity+0)
MOVT	R0, #hi_addr(_rel_humidity+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	LT
BLT	L_control_cover_humidity57
;control_func.c,227 :: 		if((++count_humi1)>=DELAY)
MOVW	R1, #lo_addr(control_cover_humidity_count_humi1_L0+0)
MOVT	R1, #hi_addr(control_cover_humidity_count_humi1_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #20
IT	CC
BCC	L_control_cover_humidity58
;control_func.c,229 :: 		count_humi1=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_cover_humidity_count_humi1_L0+0)
MOVT	R0, #hi_addr(control_cover_humidity_count_humi1_L0+0)
STRB	R1, [R0, #0]
;control_func.c,230 :: 		count_humi=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_cover_humidity_count_humi_L0+0)
MOVT	R0, #hi_addr(control_cover_humidity_count_humi_L0+0)
STRB	R1, [R0, #0]
;control_func.c,231 :: 		if(rel_humidity>=parameters_t.set_humidity+(parameters_t.humidity_delta_alarm_level-5))
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S1, [R0, #0]
VMOV.F32	S0, #5
VSUB.F32	S1, S1, S0
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S0, [R0, #0]
VADD.F32	S1, S0, S1
MOVW	R0, #lo_addr(_rel_humidity+0)
MOVT	R0, #hi_addr(_rel_humidity+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, S1
VMRS	#60, FPSCR
IT	LT
BLT	L_control_cover_humidity59
;control_func.c,234 :: 		flag_t.humidity_alarm_cover=RESET;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;control_func.c,235 :: 		}
L_control_cover_humidity59:
;control_func.c,236 :: 		}
L_control_cover_humidity58:
;control_func.c,237 :: 		}
L_control_cover_humidity57:
;control_func.c,238 :: 		}
L_end_control_cover_humidity:
BX	LR
; end of _control_cover_humidity
_humidity_cover_open_close:
;control_func.c,240 :: 		void humidity_cover_open_close()
;control_func.c,243 :: 		if(flag_t.humidity_alarm_cover==SET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_humidity_cover_open_close60
;control_func.c,246 :: 		if(flag_t.humidity_cover_status==RESET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_humidity_cover_open_close61
;control_func.c,249 :: 		if((++count_cover_h)>=(DELAY+30))
MOVW	R1, #lo_addr(humidity_cover_open_close_count_cover_h_L0+0)
MOVT	R1, #hi_addr(humidity_cover_open_close_count_cover_h_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #50
IT	CC
BCC	L_humidity_cover_open_close62
;control_func.c,251 :: 		count_cover_h1=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(humidity_cover_open_close_count_cover_h1_L0+0)
MOVT	R0, #hi_addr(humidity_cover_open_close_count_cover_h1_L0+0)
STRB	R1, [R0, #0]
;control_func.c,252 :: 		count_cover_h=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(humidity_cover_open_close_count_cover_h_L0+0)
MOVT	R0, #hi_addr(humidity_cover_open_close_count_cover_h_L0+0)
STRB	R1, [R0, #0]
;control_func.c,253 :: 		flag_t.humidity_cover_status=SET;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;control_func.c,254 :: 		}
L_humidity_cover_open_close62:
;control_func.c,255 :: 		}
L_humidity_cover_open_close61:
;control_func.c,257 :: 		if(flag_t.humidity_cover_status==SET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_humidity_cover_open_close63
;control_func.c,260 :: 		if((++count_cover_h1)>=DELAY)
MOVW	R1, #lo_addr(humidity_cover_open_close_count_cover_h1_L0+0)
MOVT	R1, #hi_addr(humidity_cover_open_close_count_cover_h1_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #20
IT	CC
BCC	L_humidity_cover_open_close64
;control_func.c,262 :: 		count_cover_h1=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(humidity_cover_open_close_count_cover_h1_L0+0)
MOVT	R0, #hi_addr(humidity_cover_open_close_count_cover_h1_L0+0)
STRB	R1, [R0, #0]
;control_func.c,263 :: 		count_cover_h=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(humidity_cover_open_close_count_cover_h_L0+0)
MOVT	R0, #hi_addr(humidity_cover_open_close_count_cover_h_L0+0)
STRB	R1, [R0, #0]
;control_func.c,264 :: 		flag_t.humidity_cover_status=RESET;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;control_func.c,265 :: 		}
L_humidity_cover_open_close64:
;control_func.c,266 :: 		}
L_humidity_cover_open_close63:
;control_func.c,267 :: 		}
L_humidity_cover_open_close60:
;control_func.c,268 :: 		if(flag_t.humidity_alarm_cover==RESET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_humidity_cover_open_close65
;control_func.c,270 :: 		flag_t.humidity_cover_status=RESET;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;control_func.c,271 :: 		}
L_humidity_cover_open_close65:
;control_func.c,272 :: 		}
L_end_humidity_cover_open_close:
BX	LR
; end of _humidity_cover_open_close
