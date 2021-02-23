_Timer0A_interrupt:
;SHT11_Inkubator.c,84 :: 		void Timer0A_interrupt() iv IVT_INT_TIMER0A_16_32_bit ics ICS_AUTO {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;SHT11_Inkubator.c,85 :: 		TIMER_ICR_TATOCINT_bit = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, 1073938468
MOVT	R0, 16387
STR	R1, [R0, #0]
;SHT11_Inkubator.c,86 :: 		flag_t.main_timer_ovf=SET;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;SHT11_Inkubator.c,87 :: 		read_key();
BL	_read_key+0
;SHT11_Inkubator.c,89 :: 		control_menu();
BL	_control_menu+0
;SHT11_Inkubator.c,90 :: 		}
L_end_Timer0A_interrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Timer0A_interrupt
_Zero_cross_detector_int:
;SHT11_Inkubator.c,92 :: 		void Zero_cross_detector_int() iv IVT_INT_GPIOD ics ICS_AUTO
SUB	SP, SP, #4
STR	LR, [SP, #0]
;SHT11_Inkubator.c,94 :: 		unsigned long temp=0;
;SHT11_Inkubator.c,95 :: 		GPIO_PORTD_ICR = _GPIO_PINMASK_6;      // clear ext interrupt flag
MOVW	R1, #64
MOVW	R0, 1073771548
MOVT	R0, 16384
STR	R1, [R0, #0]
;SHT11_Inkubator.c,96 :: 		if(flag_t.start_process==SET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Zero_cross_detector_int0
;SHT11_Inkubator.c,98 :: 		temp=(unsigned long)(100.0*out_reg_value);
MOVW	R0, #lo_addr(_out_reg_value+0)
MOVT	R0, #hi_addr(_out_reg_value+0)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VMUL.F32	S0, S0, S1
VCVT	#1, .F32, S0, S0
VMOV	R1, S0
; temp start address is: 8 (R2)
MOV	R2, R1
;SHT11_Inkubator.c,99 :: 		if(temp>PER_TIM_ZCD) temp=PER_TIM_ZCD;
MOVW	R0, #50000
CMP	R1, R0
IT	LS
BLS	L__Zero_cross_detector_int20
; temp end address is: 8 (R2)
; temp start address is: 4 (R1)
MOVW	R1, #50000
; temp end address is: 4 (R1)
IT	AL
BAL	L_Zero_cross_detector_int1
L__Zero_cross_detector_int20:
MOV	R1, R2
L_Zero_cross_detector_int1:
;SHT11_Inkubator.c,100 :: 		switch(temp)
; temp start address is: 4 (R1)
IT	AL
BAL	L_Zero_cross_detector_int2
; temp end address is: 4 (R1)
;SHT11_Inkubator.c,102 :: 		case 0:                    TRIAC_OUT=RESET; break;
L_Zero_cross_detector_int4:
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, 1073763324
MOVT	R0, 16384
STR	R1, [R0, #0]
IT	AL
BAL	L_Zero_cross_detector_int3
;SHT11_Inkubator.c,103 :: 		case 1:                    TRIAC_OUT=RESET; break;
L_Zero_cross_detector_int5:
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, 1073763324
MOVT	R0, 16384
STR	R1, [R0, #0]
IT	AL
BAL	L_Zero_cross_detector_int3
;SHT11_Inkubator.c,104 :: 		case 2:                    TRIAC_OUT=RESET; break;
L_Zero_cross_detector_int6:
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, 1073763324
MOVT	R0, 16384
STR	R1, [R0, #0]
IT	AL
BAL	L_Zero_cross_detector_int3
;SHT11_Inkubator.c,105 :: 		case PER_TIM_ZCD-2:        TRIAC_OUT=SET;   break;
L_Zero_cross_detector_int7:
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, 1073763324
MOVT	R0, 16384
STR	R1, [R0, #0]
IT	AL
BAL	L_Zero_cross_detector_int3
;SHT11_Inkubator.c,106 :: 		case PER_TIM_ZCD-1:        TRIAC_OUT=SET;   break;
L_Zero_cross_detector_int8:
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, 1073763324
MOVT	R0, 16384
STR	R1, [R0, #0]
IT	AL
BAL	L_Zero_cross_detector_int3
;SHT11_Inkubator.c,107 :: 		case PER_TIM_ZCD:          TRIAC_OUT=SET;   break;
L_Zero_cross_detector_int9:
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, 1073763324
MOVT	R0, 16384
STR	R1, [R0, #0]
IT	AL
BAL	L_Zero_cross_detector_int3
;SHT11_Inkubator.c,108 :: 		default:                   StartTimer1A_10ms(temp);break;//PER_TIM_ZCD-temp); break;
L_Zero_cross_detector_int10:
; temp start address is: 4 (R1)
MOV	R0, R1
; temp end address is: 4 (R1)
BL	_StartTimer1A_10ms+0
IT	AL
BAL	L_Zero_cross_detector_int3
;SHT11_Inkubator.c,109 :: 		}
L_Zero_cross_detector_int2:
; temp start address is: 4 (R1)
CMP	R1, #0
IT	EQ
BEQ	L_Zero_cross_detector_int4
CMP	R1, #1
IT	EQ
BEQ	L_Zero_cross_detector_int5
CMP	R1, #2
IT	EQ
BEQ	L_Zero_cross_detector_int6
MOVW	R0, #49998
CMP	R1, R0
IT	EQ
BEQ	L_Zero_cross_detector_int7
MOVW	R0, #49999
CMP	R1, R0
IT	EQ
BEQ	L_Zero_cross_detector_int8
MOVW	R0, #50000
CMP	R1, R0
IT	EQ
BEQ	L_Zero_cross_detector_int9
IT	AL
BAL	L_Zero_cross_detector_int10
; temp end address is: 4 (R1)
L_Zero_cross_detector_int3:
;SHT11_Inkubator.c,112 :: 		}
L_Zero_cross_detector_int0:
;SHT11_Inkubator.c,114 :: 		}
L_end_Zero_cross_detector_int:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Zero_cross_detector_int
_Timer1A_interrupt:
;SHT11_Inkubator.c,116 :: 		void Timer1A_interrupt() iv IVT_INT_TIMER1A_16_32_bit ics ICS_AUTO
SUB	SP, SP, #4
STR	LR, [SP, #0]
;SHT11_Inkubator.c,118 :: 		TIMER_ICR_TATOCINT_TIMER1_ICR_bit = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, 1073942564
MOVT	R0, 16387
STR	R1, [R0, #0]
;SHT11_Inkubator.c,119 :: 		StopTimer1A_10ms();
BL	_StopTimer1A_10ms+0
;SHT11_Inkubator.c,120 :: 		impulse();
BL	_impulse+0
;SHT11_Inkubator.c,121 :: 		}
L_end_Timer1A_interrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Timer1A_interrupt
_main:
;SHT11_Inkubator.c,124 :: 		void main()
SUB	SP, SP, #4
;SHT11_Inkubator.c,126 :: 		Init_flags();
BL	_Init_flags+0
;SHT11_Inkubator.c,127 :: 		Init_Gpio();
BL	_Init_Gpio+0
;SHT11_Inkubator.c,128 :: 		Lcd_Init();                        // Initialize LCD
BL	_Lcd_Init+0
;SHT11_Inkubator.c,129 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
MOVS	R0, #1
BL	_Lcd_Cmd+0
;SHT11_Inkubator.c,130 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
MOVS	R0, #12
BL	_Lcd_Cmd+0
;SHT11_Inkubator.c,132 :: 		init_pid();
BL	_init_pid+0
;SHT11_Inkubator.c,133 :: 		start_eeprom();
BL	_start_eeprom+0
;SHT11_Inkubator.c,134 :: 		reset_error_message();
BL	_reset_error_message+0
;SHT11_Inkubator.c,135 :: 		BLED=SET;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, 1073759228
MOVT	R0, 16384
STR	R1, [R0, #0]
;SHT11_Inkubator.c,136 :: 		Load();
BL	_Load+0
;SHT11_Inkubator.c,137 :: 		Init_ext_int();
BL	_Init_ext_int+0
;SHT11_Inkubator.c,138 :: 		InitTimer0A();
BL	_InitTimer0A+0
;SHT11_Inkubator.c,139 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;SHT11_Inkubator.c,141 :: 		while(TRUE)
L_main11:
;SHT11_Inkubator.c,143 :: 		if(flag_t.main_timer_ovf==SET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main13
;SHT11_Inkubator.c,146 :: 		flag_t.main_timer_ovf=RESET;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;SHT11_Inkubator.c,147 :: 		if(flag_t.start_process==SET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main14
;SHT11_Inkubator.c,149 :: 		rotation();
BL	_rotation+0
;SHT11_Inkubator.c,151 :: 		out_reg_value=fabs(UpdatePID(Rpid,(parameters_t.set_temperatura-temperature),temperature));
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S2, [R0, #0]
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
STR	R0, [SP, #0]
VLDR	#1, S0, [R0, #0]
VSUB.F32	S0, S0, S1
MOVW	R0, #lo_addr(_Rpid+0)
MOVT	R0, #hi_addr(_Rpid+0)
VMOV.F32	S1, S2
SUB	SP, SP, #28
MOV	R12, R0
ADD	R11, SP, #0
ADD	R10, R11, #28
BL	___CC2DW+0
BL	_UpdatePID+0
ADD	SP, SP, #28
BL	_fabs+0
MOVW	R0, #lo_addr(_out_reg_value+0)
MOVT	R0, #hi_addr(_out_reg_value+0)
VSTR	#1, S0, [R0, #0]
;SHT11_Inkubator.c,152 :: 		out_reg_value=(parameters_t.set_temperatura*5)-out_reg_value;
LDR	R0, [SP, #0]
VLDR	#1, S1, [R0, #0]
VMOV.F32	S0, #5
VMUL.F32	S1, S1, S0
MOVW	R0, #lo_addr(_out_reg_value+0)
MOVT	R0, #hi_addr(_out_reg_value+0)
VLDR	#1, S0, [R0, #0]
VSUB.F32	S0, S1, S0
MOVW	R0, #lo_addr(_out_reg_value+0)
MOVT	R0, #hi_addr(_out_reg_value+0)
VSTR	#1, S0, [R0, #0]
;SHT11_Inkubator.c,153 :: 		if(out_reg_value<0) out_reg_value=0;
MOVW	R0, #lo_addr(_out_reg_value+0)
MOVT	R0, #hi_addr(_out_reg_value+0)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, #0
VMRS	#60, FPSCR
IT	GE
BGE	L_main15
MOV	R0, #0
VMOV	S0, R0
MOVW	R0, #lo_addr(_out_reg_value+0)
MOVT	R0, #hi_addr(_out_reg_value+0)
VSTR	#1, S0, [R0, #0]
L_main15:
;SHT11_Inkubator.c,154 :: 		}
L_main14:
;SHT11_Inkubator.c,159 :: 		Get_key();
BL	_Get_key+0
;SHT11_Inkubator.c,160 :: 		Read_sensor();
BL	_Read_sensor+0
;SHT11_Inkubator.c,163 :: 		if(flag_t.start_process==SET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main16
;SHT11_Inkubator.c,165 :: 		control_first_start();
BL	_control_first_start+0
;SHT11_Inkubator.c,166 :: 		control_temperature();
BL	_control_temperature+0
;SHT11_Inkubator.c,167 :: 		control_temperature_triac();
BL	_control_temperature_triac+0
;SHT11_Inkubator.c,168 :: 		temperature_cover_open_close();
BL	_temperature_cover_open_close+0
;SHT11_Inkubator.c,169 :: 		control_temperature_cover();
BL	_control_temperature_cover+0
;SHT11_Inkubator.c,170 :: 		if(flag_t.control_humidity==SET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main17
;SHT11_Inkubator.c,172 :: 		control_humidity();
BL	_control_humidity+0
;SHT11_Inkubator.c,173 :: 		control_cover_humidity();
BL	_control_cover_humidity+0
;SHT11_Inkubator.c,174 :: 		humidity_cover_open_close();
BL	_humidity_cover_open_close+0
;SHT11_Inkubator.c,175 :: 		}
L_main17:
;SHT11_Inkubator.c,176 :: 		if(flag_t.control_humidity==RESET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_main18
;SHT11_Inkubator.c,178 :: 		flag_t.humidity_cover_status=RESET;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;SHT11_Inkubator.c,179 :: 		}
L_main18:
;SHT11_Inkubator.c,180 :: 		}
L_main16:
;SHT11_Inkubator.c,181 :: 		if(flag_t.start_process==RESET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_main19
;SHT11_Inkubator.c,183 :: 		reset_flags();
BL	_reset_flags+0
;SHT11_Inkubator.c,184 :: 		}
L_main19:
;SHT11_Inkubator.c,185 :: 		control_outs();
BL	_control_outs+0
;SHT11_Inkubator.c,186 :: 		out_data_to_lcd();
BL	_out_data_to_lcd+0
;SHT11_Inkubator.c,188 :: 		}
L_main13:
;SHT11_Inkubator.c,189 :: 		}
IT	AL
BAL	L_main11
;SHT11_Inkubator.c,190 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
