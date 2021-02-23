_Read_sensor:
;inkubator_func.c,5 :: 		void Read_sensor()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;inkubator_func.c,8 :: 		if((++read_sensor_count)==20)
MOVW	R1, #lo_addr(Read_sensor_read_sensor_count_L0+0)
MOVT	R1, #hi_addr(Read_sensor_read_sensor_count_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #20
IT	NE
BNE	L_Read_sensor0
;inkubator_func.c,10 :: 		read_sensor_count=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(Read_sensor_read_sensor_count_L0+0)
MOVT	R0, #hi_addr(Read_sensor_read_sensor_count_L0+0)
STRB	R1, [R0, #0]
;inkubator_func.c,12 :: 		DisableInterrupts();
BL	_DisableInterrupts+0
;inkubator_func.c,13 :: 		if (AM2302_Read(&rel_humidity, &temperature) == 1)                 // Display AM2302_Read sensor values via TFT
MOVW	R1, #lo_addr(_temperature+0)
MOVT	R1, #hi_addr(_temperature+0)
MOVW	R0, #lo_addr(_rel_humidity+0)
MOVT	R0, #hi_addr(_rel_humidity+0)
BL	_AM2302_Read+0
CMP	R0, #1
IT	NE
BNE	L_Read_sensor1
;inkubator_func.c,15 :: 		set_fault(4);
MOVS	R0, #4
BL	_set_fault+0
;inkubator_func.c,19 :: 		}
L_Read_sensor1:
;inkubator_func.c,20 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;inkubator_func.c,21 :: 		}
L_Read_sensor0:
;inkubator_func.c,23 :: 		}
L_end_Read_sensor:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Read_sensor
_out_data_to_lcd:
;inkubator_func.c,25 :: 		void out_data_to_lcd()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;inkubator_func.c,28 :: 		if((++count_data)>=10)
MOVW	R1, #lo_addr(out_data_to_lcd_count_data_L0+0)
MOVT	R1, #hi_addr(out_data_to_lcd_count_data_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #10
IT	CC
BCC	L_out_data_to_lcd2
;inkubator_func.c,30 :: 		count_data=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(out_data_to_lcd_count_data_L0+0)
MOVT	R0, #hi_addr(out_data_to_lcd_count_data_L0+0)
STRB	R1, [R0, #0]
;inkubator_func.c,31 :: 		Out_data_in_lcd();
BL	_Out_data_in_lcd+0
;inkubator_func.c,32 :: 		}
L_out_data_to_lcd2:
;inkubator_func.c,35 :: 		}
L_end_out_data_to_lcd:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _out_data_to_lcd
_Out_data_in_lcd:
;inkubator_func.c,37 :: 		void Out_data_in_lcd()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;inkubator_func.c,39 :: 		Lcd_Out(1,1,"Tr");
MOVW	R0, #lo_addr(?lstr1_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr1_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #1
MOVS	R0, #1
BL	_Lcd_Out+0
;inkubator_func.c,40 :: 		sprintf(Data_Str,"%-2.1fC",temperature);
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_2_inkubator_func+0)
MOVT	R1, #hi_addr(?lstr_2_inkubator_func+0)
MOVW	R0, #lo_addr(_Data_Str+0)
MOVT	R0, #hi_addr(_Data_Str+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;inkubator_func.c,41 :: 		Lcd_Out(1,3,Data_Str);
MOVW	R2, #lo_addr(_Data_Str+0)
MOVT	R2, #hi_addr(_Data_Str+0)
MOVS	R1, #3
MOVS	R0, #1
BL	_Lcd_Out+0
;inkubator_func.c,43 :: 		sprintf(Data_Str,"%-1.1fC%-2.0f%%  ",temperature-parameters_t.set_temperatura,rel_humidity-parameters_t.set_humidity);
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_rel_humidity+0)
MOVT	R0, #hi_addr(_rel_humidity+0)
VLDR	#1, S0, [R0, #0]
VSUB.F32	S2, S0, S1
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #lo_addr(_temperature+0)
MOVT	R0, #hi_addr(_temperature+0)
VLDR	#1, S0, [R0, #0]
VSUB.F32	S0, S0, S1
MOVW	R1, #lo_addr(?lstr_3_inkubator_func+0)
MOVT	R1, #hi_addr(?lstr_3_inkubator_func+0)
MOVW	R0, #lo_addr(_Data_Str+0)
MOVT	R0, #hi_addr(_Data_Str+0)
VPUSH	#0, (S2)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #16
;inkubator_func.c,45 :: 		Lcd_Out(2,8,Data_Str);
MOVW	R2, #lo_addr(_Data_Str+0)
MOVT	R2, #hi_addr(_Data_Str+0)
MOVS	R1, #8
MOVS	R0, #2
BL	_Lcd_Out+0
;inkubator_func.c,47 :: 		Lcd_Out(1,9,"M");
MOVW	R0, #lo_addr(?lstr4_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr4_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #9
MOVS	R0, #1
BL	_Lcd_Out+0
;inkubator_func.c,48 :: 		if(flag_t.start_fan==SET) Lcd_Out(1,10,"+");
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Out_data_in_lcd3
MOVW	R0, #lo_addr(?lstr5_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr5_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #10
MOVS	R0, #1
BL	_Lcd_Out+0
L_Out_data_in_lcd3:
;inkubator_func.c,49 :: 		if(flag_t.start_fan==RESET) Lcd_Out(1,10,"-");
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_Out_data_in_lcd4
MOVW	R0, #lo_addr(?lstr6_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr6_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #10
MOVS	R0, #1
BL	_Lcd_Out+0
L_Out_data_in_lcd4:
;inkubator_func.c,51 :: 		Lcd_Out(1,12,"P");
MOVW	R0, #lo_addr(?lstr7_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr7_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #12
MOVS	R0, #1
BL	_Lcd_Out+0
;inkubator_func.c,52 :: 		if(flag_t.start_process==SET) Lcd_Out(1,13,"+");
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Out_data_in_lcd5
MOVW	R0, #lo_addr(?lstr8_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr8_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #13
MOVS	R0, #1
BL	_Lcd_Out+0
L_Out_data_in_lcd5:
;inkubator_func.c,53 :: 		if(flag_t.start_process==RESET) Lcd_Out(1,13,"-");
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_Out_data_in_lcd6
MOVW	R0, #lo_addr(?lstr9_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr9_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #13
MOVS	R0, #1
BL	_Lcd_Out+0
L_Out_data_in_lcd6:
;inkubator_func.c,55 :: 		Lcd_Out(1,15,"K");
MOVW	R0, #lo_addr(?lstr10_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr10_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #15
MOVS	R0, #1
BL	_Lcd_Out+0
;inkubator_func.c,56 :: 		if(flag_t.cover_status==SET) Lcd_Out(1,16,"+");
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Out_data_in_lcd7
MOVW	R0, #lo_addr(?lstr11_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr11_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #16
MOVS	R0, #1
BL	_Lcd_Out+0
L_Out_data_in_lcd7:
;inkubator_func.c,57 :: 		if(flag_t.cover_status==RESET) Lcd_Out(1,16,"-");
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_Out_data_in_lcd8
MOVW	R0, #lo_addr(?lstr12_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr12_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #16
MOVS	R0, #1
BL	_Lcd_Out+0
L_Out_data_in_lcd8:
;inkubator_func.c,58 :: 		Lcd_Out(2,1,"Vr");
MOVW	R0, #lo_addr(?lstr13_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr13_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #1
MOVS	R0, #2
BL	_Lcd_Out+0
;inkubator_func.c,60 :: 		sprintf(Data_Str,"%-2.1f%%",rel_humidity);
MOVW	R0, #lo_addr(_rel_humidity+0)
MOVT	R0, #hi_addr(_rel_humidity+0)
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_14_inkubator_func+0)
MOVT	R1, #hi_addr(?lstr_14_inkubator_func+0)
MOVW	R0, #lo_addr(_Data_Str+0)
MOVT	R0, #hi_addr(_Data_Str+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;inkubator_func.c,61 :: 		Lcd_Out(2,3,Data_Str);
MOVW	R2, #lo_addr(_Data_Str+0)
MOVT	R2, #hi_addr(_Data_Str+0)
MOVS	R1, #3
MOVS	R0, #2
BL	_Lcd_Out+0
;inkubator_func.c,67 :: 		}
L_end_Out_data_in_lcd:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Out_data_in_lcd
_key_code_pressed:
;inkubator_func.c,69 :: 		unsigned char key_code_pressed()
;inkubator_func.c,71 :: 		unsigned char key_value=0;
; key_value start address is: 8 (R2)
MOVS	R2, #0
;inkubator_func.c,72 :: 		if(PIN_UP==RESET)
MOVW	R1, #lo_addr(PIN_UP+0)
MOVT	R1, #hi_addr(PIN_UP+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L__key_code_pressed156
;inkubator_func.c,74 :: 		key_value=key_up;
MOVS	R2, #1
; key_value end address is: 8 (R2)
;inkubator_func.c,75 :: 		}
IT	AL
BAL	L_key_code_pressed9
L__key_code_pressed156:
;inkubator_func.c,72 :: 		if(PIN_UP==RESET)
;inkubator_func.c,75 :: 		}
L_key_code_pressed9:
;inkubator_func.c,76 :: 		if(PIN_DOWN==RESET)
; key_value start address is: 8 (R2)
MOVW	R1, #lo_addr(PIN_DOWN+0)
MOVT	R1, #hi_addr(PIN_DOWN+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L__key_code_pressed157
;inkubator_func.c,78 :: 		key_value=key_down;
MOVS	R2, #2
; key_value end address is: 8 (R2)
;inkubator_func.c,79 :: 		}
IT	AL
BAL	L_key_code_pressed10
L__key_code_pressed157:
;inkubator_func.c,76 :: 		if(PIN_DOWN==RESET)
;inkubator_func.c,79 :: 		}
L_key_code_pressed10:
;inkubator_func.c,80 :: 		if(PIN_ENTER==RESET)
; key_value start address is: 8 (R2)
MOVW	R1, #lo_addr(PIN_ENTER+0)
MOVT	R1, #hi_addr(PIN_ENTER+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L__key_code_pressed158
;inkubator_func.c,82 :: 		key_value=key_enter;
MOVS	R2, #3
; key_value end address is: 8 (R2)
;inkubator_func.c,83 :: 		}
IT	AL
BAL	L_key_code_pressed11
L__key_code_pressed158:
;inkubator_func.c,80 :: 		if(PIN_ENTER==RESET)
;inkubator_func.c,83 :: 		}
L_key_code_pressed11:
;inkubator_func.c,84 :: 		if(PIN_BACK==RESET)
; key_value start address is: 8 (R2)
MOVW	R1, #lo_addr(PIN_BACK+0)
MOVT	R1, #hi_addr(PIN_BACK+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L__key_code_pressed159
; key_value end address is: 8 (R2)
;inkubator_func.c,86 :: 		key_value=key_back;
; key_value start address is: 0 (R0)
MOVS	R0, #4
; key_value end address is: 0 (R0)
;inkubator_func.c,87 :: 		}
IT	AL
BAL	L_key_code_pressed12
L__key_code_pressed159:
;inkubator_func.c,84 :: 		if(PIN_BACK==RESET)
UXTB	R0, R2
;inkubator_func.c,87 :: 		}
L_key_code_pressed12:
;inkubator_func.c,88 :: 		return (key_value);
; key_value start address is: 0 (R0)
; key_value end address is: 0 (R0)
;inkubator_func.c,89 :: 		}
L_end_key_code_pressed:
BX	LR
; end of _key_code_pressed
_set_temperature:
;inkubator_func.c,91 :: 		void set_temperature()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;inkubator_func.c,93 :: 		char kp=0;
MOVS	R0, #0
STRB	R0, [SP, #4]
MOVS	R0, #0
STRB	R0, [SP, #5]
;inkubator_func.c,94 :: 		char go=0;
;inkubator_func.c,95 :: 		unsigned char key_code=0;
;inkubator_func.c,96 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
MOVS	R0, #1
BL	_Lcd_Cmd+0
;inkubator_func.c,97 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
MOVS	R0, #12
BL	_Lcd_Cmd+0
;inkubator_func.c,98 :: 		Lcd_Out(1,3,"TEMPERATURA");
MOVW	R0, #lo_addr(?lstr15_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr15_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #3
MOVS	R0, #1
BL	_Lcd_Out+0
;inkubator_func.c,99 :: 		sprintf(Data_Str,"%-2.1f C",parameters_t.set_temperatura);
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_16_inkubator_func+0)
MOVT	R1, #hi_addr(?lstr_16_inkubator_func+0)
MOVW	R0, #lo_addr(_Data_Str+0)
MOVT	R0, #hi_addr(_Data_Str+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;inkubator_func.c,100 :: 		Lcd_Out(2,6,Data_Str);
MOVW	R2, #lo_addr(_Data_Str+0)
MOVT	R2, #hi_addr(_Data_Str+0)
MOVS	R1, #6
MOVS	R0, #2
BL	_Lcd_Out+0
;inkubator_func.c,101 :: 		key_value=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
;inkubator_func.c,102 :: 		while(kp==0)
L_set_temperature13:
LDRB	R0, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_set_temperature14
;inkubator_func.c,104 :: 		if(flag_t.status_in_menu==RESET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_set_temperature15
;inkubator_func.c,106 :: 		key_value=key_back;
MOVS	R1, #4
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
;inkubator_func.c,107 :: 		}
L_set_temperature15:
;inkubator_func.c,108 :: 		switch(key_value)
IT	AL
BAL	L_set_temperature16
;inkubator_func.c,110 :: 		case key_up:           key_value=0; parameters_t.set_temperatura=parameters_t.set_temperatura+0.1;
L_set_temperature18:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVW	R1, #lo_addr(_parameters_t+0)
MOVT	R1, #hi_addr(_parameters_t+0)
VLDR	#1, S1, [R1, #0]
MOVW	R0, #52429
MOVT	R0, #15820
VMOV	S0, R0
VADD.F32	S1, S1, S0
VSTR	#1, S1, [R1, #0]
;inkubator_func.c,111 :: 		if(parameters_t.set_temperatura>=40.0)
MOVW	R0, #0
MOVT	R0, #16928
VMOV	S0, R0
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	LT
BLT	L_set_temperature19
;inkubator_func.c,113 :: 		parameters_t.set_temperatura=40.0;
MOVW	R0, #0
MOVT	R0, #16928
VMOV	S0, R0
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,114 :: 		}
L_set_temperature19:
;inkubator_func.c,115 :: 		sprintf(Data_Str,"%-2.1f C",parameters_t.set_temperatura);
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_17_inkubator_func+0)
MOVT	R1, #hi_addr(?lstr_17_inkubator_func+0)
MOVW	R0, #lo_addr(_Data_Str+0)
MOVT	R0, #hi_addr(_Data_Str+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;inkubator_func.c,116 :: 		Lcd_Out(2,6,Data_Str); break;
MOVW	R2, #lo_addr(_Data_Str+0)
MOVT	R2, #hi_addr(_Data_Str+0)
MOVS	R1, #6
MOVS	R0, #2
BL	_Lcd_Out+0
IT	AL
BAL	L_set_temperature17
;inkubator_func.c,118 :: 		case key_down:            key_value=0;parameters_t.set_temperatura=parameters_t.set_temperatura-0.1;
L_set_temperature20:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVW	R1, #lo_addr(_parameters_t+0)
MOVT	R1, #hi_addr(_parameters_t+0)
VLDR	#1, S1, [R1, #0]
MOVW	R0, #52429
MOVT	R0, #15820
VMOV	S0, R0
VSUB.F32	S1, S1, S0
VSTR	#1, S1, [R1, #0]
;inkubator_func.c,119 :: 		if(parameters_t.set_temperatura<=34.0)
MOVW	R0, #0
MOVT	R0, #16904
VMOV	S0, R0
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	GT
BGT	L_set_temperature21
;inkubator_func.c,121 :: 		parameters_t.set_temperatura=34.0;
MOVW	R0, #0
MOVT	R0, #16904
VMOV	S0, R0
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,122 :: 		}
L_set_temperature21:
;inkubator_func.c,123 :: 		sprintf(Data_Str,"%-2.1f C",parameters_t.set_temperatura);
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_18_inkubator_func+0)
MOVT	R1, #hi_addr(?lstr_18_inkubator_func+0)
MOVW	R0, #lo_addr(_Data_Str+0)
MOVT	R0, #hi_addr(_Data_Str+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;inkubator_func.c,124 :: 		Lcd_Out(2,6,Data_Str); break;
MOVW	R2, #lo_addr(_Data_Str+0)
MOVT	R2, #hi_addr(_Data_Str+0)
MOVS	R1, #6
MOVS	R0, #2
BL	_Lcd_Out+0
IT	AL
BAL	L_set_temperature17
;inkubator_func.c,125 :: 		case key_enter:           key_value=0;go=1;kp=1;    break;
L_set_temperature22:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVS	R0, #1
STRB	R0, [SP, #5]
MOVS	R0, #1
STRB	R0, [SP, #4]
IT	AL
BAL	L_set_temperature17
;inkubator_func.c,126 :: 		case key_back:           key_value=0;kp=1; Lcd_Cmd(_LCD_CLEAR);               // Clear display
L_set_temperature23:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVS	R0, #1
STRB	R0, [SP, #4]
MOVS	R0, #1
BL	_Lcd_Cmd+0
;inkubator_func.c,127 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);         break;
MOVS	R0, #12
BL	_Lcd_Cmd+0
IT	AL
BAL	L_set_temperature17
;inkubator_func.c,128 :: 		}
L_set_temperature16:
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_set_temperature18
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_set_temperature20
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_set_temperature22
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_set_temperature23
L_set_temperature17:
;inkubator_func.c,130 :: 		}
IT	AL
BAL	L_set_temperature13
L_set_temperature14:
;inkubator_func.c,131 :: 		if(go==SET)set_humidity();
LDRB	R0, [SP, #5]
CMP	R0, #1
IT	NE
BNE	L_set_temperature24
BL	_set_humidity+0
L_set_temperature24:
;inkubator_func.c,133 :: 		}
L_end_set_temperature:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _set_temperature
_set_humidity:
;inkubator_func.c,136 :: 		void set_humidity()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;inkubator_func.c,138 :: 		char kp=0;
MOVS	R0, #0
STRB	R0, [SP, #4]
MOVS	R0, #0
STRB	R0, [SP, #5]
;inkubator_func.c,139 :: 		char go=0;
;inkubator_func.c,140 :: 		unsigned char key_code=0;
;inkubator_func.c,141 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
MOVS	R0, #1
BL	_Lcd_Cmd+0
;inkubator_func.c,142 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
MOVS	R0, #12
BL	_Lcd_Cmd+0
;inkubator_func.c,143 :: 		Lcd_Out(1,5,"VLAJNOST");
MOVW	R0, #lo_addr(?lstr19_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr19_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #5
MOVS	R0, #1
BL	_Lcd_Out+0
;inkubator_func.c,144 :: 		sprintf(Data_Str,"%-2.1f %%",parameters_t.set_humidity);
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_20_inkubator_func+0)
MOVT	R1, #hi_addr(?lstr_20_inkubator_func+0)
MOVW	R0, #lo_addr(_Data_Str+0)
MOVT	R0, #hi_addr(_Data_Str+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;inkubator_func.c,145 :: 		Lcd_Out(2,6,Data_Str);
MOVW	R2, #lo_addr(_Data_Str+0)
MOVT	R2, #hi_addr(_Data_Str+0)
MOVS	R1, #6
MOVS	R0, #2
BL	_Lcd_Out+0
;inkubator_func.c,146 :: 		key_value=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
;inkubator_func.c,147 :: 		while(kp==0)
L_set_humidity25:
LDRB	R0, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_set_humidity26
;inkubator_func.c,149 :: 		if(flag_t.status_in_menu==RESET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_set_humidity27
;inkubator_func.c,151 :: 		key_value=key_back;
MOVS	R1, #4
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
;inkubator_func.c,152 :: 		}
L_set_humidity27:
;inkubator_func.c,153 :: 		switch(key_value)
IT	AL
BAL	L_set_humidity28
;inkubator_func.c,155 :: 		case key_up:           key_value=0; parameters_t.set_humidity=parameters_t.set_humidity+10.0;
L_set_humidity30:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S1, [R0, #0]
VMOV.F32	S0, #10
VADD.F32	S1, S1, S0
VSTR	#1, S1, [R0, #0]
;inkubator_func.c,156 :: 		if(parameters_t.set_humidity>=90.0)
MOVW	R0, #0
MOVT	R0, #17076
VMOV	S0, R0
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	LT
BLT	L_set_humidity31
;inkubator_func.c,158 :: 		parameters_t.set_humidity=90.0;
MOVW	R0, #0
MOVT	R0, #17076
VMOV	S0, R0
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,159 :: 		}
L_set_humidity31:
;inkubator_func.c,160 :: 		sprintf(Data_Str,"%-2.1f %%",parameters_t.set_humidity);
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_21_inkubator_func+0)
MOVT	R1, #hi_addr(?lstr_21_inkubator_func+0)
MOVW	R0, #lo_addr(_Data_Str+0)
MOVT	R0, #hi_addr(_Data_Str+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;inkubator_func.c,161 :: 		Lcd_Out(2,6,Data_Str); break;
MOVW	R2, #lo_addr(_Data_Str+0)
MOVT	R2, #hi_addr(_Data_Str+0)
MOVS	R1, #6
MOVS	R0, #2
BL	_Lcd_Out+0
IT	AL
BAL	L_set_humidity29
;inkubator_func.c,163 :: 		case key_down:            key_value=0;parameters_t.set_humidity=parameters_t.set_humidity-10.0;
L_set_humidity32:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S1, [R0, #0]
VMOV.F32	S0, #10
VSUB.F32	S1, S1, S0
VSTR	#1, S1, [R0, #0]
;inkubator_func.c,164 :: 		if(parameters_t.set_humidity<=10.0)
VMOV.F32	S0, #10
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	GT
BGT	L_set_humidity33
;inkubator_func.c,166 :: 		parameters_t.set_humidity=10.0;
VMOV.F32	S0, #10
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,167 :: 		}
L_set_humidity33:
;inkubator_func.c,168 :: 		sprintf(Data_Str,"%-2.1f %%",parameters_t.set_humidity);
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_22_inkubator_func+0)
MOVT	R1, #hi_addr(?lstr_22_inkubator_func+0)
MOVW	R0, #lo_addr(_Data_Str+0)
MOVT	R0, #hi_addr(_Data_Str+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;inkubator_func.c,169 :: 		Lcd_Out(2,6,Data_Str); break;
MOVW	R2, #lo_addr(_Data_Str+0)
MOVT	R2, #hi_addr(_Data_Str+0)
MOVS	R1, #6
MOVS	R0, #2
BL	_Lcd_Out+0
IT	AL
BAL	L_set_humidity29
;inkubator_func.c,170 :: 		case key_enter:           key_value=0;  go=1; kp=1; break;
L_set_humidity34:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVS	R0, #1
STRB	R0, [SP, #5]
MOVS	R0, #1
STRB	R0, [SP, #4]
IT	AL
BAL	L_set_humidity29
;inkubator_func.c,171 :: 		case key_back:           key_value=0;kp=1; Lcd_Cmd(_LCD_CLEAR);               // Clear display
L_set_humidity35:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVS	R0, #1
STRB	R0, [SP, #4]
MOVS	R0, #1
BL	_Lcd_Cmd+0
;inkubator_func.c,172 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                break;
MOVS	R0, #12
BL	_Lcd_Cmd+0
IT	AL
BAL	L_set_humidity29
;inkubator_func.c,173 :: 		}
L_set_humidity28:
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_set_humidity30
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_set_humidity32
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_set_humidity34
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_set_humidity35
L_set_humidity29:
;inkubator_func.c,175 :: 		}
IT	AL
BAL	L_set_humidity25
L_set_humidity26:
;inkubator_func.c,176 :: 		if(go==SET)  set_temperature_gist();
LDRB	R0, [SP, #5]
CMP	R0, #1
IT	NE
BNE	L_set_humidity36
BL	_set_temperature_gist+0
L_set_humidity36:
;inkubator_func.c,177 :: 		}
L_end_set_humidity:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _set_humidity
_set_temperature_gist:
;inkubator_func.c,181 :: 		void set_temperature_gist()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;inkubator_func.c,183 :: 		char kp=0;
MOVS	R0, #0
STRB	R0, [SP, #4]
MOVS	R0, #0
STRB	R0, [SP, #5]
;inkubator_func.c,184 :: 		char go=0;
;inkubator_func.c,185 :: 		unsigned char key_code=0;
;inkubator_func.c,186 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
MOVS	R0, #1
BL	_Lcd_Cmd+0
;inkubator_func.c,187 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
MOVS	R0, #12
BL	_Lcd_Cmd+0
;inkubator_func.c,188 :: 		Lcd_Out(1,1,"TEMPERATURA GIST");
MOVW	R0, #lo_addr(?lstr23_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr23_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #1
MOVS	R0, #1
BL	_Lcd_Out+0
;inkubator_func.c,189 :: 		sprintf(Data_Str,"%-2.1f C",parameters_t.temperatura_delta__alarm_level);
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_24_inkubator_func+0)
MOVT	R1, #hi_addr(?lstr_24_inkubator_func+0)
MOVW	R0, #lo_addr(_Data_Str+0)
MOVT	R0, #hi_addr(_Data_Str+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;inkubator_func.c,190 :: 		Lcd_Out(2,6,Data_Str);
MOVW	R2, #lo_addr(_Data_Str+0)
MOVT	R2, #hi_addr(_Data_Str+0)
MOVS	R1, #6
MOVS	R0, #2
BL	_Lcd_Out+0
;inkubator_func.c,191 :: 		key_value=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
;inkubator_func.c,192 :: 		while(kp==0)
L_set_temperature_gist37:
LDRB	R0, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_set_temperature_gist38
;inkubator_func.c,194 :: 		if(flag_t.status_in_menu==RESET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_set_temperature_gist39
;inkubator_func.c,196 :: 		key_value=key_back;
MOVS	R1, #4
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
;inkubator_func.c,197 :: 		}
L_set_temperature_gist39:
;inkubator_func.c,198 :: 		switch(key_value)
IT	AL
BAL	L_set_temperature_gist40
;inkubator_func.c,200 :: 		case key_up:           key_value=0; parameters_t.temperatura_delta__alarm_level=parameters_t.temperatura_delta__alarm_level+1.0;
L_set_temperature_gist42:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
VMOV.F32	S0, #1
VADD.F32	S1, S1, S0
VSTR	#1, S1, [R0, #0]
;inkubator_func.c,201 :: 		if(parameters_t.temperatura_delta__alarm_level>=5.0)
VMOV.F32	S0, #5
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	LT
BLT	L_set_temperature_gist43
;inkubator_func.c,203 :: 		parameters_t.temperatura_delta__alarm_level=5.0;
VMOV.F32	S0, #5
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,204 :: 		}
L_set_temperature_gist43:
;inkubator_func.c,205 :: 		sprintf(Data_Str,"%-2.1f C",parameters_t.temperatura_delta__alarm_level);
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_25_inkubator_func+0)
MOVT	R1, #hi_addr(?lstr_25_inkubator_func+0)
MOVW	R0, #lo_addr(_Data_Str+0)
MOVT	R0, #hi_addr(_Data_Str+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;inkubator_func.c,206 :: 		Lcd_Out(2,6,Data_Str); break;
MOVW	R2, #lo_addr(_Data_Str+0)
MOVT	R2, #hi_addr(_Data_Str+0)
MOVS	R1, #6
MOVS	R0, #2
BL	_Lcd_Out+0
IT	AL
BAL	L_set_temperature_gist41
;inkubator_func.c,208 :: 		case key_down:            key_value=0;parameters_t.temperatura_delta__alarm_level=parameters_t.temperatura_delta__alarm_level-1.0;
L_set_temperature_gist44:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
VMOV.F32	S0, #1
VSUB.F32	S1, S1, S0
VSTR	#1, S1, [R0, #0]
;inkubator_func.c,209 :: 		if(parameters_t.temperatura_delta__alarm_level<=1.0)
VMOV.F32	S0, #1
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	GT
BGT	L_set_temperature_gist45
;inkubator_func.c,211 :: 		parameters_t.temperatura_delta__alarm_level=1.0;
VMOV.F32	S0, #1
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,212 :: 		}
L_set_temperature_gist45:
;inkubator_func.c,213 :: 		sprintf(Data_Str,"%-2.1f C",parameters_t.temperatura_delta__alarm_level);
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_26_inkubator_func+0)
MOVT	R1, #hi_addr(?lstr_26_inkubator_func+0)
MOVW	R0, #lo_addr(_Data_Str+0)
MOVT	R0, #hi_addr(_Data_Str+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;inkubator_func.c,214 :: 		Lcd_Out(2,6,Data_Str); break;
MOVW	R2, #lo_addr(_Data_Str+0)
MOVT	R2, #hi_addr(_Data_Str+0)
MOVS	R1, #6
MOVS	R0, #2
BL	_Lcd_Out+0
IT	AL
BAL	L_set_temperature_gist41
;inkubator_func.c,215 :: 		case key_enter:           key_value=0;  go=1; kp=1; break;
L_set_temperature_gist46:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVS	R0, #1
STRB	R0, [SP, #5]
MOVS	R0, #1
STRB	R0, [SP, #4]
IT	AL
BAL	L_set_temperature_gist41
;inkubator_func.c,216 :: 		case key_back:           key_value=0;kp=1;  Lcd_Cmd(_LCD_CLEAR);               // Clear display
L_set_temperature_gist47:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVS	R0, #1
STRB	R0, [SP, #4]
MOVS	R0, #1
BL	_Lcd_Cmd+0
;inkubator_func.c,217 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);               break;
MOVS	R0, #12
BL	_Lcd_Cmd+0
IT	AL
BAL	L_set_temperature_gist41
;inkubator_func.c,218 :: 		}
L_set_temperature_gist40:
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_set_temperature_gist42
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_set_temperature_gist44
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_set_temperature_gist46
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_set_temperature_gist47
L_set_temperature_gist41:
;inkubator_func.c,220 :: 		}
IT	AL
BAL	L_set_temperature_gist37
L_set_temperature_gist38:
;inkubator_func.c,221 :: 		if(go==SET)  set_humidity_gist();
LDRB	R0, [SP, #5]
CMP	R0, #1
IT	NE
BNE	L_set_temperature_gist48
BL	_set_humidity_gist+0
L_set_temperature_gist48:
;inkubator_func.c,222 :: 		}
L_end_set_temperature_gist:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _set_temperature_gist
_set_humidity_gist:
;inkubator_func.c,226 :: 		void set_humidity_gist()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;inkubator_func.c,228 :: 		char kp=0;
MOVS	R0, #0
STRB	R0, [SP, #4]
MOVS	R0, #0
STRB	R0, [SP, #5]
;inkubator_func.c,229 :: 		char go=0;
;inkubator_func.c,230 :: 		unsigned char key_code=0;
;inkubator_func.c,231 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
MOVS	R0, #1
BL	_Lcd_Cmd+0
;inkubator_func.c,232 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
MOVS	R0, #12
BL	_Lcd_Cmd+0
;inkubator_func.c,233 :: 		Lcd_Out(1,3,"VLAJNOST GIST");
MOVW	R0, #lo_addr(?lstr27_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr27_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #3
MOVS	R0, #1
BL	_Lcd_Out+0
;inkubator_func.c,234 :: 		sprintf(Data_Str,"%-2.1f %%",parameters_t.humidity_delta_alarm_level);
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_28_inkubator_func+0)
MOVT	R1, #hi_addr(?lstr_28_inkubator_func+0)
MOVW	R0, #lo_addr(_Data_Str+0)
MOVT	R0, #hi_addr(_Data_Str+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;inkubator_func.c,235 :: 		Lcd_Out(2,6,Data_Str);
MOVW	R2, #lo_addr(_Data_Str+0)
MOVT	R2, #hi_addr(_Data_Str+0)
MOVS	R1, #6
MOVS	R0, #2
BL	_Lcd_Out+0
;inkubator_func.c,236 :: 		key_value=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
;inkubator_func.c,237 :: 		while(kp==0)
L_set_humidity_gist49:
LDRB	R0, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_set_humidity_gist50
;inkubator_func.c,239 :: 		if(flag_t.status_in_menu==RESET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_set_humidity_gist51
;inkubator_func.c,241 :: 		key_value=key_back;
MOVS	R1, #4
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
;inkubator_func.c,242 :: 		}
L_set_humidity_gist51:
;inkubator_func.c,243 :: 		switch(key_value)
IT	AL
BAL	L_set_humidity_gist52
;inkubator_func.c,245 :: 		case key_up:           key_value=0; parameters_t.humidity_delta_alarm_level=parameters_t.humidity_delta_alarm_level+10.0;
L_set_humidity_gist54:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S1, [R0, #0]
VMOV.F32	S0, #10
VADD.F32	S1, S1, S0
VSTR	#1, S1, [R0, #0]
;inkubator_func.c,246 :: 		if(parameters_t.humidity_delta_alarm_level>=90.0)
MOVW	R0, #0
MOVT	R0, #17076
VMOV	S0, R0
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	LT
BLT	L_set_humidity_gist55
;inkubator_func.c,248 :: 		parameters_t.humidity_delta_alarm_level=90.0;
MOVW	R0, #0
MOVT	R0, #17076
VMOV	S0, R0
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,249 :: 		}
L_set_humidity_gist55:
;inkubator_func.c,250 :: 		sprintf(Data_Str,"%-2.1f %%",parameters_t.humidity_delta_alarm_level);
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_29_inkubator_func+0)
MOVT	R1, #hi_addr(?lstr_29_inkubator_func+0)
MOVW	R0, #lo_addr(_Data_Str+0)
MOVT	R0, #hi_addr(_Data_Str+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;inkubator_func.c,251 :: 		Lcd_Out(2,6,Data_Str); break;
MOVW	R2, #lo_addr(_Data_Str+0)
MOVT	R2, #hi_addr(_Data_Str+0)
MOVS	R1, #6
MOVS	R0, #2
BL	_Lcd_Out+0
IT	AL
BAL	L_set_humidity_gist53
;inkubator_func.c,253 :: 		case key_down:            key_value=0;parameters_t.humidity_delta_alarm_level=parameters_t.humidity_delta_alarm_level-10.0;
L_set_humidity_gist56:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S1, [R0, #0]
VMOV.F32	S0, #10
VSUB.F32	S1, S1, S0
VSTR	#1, S1, [R0, #0]
;inkubator_func.c,254 :: 		if(parameters_t.humidity_delta_alarm_level<=10.0)
VMOV.F32	S0, #10
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	GT
BGT	L_set_humidity_gist57
;inkubator_func.c,256 :: 		parameters_t.humidity_delta_alarm_level=10.0;
VMOV.F32	S0, #10
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,257 :: 		}
L_set_humidity_gist57:
;inkubator_func.c,258 :: 		sprintf(Data_Str,"%-2.1f %%",parameters_t.humidity_delta_alarm_level);
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_30_inkubator_func+0)
MOVT	R1, #hi_addr(?lstr_30_inkubator_func+0)
MOVW	R0, #lo_addr(_Data_Str+0)
MOVT	R0, #hi_addr(_Data_Str+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;inkubator_func.c,259 :: 		Lcd_Out(2,6,Data_Str); break;
MOVW	R2, #lo_addr(_Data_Str+0)
MOVT	R2, #hi_addr(_Data_Str+0)
MOVS	R1, #6
MOVS	R0, #2
BL	_Lcd_Out+0
IT	AL
BAL	L_set_humidity_gist53
;inkubator_func.c,260 :: 		case key_enter:           key_value=0;  go=1; kp=1; break;
L_set_humidity_gist58:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVS	R0, #1
STRB	R0, [SP, #5]
MOVS	R0, #1
STRB	R0, [SP, #4]
IT	AL
BAL	L_set_humidity_gist53
;inkubator_func.c,261 :: 		case key_back:           key_value=0;kp=1; Lcd_Cmd(_LCD_CLEAR);               // Clear display
L_set_humidity_gist59:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVS	R0, #1
STRB	R0, [SP, #4]
MOVS	R0, #1
BL	_Lcd_Cmd+0
;inkubator_func.c,262 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                break;
MOVS	R0, #12
BL	_Lcd_Cmd+0
IT	AL
BAL	L_set_humidity_gist53
;inkubator_func.c,263 :: 		}
L_set_humidity_gist52:
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_set_humidity_gist54
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_set_humidity_gist56
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_set_humidity_gist58
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_set_humidity_gist59
L_set_humidity_gist53:
;inkubator_func.c,265 :: 		}
IT	AL
BAL	L_set_humidity_gist49
L_set_humidity_gist50:
;inkubator_func.c,266 :: 		if(go==SET)  set_turn_time();
LDRB	R0, [SP, #5]
CMP	R0, #1
IT	NE
BNE	L_set_humidity_gist60
BL	_set_turn_time+0
L_set_humidity_gist60:
;inkubator_func.c,267 :: 		}
L_end_set_humidity_gist:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _set_humidity_gist
_set_turn_time:
;inkubator_func.c,270 :: 		void set_turn_time()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;inkubator_func.c,272 :: 		char kp=0;
MOVS	R0, #0
STRB	R0, [SP, #4]
MOVS	R0, #0
STRB	R0, [SP, #5]
;inkubator_func.c,273 :: 		char go=0;
;inkubator_func.c,274 :: 		unsigned char key_code=0;
;inkubator_func.c,275 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
MOVS	R0, #1
BL	_Lcd_Cmd+0
;inkubator_func.c,276 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
MOVS	R0, #12
BL	_Lcd_Cmd+0
;inkubator_func.c,277 :: 		Lcd_Out(1,6,"VREMYA");
MOVW	R0, #lo_addr(?lstr31_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr31_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #6
MOVS	R0, #1
BL	_Lcd_Out+0
;inkubator_func.c,278 :: 		sprintf(Data_Str,"%-3.1f min",parameters_t.set_turn_time);
MOVW	R0, #lo_addr(_parameters_t+8)
MOVT	R0, #hi_addr(_parameters_t+8)
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_32_inkubator_func+0)
MOVT	R1, #hi_addr(?lstr_32_inkubator_func+0)
MOVW	R0, #lo_addr(_Data_Str+0)
MOVT	R0, #hi_addr(_Data_Str+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;inkubator_func.c,279 :: 		Lcd_Out(2,5,Data_Str);
MOVW	R2, #lo_addr(_Data_Str+0)
MOVT	R2, #hi_addr(_Data_Str+0)
MOVS	R1, #5
MOVS	R0, #2
BL	_Lcd_Out+0
;inkubator_func.c,280 :: 		key_value=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
;inkubator_func.c,281 :: 		while(kp==0)
L_set_turn_time61:
LDRB	R0, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_set_turn_time62
;inkubator_func.c,283 :: 		if(flag_t.status_in_menu==RESET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_set_turn_time63
;inkubator_func.c,285 :: 		key_value=key_back;
MOVS	R1, #4
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
;inkubator_func.c,286 :: 		}
L_set_turn_time63:
;inkubator_func.c,287 :: 		switch(key_value)
IT	AL
BAL	L_set_turn_time64
;inkubator_func.c,289 :: 		case key_up:           key_value=0; parameters_t.set_turn_time=parameters_t.set_turn_time+10.0;
L_set_turn_time66:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+8)
MOVT	R0, #hi_addr(_parameters_t+8)
VLDR	#1, S1, [R0, #0]
VMOV.F32	S0, #10
VADD.F32	S1, S1, S0
VSTR	#1, S1, [R0, #0]
;inkubator_func.c,290 :: 		if(parameters_t.set_turn_time>=120.0)
MOVW	R0, #0
MOVT	R0, #17136
VMOV	S0, R0
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	LT
BLT	L_set_turn_time67
;inkubator_func.c,292 :: 		parameters_t.set_turn_time=120.0;
MOVW	R0, #0
MOVT	R0, #17136
VMOV	S0, R0
MOVW	R0, #lo_addr(_parameters_t+8)
MOVT	R0, #hi_addr(_parameters_t+8)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,293 :: 		}
L_set_turn_time67:
;inkubator_func.c,294 :: 		sprintf(Data_Str,"%-3.1f min  ",parameters_t.set_turn_time);
MOVW	R0, #lo_addr(_parameters_t+8)
MOVT	R0, #hi_addr(_parameters_t+8)
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_33_inkubator_func+0)
MOVT	R1, #hi_addr(?lstr_33_inkubator_func+0)
MOVW	R0, #lo_addr(_Data_Str+0)
MOVT	R0, #hi_addr(_Data_Str+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;inkubator_func.c,295 :: 		Lcd_Out(2,5,Data_Str); break;
MOVW	R2, #lo_addr(_Data_Str+0)
MOVT	R2, #hi_addr(_Data_Str+0)
MOVS	R1, #5
MOVS	R0, #2
BL	_Lcd_Out+0
IT	AL
BAL	L_set_turn_time65
;inkubator_func.c,297 :: 		case key_down:            key_value=0;parameters_t.set_turn_time=parameters_t.set_turn_time-10.0;
L_set_turn_time68:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_parameters_t+8)
MOVT	R0, #hi_addr(_parameters_t+8)
VLDR	#1, S1, [R0, #0]
VMOV.F32	S0, #10
VSUB.F32	S1, S1, S0
VSTR	#1, S1, [R0, #0]
;inkubator_func.c,298 :: 		if(parameters_t.set_turn_time<=10.0)
VMOV.F32	S0, #10
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	GT
BGT	L_set_turn_time69
;inkubator_func.c,300 :: 		parameters_t.set_turn_time=10.0;
VMOV.F32	S0, #10
MOVW	R0, #lo_addr(_parameters_t+8)
MOVT	R0, #hi_addr(_parameters_t+8)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,301 :: 		}
L_set_turn_time69:
;inkubator_func.c,302 :: 		sprintf(Data_Str,"%-3.1f min  ",parameters_t.set_turn_time);
MOVW	R0, #lo_addr(_parameters_t+8)
MOVT	R0, #hi_addr(_parameters_t+8)
VLDR	#1, S0, [R0, #0]
MOVW	R1, #lo_addr(?lstr_34_inkubator_func+0)
MOVT	R1, #hi_addr(?lstr_34_inkubator_func+0)
MOVW	R0, #lo_addr(_Data_Str+0)
MOVT	R0, #hi_addr(_Data_Str+0)
VPUSH	#0, (S0)
PUSH	(R1)
PUSH	(R0)
BL	_sprintf+0
ADD	SP, SP, #12
;inkubator_func.c,303 :: 		Lcd_Out(2,5,Data_Str); break;
MOVW	R2, #lo_addr(_Data_Str+0)
MOVT	R2, #hi_addr(_Data_Str+0)
MOVS	R1, #5
MOVS	R0, #2
BL	_Lcd_Out+0
IT	AL
BAL	L_set_turn_time65
;inkubator_func.c,304 :: 		case key_enter:           key_value=0;  go=1; kp=1; break;
L_set_turn_time70:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVS	R0, #1
STRB	R0, [SP, #5]
MOVS	R0, #1
STRB	R0, [SP, #4]
IT	AL
BAL	L_set_turn_time65
;inkubator_func.c,305 :: 		case key_back:           key_value=0;kp=1; Lcd_Cmd(_LCD_CLEAR);               // Clear display
L_set_turn_time71:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVS	R0, #1
STRB	R0, [SP, #4]
MOVS	R0, #1
BL	_Lcd_Cmd+0
;inkubator_func.c,306 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                break;
MOVS	R0, #12
BL	_Lcd_Cmd+0
IT	AL
BAL	L_set_turn_time65
;inkubator_func.c,307 :: 		}
L_set_turn_time64:
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_set_turn_time66
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_set_turn_time68
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_set_turn_time70
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_set_turn_time71
L_set_turn_time65:
;inkubator_func.c,309 :: 		}
IT	AL
BAL	L_set_turn_time61
L_set_turn_time62:
;inkubator_func.c,310 :: 		if(go==SET) set_humidity_control();
LDRB	R0, [SP, #5]
CMP	R0, #1
IT	NE
BNE	L_set_turn_time72
BL	_set_humidity_control+0
L_set_turn_time72:
;inkubator_func.c,311 :: 		}
L_end_set_turn_time:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _set_turn_time
_set_humidity_control:
;inkubator_func.c,313 :: 		void set_humidity_control()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;inkubator_func.c,315 :: 		char kp=0;
; kp start address is: 32 (R8)
MOVW	R8, #0
;inkubator_func.c,316 :: 		char go=0;
; go start address is: 24 (R6)
MOVS	R6, #0
;inkubator_func.c,317 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
MOVS	R0, #1
BL	_Lcd_Cmd+0
;inkubator_func.c,318 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
MOVS	R0, #12
BL	_Lcd_Cmd+0
;inkubator_func.c,319 :: 		Lcd_Out(1,3,"CTRL VLAJNOSTY");
MOVW	R0, #lo_addr(?lstr35_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr35_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #3
MOVS	R0, #1
BL	_Lcd_Out+0
;inkubator_func.c,320 :: 		if(parameters_t.control_humidity==0.0)
MOVW	R0, #lo_addr(_parameters_t+20)
MOVT	R0, #hi_addr(_parameters_t+20)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, #0
VMRS	#60, FPSCR
IT	NE
BNE	L_set_humidity_control73
;inkubator_func.c,322 :: 		flag_t.control_humidity=RESET;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;inkubator_func.c,323 :: 		Lcd_Out(2,7,"NET.  ");
MOVW	R0, #lo_addr(?lstr36_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr36_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #7
MOVS	R0, #2
BL	_Lcd_Out+0
;inkubator_func.c,324 :: 		}
L_set_humidity_control73:
;inkubator_func.c,325 :: 		if(parameters_t.control_humidity==1.0)
MOVW	R0, #lo_addr(_parameters_t+20)
MOVT	R0, #hi_addr(_parameters_t+20)
VLDR	#1, S1, [R0, #0]
VMOV.F32	S0, #1
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	NE
BNE	L_set_humidity_control74
;inkubator_func.c,327 :: 		flag_t.control_humidity=SET;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;inkubator_func.c,328 :: 		Lcd_Out(2,7,"DA .  ");
MOVW	R0, #lo_addr(?lstr37_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr37_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #7
MOVS	R0, #2
BL	_Lcd_Out+0
;inkubator_func.c,329 :: 		}
L_set_humidity_control74:
;inkubator_func.c,330 :: 		key_value=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
; kp end address is: 32 (R8)
; go end address is: 24 (R6)
;inkubator_func.c,331 :: 		while(kp==0)
L_set_humidity_control75:
; go start address is: 24 (R6)
; kp start address is: 32 (R8)
CMP	R8, #0
IT	NE
BNE	L_set_humidity_control76
;inkubator_func.c,333 :: 		if(flag_t.status_in_menu==RESET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_set_humidity_control77
;inkubator_func.c,335 :: 		key_value=key_back;
MOVS	R1, #4
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
;inkubator_func.c,336 :: 		}
L_set_humidity_control77:
;inkubator_func.c,337 :: 		switch(key_value)
IT	AL
BAL	L_set_humidity_control78
;inkubator_func.c,339 :: 		case key_up:          key_value=0; Lcd_Out(2,7,"DA .  "); flag_t.control_humidity=SET;parameters_t.control_humidity=1.0;     break;
L_set_humidity_control80:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVW	R0, #lo_addr(?lstr38_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr38_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #7
MOVS	R0, #2
BL	_Lcd_Out+0
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
VMOV.F32	S0, #1
MOVW	R0, #lo_addr(_parameters_t+20)
MOVT	R0, #hi_addr(_parameters_t+20)
VSTR	#1, S0, [R0, #0]
IT	AL
BAL	L_set_humidity_control79
;inkubator_func.c,340 :: 		case key_down:        key_value=0; Lcd_Out(2,7,"NET.  ");  flag_t.control_humidity=RESET; parameters_t.control_humidity=0.0; break;
L_set_humidity_control81:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVW	R0, #lo_addr(?lstr39_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr39_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #7
MOVS	R0, #2
BL	_Lcd_Out+0
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
MOV	R0, #0
VMOV	S0, R0
MOVW	R0, #lo_addr(_parameters_t+20)
MOVT	R0, #hi_addr(_parameters_t+20)
VSTR	#1, S0, [R0, #0]
; kp end address is: 32 (R8)
; go end address is: 24 (R6)
IT	AL
BAL	L_set_humidity_control79
;inkubator_func.c,341 :: 		case key_enter:       key_value=0;go=1;kp=1;                                                                               break;
L_set_humidity_control82:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
; go start address is: 0 (R0)
MOVS	R0, #1
; kp start address is: 4 (R1)
MOVS	R1, #1
UXTB	R6, R0
; go end address is: 0 (R0)
; kp end address is: 4 (R1)
UXTB	R8, R1
IT	AL
BAL	L_set_humidity_control79
;inkubator_func.c,342 :: 		case key_back:        key_value=0;kp=1;    Lcd_Cmd(_LCD_CLEAR);
L_set_humidity_control83:
; go start address is: 24 (R6)
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
; kp start address is: 12 (R3)
MOVS	R3, #1
MOVS	R0, #1
BL	_Lcd_Cmd+0
;inkubator_func.c,343 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                                                       break;
MOVS	R0, #12
BL	_Lcd_Cmd+0
; kp end address is: 12 (R3)
UXTB	R8, R3
IT	AL
BAL	L_set_humidity_control79
;inkubator_func.c,344 :: 		}
L_set_humidity_control78:
; kp start address is: 32 (R8)
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_set_humidity_control80
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_set_humidity_control81
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_set_humidity_control82
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_set_humidity_control83
; kp end address is: 32 (R8)
; go end address is: 24 (R6)
L_set_humidity_control79:
;inkubator_func.c,345 :: 		}
; kp start address is: 32 (R8)
; go start address is: 24 (R6)
; kp end address is: 32 (R8)
IT	AL
BAL	L_set_humidity_control75
L_set_humidity_control76:
;inkubator_func.c,346 :: 		if(go==SET) save_data();
CMP	R6, #1
IT	NE
BNE	L_set_humidity_control84
; go end address is: 24 (R6)
BL	_save_data+0
L_set_humidity_control84:
;inkubator_func.c,347 :: 		}
L_end_set_humidity_control:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _set_humidity_control
_save_data_exit:
;inkubator_func.c,349 :: 		void save_data_exit()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;inkubator_func.c,351 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
MOVS	R0, #1
BL	_Lcd_Cmd+0
;inkubator_func.c,352 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
MOVS	R0, #12
BL	_Lcd_Cmd+0
;inkubator_func.c,353 :: 		save_data_to_eeprom();
BL	_save_data_to_eeprom+0
;inkubator_func.c,354 :: 		Delay_ms(1000);
MOVW	R7, #13823
MOVT	R7, #366
NOP
NOP
L_save_data_exit85:
SUBS	R7, R7, #1
BNE	L_save_data_exit85
NOP
NOP
;inkubator_func.c,355 :: 		Lcd_Out(1,6,"DANYE");
MOVW	R0, #lo_addr(?lstr40_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr40_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #6
MOVS	R0, #1
BL	_Lcd_Out+0
;inkubator_func.c,356 :: 		Lcd_Out(2,5,"ZAPISANY");
MOVW	R0, #lo_addr(?lstr41_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr41_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #5
MOVS	R0, #2
BL	_Lcd_Out+0
;inkubator_func.c,357 :: 		Delay_ms(1000);
MOVW	R7, #13823
MOVT	R7, #366
NOP
NOP
L_save_data_exit87:
SUBS	R7, R7, #1
BNE	L_save_data_exit87
NOP
NOP
;inkubator_func.c,358 :: 		Lcd_Cmd(_LCD_CLEAR);
MOVS	R0, #1
BL	_Lcd_Cmd+0
;inkubator_func.c,359 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
MOVS	R0, #12
BL	_Lcd_Cmd+0
;inkubator_func.c,360 :: 		}
L_end_save_data_exit:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _save_data_exit
_save_data:
;inkubator_func.c,362 :: 		void save_data()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;inkubator_func.c,364 :: 		char kp=0;
; kp start address is: 24 (R6)
MOVS	R6, #0
;inkubator_func.c,365 :: 		char go=0;
; go start address is: 32 (R8)
MOVW	R8, #0
;inkubator_func.c,366 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
MOVS	R0, #1
BL	_Lcd_Cmd+0
;inkubator_func.c,367 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
MOVS	R0, #12
BL	_Lcd_Cmd+0
;inkubator_func.c,368 :: 		Lcd_Out(1,3,"ZAPIS DANYH");
MOVW	R0, #lo_addr(?lstr42_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr42_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #3
MOVS	R0, #1
BL	_Lcd_Out+0
;inkubator_func.c,369 :: 		Lcd_Out(2,7,"NET.  ");
MOVW	R0, #lo_addr(?lstr43_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr43_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #7
MOVS	R0, #2
BL	_Lcd_Out+0
;inkubator_func.c,370 :: 		flag_t.data_save=RESET;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;inkubator_func.c,371 :: 		key_value=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
; kp end address is: 24 (R6)
; go end address is: 32 (R8)
;inkubator_func.c,372 :: 		while(kp==0)
L_save_data89:
; go start address is: 32 (R8)
; kp start address is: 24 (R6)
CMP	R6, #0
IT	NE
BNE	L_save_data90
;inkubator_func.c,374 :: 		if(flag_t.status_in_menu==RESET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_save_data91
;inkubator_func.c,376 :: 		key_value=key_back;
MOVS	R1, #4
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
;inkubator_func.c,377 :: 		}
L_save_data91:
;inkubator_func.c,378 :: 		switch(key_value)
IT	AL
BAL	L_save_data92
;inkubator_func.c,380 :: 		case key_up:          key_value=0; Lcd_Out(2,7,"DA .  "); flag_t.data_save=SET;                      break;
L_save_data94:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVW	R0, #lo_addr(?lstr44_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr44_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #7
MOVS	R0, #2
BL	_Lcd_Out+0
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_save_data93
;inkubator_func.c,381 :: 		case key_down:        key_value=0; Lcd_Out(2,7,"NET.  ");  flag_t.data_save=RESET;                   break;
L_save_data95:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVW	R0, #lo_addr(?lstr45_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr45_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #7
MOVS	R0, #2
BL	_Lcd_Out+0
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
; kp end address is: 24 (R6)
; go end address is: 32 (R8)
IT	AL
BAL	L_save_data93
;inkubator_func.c,382 :: 		case key_enter:       key_value=0;go=1;kp=1;                                                       break;
L_save_data96:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
; go start address is: 0 (R0)
MOVS	R0, #1
; kp start address is: 4 (R1)
MOVS	R1, #1
UXTB	R8, R0
; go end address is: 0 (R0)
; kp end address is: 4 (R1)
UXTB	R6, R1
IT	AL
BAL	L_save_data93
;inkubator_func.c,383 :: 		case key_back:        key_value=0;kp=1;    Lcd_Cmd(_LCD_CLEAR);
L_save_data97:
; go start address is: 32 (R8)
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
; kp start address is: 12 (R3)
MOVS	R3, #1
MOVS	R0, #1
BL	_Lcd_Cmd+0
;inkubator_func.c,384 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                               break;
MOVS	R0, #12
BL	_Lcd_Cmd+0
; kp end address is: 12 (R3)
UXTB	R6, R3
IT	AL
BAL	L_save_data93
;inkubator_func.c,385 :: 		}
L_save_data92:
; kp start address is: 24 (R6)
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_save_data94
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_save_data95
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_save_data96
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_save_data97
; kp end address is: 24 (R6)
; go end address is: 32 (R8)
L_save_data93:
;inkubator_func.c,386 :: 		}
; kp start address is: 24 (R6)
; go start address is: 32 (R8)
; kp end address is: 24 (R6)
IT	AL
BAL	L_save_data89
L_save_data90:
;inkubator_func.c,387 :: 		if(flag_t.data_save==SET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_save_data98
;inkubator_func.c,389 :: 		save_data_exit();
BL	_save_data_exit+0
;inkubator_func.c,390 :: 		}
L_save_data98:
;inkubator_func.c,391 :: 		if(go==SET) set_errors();
CMP	R8, #1
IT	NE
BNE	L_save_data99
; go end address is: 32 (R8)
BL	_set_errors+0
L_save_data99:
;inkubator_func.c,392 :: 		}
L_end_save_data:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _save_data
_save_data_to_eeprom:
;inkubator_func.c,395 :: 		char save_data_to_eeprom()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;inkubator_func.c,397 :: 		char position=0;
;inkubator_func.c,398 :: 		unsigned long temp=0,adress=0;
; temp start address is: 8 (R2)
MOV	R2, #0
;inkubator_func.c,400 :: 		for(position=0;position<DATA_SIZE;position++)
; position start address is: 12 (R3)
MOVS	R3, #0
; temp end address is: 8 (R2)
; position end address is: 12 (R3)
L_save_data_to_eeprom100:
; position start address is: 12 (R3)
; temp start address is: 8 (R2)
CMP	R3, #10
IT	CS
BCS	L_save_data_to_eeprom101
;inkubator_func.c,402 :: 		ee_data[position]=0;
LSLS	R1, R3, #2
MOVW	R0, #lo_addr(_ee_data+0)
MOVT	R0, #hi_addr(_ee_data+0)
ADDS	R1, R0, R1
MOVS	R0, #0
STR	R0, [R1, #0]
;inkubator_func.c,400 :: 		for(position=0;position<DATA_SIZE;position++)
ADDS	R3, R3, #1
UXTB	R3, R3
;inkubator_func.c,403 :: 		}
; position end address is: 12 (R3)
IT	AL
BAL	L_save_data_to_eeprom100
L_save_data_to_eeprom101:
;inkubator_func.c,404 :: 		ee_data[0]=(unsigned long)(parameters_t.set_temperatura*100.0);
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VMUL.F32	S0, S1, S0
VCVT	#1, .F32, S0, S0
VMOV	R1, S0
MOVW	R0, #lo_addr(_ee_data+0)
MOVT	R0, #hi_addr(_ee_data+0)
STR	R1, [R0, #0]
;inkubator_func.c,405 :: 		ee_data[1]=(unsigned long)(parameters_t.set_humidity*100.0);
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VMUL.F32	S0, S1, S0
VCVT	#1, .F32, S0, S0
VMOV	R1, S0
MOVW	R0, #lo_addr(_ee_data+4)
MOVT	R0, #hi_addr(_ee_data+4)
STR	R1, [R0, #0]
;inkubator_func.c,406 :: 		ee_data[2]=(unsigned long)(parameters_t.set_turn_time*100.0);
MOVW	R0, #lo_addr(_parameters_t+8)
MOVT	R0, #hi_addr(_parameters_t+8)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VMUL.F32	S0, S1, S0
VCVT	#1, .F32, S0, S0
VMOV	R1, S0
MOVW	R0, #lo_addr(_ee_data+8)
MOVT	R0, #hi_addr(_ee_data+8)
STR	R1, [R0, #0]
;inkubator_func.c,407 :: 		ee_data[3]=(unsigned long)(parameters_t.temperatura_delta__alarm_level*100.0);
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VMUL.F32	S0, S1, S0
VCVT	#1, .F32, S0, S0
VMOV	R1, S0
MOVW	R0, #lo_addr(_ee_data+12)
MOVT	R0, #hi_addr(_ee_data+12)
STR	R1, [R0, #0]
;inkubator_func.c,408 :: 		ee_data[4]=(unsigned long)(parameters_t.humidity_delta_alarm_level*100.0);
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VMUL.F32	S0, S1, S0
VCVT	#1, .F32, S0, S0
VMOV	R1, S0
MOVW	R0, #lo_addr(_ee_data+16)
MOVT	R0, #hi_addr(_ee_data+16)
STR	R1, [R0, #0]
;inkubator_func.c,409 :: 		ee_data[5]=(unsigned long)(parameters_t.control_humidity*100.0);
MOVW	R0, #lo_addr(_parameters_t+20)
MOVT	R0, #hi_addr(_parameters_t+20)
VLDR	#1, S1, [R0, #0]
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VMUL.F32	S0, S1, S0
VCVT	#1, .F32, S0, S0
VMOV	R1, S0
MOVW	R0, #lo_addr(_ee_data+20)
MOVT	R0, #hi_addr(_ee_data+20)
STR	R1, [R0, #0]
;inkubator_func.c,410 :: 		ee_data[6]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ee_data+24)
MOVT	R0, #hi_addr(_ee_data+24)
STR	R1, [R0, #0]
;inkubator_func.c,411 :: 		ee_data[7]=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ee_data+28)
MOVT	R0, #hi_addr(_ee_data+28)
STR	R1, [R0, #0]
;inkubator_func.c,412 :: 		for(position=0;position<8;position++)
; position start address is: 0 (R0)
MOVS	R0, #0
; temp end address is: 8 (R2)
; position end address is: 0 (R0)
MOV	R7, R2
UXTB	R2, R0
L_save_data_to_eeprom103:
; position start address is: 8 (R2)
; temp start address is: 28 (R7)
CMP	R2, #8
IT	CS
BCS	L_save_data_to_eeprom104
;inkubator_func.c,414 :: 		temp+=ee_data[position];
LSLS	R1, R2, #2
MOVW	R0, #lo_addr(_ee_data+0)
MOVT	R0, #hi_addr(_ee_data+0)
ADDS	R0, R0, R1
LDR	R0, [R0, #0]
ADDS	R7, R7, R0
;inkubator_func.c,412 :: 		for(position=0;position<8;position++)
ADDS	R2, R2, #1
UXTB	R2, R2
;inkubator_func.c,415 :: 		}
; position end address is: 8 (R2)
IT	AL
BAL	L_save_data_to_eeprom103
L_save_data_to_eeprom104:
;inkubator_func.c,416 :: 		ee_data[8]=temp;
MOVW	R0, #lo_addr(_ee_data+32)
MOVT	R0, #hi_addr(_ee_data+32)
STR	R7, [R0, #0]
; temp end address is: 28 (R7)
;inkubator_func.c,417 :: 		DisableInterrupts();
BL	_DisableInterrupts+0
;inkubator_func.c,419 :: 		EEPROM_MassErase();
BL	_EEPROM_MassErase+0
;inkubator_func.c,420 :: 		EEPROM_Program(ee_data, START_ADDRESS, BLOCK_SIZE);
MOVS	R2, #64
MOVS	R1, #0
MOVW	R0, #lo_addr(_ee_data+0)
MOVT	R0, #hi_addr(_ee_data+0)
BL	_EEPROM_Program+0
;inkubator_func.c,421 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;inkubator_func.c,422 :: 		return read_data_in_eeprom();
BL	_read_data_in_eeprom+0
;inkubator_func.c,423 :: 		}
L_end_save_data_to_eeprom:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _save_data_to_eeprom
_read_data_in_eeprom:
;inkubator_func.c,426 :: 		char read_data_in_eeprom()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;inkubator_func.c,428 :: 		unsigned long temp=0,temp1=0;
; temp1 start address is: 24 (R6)
MOV	R6, #0
;inkubator_func.c,429 :: 		char position=0;
;inkubator_func.c,430 :: 		DisableInterrupts();
BL	_DisableInterrupts+0
;inkubator_func.c,431 :: 		for(position=0;position<DATA_SIZE;position++)
; position start address is: 8 (R2)
MOVS	R2, #0
; temp1 end address is: 24 (R6)
; position end address is: 8 (R2)
L_read_data_in_eeprom106:
; position start address is: 8 (R2)
; temp1 start address is: 24 (R6)
CMP	R2, #10
IT	CS
BCS	L_read_data_in_eeprom107
;inkubator_func.c,433 :: 		ee_data[position]=0;
LSLS	R1, R2, #2
MOVW	R0, #lo_addr(_ee_data+0)
MOVT	R0, #hi_addr(_ee_data+0)
ADDS	R1, R0, R1
MOVS	R0, #0
STR	R0, [R1, #0]
;inkubator_func.c,431 :: 		for(position=0;position<DATA_SIZE;position++)
ADDS	R2, R2, #1
UXTB	R2, R2
;inkubator_func.c,434 :: 		}
; position end address is: 8 (R2)
IT	AL
BAL	L_read_data_in_eeprom106
L_read_data_in_eeprom107:
;inkubator_func.c,437 :: 		EEPROM_Read(ee_Data, START_ADDRESS, BLOCK_SIZE);
MOVS	R2, #64
MOVS	R1, #0
MOVW	R0, #lo_addr(_ee_data+0)
MOVT	R0, #hi_addr(_ee_data+0)
BL	_EEPROM_Read+0
;inkubator_func.c,438 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;inkubator_func.c,439 :: 		for(position=0;position<8;position++)
; position start address is: 8 (R2)
MOVS	R2, #0
; temp1 end address is: 24 (R6)
; position end address is: 8 (R2)
MOV	R3, R6
L_read_data_in_eeprom109:
; position start address is: 8 (R2)
; temp1 start address is: 12 (R3)
CMP	R2, #8
IT	CS
BCS	L_read_data_in_eeprom110
;inkubator_func.c,441 :: 		temp1+=ee_data[position];
LSLS	R1, R2, #2
MOVW	R0, #lo_addr(_ee_data+0)
MOVT	R0, #hi_addr(_ee_data+0)
ADDS	R0, R0, R1
LDR	R0, [R0, #0]
ADDS	R3, R3, R0
;inkubator_func.c,439 :: 		for(position=0;position<8;position++)
ADDS	R2, R2, #1
UXTB	R2, R2
;inkubator_func.c,442 :: 		}
; position end address is: 8 (R2)
IT	AL
BAL	L_read_data_in_eeprom109
L_read_data_in_eeprom110:
;inkubator_func.c,443 :: 		temp=ee_data[8];
MOVW	R0, #lo_addr(_ee_data+32)
MOVT	R0, #hi_addr(_ee_data+32)
; temp start address is: 4 (R1)
LDR	R1, [R0, #0]
;inkubator_func.c,445 :: 		if(temp==temp1)
LDR	R0, [R0, #0]
CMP	R0, R3
IT	NE
BNE	L_read_data_in_eeprom112
; temp1 end address is: 12 (R3)
; temp end address is: 4 (R1)
;inkubator_func.c,447 :: 		parameters_t.set_temperatura=                                             (float)((float)ee_data[0]/100.0);
MOVW	R0, #lo_addr(_ee_data+0)
MOVT	R0, #hi_addr(_ee_data+0)
VLDR	#1, S0, [R0, #0]
VCVT.F32	#0, S1, S0
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VDIV.F32	S0, S1, S0
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,448 :: 		parameters_t.set_humidity=                                                (float)((float)ee_data[1]/100.0);
MOVW	R0, #lo_addr(_ee_data+4)
MOVT	R0, #hi_addr(_ee_data+4)
VLDR	#1, S0, [R0, #0]
VCVT.F32	#0, S1, S0
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VDIV.F32	S0, S1, S0
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,449 :: 		parameters_t.set_turn_time=                                               (float)((float)ee_data[2]/100.0);
MOVW	R0, #lo_addr(_ee_data+8)
MOVT	R0, #hi_addr(_ee_data+8)
VLDR	#1, S0, [R0, #0]
VCVT.F32	#0, S1, S0
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VDIV.F32	S0, S1, S0
MOVW	R0, #lo_addr(_parameters_t+8)
MOVT	R0, #hi_addr(_parameters_t+8)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,450 :: 		parameters_t.temperatura_delta__alarm_level=                              (float)((float)ee_data[3]/100.0);
MOVW	R0, #lo_addr(_ee_data+12)
MOVT	R0, #hi_addr(_ee_data+12)
VLDR	#1, S0, [R0, #0]
VCVT.F32	#0, S1, S0
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VDIV.F32	S0, S1, S0
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,451 :: 		parameters_t.humidity_delta_alarm_level=                                  (float)((float)ee_data[4]/100.0);
MOVW	R0, #lo_addr(_ee_data+16)
MOVT	R0, #hi_addr(_ee_data+16)
VLDR	#1, S0, [R0, #0]
VCVT.F32	#0, S1, S0
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VDIV.F32	S0, S1, S0
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,452 :: 		parameters_t.control_humidity=                                            (float)((float)ee_data[5]/100.0);
MOVW	R0, #lo_addr(_ee_data+20)
MOVT	R0, #hi_addr(_ee_data+20)
VLDR	#1, S0, [R0, #0]
VCVT.F32	#0, S1, S0
MOVW	R0, #0
MOVT	R0, #17096
VMOV	S0, R0
VDIV.F32	S0, S1, S0
MOVW	R0, #lo_addr(_parameters_t+20)
MOVT	R0, #hi_addr(_parameters_t+20)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,455 :: 		return 0;
MOVS	R0, #0
IT	AL
BAL	L_end_read_data_in_eeprom
;inkubator_func.c,456 :: 		}
L_read_data_in_eeprom112:
;inkubator_func.c,457 :: 		if(temp!=temp1)
; temp start address is: 4 (R1)
; temp1 start address is: 12 (R3)
CMP	R1, R3
IT	EQ
BEQ	L_read_data_in_eeprom113
; temp1 end address is: 12 (R3)
; temp end address is: 4 (R1)
;inkubator_func.c,459 :: 		return 1;
MOVS	R0, #1
IT	AL
BAL	L_end_read_data_in_eeprom
;inkubator_func.c,460 :: 		}
L_read_data_in_eeprom113:
;inkubator_func.c,461 :: 		}
L_end_read_data_in_eeprom:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _read_data_in_eeprom
_read_key:
;inkubator_func.c,463 :: 		void read_key()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;inkubator_func.c,466 :: 		if(PIN_UP==RESET||PIN_DOWN==RESET||PIN_ENTER==RESET||PIN_BACK==RESET)
MOVW	R1, #lo_addr(PIN_UP+0)
MOVT	R1, #hi_addr(PIN_UP+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__read_key165
MOVW	R1, #lo_addr(PIN_DOWN+0)
MOVT	R1, #hi_addr(PIN_DOWN+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__read_key164
MOVW	R1, #lo_addr(PIN_ENTER+0)
MOVT	R1, #hi_addr(PIN_ENTER+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__read_key163
MOVW	R1, #lo_addr(PIN_BACK+0)
MOVT	R1, #hi_addr(PIN_BACK+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__read_key162
IT	AL
BAL	L_read_key116
L__read_key165:
L__read_key164:
L__read_key163:
L__read_key162:
;inkubator_func.c,468 :: 		count_key++;
MOVW	R1, #lo_addr(read_key_count_key_L0+0)
MOVT	R1, #hi_addr(read_key_count_key_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
;inkubator_func.c,469 :: 		if(count_key==10)
CMP	R0, #10
IT	NE
BNE	L_read_key117
;inkubator_func.c,471 :: 		count_key=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(read_key_count_key_L0+0)
MOVT	R0, #hi_addr(read_key_count_key_L0+0)
STRB	R1, [R0, #0]
;inkubator_func.c,472 :: 		if(PIN_UP==RESET||PIN_DOWN==RESET||PIN_ENTER==RESET||PIN_BACK==RESET)
MOVW	R1, #lo_addr(PIN_UP+0)
MOVT	R1, #hi_addr(PIN_UP+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__read_key169
MOVW	R1, #lo_addr(PIN_DOWN+0)
MOVT	R1, #hi_addr(PIN_DOWN+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__read_key168
MOVW	R1, #lo_addr(PIN_ENTER+0)
MOVT	R1, #hi_addr(PIN_ENTER+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__read_key167
MOVW	R1, #lo_addr(PIN_BACK+0)
MOVT	R1, #hi_addr(PIN_BACK+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__read_key166
IT	AL
BAL	L_read_key120
L__read_key169:
L__read_key168:
L__read_key167:
L__read_key166:
;inkubator_func.c,474 :: 		Beep();
BL	_Beep+0
;inkubator_func.c,475 :: 		key_value=key_code_pressed();
BL	_key_code_pressed+0
MOVW	R1, #lo_addr(_key_value+0)
MOVT	R1, #hi_addr(_key_value+0)
STRB	R0, [R1, #0]
;inkubator_func.c,477 :: 		}
L_read_key120:
;inkubator_func.c,478 :: 		}
L_read_key117:
;inkubator_func.c,479 :: 		}
L_read_key116:
;inkubator_func.c,480 :: 		}
L_end_read_key:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _read_key
_Beep:
;inkubator_func.c,482 :: 		void Beep()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;inkubator_func.c,484 :: 		Sound_Play(1000,100);
MOVS	R1, #100
MOVW	R0, #1000
BL	_Sound_Play+0
;inkubator_func.c,485 :: 		}
L_end_Beep:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Beep
_pid_Init:
;inkubator_func.c,497 :: 		void pid_Init(int16_t p_factor, int16_t i_factor, int16_t d_factor, struct PID_DATA *pid)
; pid start address is: 12 (R3)
; d_factor start address is: 8 (R2)
; i_factor start address is: 4 (R1)
; p_factor start address is: 0 (R0)
; pid end address is: 12 (R3)
; d_factor end address is: 8 (R2)
; i_factor end address is: 4 (R1)
; p_factor end address is: 0 (R0)
; p_factor start address is: 0 (R0)
; i_factor start address is: 4 (R1)
; d_factor start address is: 8 (R2)
; pid start address is: 12 (R3)
;inkubator_func.c,501 :: 		pid->sumError = 0;
ADDS	R5, R3, #4
MOVS	R4, #0
STR	R4, [R5, #0]
;inkubator_func.c,502 :: 		pid->lastProcessValue = 0;
MOVS	R4, #0
SXTB	R4, R4
STRB	R4, [R3, #0]
;inkubator_func.c,504 :: 		pid->P_Factor = p_factor;
ADDW	R4, R3, #8
STRB	R0, [R4, #0]
; p_factor end address is: 0 (R0)
;inkubator_func.c,505 :: 		pid->I_Factor = i_factor;
ADDW	R4, R3, #9
STRB	R1, [R4, #0]
; i_factor end address is: 4 (R1)
;inkubator_func.c,506 :: 		pid->D_Factor = d_factor;
ADDW	R4, R3, #10
STRB	R2, [R4, #0]
; d_factor end address is: 8 (R2)
;inkubator_func.c,508 :: 		pid->maxError = MAX_INT / (pid->P_Factor + 1);
ADDW	R6, R3, #11
ADDW	R4, R3, #8
LDRSB	R4, [R4, #0]
ADDS	R5, R4, #1
SXTH	R5, R5
MOVW	R4, #32767
SXTH	R4, R4
SDIV	R4, R4, R5
STRB	R4, [R6, #0]
;inkubator_func.c,509 :: 		pid->maxSumError = MAX_I_TERM / (pid->I_Factor + 1);
ADDW	R6, R3, #12
ADDW	R4, R3, #9
; pid end address is: 12 (R3)
LDRSB	R4, [R4, #0]
ADDS	R5, R4, #1
SXTH	R5, R5
MVN	R4, #-1073741824
SDIV	R4, R4, R5
STR	R4, [R6, #0]
;inkubator_func.c,510 :: 		}
L_end_pid_Init:
BX	LR
; end of _pid_Init
_pid_Controller:
;inkubator_func.c,521 :: 		int16_t pid_Controller(int16_t setPoint, int16_t processValue, struct PID_DATA *pid_st)
; pid_st start address is: 8 (R2)
; processValue start address is: 4 (R1)
; setPoint start address is: 0 (R0)
; pid_st end address is: 8 (R2)
; processValue end address is: 4 (R1)
; setPoint end address is: 0 (R0)
; setPoint start address is: 0 (R0)
; processValue start address is: 4 (R1)
; pid_st start address is: 8 (R2)
;inkubator_func.c,526 :: 		error = setPoint - processValue;
SUB	R5, R0, R1
; setPoint end address is: 0 (R0)
; error start address is: 24 (R6)
SXTB	R6, R5
;inkubator_func.c,529 :: 		if (error > pid_st->maxError){
ADDW	R3, R2, #11
LDRSB	R4, [R3, #0]
SXTB	R3, R5
CMP	R3, R4
IT	LE
BLE	L_pid_Controller121
;inkubator_func.c,530 :: 		p_term = MAX_INT;
; p_term start address is: 0 (R0)
MOVS	R0, #255
SXTB	R0, R0
;inkubator_func.c,531 :: 		}
; p_term end address is: 0 (R0)
IT	AL
BAL	L_pid_Controller122
L_pid_Controller121:
;inkubator_func.c,532 :: 		else if (error < -pid_st->maxError){
ADDW	R3, R2, #11
LDRSB	R3, [R3, #0]
RSBS	R3, R3, #0
SXTH	R3, R3
CMP	R6, R3
IT	GE
BGE	L_pid_Controller123
;inkubator_func.c,533 :: 		p_term = -MAX_INT;
; p_term start address is: 0 (R0)
MOVS	R0, #1
SXTB	R0, R0
;inkubator_func.c,534 :: 		}
; p_term end address is: 0 (R0)
IT	AL
BAL	L_pid_Controller124
L_pid_Controller123:
;inkubator_func.c,536 :: 		p_term = pid_st->P_Factor * error;
ADDW	R3, R2, #8
LDRSB	R3, [R3, #0]
MULS	R3, R6, R3
; p_term start address is: 0 (R0)
SXTB	R0, R3
; p_term end address is: 0 (R0)
;inkubator_func.c,537 :: 		}
L_pid_Controller124:
; p_term start address is: 0 (R0)
; p_term end address is: 0 (R0)
L_pid_Controller122:
;inkubator_func.c,540 :: 		temp = pid_st->sumError + error;
; p_term start address is: 0 (R0)
ADDS	R3, R2, #4
LDR	R3, [R3, #0]
ADDS	R4, R3, R6
; error end address is: 24 (R6)
; temp start address is: 20 (R5)
MOV	R5, R4
;inkubator_func.c,541 :: 		if(temp > pid_st->maxSumError){
ADDW	R3, R2, #12
LDR	R3, [R3, #0]
CMP	R4, R3
IT	LE
BLE	L_pid_Controller125
; temp end address is: 20 (R5)
;inkubator_func.c,542 :: 		i_term = MAX_I_TERM;
; i_term start address is: 20 (R5)
MVN	R5, #-1073741824
;inkubator_func.c,543 :: 		pid_st->sumError = pid_st->maxSumError;
ADDS	R4, R2, #4
ADDW	R3, R2, #12
LDR	R3, [R3, #0]
STR	R3, [R4, #0]
;inkubator_func.c,544 :: 		}
; i_term end address is: 20 (R5)
IT	AL
BAL	L_pid_Controller126
L_pid_Controller125:
;inkubator_func.c,545 :: 		else if(temp < -pid_st->maxSumError){
; temp start address is: 20 (R5)
ADDW	R3, R2, #12
LDR	R3, [R3, #0]
RSBS	R3, R3, #0
CMP	R5, R3
IT	GE
BGE	L_pid_Controller127
; temp end address is: 20 (R5)
;inkubator_func.c,546 :: 		i_term = -MAX_I_TERM;
; i_term start address is: 20 (R5)
MOVW	R5, #1
MOVT	R5, #49152
;inkubator_func.c,547 :: 		pid_st->sumError = -pid_st->maxSumError;
ADDS	R4, R2, #4
ADDW	R3, R2, #12
LDR	R3, [R3, #0]
RSBS	R3, R3, #0
STR	R3, [R4, #0]
;inkubator_func.c,548 :: 		}
; i_term end address is: 20 (R5)
IT	AL
BAL	L_pid_Controller128
L_pid_Controller127:
;inkubator_func.c,550 :: 		pid_st->sumError = temp;
; temp start address is: 20 (R5)
ADDS	R3, R2, #4
STR	R5, [R3, #0]
; temp end address is: 20 (R5)
;inkubator_func.c,551 :: 		i_term = pid_st->I_Factor * pid_st->sumError;
ADDW	R3, R2, #9
LDRSB	R4, [R3, #0]
ADDS	R3, R2, #4
LDR	R3, [R3, #0]
MULS	R3, R4, R3
; i_term start address is: 16 (R4)
MOV	R4, R3
; i_term end address is: 16 (R4)
MOV	R5, R4
;inkubator_func.c,552 :: 		}
L_pid_Controller128:
; i_term start address is: 20 (R5)
; i_term end address is: 20 (R5)
L_pid_Controller126:
;inkubator_func.c,555 :: 		d_term = pid_st->D_Factor * (pid_st->lastProcessValue - processValue);
; i_term start address is: 20 (R5)
ADDW	R3, R2, #10
LDRSB	R4, [R3, #0]
LDRSB	R3, [R2, #0]
SUB	R3, R3, R1
SXTH	R3, R3
MULS	R3, R4, R3
; d_term start address is: 16 (R4)
SXTB	R4, R3
;inkubator_func.c,557 :: 		pid_st->lastProcessValue = processValue;
STRB	R1, [R2, #0]
; processValue end address is: 4 (R1)
; pid_st end address is: 8 (R2)
;inkubator_func.c,559 :: 		ret = (p_term + i_term + d_term) / SCALING_FACTOR;
ADDS	R3, R0, R5
; p_term end address is: 0 (R0)
; i_term end address is: 20 (R5)
ADDS	R3, R3, R4
; d_term end address is: 16 (R4)
VMOV	S1, R3
VCVT.F32	#1, S1, S1
MOV	R3, #1124073472
VMOV	S0, R3
VDIV.F32	S0, S1, S0
VCVT	#1, .F32, S0, S0
VMOV	R4, S0
; ret start address is: 0 (R0)
MOV	R0, R4
;inkubator_func.c,560 :: 		if(ret > MAX_INT){
MOVW	R3, #32767
CMP	R4, R3
IT	LE
BLE	L_pid_Controller129
;inkubator_func.c,561 :: 		ret = MAX_INT;
MOVW	R0, #32767
;inkubator_func.c,562 :: 		}
IT	AL
BAL	L_pid_Controller130
L_pid_Controller129:
;inkubator_func.c,563 :: 		else if(ret < -MAX_INT){
MOVW	R3, #32769
MOVT	R3, #65535
CMP	R0, R3
IT	GE
BGE	L__pid_Controller170
;inkubator_func.c,564 :: 		ret = -MAX_INT;
MOVW	R0, #32769
MOVT	R0, #65535
; ret end address is: 0 (R0)
;inkubator_func.c,565 :: 		}
IT	AL
BAL	L_pid_Controller131
L__pid_Controller170:
;inkubator_func.c,563 :: 		else if(ret < -MAX_INT){
;inkubator_func.c,565 :: 		}
L_pid_Controller131:
; ret start address is: 0 (R0)
; ret end address is: 0 (R0)
L_pid_Controller130:
;inkubator_func.c,567 :: 		return((int16_t)ret);
; ret start address is: 0 (R0)
SXTB	R0, R0
; ret end address is: 0 (R0)
;inkubator_func.c,568 :: 		}
L_end_pid_Controller:
BX	LR
; end of _pid_Controller
_pid_Reset_Integrator:
;inkubator_func.c,574 :: 		void pid_Reset_Integrator(pidData_t *pid_st)
; pid_st start address is: 0 (R0)
; pid_st end address is: 0 (R0)
; pid_st start address is: 0 (R0)
;inkubator_func.c,576 :: 		pid_st->sumError = 0;
ADDS	R2, R0, #4
; pid_st end address is: 0 (R0)
MOVS	R1, #0
STR	R1, [R2, #0]
;inkubator_func.c,577 :: 		}
L_end_pid_Reset_Integrator:
BX	LR
; end of _pid_Reset_Integrator
_control_outs:
;inkubator_func.c,579 :: 		void control_outs()
;inkubator_func.c,581 :: 		RELE_ALARM             = flag_t.temperatura_alarm||flag_t.humidity_alarm;
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_control_outs133
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_control_outs133
MOVS	R1, #0
IT	AL
BAL	L_control_outs132
L_control_outs133:
MOVS	R1, #1
L_control_outs132:
MOVW	R0, #lo_addr(RELE_ALARM+0)
MOVT	R0, #hi_addr(RELE_ALARM+0)
STR	R1, [R0, #0]
;inkubator_func.c,582 :: 		LED_RED                = flag_t.temperatura_alarm||flag_t.humidity_alarm;
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_control_outs135
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_control_outs135
MOVS	R1, #0
IT	AL
BAL	L_control_outs134
L_control_outs135:
MOVS	R1, #1
L_control_outs134:
MOVW	R0, #lo_addr(LED_RED+0)
MOVT	R0, #hi_addr(LED_RED+0)
STR	R1, [R0, #0]
;inkubator_func.c,584 :: 		RELE_ALARM_TRIAC       = flag_t.temperatura_triac_alarm;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(RELE_ALARM_TRIAC+0)
MOVT	R0, #hi_addr(RELE_ALARM_TRIAC+0)
STR	R1, [R0, #0]
;inkubator_func.c,585 :: 		LED_BLUE               = flag_t.temperatura_triac_alarm;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(LED_BLUE+0)
MOVT	R0, #hi_addr(LED_BLUE+0)
STR	R1, [R0, #0]
;inkubator_func.c,587 :: 		RELE_FAN               = flag_t.start_fan;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(RELE_FAN+0)
MOVT	R0, #hi_addr(RELE_FAN+0)
STR	R1, [R0, #0]
;inkubator_func.c,589 :: 		RELE_COVER             = flag_t.cover_status;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(RELE_COVER+0)
MOVT	R0, #hi_addr(RELE_COVER+0)
STR	R1, [R0, #0]
;inkubator_func.c,591 :: 		RELE_HUMIDITI          = flag_t.humidity_cover_status;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(RELE_HUMIDITI+0)
MOVT	R0, #hi_addr(RELE_HUMIDITI+0)
STR	R1, [R0, #0]
;inkubator_func.c,592 :: 		LED_GREEN              = flag_t.humidity_cover_status;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(LED_GREEN+0)
MOVT	R0, #hi_addr(LED_GREEN+0)
STR	R1, [R0, #0]
;inkubator_func.c,593 :: 		}
L_end_control_outs:
BX	LR
; end of _control_outs
_reset_flags:
;inkubator_func.c,595 :: 		void reset_flags()
;inkubator_func.c,597 :: 		flag_t.temperatura_alarm=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;inkubator_func.c,598 :: 		flag_t.temperatura_triac_alarm=0;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;inkubator_func.c,599 :: 		flag_t.cover_status=0;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;inkubator_func.c,600 :: 		flag_t.humidity_alarm=0;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;inkubator_func.c,601 :: 		flag_t.humidity_cover_status=0;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;inkubator_func.c,602 :: 		flag_t.control_humidity=0;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;inkubator_func.c,603 :: 		}
L_end_reset_flags:
BX	LR
; end of _reset_flags
_set_default_parameters:
;inkubator_func.c,606 :: 		void set_default_parameters()
;inkubator_func.c,608 :: 		parameters_t.set_temperatura=37.5;
MOVW	R0, #0
MOVT	R0, #16918
VMOV	S0, R0
MOVW	R0, #lo_addr(_parameters_t+0)
MOVT	R0, #hi_addr(_parameters_t+0)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,609 :: 		parameters_t.set_humidity=50.0;
MOVW	R0, #0
MOVT	R0, #16968
VMOV	S0, R0
MOVW	R0, #lo_addr(_parameters_t+4)
MOVT	R0, #hi_addr(_parameters_t+4)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,610 :: 		parameters_t.set_turn_time=60.0;
MOVW	R0, #0
MOVT	R0, #17008
VMOV	S0, R0
MOVW	R0, #lo_addr(_parameters_t+8)
MOVT	R0, #hi_addr(_parameters_t+8)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,611 :: 		parameters_t.temperatura_delta__alarm_level=2.0;
VMOV.F32	S0, #2
MOVW	R0, #lo_addr(_parameters_t+12)
MOVT	R0, #hi_addr(_parameters_t+12)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,612 :: 		parameters_t.humidity_delta_alarm_level=10.0;
VMOV.F32	S0, #10
MOVW	R0, #lo_addr(_parameters_t+16)
MOVT	R0, #hi_addr(_parameters_t+16)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,613 :: 		parameters_t.control_humidity=0.0;
MOV	R0, #0
VMOV	S0, R0
MOVW	R0, #lo_addr(_parameters_t+20)
MOVT	R0, #hi_addr(_parameters_t+20)
VSTR	#1, S0, [R0, #0]
;inkubator_func.c,614 :: 		}
L_end_set_default_parameters:
BX	LR
; end of _set_default_parameters
_Load:
;inkubator_func.c,616 :: 		void Load()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;inkubator_func.c,618 :: 		char i=0;
;inkubator_func.c,619 :: 		unsigned int tone=0;
;inkubator_func.c,620 :: 		Lcd_Cmd(_LCD_CLEAR);
MOVS	R0, #1
BL	_Lcd_Cmd+0
;inkubator_func.c,621 :: 		Lcd_Out(2,1,"SYSTEMA STARTUET");
MOVW	R0, #lo_addr(?lstr46_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr46_inkubator_func+0)
MOV	R2, R0
MOVS	R1, #1
MOVS	R0, #2
BL	_Lcd_Out+0
;inkubator_func.c,622 :: 		for(i=0,tone=500;i<17;i++,tone+=80)
; i start address is: 32 (R8)
MOVW	R8, #0
; tone start address is: 24 (R6)
MOVW	R6, #500
; i end address is: 32 (R8)
; tone end address is: 24 (R6)
L_Load136:
; tone start address is: 24 (R6)
; i start address is: 32 (R8)
CMP	R8, #17
IT	CS
BCS	L_Load137
;inkubator_func.c,624 :: 		Lcd_Out(1,i,">");
MOVW	R0, #lo_addr(?lstr47_inkubator_func+0)
MOVT	R0, #hi_addr(?lstr47_inkubator_func+0)
MOV	R2, R0
UXTB	R1, R8
MOVS	R0, #1
BL	_Lcd_Out+0
;inkubator_func.c,625 :: 		Delay_ms(300);
MOVW	R7, #56575
MOVT	R7, #109
NOP
NOP
L_Load139:
SUBS	R7, R7, #1
BNE	L_Load139
NOP
NOP
NOP
;inkubator_func.c,626 :: 		Sound_Play(tone,100);
MOVS	R1, #100
UXTH	R0, R6
BL	_Sound_Play+0
;inkubator_func.c,622 :: 		for(i=0,tone=500;i<17;i++,tone+=80)
ADD	R8, R8, #1
UXTB	R8, R8
ADDS	R6, #80
UXTH	R6, R6
;inkubator_func.c,627 :: 		}
; i end address is: 32 (R8)
; tone end address is: 24 (R6)
IT	AL
BAL	L_Load136
L_Load137:
;inkubator_func.c,628 :: 		Lcd_Cmd(_LCD_CLEAR);
MOVS	R0, #1
BL	_Lcd_Cmd+0
;inkubator_func.c,629 :: 		}
L_end_Load:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Load
_rotation:
;inkubator_func.c,639 :: 		void rotation()
;inkubator_func.c,642 :: 		if(++count_rotations>=((unsigned long)parameters_t.set_turn_time*1200))
MOVW	R1, #lo_addr(rotation_count_rotations_L0+0)
MOVT	R1, #hi_addr(rotation_count_rotations_L0+0)
LDR	R0, [R1, #0]
ADDS	R2, R0, #1
STR	R2, [R1, #0]
MOVW	R0, #lo_addr(_parameters_t+8)
MOVT	R0, #hi_addr(_parameters_t+8)
VLDR	#1, S0, [R0, #0]
VCVT	#1, .F32, S0, S0
VMOV	R1, S0
MOVW	R0, #1200
MULS	R0, R1, R0
CMP	R2, R0
IT	CC
BCC	L_rotation141
;inkubator_func.c,644 :: 		RELE_ROTATION^=1;
MOVW	R1, #lo_addr(RELE_ROTATION+0)
MOVT	R1, #hi_addr(RELE_ROTATION+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #1
STR	R0, [R1, #0]
;inkubator_func.c,645 :: 		count_rotations=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(rotation_count_rotations_L0+0)
MOVT	R0, #hi_addr(rotation_count_rotations_L0+0)
STR	R1, [R0, #0]
;inkubator_func.c,646 :: 		}
L_rotation141:
;inkubator_func.c,647 :: 		}
L_end_rotation:
BX	LR
; end of _rotation
_Get_key:
;inkubator_func.c,649 :: 		void Get_key()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;inkubator_func.c,651 :: 		switch(key_value)
IT	AL
BAL	L_Get_key142
;inkubator_func.c,653 :: 		case  key_up   :   key_value=0;flag_t.start_fan^=1;                                   break;
L_Get_key144:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
IT	AL
BAL	L_Get_key143
;inkubator_func.c,654 :: 		case  key_down :   key_value=0;flag_t.start_process^=1;
L_Get_key145:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;inkubator_func.c,655 :: 		if(flag_t.start_process==SET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_Get_key146
;inkubator_func.c,657 :: 		flag_t.first_start_t=RESET;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;inkubator_func.c,658 :: 		flag_t.first_start_h=RESET;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;inkubator_func.c,659 :: 		}
L_Get_key146:
;inkubator_func.c,660 :: 		break;
IT	AL
BAL	L_Get_key143
;inkubator_func.c,661 :: 		case  key_enter:   key_value=0;flag_t.status_in_menu=SET; set_temperature();          break;
L_Get_key147:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
BL	_set_temperature+0
IT	AL
BAL	L_Get_key143
;inkubator_func.c,662 :: 		case  key_back :   key_value=0;                                                       break;
L_Get_key148:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
IT	AL
BAL	L_Get_key143
;inkubator_func.c,663 :: 		}
L_Get_key142:
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_Get_key144
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_Get_key145
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_Get_key147
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_Get_key148
L_Get_key143:
;inkubator_func.c,665 :: 		}
L_end_Get_key:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Get_key
_control_menu:
;inkubator_func.c,667 :: 		void control_menu()
;inkubator_func.c,671 :: 		if(flag_t.status_in_menu==SET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_control_menu149
;inkubator_func.c,673 :: 		if((++count_processed)>=(sec*20))   //20 count 1 second
MOVW	R1, #lo_addr(control_menu_count_processed_L0+0)
MOVT	R1, #hi_addr(control_menu_count_processed_L0+0)
LDRH	R0, [R1, #0]
ADDS	R2, R0, #1
UXTH	R2, R2
STRH	R2, [R1, #0]
MOVW	R0, #lo_addr(control_menu_sec_L0+0)
MOVT	R0, #hi_addr(control_menu_sec_L0+0)
LDRH	R1, [R0, #0]
MOVS	R0, #20
MULS	R0, R1, R0
UXTH	R0, R0
CMP	R2, R0
IT	CC
BCC	L_control_menu150
;inkubator_func.c,675 :: 		count_processed=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(control_menu_count_processed_L0+0)
MOVT	R0, #hi_addr(control_menu_count_processed_L0+0)
STRH	R1, [R0, #0]
;inkubator_func.c,676 :: 		flag_t.status_in_menu=RESET;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;inkubator_func.c,677 :: 		}
L_control_menu150:
;inkubator_func.c,678 :: 		}
L_control_menu149:
;inkubator_func.c,679 :: 		}
L_end_control_menu:
BX	LR
; end of _control_menu
_impulse:
;inkubator_func.c,681 :: 		void impulse()
;inkubator_func.c,684 :: 		TRIAC_OUT=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TRIAC_OUT+0)
MOVT	R0, #hi_addr(TRIAC_OUT+0)
STR	R1, [R0, #0]
;inkubator_func.c,685 :: 		Delay_us(500);
MOVW	R7, #11998
MOVT	R7, #0
NOP
NOP
L_impulse151:
SUBS	R7, R7, #1
BNE	L_impulse151
NOP
NOP
NOP
NOP
;inkubator_func.c,687 :: 		TRIAC_OUT=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TRIAC_OUT+0)
MOVT	R0, #hi_addr(TRIAC_OUT+0)
STR	R1, [R0, #0]
;inkubator_func.c,688 :: 		}
L_end_impulse:
BX	LR
; end of _impulse
_start_eeprom:
;inkubator_func.c,690 :: 		void start_eeprom()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;inkubator_func.c,692 :: 		EEPROM_Init();
BL	_EEPROM_Init+0
;inkubator_func.c,693 :: 		if(read_data_in_eeprom()==SET)
BL	_read_data_in_eeprom+0
CMP	R0, #1
IT	NE
BNE	L_start_eeprom153
;inkubator_func.c,695 :: 		set_default_parameters();
BL	_set_default_parameters+0
;inkubator_func.c,696 :: 		}
L_start_eeprom153:
;inkubator_func.c,697 :: 		if(parameters_t.control_humidity==0.0)
MOVW	R0, #lo_addr(_parameters_t+20)
MOVT	R0, #hi_addr(_parameters_t+20)
VLDR	#1, S0, [R0, #0]
VCMPE.F32	S0, #0
VMRS	#60, FPSCR
IT	NE
BNE	L_start_eeprom154
;inkubator_func.c,699 :: 		flag_t.control_humidity=RESET;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;inkubator_func.c,700 :: 		}
L_start_eeprom154:
;inkubator_func.c,701 :: 		if(parameters_t.control_humidity==1.0)
MOVW	R0, #lo_addr(_parameters_t+20)
MOVT	R0, #hi_addr(_parameters_t+20)
VLDR	#1, S1, [R0, #0]
VMOV.F32	S0, #1
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	NE
BNE	L_start_eeprom155
;inkubator_func.c,703 :: 		flag_t.control_humidity=SET;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;inkubator_func.c,704 :: 		}
L_start_eeprom155:
;inkubator_func.c,706 :: 		}
L_end_start_eeprom:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _start_eeprom
