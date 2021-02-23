_Init_Gpio:
;init_func.c,4 :: 		void Init_Gpio()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;init_func.c,7 :: 		GPIO_Config(&GPIO_PORTF, _GPIO_PINMASK_1|_GPIO_PINMASK_2|_GPIO_PINMASK_3 , _GPIO_DIR_OUTPUT, _GPIO_CFG_DIGITAL_ENABLE| _GPIO_CFG_DRIVE_8mA , _GPIO_PINCODE_NONE);
MOVS	R0, #0
PUSH	(R0)
MOVW	R3, #320
MOVS	R2, #1
MOVS	R1, #14
MOVW	R0, #20480
MOVT	R0, #16386
BL	_GPIO_Config+0
ADD	SP, SP, #4
;init_func.c,9 :: 		GPIO_Config(&GPIO_PORTA, _GPIO_PINMASK_3|_GPIO_PINMASK_4|_GPIO_PINMASK_5 , _GPIO_DIR_OUTPUT, _GPIO_CFG_DIGITAL_ENABLE| _GPIO_CFG_DRIVE_8mA , _GPIO_PINCODE_NONE);
MOVS	R0, #0
PUSH	(R0)
MOVW	R3, #320
MOVS	R2, #1
MOVS	R1, #56
MOVW	R0, #16384
MOVT	R0, #16384
BL	_GPIO_Config+0
ADD	SP, SP, #4
;init_func.c,10 :: 		GPIO_Config(&GPIO_PORTB, _GPIO_PINMASK_5|_GPIO_PINMASK_6|_GPIO_PINMASK_7 , _GPIO_DIR_OUTPUT, _GPIO_CFG_DIGITAL_ENABLE| _GPIO_CFG_DRIVE_8mA , _GPIO_PINCODE_NONE);
MOVS	R0, #0
PUSH	(R0)
MOVW	R3, #320
MOVS	R2, #1
MOVS	R1, #224
MOVW	R0, #20480
MOVT	R0, #16384
BL	_GPIO_Config+0
ADD	SP, SP, #4
;init_func.c,11 :: 		GPIO_Config(&GPIO_PORTE, _GPIO_PINMASK_0 , _GPIO_DIR_OUTPUT, _GPIO_CFG_DIGITAL_ENABLE| _GPIO_CFG_DRIVE_8mA  , _GPIO_PINCODE_NONE);
MOVS	R0, #0
PUSH	(R0)
MOVW	R3, #320
MOVS	R2, #1
MOVS	R1, #1
MOVW	R0, #16384
MOVT	R0, #16386
BL	_GPIO_Config+0
ADD	SP, SP, #4
;init_func.c,13 :: 		GPIO_Config(&GPIO_PORTB, _GPIO_PINMASK_3, _GPIO_DIR_INPUT, _GPIO_CFG_DIGITAL_ENABLE, _GPIO_PINCODE_NONE);
MOVS	R0, #0
PUSH	(R0)
MOVW	R3, #256
MOVS	R2, #0
MOVS	R1, #8
MOVW	R0, #20480
MOVT	R0, #16384
BL	_GPIO_Config+0
ADD	SP, SP, #4
;init_func.c,15 :: 		GPIO_Config(&GPIO_PORTA, _GPIO_PINMASK_2, _GPIO_DIR_OUTPUT, _GPIO_CFG_DIGITAL_ENABLE| _GPIO_CFG_DRIVE_8mA , _GPIO_PINCODE_NONE);
MOVS	R0, #0
PUSH	(R0)
MOVW	R3, #320
MOVS	R2, #1
MOVS	R1, #4
MOVW	R0, #16384
MOVT	R0, #16384
BL	_GPIO_Config+0
ADD	SP, SP, #4
;init_func.c,17 :: 		Sound_Init(&GPIO_PORTE_DATA, 1);
MOVS	R1, #1
MOVW	R0, #17404
MOVT	R0, #16386
BL	_Sound_Init+0
;init_func.c,19 :: 		GPIO_Config(&GPIO_PORTD,_GPIO_PINMASK_6,_GPIO_DIR_INPUT,_GPIO_CFG_DIGITAL_ENABLE,_GPIO_PINCODE_NONE);
MOVS	R0, #0
PUSH	(R0)
MOVW	R3, #256
MOVS	R2, #0
MOVS	R1, #64
MOVW	R0, #28672
MOVT	R0, #16384
BL	_GPIO_Config+0
ADD	SP, SP, #4
;init_func.c,21 :: 		GPIO_Config(&GPIO_PORTB, _GPIO_PINMASK_2 ,_GPIO_DIR_OUTPUT, _GPIO_CFG_DIGITAL_ENABLE, _GPIO_PINCODE_NONE);
MOVS	R0, #0
PUSH	(R0)
MOVW	R3, #256
MOVS	R2, #1
MOVS	R1, #4
MOVW	R0, #20480
MOVT	R0, #16384
BL	_GPIO_Config+0
ADD	SP, SP, #4
;init_func.c,24 :: 		GPIO_Config(&GPIO_PORTD,_GPIO_PINMASK_0|_GPIO_PINMASK_1|_GPIO_PINMASK_2|_GPIO_PINMASK_3,_GPIO_DIR_INPUT,_GPIO_CFG_DIGITAL_ENABLE,_GPIO_PINCODE_NONE);
MOVS	R0, #0
PUSH	(R0)
MOVW	R3, #256
MOVS	R2, #0
MOVS	R1, #15
MOVW	R0, #28672
MOVT	R0, #16384
BL	_GPIO_Config+0
ADD	SP, SP, #4
;init_func.c,26 :: 		}
L_end_Init_Gpio:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Init_Gpio
_Init_ext_int:
;init_func.c,28 :: 		void Init_ext_int()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;init_func.c,30 :: 		GPIO_PORTD_AFSEL = _GPIO_PINMASK_6;    // Enable alternate pin functions
MOVW	R1, #64
MOVW	R0, 1073771552
MOVT	R0, 16384
STR	R1, [R0, #0]
;init_func.c,31 :: 		GPIO_PORTD_IS = 0;                     // Edge sensitive
MOVS	R1, #0
MOVW	R0, 1073771524
MOVT	R0, 16384
STR	R1, [R0, #0]
;init_func.c,32 :: 		GPIO_PORTD_IBE = 0;                    // Edge/Level detection triggers interrupt
MOVS	R1, #0
MOVW	R0, 1073771528
MOVT	R0, 16384
STR	R1, [R0, #0]
;init_func.c,33 :: 		GPIO_PORTD_IEV = _GPIO_PINMASK_6;      // Rising Edge will trigger interrupt
MOVW	R1, #64
MOVW	R0, 1073771532
MOVT	R0, 16384
STR	R1, [R0, #0]
;init_func.c,34 :: 		GPIO_PORTD_IM = _GPIO_PINMASK_6;       // Set mask to pin6
MOVW	R1, #64
MOVW	R0, 1073771536
MOVT	R0, 16384
STR	R1, [R0, #0]
;init_func.c,35 :: 		NVIC_IntEnable(IVT_INT_GPIOD);         // Enable GPIOD interrupt
MOVW	R0, #19
BL	_NVIC_IntEnable+0
;init_func.c,37 :: 		}
L_end_Init_ext_int:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Init_ext_int
_InitTimer0A:
;init_func.c,40 :: 		void InitTimer0A(){
SUB	SP, SP, #8
STR	LR, [SP, #0]
;init_func.c,41 :: 		SYSCTL_RCGCTIMER_R0_bit = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, 1074783748
MOVT	R0, 16399
STR	R1, [R0, #0]
;init_func.c,42 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;init_func.c,43 :: 		TIMER_CTL_TAEN_bit = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, 1073938444
MOVT	R0, 16387
STR	R0, [SP, #4]
STR	R1, [R0, #0]
;init_func.c,44 :: 		TIMER0_CFG   = 4;
MOVS	R1, #4
MOVW	R0, 1073938432
MOVT	R0, 16387
STR	R1, [R0, #0]
;init_func.c,45 :: 		TIMER0_TAMR |= 2;
MOVW	R0, 1073938436
MOVT	R0, 16387
LDR	R0, [R0, #0]
ORR	R1, R0, #2
MOVW	R0, 1073938436
MOVT	R0, 16387
STR	R1, [R0, #0]
;init_func.c,46 :: 		TIMER0_TAPR  = 63;
MOVS	R1, #63
MOVW	R0, 1073938488
MOVT	R0, 16387
STR	R1, [R0, #0]
;init_func.c,47 :: 		TIMER0_TAILR = 62500;
MOVW	R1, #62500
MOVW	R0, 1073938472
MOVT	R0, 16387
STR	R1, [R0, #0]
;init_func.c,48 :: 		NVIC_IntEnable(IVT_INT_TIMER0A_16_32_bit);
MOVW	R0, #35
BL	_NVIC_IntEnable+0
;init_func.c,49 :: 		TIMER_IMR_TATOIM_bit = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, 1073938456
MOVT	R0, 16387
STR	R1, [R0, #0]
;init_func.c,50 :: 		TIMER_CTL_TAEN_bit   = 1;
LDR	R0, [SP, #4]
STR	R1, [R0, #0]
;init_func.c,51 :: 		}
L_end_InitTimer0A:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _InitTimer0A
_StartTimer1A_10ms:
;init_func.c,56 :: 		void StartTimer1A_10ms(unsigned long interval){ //50000=>10ms
; interval start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
; interval end address is: 0 (R0)
; interval start address is: 0 (R0)
;init_func.c,57 :: 		SYSCTL_RCGCTIMER_R1_bit = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, 1074783748
MOVT	R1, 16399
STR	R2, [R1, #0]
;init_func.c,58 :: 		TIMER_CTL_TAEN_TIMER1_CTL_bit = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, 1073942540
MOVT	R1, 16387
STR	R1, [SP, #4]
STR	R2, [R1, #0]
;init_func.c,59 :: 		TIMER1_CFG   = 4;
MOVS	R2, #4
MOVW	R1, 1073942528
MOVT	R1, 16387
STR	R2, [R1, #0]
;init_func.c,60 :: 		TIMER1_TAMR |= 2;
MOVW	R1, 1073942532
MOVT	R1, 16387
LDR	R1, [R1, #0]
ORR	R2, R1, #2
MOVW	R1, 1073942532
MOVT	R1, 16387
STR	R2, [R1, #0]
;init_func.c,61 :: 		TIMER1_TAPR  = 15;
MOVS	R2, #15
MOVW	R1, 1073942584
MOVT	R1, 16387
STR	R2, [R1, #0]
;init_func.c,62 :: 		TIMER1_TAILR = interval;//50000;
MOVW	R1, 1073942568
MOVT	R1, 16387
STR	R0, [R1, #0]
; interval end address is: 0 (R0)
;init_func.c,63 :: 		NVIC_IntEnable(IVT_INT_TIMER1A_16_32_bit);
MOVW	R0, #37
BL	_NVIC_IntEnable+0
;init_func.c,64 :: 		TIMER_IMR_TATOIM_TIMER1_IMR_bit = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, 1073942552
MOVT	R1, 16387
STR	R2, [R1, #0]
;init_func.c,65 :: 		TIMER_CTL_TAEN_TIMER1_CTL_bit = 1;
LDR	R1, [SP, #4]
STR	R2, [R1, #0]
;init_func.c,66 :: 		}
L_end_StartTimer1A_10ms:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _StartTimer1A_10ms
_StopTimer1A_10ms:
;init_func.c,68 :: 		void StopTimer1A_10ms(){
;init_func.c,69 :: 		TIMER_CTL_TAEN_TIMER1_CTL_bit = 0;
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, 1073942540
MOVT	R2, 16387
STR	R3, [R2, #0]
;init_func.c,70 :: 		TIMER1_CFG   = 0;
MOVS	R1, #0
MOVW	R0, 1073942528
MOVT	R0, 16387
STR	R1, [R0, #0]
;init_func.c,71 :: 		TIMER1_TAMR  = 0;
MOVS	R1, #0
MOVW	R0, 1073942532
MOVT	R0, 16387
STR	R1, [R0, #0]
;init_func.c,72 :: 		TIMER1_TAPR  = 0;
MOVS	R1, #0
MOVW	R0, 1073942584
MOVT	R0, 16387
STR	R1, [R0, #0]
;init_func.c,73 :: 		TIMER1_TAILR = 0;
MOVS	R1, #0
MOVW	R0, 1073942568
MOVT	R0, 16387
STR	R1, [R0, #0]
;init_func.c,75 :: 		TIMER_IMR_TATOIM_TIMER1_IMR_bit = 0;
MOVW	R0, 1073942552
MOVT	R0, 16387
STR	R3, [R0, #0]
;init_func.c,76 :: 		TIMER_CTL_TAEN_TIMER1_CTL_bit = 0;
STR	R3, [R2, #0]
;init_func.c,77 :: 		}
L_end_StopTimer1A_10ms:
BX	LR
; end of _StopTimer1A_10ms
_Init_flags:
;init_func.c,79 :: 		void Init_flags()
;init_func.c,81 :: 		flag_t.main_timer_ovf                 = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;init_func.c,82 :: 		flag_t.temperatura_alarm              = 0;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;init_func.c,83 :: 		flag_t.temperatura_alarm_cover        = 0;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;init_func.c,84 :: 		flag_t.humidity_alarm                 = 0;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;init_func.c,85 :: 		flag_t.temperatura_triac_alarm        = 0;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;init_func.c,86 :: 		flag_t.cover_status                   = 0;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;init_func.c,87 :: 		flag_t.start_fan                      = 0;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;init_func.c,88 :: 		flag_t.start_process                  = 0;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;init_func.c,89 :: 		flag_t.data_save                      = 0;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;init_func.c,90 :: 		flag_t.status_in_menu                 = 0;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;init_func.c,91 :: 		flag_t.first_start_t                  = 0;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;init_func.c,92 :: 		flag_t.first_start_h                  = 0;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;init_func.c,93 :: 		flag_t.humidity_cover_status          = 0;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;init_func.c,94 :: 		flag_t.humidity_alarm_cover           = 0;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;init_func.c,95 :: 		flag_t.control_humidity               = 0;
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STR	R1, [R0, #0]
;init_func.c,96 :: 		}
L_end_Init_flags:
BX	LR
; end of _Init_flags
