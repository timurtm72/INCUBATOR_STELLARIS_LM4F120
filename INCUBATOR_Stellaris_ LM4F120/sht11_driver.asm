_s_transstart:
;sht11_driver.c,43 :: 		void s_transstart()
;sht11_driver.c,46 :: 		SDA_pin_DIR = 0;        //release DATA-line
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(SDA_pin_DIR+0)
MOVT	R0, #hi_addr(SDA_pin_DIR+0)
STR	R1, [R0, #0]
;sht11_driver.c,47 :: 		SCL_pin = 0;            // SCL Low
MOVW	R0, #lo_addr(SCL_pin+0)
MOVT	R0, #hi_addr(SCL_pin+0)
STR	R1, [R0, #0]
;sht11_driver.c,49 :: 		Delay_uS(10);
MOVW	R7, #239
MOVT	R7, #0
NOP
NOP
L_s_transstart0:
SUBS	R7, R7, #1
BNE	L_s_transstart0
NOP
NOP
;sht11_driver.c,50 :: 		SCL_pin = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(SCL_pin+0)
MOVT	R0, #hi_addr(SCL_pin+0)
STR	R1, [R0, #0]
;sht11_driver.c,51 :: 		Delay_uS(10);
MOVW	R7, #239
MOVT	R7, #0
NOP
NOP
L_s_transstart2:
SUBS	R7, R7, #1
BNE	L_s_transstart2
NOP
NOP
;sht11_driver.c,53 :: 		SDA_pin_DIR = 1;        // DATA as output
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(SDA_pin_DIR+0)
MOVT	R0, #hi_addr(SDA_pin_DIR+0)
STR	R1, [R0, #0]
;sht11_driver.c,54 :: 		SDA_pin = 0;            // SDA low
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(SDA_pin+0)
MOVT	R0, #hi_addr(SDA_pin+0)
STR	R1, [R0, #0]
;sht11_driver.c,55 :: 		Delay_uS(10);
MOVW	R7, #239
MOVT	R7, #0
NOP
NOP
L_s_transstart4:
SUBS	R7, R7, #1
BNE	L_s_transstart4
NOP
NOP
;sht11_driver.c,56 :: 		SCL_pin = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(SCL_pin+0)
MOVT	R0, #hi_addr(SCL_pin+0)
STR	R1, [R0, #0]
;sht11_driver.c,57 :: 		Delay_uS(30);
MOVW	R7, #719
MOVT	R7, #0
NOP
NOP
L_s_transstart6:
SUBS	R7, R7, #1
BNE	L_s_transstart6
NOP
NOP
NOP
;sht11_driver.c,58 :: 		SCL_pin = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(SCL_pin+0)
MOVT	R0, #hi_addr(SCL_pin+0)
STR	R1, [R0, #0]
;sht11_driver.c,59 :: 		Delay_uS(10);
MOVW	R7, #239
MOVT	R7, #0
NOP
NOP
L_s_transstart8:
SUBS	R7, R7, #1
BNE	L_s_transstart8
NOP
NOP
;sht11_driver.c,61 :: 		SDA_pin_DIR = 0;        //release DATA-line
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(SDA_pin_DIR+0)
MOVT	R0, #hi_addr(SDA_pin_DIR+0)
STR	R1, [R0, #0]
;sht11_driver.c,62 :: 		Delay_uS(10);
MOVW	R7, #239
MOVT	R7, #0
NOP
NOP
L_s_transstart10:
SUBS	R7, R7, #1
BNE	L_s_transstart10
NOP
NOP
;sht11_driver.c,63 :: 		SCL_pin = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(SCL_pin+0)
MOVT	R0, #hi_addr(SCL_pin+0)
STR	R1, [R0, #0]
;sht11_driver.c,64 :: 		}
L_end_s_transstart:
BX	LR
; end of _s_transstart
_s_read_byte:
;sht11_driver.c,69 :: 		unsigned char s_read_byte(unsigned char ack)
; ack start address is: 0 (R0)
; ack end address is: 0 (R0)
; ack start address is: 0 (R0)
;sht11_driver.c,71 :: 		unsigned char i=0x80;
; i start address is: 12 (R3)
MOVS	R3, #128
;sht11_driver.c,72 :: 		unsigned char val=0;
; val start address is: 16 (R4)
MOVS	R4, #0
;sht11_driver.c,75 :: 		SDA_pin_DIR = 0;        //release DATA-line
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(SDA_pin_DIR+0)
MOVT	R1, #hi_addr(SDA_pin_DIR+0)
STR	R2, [R1, #0]
;sht11_driver.c,76 :: 		SCL_pin = 0;            // SCL Low
MOVW	R1, #lo_addr(SCL_pin+0)
MOVT	R1, #hi_addr(SCL_pin+0)
STR	R2, [R1, #0]
; ack end address is: 0 (R0)
; val end address is: 16 (R4)
; i end address is: 12 (R3)
;sht11_driver.c,78 :: 		while(i)                //shift bit for masking
L_s_read_byte12:
; val start address is: 16 (R4)
; i start address is: 12 (R3)
; ack start address is: 0 (R0)
CMP	R3, #0
IT	EQ
BEQ	L_s_read_byte13
;sht11_driver.c,80 :: 		SCL_pin = 1;          //clk for SENSI-BUS
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(SCL_pin+0)
MOVT	R1, #hi_addr(SCL_pin+0)
STR	R2, [R1, #0]
;sht11_driver.c,81 :: 		Delay_uS(10);
MOVW	R7, #239
MOVT	R7, #0
NOP
NOP
L_s_read_byte14:
SUBS	R7, R7, #1
BNE	L_s_read_byte14
NOP
NOP
;sht11_driver.c,82 :: 		if (SDA_pin == 1)
MOVW	R2, #lo_addr(SDA_pin+0)
MOVT	R2, #hi_addr(SDA_pin+0)
LDR	R1, [R2, #0]
CMP	R1, #0
IT	EQ
BEQ	L__s_read_byte63
;sht11_driver.c,84 :: 		val=(val | i);      //read bit
ORRS	R4, R3
UXTB	R4, R4
; val end address is: 16 (R4)
;sht11_driver.c,85 :: 		}
IT	AL
BAL	L_s_read_byte16
L__s_read_byte63:
;sht11_driver.c,82 :: 		if (SDA_pin == 1)
;sht11_driver.c,85 :: 		}
L_s_read_byte16:
;sht11_driver.c,86 :: 		SCL_pin = 0;
; val start address is: 16 (R4)
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(SCL_pin+0)
MOVT	R1, #hi_addr(SCL_pin+0)
STR	R2, [R1, #0]
;sht11_driver.c,87 :: 		Delay_uS(10);
MOVW	R7, #239
MOVT	R7, #0
NOP
NOP
L_s_read_byte17:
SUBS	R7, R7, #1
BNE	L_s_read_byte17
NOP
NOP
;sht11_driver.c,88 :: 		i=(i>>1);
LSRS	R3, R3, #1
UXTB	R3, R3
;sht11_driver.c,89 :: 		}
; i end address is: 12 (R3)
IT	AL
BAL	L_s_read_byte12
L_s_read_byte13:
;sht11_driver.c,91 :: 		SDA_pin_DIR = 1;        // DATA as output
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(SDA_pin_DIR+0)
MOVT	R1, #hi_addr(SDA_pin_DIR+0)
STR	R2, [R1, #0]
;sht11_driver.c,92 :: 		if (ack)
CMP	R0, #0
IT	EQ
BEQ	L_s_read_byte19
; ack end address is: 0 (R0)
;sht11_driver.c,95 :: 		SDA_pin = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(SDA_pin+0)
MOVT	R1, #hi_addr(SDA_pin+0)
STR	R2, [R1, #0]
;sht11_driver.c,96 :: 		}
IT	AL
BAL	L_s_read_byte20
L_s_read_byte19:
;sht11_driver.c,99 :: 		SDA_pin = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(SDA_pin+0)
MOVT	R1, #hi_addr(SDA_pin+0)
STR	R2, [R1, #0]
;sht11_driver.c,100 :: 		}
L_s_read_byte20:
;sht11_driver.c,102 :: 		SCL_pin = 1;            //clk #9 for ack
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(SCL_pin+0)
MOVT	R1, #hi_addr(SCL_pin+0)
STR	R2, [R1, #0]
;sht11_driver.c,103 :: 		Delay_uS(30);
MOVW	R7, #719
MOVT	R7, #0
NOP
NOP
L_s_read_byte21:
SUBS	R7, R7, #1
BNE	L_s_read_byte21
NOP
NOP
NOP
;sht11_driver.c,104 :: 		SCL_pin = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(SCL_pin+0)
MOVT	R1, #hi_addr(SCL_pin+0)
STR	R2, [R1, #0]
;sht11_driver.c,105 :: 		Delay_uS(10);
MOVW	R7, #239
MOVT	R7, #0
NOP
NOP
L_s_read_byte23:
SUBS	R7, R7, #1
BNE	L_s_read_byte23
NOP
NOP
;sht11_driver.c,107 :: 		SDA_pin_DIR = 0;        //release DATA-line
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(SDA_pin_DIR+0)
MOVT	R1, #hi_addr(SDA_pin_DIR+0)
STR	R2, [R1, #0]
;sht11_driver.c,108 :: 		return (val);
UXTB	R0, R4
; val end address is: 16 (R4)
;sht11_driver.c,109 :: 		}
L_end_s_read_byte:
BX	LR
; end of _s_read_byte
_s_write_byte:
;sht11_driver.c,114 :: 		unsigned char s_write_byte(unsigned char value)
; value start address is: 0 (R0)
SUB	SP, SP, #4
; value end address is: 0 (R0)
; value start address is: 0 (R0)
;sht11_driver.c,116 :: 		unsigned char i=0x80;
; i start address is: 12 (R3)
MOVS	R3, #128
;sht11_driver.c,117 :: 		unsigned char error=0;
; error start address is: 16 (R4)
MOVS	R4, #0
;sht11_driver.c,119 :: 		SDA_pin_DIR = 1;        // DATA as output
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(SDA_pin_DIR+0)
MOVT	R1, #hi_addr(SDA_pin_DIR+0)
STR	R2, [R1, #0]
; value end address is: 0 (R0)
; i end address is: 12 (R3)
; error end address is: 16 (R4)
STRB	R4, [SP, #0]
UXTB	R4, R3
UXTB	R3, R0
LDRB	R0, [SP, #0]
;sht11_driver.c,120 :: 		while(i)
L_s_write_byte25:
; error start address is: 0 (R0)
; value start address is: 12 (R3)
; i start address is: 16 (R4)
; value start address is: 12 (R3)
; value end address is: 12 (R3)
CMP	R4, #0
IT	EQ
BEQ	L_s_write_byte26
; value end address is: 12 (R3)
;sht11_driver.c,122 :: 		if (i & value)
; value start address is: 12 (R3)
AND	R1, R4, R3, LSL #0
UXTB	R1, R1
CMP	R1, #0
IT	EQ
BEQ	L_s_write_byte27
;sht11_driver.c,124 :: 		SDA_pin = 1;        //masking value with i , write to SENSI-BUS
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(SDA_pin+0)
MOVT	R1, #hi_addr(SDA_pin+0)
STR	R2, [R1, #0]
;sht11_driver.c,125 :: 		}
IT	AL
BAL	L_s_write_byte28
L_s_write_byte27:
;sht11_driver.c,128 :: 		SDA_pin = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(SDA_pin+0)
MOVT	R1, #hi_addr(SDA_pin+0)
STR	R2, [R1, #0]
;sht11_driver.c,129 :: 		}
L_s_write_byte28:
;sht11_driver.c,131 :: 		SCL_pin = 1;          //clk for SENSI-BUS
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(SCL_pin+0)
MOVT	R1, #hi_addr(SCL_pin+0)
STR	R2, [R1, #0]
;sht11_driver.c,132 :: 		Delay_uS(30);
MOVW	R7, #719
MOVT	R7, #0
NOP
NOP
L_s_write_byte29:
SUBS	R7, R7, #1
BNE	L_s_write_byte29
NOP
NOP
NOP
;sht11_driver.c,133 :: 		SCL_pin = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(SCL_pin+0)
MOVT	R1, #hi_addr(SCL_pin+0)
STR	R2, [R1, #0]
;sht11_driver.c,134 :: 		Delay_uS(30);
MOVW	R7, #719
MOVT	R7, #0
NOP
NOP
L_s_write_byte31:
SUBS	R7, R7, #1
BNE	L_s_write_byte31
NOP
NOP
NOP
;sht11_driver.c,135 :: 		i=(i>>1);
LSRS	R4, R4, #1
UXTB	R4, R4
;sht11_driver.c,136 :: 		}
; value end address is: 12 (R3)
; i end address is: 16 (R4)
IT	AL
BAL	L_s_write_byte25
L_s_write_byte26:
;sht11_driver.c,138 :: 		SDA_pin_DIR = 0;        //release DATA-line
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(SDA_pin_DIR+0)
MOVT	R1, #hi_addr(SDA_pin_DIR+0)
STR	R2, [R1, #0]
;sht11_driver.c,140 :: 		SCL_pin = 1;            //clk #9 for ack
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(SCL_pin+0)
MOVT	R1, #hi_addr(SCL_pin+0)
STR	R2, [R1, #0]
;sht11_driver.c,141 :: 		Delay_uS(30);
MOVW	R7, #719
MOVT	R7, #0
NOP
NOP
L_s_write_byte33:
SUBS	R7, R7, #1
BNE	L_s_write_byte33
NOP
NOP
NOP
;sht11_driver.c,142 :: 		if (SDA_pin == 1)  error = 1; //check ack (DATA will be pulled down by SHT11)
MOVW	R2, #lo_addr(SDA_pin+0)
MOVT	R2, #hi_addr(SDA_pin+0)
LDR	R1, [R2, #0]
CMP	R1, #0
IT	EQ
BEQ	L__s_write_byte64
MOVS	R0, #1
; error end address is: 0 (R0)
IT	AL
BAL	L_s_write_byte35
L__s_write_byte64:
L_s_write_byte35:
;sht11_driver.c,143 :: 		Delay_uS(10);
; error start address is: 0 (R0)
MOVW	R7, #239
MOVT	R7, #0
NOP
NOP
L_s_write_byte36:
SUBS	R7, R7, #1
BNE	L_s_write_byte36
NOP
NOP
;sht11_driver.c,144 :: 		SCL_pin = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(SCL_pin+0)
MOVT	R1, #hi_addr(SCL_pin+0)
STR	R2, [R1, #0]
;sht11_driver.c,146 :: 		return(error); //error=1 in case of no acknowledge
; error end address is: 0 (R0)
;sht11_driver.c,147 :: 		}
L_end_s_write_byte:
ADD	SP, SP, #4
BX	LR
; end of _s_write_byte
_s_measure:
;sht11_driver.c,155 :: 		unsigned char s_measure(unsigned int *p_value, unsigned char mode)
; mode start address is: 4 (R1)
; p_value start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R5, R0
UXTB	R3, R1
; mode end address is: 4 (R1)
; p_value end address is: 0 (R0)
; p_value start address is: 20 (R5)
; mode start address is: 12 (R3)
;sht11_driver.c,157 :: 		unsigned char i=0;
; i start address is: 24 (R6)
MOVS	R6, #0
;sht11_driver.c,161 :: 		*p_value=0;
MOVS	R2, #0
STRH	R2, [R5, #0]
;sht11_driver.c,162 :: 		s_transstart(); //transmission start
BL	_s_transstart+0
;sht11_driver.c,164 :: 		if(mode)
CMP	R3, #0
IT	EQ
BEQ	L_s_measure38
; mode end address is: 12 (R3)
;sht11_driver.c,166 :: 		mode = MEASURE_HUMI;
; mode start address is: 0 (R0)
MOVS	R0, #5
;sht11_driver.c,167 :: 		}
; mode end address is: 0 (R0)
IT	AL
BAL	L_s_measure39
L_s_measure38:
;sht11_driver.c,170 :: 		mode = MEASURE_TEMP;
; mode start address is: 0 (R0)
MOVS	R0, #3
; mode end address is: 0 (R0)
;sht11_driver.c,171 :: 		}
L_s_measure39:
;sht11_driver.c,173 :: 		if (s_write_byte(mode)) return(1);
; mode start address is: 0 (R0)
; mode end address is: 0 (R0)
BL	_s_write_byte+0
CMP	R0, #0
IT	EQ
BEQ	L_s_measure40
; i end address is: 24 (R6)
; p_value end address is: 20 (R5)
MOVS	R0, #1
IT	AL
BAL	L_end_s_measure
L_s_measure40:
;sht11_driver.c,176 :: 		SDA_pin_DIR = 0;           //release DATA-line
; p_value start address is: 20 (R5)
; i start address is: 24 (R6)
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(SDA_pin_DIR+0)
MOVT	R2, #hi_addr(SDA_pin_DIR+0)
STR	R3, [R2, #0]
; i end address is: 24 (R6)
; p_value end address is: 20 (R5)
UXTB	R0, R6
;sht11_driver.c,178 :: 		while(i<240)
L_s_measure41:
; i start address is: 0 (R0)
; p_value start address is: 20 (R5)
CMP	R0, #240
IT	CS
BCS	L__s_measure65
;sht11_driver.c,180 :: 		Delay_mS(1);
MOVW	R7, #23999
MOVT	R7, #0
NOP
NOP
L_s_measure43:
SUBS	R7, R7, #1
BNE	L_s_measure43
NOP
NOP
;sht11_driver.c,181 :: 		Delay_mS(1);
MOVW	R7, #23999
MOVT	R7, #0
NOP
NOP
L_s_measure45:
SUBS	R7, R7, #1
BNE	L_s_measure45
NOP
NOP
;sht11_driver.c,182 :: 		Delay_mS(1);
MOVW	R7, #23999
MOVT	R7, #0
NOP
NOP
L_s_measure47:
SUBS	R7, R7, #1
BNE	L_s_measure47
NOP
NOP
;sht11_driver.c,183 :: 		if (SDA_pin == 0)
MOVW	R3, #lo_addr(SDA_pin+0)
MOVT	R3, #hi_addr(SDA_pin+0)
LDR	R2, [R3, #0]
CMP	R2, #0
IT	NE
BNE	L_s_measure49
;sht11_driver.c,185 :: 		i=0;
MOVS	R0, #0
;sht11_driver.c,186 :: 		break;
IT	AL
BAL	L_s_measure42
;sht11_driver.c,187 :: 		}
L_s_measure49:
;sht11_driver.c,188 :: 		i++;
ADDS	R0, R0, #1
UXTB	R0, R0
;sht11_driver.c,189 :: 		}
; i end address is: 0 (R0)
IT	AL
BAL	L_s_measure41
L__s_measure65:
;sht11_driver.c,178 :: 		while(i<240)
;sht11_driver.c,189 :: 		}
L_s_measure42:
;sht11_driver.c,192 :: 		if(i) return(2);
; i start address is: 0 (R0)
CMP	R0, #0
IT	EQ
BEQ	L_s_measure50
; p_value end address is: 20 (R5)
; i end address is: 0 (R0)
MOVS	R0, #2
IT	AL
BAL	L_end_s_measure
L_s_measure50:
;sht11_driver.c,194 :: 		msb=s_read_byte(ACK); //read the first byte (MSB)
; p_value start address is: 20 (R5)
MOVS	R0, #1
BL	_s_read_byte+0
; msb start address is: 24 (R6)
UXTB	R6, R0
;sht11_driver.c,195 :: 		lsb=s_read_byte(ACK); //read the second byte (LSB)
MOVS	R0, #1
BL	_s_read_byte+0
; lsb start address is: 32 (R8)
UXTB	R8, R0
;sht11_driver.c,196 :: 		checksum=s_read_byte(noACK);                //read checksum (8-bit)
MOVS	R0, #0
BL	_s_read_byte+0
;sht11_driver.c,198 :: 		*p_value=(msb<<8)|(lsb);
LSLS	R2, R6, #8
UXTH	R2, R2
; msb end address is: 24 (R6)
ORR	R2, R2, R8, LSL #0
; lsb end address is: 32 (R8)
STRH	R2, [R5, #0]
; p_value end address is: 20 (R5)
;sht11_driver.c,200 :: 		return(0);
MOVS	R0, #0
;sht11_driver.c,201 :: 		}
L_end_s_measure:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _s_measure
_calc_sth11_temp:
;sht11_driver.c,208 :: 		float calc_sth11_temp(unsigned int t)
; t start address is: 0 (R0)
; t end address is: 0 (R0)
; t start address is: 0 (R0)
;sht11_driver.c,211 :: 		t_out =  t*0.01 - 40;
VMOV	S1, R0
VCVT.F32	#0, S1, S1
; t end address is: 0 (R0)
MOVW	R1, #55050
MOVT	R1, #15395
VMOV	S0, R1
VMUL.F32	S1, S1, S0
MOVW	R1, #0
MOVT	R1, #16928
VMOV	S0, R1
VSUB.F32	S0, S1, S0
;sht11_driver.c,213 :: 		return t_out;
VMOV.F32	S0, S0
;sht11_driver.c,214 :: 		}
L_end_calc_sth11_temp:
BX	LR
; end of _calc_sth11_temp
_calc_sth11_humi:
;sht11_driver.c,224 :: 		float calc_sth11_humi(unsigned int h, int t)
; t start address is: 4 (R1)
; h start address is: 0 (R0)
; t end address is: 4 (R1)
; h end address is: 0 (R0)
; h start address is: 0 (R0)
; t start address is: 4 (R1)
;sht11_driver.c,226 :: 		t_C=t*0.01 - 40;                          //calc. temperature from ticks to [°C]
VMOV	S1, R1
VCVT.F32	#1, S1, S1
; t end address is: 4 (R1)
MOVW	R2, #55050
MOVT	R2, #15395
VMOV	S0, R2
VMUL.F32	S1, S1, S0
MOVW	R2, #0
MOVT	R2, #16928
VMOV	S0, R2
VSUB.F32	S2, S1, S0
MOVW	R2, #lo_addr(_t_C+0)
MOVT	R2, #hi_addr(_t_C+0)
VSTR	#1, S2, [R2, #0]
;sht11_driver.c,227 :: 		rh_lin=C3*h*h + C2*h + C1;                //calc. humidity from ticks to [%RH]
VMOV	S4, R0
VCVT.F32	#0, S4, S4
; h end address is: 0 (R0)
MOVW	R2, #59298
MOVT	R2, #46651
VMOV	S0, R2
VMUL.F32	S0, S0, S4
VMUL.F32	S1, S0, S4
MOVW	R2, #58196
MOVT	R2, #15653
VMOV	S0, R2
VMUL.F32	S0, S0, S4
VADD.F32	S1, S1, S0
VMOV.F32	S0, #-4
VADD.F32	S3, S1, S0
MOVW	R2, #lo_addr(_rh_lin+0)
MOVT	R2, #hi_addr(_rh_lin+0)
VSTR	#1, S3, [R2, #0]
;sht11_driver.c,228 :: 		rh_true=(t_C-25)*(Temp1+Temp2*h)+rh_lin;        //calc. temperature compensated humidity
VMOV.F32	S0, #25
VSUB.F32	S2, S2, S0
MOVW	R2, #50604
MOVT	R2, #14503
VMOV	S0, R2
VMUL.F32	S1, S0, S4
MOVW	R2, #55050
MOVT	R2, #15395
VMOV	S0, R2
VADD.F32	S0, S0, S1
VMUL.F32	S0, S2, S0
VADD.F32	S1, S0, S3
MOVW	R2, #lo_addr(_rh_true+0)
MOVT	R2, #hi_addr(_rh_true+0)
VSTR	#1, S1, [R2, #0]
;sht11_driver.c,237 :: 		if(rh_true>100)rh_true=100;               //cut if the value is outside of
MOVW	R2, #0
MOVT	R2, #17096
VMOV	S0, R2
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	LE
BLE	L_calc_sth11_humi51
MOVW	R2, #0
MOVT	R2, #17096
VMOV	S0, R2
MOVW	R2, #lo_addr(_rh_true+0)
MOVT	R2, #hi_addr(_rh_true+0)
VSTR	#1, S0, [R2, #0]
L_calc_sth11_humi51:
;sht11_driver.c,238 :: 		if(rh_true<0.1)rh_true=0.1;               //the physical possible range
MOVW	R2, #lo_addr(_rh_true+0)
MOVT	R2, #hi_addr(_rh_true+0)
VLDR	#1, S1, [R2, #0]
MOVW	R2, #52429
MOVT	R2, #15820
VMOV	S0, R2
VCMPE.F32	S1, S0
VMRS	#60, FPSCR
IT	GE
BGE	L_calc_sth11_humi52
MOVW	R2, #52429
MOVT	R2, #15820
VMOV	S0, R2
MOVW	R2, #lo_addr(_rh_true+0)
MOVT	R2, #hi_addr(_rh_true+0)
VSTR	#1, S0, [R2, #0]
L_calc_sth11_humi52:
;sht11_driver.c,240 :: 		return rh_true;
MOVW	R2, #lo_addr(_rh_true+0)
MOVT	R2, #hi_addr(_rh_true+0)
VLDR	#1, S0, [R2, #0]
;sht11_driver.c,241 :: 		}
L_end_calc_sth11_humi:
BX	LR
; end of _calc_sth11_humi
_Read_SHT11:
;sht11_driver.c,246 :: 		void Read_SHT11(float *fT, float *fRH)
; fRH start address is: 4 (R1)
; fT start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
MOV	R9, R0
MOV	R10, R1
; fRH end address is: 4 (R1)
; fT end address is: 0 (R0)
; fT start address is: 36 (R9)
; fRH start address is: 40 (R10)
;sht11_driver.c,252 :: 		ucSens_Error = 0;
MOVS	R3, #0
MOVW	R2, #lo_addr(_ucSens_Error+0)
MOVT	R2, #hi_addr(_ucSens_Error+0)
STRB	R3, [R2, #0]
;sht11_driver.c,254 :: 		ucSens_Error = s_measure(&t, 0);
ADD	R2, SP, #4
MOVS	R1, #0
MOV	R0, R2
BL	_s_measure+0
MOVW	R2, #lo_addr(_ucSens_Error+0)
MOVT	R2, #hi_addr(_ucSens_Error+0)
STRB	R0, [R2, #0]
;sht11_driver.c,255 :: 		iSHT_Temp = (int)(calc_sth11_temp(t) * 10);
LDRH	R0, [SP, #4]
BL	_calc_sth11_temp+0
VMOV.F32	S1, #10
VMUL.F32	S0, S0, S1
VCVT	#1, .F32, S0, S0
VMOV	R3, S0
SXTH	R3, R3
MOVW	R2, #lo_addr(_iSHT_Temp+0)
MOVT	R2, #hi_addr(_iSHT_Temp+0)
STR	R2, [SP, #8]
STRH	R3, [R2, #0]
;sht11_driver.c,257 :: 		ucSens_Error = s_measure(&h, 1);
ADD	R2, SP, #6
MOVS	R1, #1
MOV	R0, R2
BL	_s_measure+0
MOVW	R2, #lo_addr(_ucSens_Error+0)
MOVT	R2, #hi_addr(_ucSens_Error+0)
STRB	R0, [R2, #0]
;sht11_driver.c,258 :: 		iSHT_Humi = (int)(calc_sth11_humi(h, t) * 10);
LDRH	R1, [SP, #4]
LDRH	R0, [SP, #6]
BL	_calc_sth11_humi+0
VMOV.F32	S1, #10
VMUL.F32	S0, S0, S1
VCVT	#1, .F32, S0, S0
VMOV	R2, S0
SXTH	R2, R2
MOVW	R3, #lo_addr(_iSHT_Humi+0)
MOVT	R3, #hi_addr(_iSHT_Humi+0)
STRH	R2, [R3, #0]
;sht11_driver.c,260 :: 		value = (float)iSHT_Temp;
LDR	R2, [SP, #8]
LDRSH	R2, [R2, #0]
VMOV	S1, R2
VCVT.F32	#1, S1, S1
;sht11_driver.c,261 :: 		*fT = value / 10;
VMOV.F32	S0, #10
VDIV.F32	S0, S1, S0
VSTR	#1, S0, [R9, #0]
; fT end address is: 36 (R9)
;sht11_driver.c,262 :: 		value = (float)iSHT_Humi;
MOV	R2, R3
LDRSH	R2, [R2, #0]
VMOV	S1, R2
VCVT.F32	#1, S1, S1
;sht11_driver.c,263 :: 		*fRH = value / 10;
VMOV.F32	S0, #10
VDIV.F32	S0, S1, S0
VSTR	#1, S0, [R10, #0]
; fRH end address is: 40 (R10)
;sht11_driver.c,264 :: 		}
L_end_Read_SHT11:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _Read_SHT11
_s_read_statusreg:
;sht11_driver.c,269 :: 		char s_read_statusreg(unsigned char *p_value)
; p_value start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R5, R0
; p_value end address is: 0 (R0)
; p_value start address is: 20 (R5)
;sht11_driver.c,271 :: 		unsigned char checksum = 0;
;sht11_driver.c,273 :: 		s_transstart();                             //transmission start
BL	_s_transstart+0
;sht11_driver.c,274 :: 		if(s_write_byte(STATUS_REG_R)) return 1;    //send command to sensor
MOVS	R0, #7
BL	_s_write_byte+0
CMP	R0, #0
IT	EQ
BEQ	L_s_read_statusreg53
; p_value end address is: 20 (R5)
MOVS	R0, #1
IT	AL
BAL	L_end_s_read_statusreg
L_s_read_statusreg53:
;sht11_driver.c,275 :: 		*p_value=s_read_byte(ACK);                  //read status register (8-bit)
; p_value start address is: 20 (R5)
MOVS	R0, #1
BL	_s_read_byte+0
STRB	R0, [R5, #0]
; p_value end address is: 20 (R5)
;sht11_driver.c,276 :: 		checksum=s_read_byte(noACK);                //read checksum (8-bit)
MOVS	R0, #0
BL	_s_read_byte+0
;sht11_driver.c,278 :: 		return 0;
MOVS	R0, #0
;sht11_driver.c,279 :: 		}
L_end_s_read_statusreg:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _s_read_statusreg
_s_write_statusreg:
;sht11_driver.c,286 :: 		char s_write_statusreg(unsigned char value)
; value start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R5, R0
; value end address is: 0 (R0)
; value start address is: 20 (R5)
;sht11_driver.c,288 :: 		s_transstart();                             //transmission start
BL	_s_transstart+0
;sht11_driver.c,289 :: 		if(s_write_byte(STATUS_REG_W)) return 1;    //send command to sensor
MOVS	R0, #6
BL	_s_write_byte+0
CMP	R0, #0
IT	EQ
BEQ	L_s_write_statusreg54
; value end address is: 20 (R5)
MOVS	R0, #1
IT	AL
BAL	L_end_s_write_statusreg
L_s_write_statusreg54:
;sht11_driver.c,290 :: 		if(s_write_byte(value)) return 1;           //send value of status register
; value start address is: 20 (R5)
UXTB	R0, R5
; value end address is: 20 (R5)
BL	_s_write_byte+0
CMP	R0, #0
IT	EQ
BEQ	L_s_write_statusreg55
MOVS	R0, #1
IT	AL
BAL	L_end_s_write_statusreg
L_s_write_statusreg55:
;sht11_driver.c,292 :: 		return 0;
MOVS	R0, #0
;sht11_driver.c,293 :: 		}
L_end_s_write_statusreg:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _s_write_statusreg
_s_connectionreset:
;sht11_driver.c,302 :: 		void s_connectionreset()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;sht11_driver.c,305 :: 		SDA_pin_DIR = 0;                       //release DATA-line
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(SDA_pin_DIR+0)
MOVT	R0, #hi_addr(SDA_pin_DIR+0)
STR	R1, [R0, #0]
;sht11_driver.c,306 :: 		SCL_pin = 0;                           // SCL Low
MOVW	R0, #lo_addr(SCL_pin+0)
MOVT	R0, #hi_addr(SCL_pin+0)
STR	R1, [R0, #0]
;sht11_driver.c,308 :: 		for(i=0; i<9; i++)                     //9 SCK cycles
; i start address is: 8 (R2)
MOVS	R2, #0
; i end address is: 8 (R2)
L_s_connectionreset56:
; i start address is: 8 (R2)
CMP	R2, #9
IT	CS
BCS	L_s_connectionreset57
;sht11_driver.c,310 :: 		SCL_pin = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(SCL_pin+0)
MOVT	R0, #hi_addr(SCL_pin+0)
STR	R1, [R0, #0]
;sht11_driver.c,311 :: 		Delay_uS(30);
MOVW	R7, #719
MOVT	R7, #0
NOP
NOP
L_s_connectionreset59:
SUBS	R7, R7, #1
BNE	L_s_connectionreset59
NOP
NOP
NOP
;sht11_driver.c,312 :: 		SCL_pin = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(SCL_pin+0)
MOVT	R0, #hi_addr(SCL_pin+0)
STR	R1, [R0, #0]
;sht11_driver.c,313 :: 		Delay_uS(30);
MOVW	R7, #719
MOVT	R7, #0
NOP
NOP
L_s_connectionreset61:
SUBS	R7, R7, #1
BNE	L_s_connectionreset61
NOP
NOP
NOP
;sht11_driver.c,308 :: 		for(i=0; i<9; i++)                     //9 SCK cycles
ADDS	R2, R2, #1
UXTB	R2, R2
;sht11_driver.c,314 :: 		}
; i end address is: 8 (R2)
IT	AL
BAL	L_s_connectionreset56
L_s_connectionreset57:
;sht11_driver.c,316 :: 		s_transstart();                        //transmission start
BL	_s_transstart+0
;sht11_driver.c,317 :: 		}
L_end_s_connectionreset:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _s_connectionreset
_s_softreset:
;sht11_driver.c,322 :: 		unsigned char s_softreset(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;sht11_driver.c,324 :: 		s_connectionreset();                         //reset communication
BL	_s_connectionreset+0
;sht11_driver.c,326 :: 		return (s_write_byte(RESET));                //return=1 in case of no response form the sensor
MOVS	R0, #30
BL	_s_write_byte+0
;sht11_driver.c,327 :: 		}
L_end_s_softreset:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _s_softreset
