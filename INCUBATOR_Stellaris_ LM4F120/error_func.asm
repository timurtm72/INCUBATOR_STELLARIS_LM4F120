_set_errors:
;error_func.c,4 :: 		void set_errors()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;error_func.c,6 :: 		char kp=0;
MOVS	R0, #0
STRB	R0, [SP, #4]
MOVS	R0, #0
STRB	R0, [SP, #5]
MOVS	R0, #0
STRB	R0, [SP, #6]
;error_func.c,7 :: 		char go=0;
;error_func.c,8 :: 		unsigned char position=0,pos=0;
;error_func.c,9 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
MOVS	R0, #1
BL	_Lcd_Cmd+0
;error_func.c,10 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
MOVS	R0, #12
BL	_Lcd_Cmd+0
;error_func.c,11 :: 		Lcd_Out(1,4,"OSHIBKI");
MOVW	R0, #lo_addr(?lstr1_error_func+0)
MOVT	R0, #hi_addr(?lstr1_error_func+0)
MOV	R2, R0
MOVS	R1, #4
MOVS	R0, #1
BL	_Lcd_Out+0
;error_func.c,12 :: 		out_lcd_errors(position);
LDRB	R0, [SP, #6]
BL	_out_lcd_errors+0
;error_func.c,13 :: 		while(kp==0)
L_set_errors0:
LDRB	R0, [SP, #4]
CMP	R0, #0
IT	NE
BNE	L_set_errors1
;error_func.c,15 :: 		if(flag_t.status_in_menu==RESET)
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_set_errors2
;error_func.c,17 :: 		key_value=key_back;
MOVS	R1, #4
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
;error_func.c,18 :: 		}
L_set_errors2:
;error_func.c,19 :: 		switch(key_value)
IT	AL
BAL	L_set_errors3
;error_func.c,21 :: 		case key_up:          key_value=0;
L_set_errors5:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
;error_func.c,22 :: 		if(position==0)
LDRB	R0, [SP, #6]
CMP	R0, #0
IT	NE
BNE	L_set_errors6
;error_func.c,24 :: 		position=0;
MOVS	R0, #0
STRB	R0, [SP, #6]
;error_func.c,25 :: 		}
IT	AL
BAL	L_set_errors7
L_set_errors6:
;error_func.c,28 :: 		position--;
LDRB	R0, [SP, #6]
SUBS	R0, R0, #1
STRB	R0, [SP, #6]
;error_func.c,29 :: 		}
L_set_errors7:
;error_func.c,30 :: 		out_lcd_errors(position);                    break;
LDRB	R0, [SP, #6]
BL	_out_lcd_errors+0
IT	AL
BAL	L_set_errors4
;error_func.c,32 :: 		case key_down:        key_value=0; position++;
L_set_errors8:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
LDRB	R0, [SP, #6]
ADDS	R1, R0, #1
UXTB	R1, R1
STRB	R1, [SP, #6]
;error_func.c,33 :: 		if(errors[position]==0)
MOVW	R0, #lo_addr(_errors+0)
MOVT	R0, #hi_addr(_errors+0)
ADDS	R0, R0, R1
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_set_errors9
;error_func.c,35 :: 		position=position;
LDRB	R0, [SP, #6]
STRB	R0, [SP, #6]
;error_func.c,36 :: 		}
L_set_errors9:
;error_func.c,37 :: 		if(position==255)
LDRB	R0, [SP, #6]
CMP	R0, #255
IT	NE
BNE	L_set_errors10
;error_func.c,39 :: 		for(pos=0;pos<255;pos++)
; pos start address is: 8 (R2)
MOVS	R2, #0
; pos end address is: 8 (R2)
L_set_errors11:
; pos start address is: 8 (R2)
CMP	R2, #255
IT	CS
BCS	L_set_errors12
;error_func.c,41 :: 		errors[pos]=0;
MOVW	R0, #lo_addr(_errors+0)
MOVT	R0, #hi_addr(_errors+0)
ADDS	R1, R0, R2
MOVS	R0, #0
STRB	R0, [R1, #0]
;error_func.c,39 :: 		for(pos=0;pos<255;pos++)
ADDS	R0, R2, #1
; pos end address is: 8 (R2)
; pos start address is: 0 (R0)
;error_func.c,42 :: 		}
UXTB	R2, R0
; pos end address is: 0 (R0)
IT	AL
BAL	L_set_errors11
L_set_errors12:
;error_func.c,44 :: 		}
L_set_errors10:
;error_func.c,45 :: 		out_lcd_errors(position);
LDRB	R0, [SP, #6]
BL	_out_lcd_errors+0
;error_func.c,46 :: 		break;
IT	AL
BAL	L_set_errors4
;error_func.c,47 :: 		case key_enter:       key_value=0;   for(pos=0;pos<255;pos++)
L_set_errors14:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
; pos start address is: 8 (R2)
MOVS	R2, #0
; pos end address is: 8 (R2)
L_set_errors15:
; pos start address is: 8 (R2)
CMP	R2, #255
IT	CS
BCS	L_set_errors16
;error_func.c,49 :: 		errors[pos]=0;
MOVW	R0, #lo_addr(_errors+0)
MOVT	R0, #hi_addr(_errors+0)
ADDS	R1, R0, R2
MOVS	R0, #0
STRB	R0, [R1, #0]
;error_func.c,47 :: 		case key_enter:       key_value=0;   for(pos=0;pos<255;pos++)
ADDS	R0, R2, #1
UXTB	R0, R0
; pos end address is: 8 (R2)
; pos start address is: 0 (R0)
;error_func.c,50 :: 		}
UXTB	R2, R0
; pos end address is: 0 (R0)
IT	AL
BAL	L_set_errors15
L_set_errors16:
;error_func.c,52 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
MOVS	R0, #1
BL	_Lcd_Cmd+0
;error_func.c,53 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
MOVS	R0, #12
BL	_Lcd_Cmd+0
;error_func.c,54 :: 		Lcd_Out(1,2,"OSHIBKI STERTY");
MOVW	R0, #lo_addr(?lstr2_error_func+0)
MOVT	R0, #hi_addr(?lstr2_error_func+0)
MOV	R2, R0
MOVS	R1, #2
MOVS	R0, #1
BL	_Lcd_Out+0
;error_func.c,55 :: 		Delay_ms(1000);
MOVW	R7, #13823
MOVT	R7, #366
NOP
NOP
L_set_errors18:
SUBS	R7, R7, #1
BNE	L_set_errors18
NOP
NOP
;error_func.c,56 :: 		go=1;kp=1;             break;
MOVS	R0, #1
STRB	R0, [SP, #5]
MOVS	R0, #1
STRB	R0, [SP, #4]
IT	AL
BAL	L_set_errors4
;error_func.c,57 :: 		case key_back:        key_value=0; kp=1;   Lcd_Cmd(_LCD_CLEAR);
L_set_errors20:
MOVS	R1, #0
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
STRB	R1, [R0, #0]
MOVS	R0, #1
STRB	R0, [SP, #4]
MOVS	R0, #1
BL	_Lcd_Cmd+0
;error_func.c,58 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);                              break;
MOVS	R0, #12
BL	_Lcd_Cmd+0
IT	AL
BAL	L_set_errors4
;error_func.c,59 :: 		}
L_set_errors3:
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_set_errors5
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_set_errors8
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #3
IT	EQ
BEQ	L_set_errors14
MOVW	R0, #lo_addr(_key_value+0)
MOVT	R0, #hi_addr(_key_value+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_set_errors20
L_set_errors4:
;error_func.c,60 :: 		}
IT	AL
BAL	L_set_errors0
L_set_errors1:
;error_func.c,61 :: 		if(go==SET) set_temperature();
LDRB	R0, [SP, #5]
CMP	R0, #1
IT	NE
BNE	L_set_errors21
BL	_set_temperature+0
L_set_errors21:
;error_func.c,62 :: 		}
L_end_set_errors:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _set_errors
_out_lcd_errors:
;error_func.c,64 :: 		void out_lcd_errors(unsigned char position)
; position start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R6, R0
; position end address is: 0 (R0)
; position start address is: 24 (R6)
;error_func.c,66 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
MOVS	R0, #1
BL	_Lcd_Cmd+0
;error_func.c,67 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
MOVS	R0, #12
BL	_Lcd_Cmd+0
;error_func.c,68 :: 		Lcd_Out(1,6,"OSHIBKI");
MOVW	R1, #lo_addr(?lstr3_error_func+0)
MOVT	R1, #hi_addr(?lstr3_error_func+0)
MOV	R2, R1
MOVS	R1, #6
MOVS	R0, #1
BL	_Lcd_Out+0
;error_func.c,69 :: 		if(errors[position]==0)
MOVW	R1, #lo_addr(_errors+0)
MOVT	R1, #hi_addr(_errors+0)
ADDS	R1, R1, R6
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	NE
BNE	L_out_lcd_errors22
; position end address is: 24 (R6)
;error_func.c,71 :: 		Lcd_Out(2,1,"NET OSHIBOK...");
MOVW	R1, #lo_addr(?lstr4_error_func+0)
MOVT	R1, #hi_addr(?lstr4_error_func+0)
MOV	R2, R1
MOVS	R1, #1
MOVS	R0, #2
BL	_Lcd_Out+0
;error_func.c,72 :: 		}
IT	AL
BAL	L_out_lcd_errors23
L_out_lcd_errors22:
;error_func.c,75 :: 		Lcd_Out(2,1,message[errors[position]]);
; position start address is: 24 (R6)
MOVW	R1, #lo_addr(_errors+0)
MOVT	R1, #hi_addr(_errors+0)
ADDS	R1, R1, R6
; position end address is: 24 (R6)
LDRB	R1, [R1, #0]
LSLS	R2, R1, #2
MOVW	R1, #lo_addr(_message+0)
MOVT	R1, #hi_addr(_message+0)
ADDS	R1, R1, R2
LDR	R1, [R1, #0]
MOV	R2, R1
MOVS	R1, #1
MOVS	R0, #2
BL	_Lcd_Out+0
;error_func.c,76 :: 		}
L_out_lcd_errors23:
;error_func.c,77 :: 		}
L_end_out_lcd_errors:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _out_lcd_errors
_reset_error_message:
;error_func.c,79 :: 		void reset_error_message()
;error_func.c,81 :: 		unsigned char count_err=0;
;error_func.c,82 :: 		for(count_err=0;count_err<255;count_err++)
; count_err start address is: 8 (R2)
MOVS	R2, #0
; count_err end address is: 8 (R2)
L_reset_error_message24:
; count_err start address is: 8 (R2)
CMP	R2, #255
IT	CS
BCS	L_reset_error_message25
;error_func.c,84 :: 		errors[count_err]=0;
MOVW	R0, #lo_addr(_errors+0)
MOVT	R0, #hi_addr(_errors+0)
ADDS	R1, R0, R2
MOVS	R0, #0
STRB	R0, [R1, #0]
;error_func.c,82 :: 		for(count_err=0;count_err<255;count_err++)
ADDS	R2, R2, #1
UXTB	R2, R2
;error_func.c,85 :: 		}
; count_err end address is: 8 (R2)
IT	AL
BAL	L_reset_error_message24
L_reset_error_message25:
;error_func.c,88 :: 		}
L_end_reset_error_message:
BX	LR
; end of _reset_error_message
_set_fault:
;error_func.c,90 :: 		void set_fault(char error_code)
; error_code start address is: 0 (R0)
; error_code end address is: 0 (R0)
; error_code start address is: 0 (R0)
;error_func.c,93 :: 		errors[count_error1++]=error_code;
MOVW	R3, #lo_addr(set_fault_count_error1_L0+0)
MOVT	R3, #hi_addr(set_fault_count_error1_L0+0)
LDRB	R2, [R3, #0]
MOVW	R1, #lo_addr(_errors+0)
MOVT	R1, #hi_addr(_errors+0)
ADDS	R1, R1, R2
STRB	R0, [R1, #0]
; error_code end address is: 0 (R0)
MOV	R1, R3
LDRB	R1, [R1, #0]
ADDS	R1, R1, #1
UXTB	R1, R1
STRB	R1, [R3, #0]
;error_func.c,94 :: 		if(count_error1>=255)
CMP	R1, #255
IT	CC
BCC	L_set_fault27
;error_func.c,96 :: 		for(count_error1=0;count_error1<255;count_error1++)
MOVS	R2, #0
MOVW	R1, #lo_addr(set_fault_count_error1_L0+0)
MOVT	R1, #hi_addr(set_fault_count_error1_L0+0)
STRB	R2, [R1, #0]
L_set_fault28:
MOVW	R1, #lo_addr(set_fault_count_error1_L0+0)
MOVT	R1, #hi_addr(set_fault_count_error1_L0+0)
LDRB	R1, [R1, #0]
CMP	R1, #255
IT	CS
BCS	L_set_fault29
;error_func.c,98 :: 		errors[count_error1]=0;
MOVW	R3, #lo_addr(set_fault_count_error1_L0+0)
MOVT	R3, #hi_addr(set_fault_count_error1_L0+0)
LDRB	R2, [R3, #0]
MOVW	R1, #lo_addr(_errors+0)
MOVT	R1, #hi_addr(_errors+0)
ADDS	R2, R1, R2
MOVS	R1, #0
STRB	R1, [R2, #0]
;error_func.c,96 :: 		for(count_error1=0;count_error1<255;count_error1++)
MOV	R1, R3
LDRB	R1, [R1, #0]
ADDS	R1, R1, #1
STRB	R1, [R3, #0]
;error_func.c,99 :: 		}
IT	AL
BAL	L_set_fault28
L_set_fault29:
;error_func.c,100 :: 		count_error1=0;
MOVS	R2, #0
MOVW	R1, #lo_addr(set_fault_count_error1_L0+0)
MOVT	R1, #hi_addr(set_fault_count_error1_L0+0)
STRB	R2, [R1, #0]
;error_func.c,101 :: 		}
L_set_fault27:
;error_func.c,103 :: 		}
L_end_set_fault:
BX	LR
; end of _set_fault
