_AM2302_Read:
;dht22.c,18 :: 		char AM2302_Read(float *humidity, float *temperature) {
; temperature start address is: 4 (R1)
; humidity start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
MOV	R10, R0
MOV	R11, R1
; temperature end address is: 4 (R1)
; humidity end address is: 0 (R0)
; humidity start address is: 40 (R10)
; temperature start address is: 44 (R11)
;dht22.c,19 :: 		char i = 0, j = 1;
;dht22.c,20 :: 		char timeout = 0;
;dht22.c,22 :: 		int t=0;
;dht22.c,23 :: 		int h=0;
;dht22.c,25 :: 		GPIO_Config(&GPIO_PORTB, _GPIO_PINMASK_3, _GPIO_DIR_INPUT, _GPIO_CFG_DIGITAL_ENABLE , _GPIO_PINCODE_NONE);
MOVS	R2, #0
PUSH	(R2)
MOVW	R3, #256
MOVS	R2, #0
MOVS	R1, #8
MOVW	R0, #20480
MOVT	R0, #16384
BL	_GPIO_Config+0
ADD	SP, SP, #4
;dht22.c,27 :: 		GPIO_Config(&GPIO_PORTB, _GPIO_PINMASK_3, _GPIO_DIR_OUTPUT, _GPIO_CFG_DIGITAL_ENABLE | _GPIO_CFG_OPEN_DRAIN, _GPIO_PINCODE_NONE);
MOVS	R2, #0
PUSH	(R2)
MOVW	R3, #264
MOVS	R2, #1
MOVS	R1, #8
MOVW	R0, #20480
MOVT	R0, #16384
BL	_GPIO_Config+0
ADD	SP, SP, #4
;dht22.c,28 :: 		AM2302_Bus_Out = 1;                                 //Set GPIOD pin 13 HIGH for 100 milliseconds
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, 1073763324
MOVT	R2, 16384
STR	R3, [R2, #0]
;dht22.c,29 :: 		Delay_ms(100);                                      //Delay 100ms
MOVW	R7, #40703
MOVT	R7, #36
NOP
NOP
L_AM2302_Read0:
SUBS	R7, R7, #1
BNE	L_AM2302_Read0
NOP
NOP
;dht22.c,30 :: 		AM2302_Bus_Out = 0;                                 //Host the start signal down time min: 0.8ms, typ: 1ms, max: 20ms
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, 1073763324
MOVT	R2, 16384
STR	R3, [R2, #0]
;dht22.c,31 :: 		Delay_ms(2);                                        //Delay 2ms
MOVW	R7, #47998
MOVT	R7, #0
NOP
NOP
L_AM2302_Read2:
SUBS	R7, R7, #1
BNE	L_AM2302_Read2
NOP
NOP
NOP
NOP
;dht22.c,32 :: 		AM2302_Bus_Out = 1;                                 //Set GPIOD pin 13 HIGH
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, 1073763324
MOVT	R2, 16384
STR	R3, [R2, #0]
;dht22.c,35 :: 		GPIO_Config(&GPIO_PORTB, _GPIO_PINMASK_3, _GPIO_DIR_INPUT, _GPIO_CFG_DIGITAL_ENABLE, _GPIO_PINCODE_NONE);
MOVS	R2, #0
PUSH	(R2)
MOVW	R3, #256
MOVS	R2, #0
MOVS	R1, #8
MOVW	R0, #20480
MOVT	R0, #16384
BL	_GPIO_Config+0
ADD	SP, SP, #4
;dht22.c,37 :: 		timeout = 200;
; timeout start address is: 16 (R4)
MOVS	R4, #200
; humidity end address is: 40 (R10)
; temperature end address is: 44 (R11)
; timeout end address is: 16 (R4)
MOV	R1, R10
MOV	R0, R11
;dht22.c,38 :: 		while (AM2302_Bus_In) {
L_AM2302_Read4:
; timeout start address is: 16 (R4)
; temperature start address is: 0 (R0)
; humidity start address is: 4 (R1)
MOVW	R3, 1073763324
MOVT	R3, 16384
LDR	R2, [R3, #0]
CMP	R2, #0
IT	EQ
BEQ	L_AM2302_Read5
;dht22.c,39 :: 		Delay_us(1);
MOVW	R7, #23
MOVT	R7, #0
NOP
NOP
L_AM2302_Read6:
SUBS	R7, R7, #1
BNE	L_AM2302_Read6
NOP
NOP
;dht22.c,40 :: 		if (!timeout--) {
UXTB	R3, R4
SUBS	R4, R4, #1
UXTB	R4, R4
CMP	R3, #0
IT	NE
BNE	L_AM2302_Read8
; temperature end address is: 0 (R0)
; timeout end address is: 16 (R4)
; humidity end address is: 4 (R1)
;dht22.c,41 :: 		return 1;
MOVS	R0, #1
IT	AL
BAL	L_end_AM2302_Read
;dht22.c,42 :: 		} //ERROR: Sensor not responding
L_AM2302_Read8:
;dht22.c,43 :: 		}
; humidity start address is: 4 (R1)
; timeout start address is: 16 (R4)
; temperature start address is: 0 (R0)
; timeout end address is: 16 (R4)
IT	AL
BAL	L_AM2302_Read4
L_AM2302_Read5:
;dht22.c,46 :: 		while (!AM2302_Bus_In) { //response to low time
STR	R1, [SP, #4]
; humidity end address is: 4 (R1)
MOV	R1, R0
LDR	R0, [SP, #4]
L_AM2302_Read9:
; temperature end address is: 0 (R0)
; humidity start address is: 0 (R0)
; temperature start address is: 4 (R1)
MOVW	R3, 1073763324
MOVT	R3, 16384
LDR	R2, [R3, #0]
CMP	R2, #0
IT	NE
BNE	L_AM2302_Read10
;dht22.c,47 :: 		Delay_us(1);
MOVW	R7, #23
MOVT	R7, #0
NOP
NOP
L_AM2302_Read11:
SUBS	R7, R7, #1
BNE	L_AM2302_Read11
NOP
NOP
;dht22.c,48 :: 		}
IT	AL
BAL	L_AM2302_Read9
L_AM2302_Read10:
;dht22.c,50 :: 		while (AM2302_Bus_In) { //response to high time
; temperature end address is: 4 (R1)
L_AM2302_Read13:
; humidity end address is: 0 (R0)
; temperature start address is: 4 (R1)
; humidity start address is: 0 (R0)
MOVW	R3, 1073763324
MOVT	R3, 16384
LDR	R2, [R3, #0]
CMP	R2, #0
IT	EQ
BEQ	L_AM2302_Read14
;dht22.c,51 :: 		Delay_us(1);
MOVW	R7, #23
MOVT	R7, #0
NOP
NOP
L_AM2302_Read15:
SUBS	R7, R7, #1
BNE	L_AM2302_Read15
NOP
NOP
;dht22.c,52 :: 		}
IT	AL
BAL	L_AM2302_Read13
L_AM2302_Read14:
;dht22.c,62 :: 		for (i = 0; i < 5; i++) {
; i start address is: 16 (R4)
MOVS	R4, #0
; i end address is: 16 (R4)
; humidity end address is: 0 (R0)
; temperature end address is: 4 (R1)
L_AM2302_Read17:
; i start address is: 16 (R4)
; humidity start address is: 0 (R0)
; temperature start address is: 4 (R1)
CMP	R4, #5
IT	CS
BCS	L_AM2302_Read18
;dht22.c,64 :: 		for (j = 1; j <= 8; j++) { //get 8 bits from sensor
; j start address is: 12 (R3)
MOVS	R3, #1
; i end address is: 16 (R4)
; humidity end address is: 0 (R0)
; temperature end address is: 4 (R1)
; j end address is: 12 (R3)
STR	R1, [SP, #4]
MOV	R1, R0
UXTB	R0, R4
LDR	R4, [SP, #4]
L_AM2302_Read20:
; j start address is: 12 (R3)
; temperature start address is: 16 (R4)
; humidity start address is: 4 (R1)
; i start address is: 0 (R0)
CMP	R3, #8
IT	HI
BHI	L_AM2302_Read21
; temperature end address is: 16 (R4)
; humidity end address is: 4 (R1)
; j end address is: 12 (R3)
; i end address is: 0 (R0)
MOV	R5, R4
UXTB	R4, R3
;dht22.c,65 :: 		while (!AM2302_Bus_In) { //signal "0", "1" low time
L_AM2302_Read23:
; i start address is: 0 (R0)
; humidity start address is: 4 (R1)
; temperature start address is: 20 (R5)
; j start address is: 16 (R4)
MOVW	R3, 1073763324
MOVT	R3, 16384
LDR	R2, [R3, #0]
CMP	R2, #0
IT	NE
BNE	L_AM2302_Read24
;dht22.c,66 :: 		Delay_us(1);
MOVW	R7, #23
MOVT	R7, #0
NOP
NOP
L_AM2302_Read25:
SUBS	R7, R7, #1
BNE	L_AM2302_Read25
NOP
NOP
;dht22.c,67 :: 		}
IT	AL
BAL	L_AM2302_Read23
L_AM2302_Read24:
;dht22.c,68 :: 		Delay_us(30);
MOVW	R7, #719
MOVT	R7, #0
NOP
NOP
L_AM2302_Read27:
SUBS	R7, R7, #1
BNE	L_AM2302_Read27
NOP
NOP
NOP
;dht22.c,69 :: 		sensor_byte <<= 1;       //add new lower byte
LDRB	R2, [SP, #8]
LSLS	R2, R2, #1
STRB	R2, [SP, #8]
;dht22.c,70 :: 		if (AM2302_Bus_In) {     //if sda high after 30us => bit=1 else bit=0
MOVW	R3, 1073763324
MOVT	R3, 16384
LDR	R2, [R3, #0]
CMP	R2, #0
IT	EQ
BEQ	L__AM2302_Read36
;dht22.c,71 :: 		sensor_byte |= 1;
LDRB	R2, [SP, #8]
ORR	R2, R2, #1
STRB	R2, [SP, #8]
;dht22.c,72 :: 		delay_us(45);
MOVW	R7, #1079
MOVT	R7, #0
NOP
NOP
L_AM2302_Read30:
SUBS	R7, R7, #1
BNE	L_AM2302_Read30
NOP
NOP
NOP
; j end address is: 16 (R4)
; temperature end address is: 20 (R5)
; humidity end address is: 4 (R1)
; i end address is: 0 (R0)
;dht22.c,73 :: 		while (AM2302_Bus_In) {
L_AM2302_Read32:
; j start address is: 16 (R4)
; temperature start address is: 20 (R5)
; humidity start address is: 4 (R1)
; i start address is: 0 (R0)
MOVW	R3, 1073763324
MOVT	R3, 16384
LDR	R2, [R3, #0]
CMP	R2, #0
IT	EQ
BEQ	L_AM2302_Read33
;dht22.c,74 :: 		Delay_us(1);
MOVW	R7, #23
MOVT	R7, #0
NOP
NOP
L_AM2302_Read34:
SUBS	R7, R7, #1
BNE	L_AM2302_Read34
NOP
NOP
;dht22.c,75 :: 		}
IT	AL
BAL	L_AM2302_Read32
L_AM2302_Read33:
;dht22.c,76 :: 		}
; temperature end address is: 20 (R5)
; humidity end address is: 4 (R1)
; i end address is: 0 (R0)
UXTB	R3, R4
MOV	R4, R5
IT	AL
BAL	L_AM2302_Read29
; j end address is: 16 (R4)
L__AM2302_Read36:
;dht22.c,70 :: 		if (AM2302_Bus_In) {     //if sda high after 30us => bit=1 else bit=0
UXTB	R3, R4
MOV	R4, R5
;dht22.c,76 :: 		}
L_AM2302_Read29:
;dht22.c,64 :: 		for (j = 1; j <= 8; j++) { //get 8 bits from sensor
; j start address is: 12 (R3)
; temperature start address is: 16 (R4)
; humidity start address is: 4 (R1)
; i start address is: 0 (R0)
ADDS	R3, R3, #1
UXTB	R3, R3
;dht22.c,77 :: 		}
; j end address is: 12 (R3)
IT	AL
BAL	L_AM2302_Read20
L_AM2302_Read21:
;dht22.c,78 :: 		AM2302_Data[i] = sensor_byte;
MOVW	R2, #lo_addr(_AM2302_Data+0)
MOVT	R2, #hi_addr(_AM2302_Data+0)
ADDS	R3, R2, R0
LDRB	R2, [SP, #8]
STRB	R2, [R3, #0]
;dht22.c,62 :: 		for (i = 0; i < 5; i++) {
ADDS	R0, R0, #1
UXTB	R0, R0
;dht22.c,79 :: 		}
STRB	R0, [SP, #4]
; temperature end address is: 16 (R4)
; humidity end address is: 4 (R1)
; i end address is: 0 (R0)
MOV	R0, R1
MOV	R1, R4
LDRB	R4, [SP, #4]
IT	AL
BAL	L_AM2302_Read17
L_AM2302_Read18:
;dht22.c,81 :: 		h= (AM2302_Data[0] << 8) + AM2302_Data[1];
; temperature start address is: 4 (R1)
; humidity start address is: 0 (R0)
MOVW	R2, #lo_addr(_AM2302_Data+0)
MOVT	R2, #hi_addr(_AM2302_Data+0)
LDRB	R2, [R2, #0]
LSLS	R3, R2, #8
UXTH	R3, R3
MOVW	R2, #lo_addr(_AM2302_Data+1)
MOVT	R2, #hi_addr(_AM2302_Data+1)
LDRB	R2, [R2, #0]
ADDS	R4, R3, R2
UXTH	R4, R4
;dht22.c,82 :: 		t = (AM2302_Data[2] << 8) + AM2302_Data[3];
MOVW	R2, #lo_addr(_AM2302_Data+2)
MOVT	R2, #hi_addr(_AM2302_Data+2)
LDRB	R2, [R2, #0]
LSLS	R3, R2, #8
UXTH	R3, R3
MOVW	R2, #lo_addr(_AM2302_Data+3)
MOVT	R2, #hi_addr(_AM2302_Data+3)
LDRB	R2, [R2, #0]
ADDS	R2, R3, R2
; t start address is: 8 (R2)
SXTH	R2, R2
;dht22.c,83 :: 		*humidity=    (float)h / 10.0;
VMOV	S1, R4
VCVT.F32	#1, S1, S1
VMOV.F32	S0, #10
VDIV.F32	S0, S1, S0
VSTR	#1, S0, [R0, #0]
; humidity end address is: 0 (R0)
;dht22.c,84 :: 		*temperature= (float)t/10.0;
VMOV	S1, R2
VCVT.F32	#1, S1, S1
; t end address is: 8 (R2)
VMOV.F32	S0, #10
VDIV.F32	S0, S1, S0
VSTR	#1, S0, [R1, #0]
; temperature end address is: 4 (R1)
;dht22.c,85 :: 		return 0;
MOVS	R0, #0
;dht22.c,86 :: 		}
L_end_AM2302_Read:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _AM2302_Read
