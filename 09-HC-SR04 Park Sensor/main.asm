
_wait:

;main.c,16 :: 		void wait(unsigned int time){
;main.c,17 :: 		while(time--)
L_wait0:
	MOVF        FARG_wait_time+0, 0 
	MOVWF       R0 
	MOVF        FARG_wait_time+1, 0 
	MOVWF       R1 
	MOVLW       1
	SUBWF       FARG_wait_time+0, 1 
	MOVLW       0
	SUBWFB      FARG_wait_time+1, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_wait1
;main.c,18 :: 		delay_ms(1);
	MOVLW       16
	MOVWF       R12, 0
	MOVLW       148
	MOVWF       R13, 0
L_wait2:
	DECFSZ      R13, 1, 1
	BRA         L_wait2
	DECFSZ      R12, 1, 1
	BRA         L_wait2
	NOP
	GOTO        L_wait0
L_wait1:
;main.c,19 :: 		}
L_end_wait:
	RETURN      0
; end of _wait

_getDistance:

;main.c,21 :: 		unsigned int getDistance(){
;main.c,23 :: 		T0CON=0b01000110;
	MOVLW       70
	MOVWF       T0CON+0 
;main.c,24 :: 		TMR0H=0;
	CLRF        TMR0H+0 
;main.c,25 :: 		TMR0L=0;
	CLRF        TMR0L+0 
;main.c,27 :: 		TRIG=1;
	BSF         LATB0_bit+0, BitPos(LATB0_bit+0) 
;main.c,28 :: 		delay_us(10);
	MOVLW       39
	MOVWF       R13, 0
L_getDistance3:
	DECFSZ      R13, 1, 1
	BRA         L_getDistance3
	NOP
	NOP
;main.c,29 :: 		TRIG=0;
	BCF         LATB0_bit+0, BitPos(LATB0_bit+0) 
;main.c,31 :: 		while(!ECHO);
L_getDistance4:
	BTFSC       RB1_bit+0, BitPos(RB1_bit+0) 
	GOTO        L_getDistance5
	GOTO        L_getDistance4
L_getDistance5:
;main.c,32 :: 		TMR0ON_bit=1;
	BSF         TMR0ON_bit+0, BitPos(TMR0ON_bit+0) 
;main.c,33 :: 		while(ECHO && TMR0L<250);
L_getDistance6:
	BTFSS       RB1_bit+0, BitPos(RB1_bit+0) 
	GOTO        L_getDistance7
	MOVLW       250
	SUBWF       TMR0L+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_getDistance7
L__getDistance18:
	GOTO        L_getDistance6
L_getDistance7:
;main.c,35 :: 		temp=1.8303*TMR0L;
	MOVF        TMR0L+0, 0 
	MOVWF       R0 
	CALL        _byte2double+0, 0
	MOVLW       69
	MOVWF       R4 
	MOVLW       71
	MOVWF       R5 
	MOVLW       106
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2word+0, 0
;main.c,37 :: 		return temp;
;main.c,38 :: 		}
L_end_getDistance:
	RETURN      0
; end of _getDistance

_main:

;main.c,40 :: 		void main() {
;main.c,41 :: 		TRISA=0b00000000; // [][][][LED][][][][]
	CLRF        TRISA+0 
;main.c,42 :: 		TRISB=0b00000010; // [][][][][][][ECHO][TRIG]
	MOVLW       2
	MOVWF       TRISB+0 
;main.c,43 :: 		TRISD=0b00000000; // [][][][][BUZZER][LEDG][LEDY][LEDR]
	CLRF        TRISD+0 
;main.c,45 :: 		LATA=0x00;
	CLRF        LATA+0 
;main.c,46 :: 		LATB=0x00;
	CLRF        LATB+0 
;main.c,47 :: 		LATD=0x00;
	CLRF        LATD+0 
;main.c,49 :: 		ADCON1=0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;main.c,50 :: 		while(1){
L_main10:
;main.c,51 :: 		distance=getDistance();
	CALL        _getDistance+0, 0
	MOVF        R0, 0 
	MOVWF       _distance+0 
	MOVF        R1, 0 
	MOVWF       _distance+1 
;main.c,53 :: 		if(distance>200){
	MOVLW       0
	MOVWF       R2 
	MOVF        R1, 0 
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main22
	MOVF        R0, 0 
	SUBLW       200
L__main22:
	BTFSC       STATUS+0, 0 
	GOTO        L_main12
;main.c,54 :: 		LEDR=0; LEDY=0; LEDG=!LEDG;
	BCF         LATD0_bit+0, BitPos(LATD0_bit+0) 
	BCF         LATD1_bit+0, BitPos(LATD1_bit+0) 
	BTG         LATD2_bit+0, BitPos(LATD2_bit+0) 
;main.c,55 :: 		}
	GOTO        L_main13
L_main12:
;main.c,56 :: 		else if(distance>100){
	MOVLW       0
	MOVWF       R0 
	MOVF        _distance+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main23
	MOVF        _distance+0, 0 
	SUBLW       100
L__main23:
	BTFSC       STATUS+0, 0 
	GOTO        L_main14
;main.c,57 :: 		LEDR=0; LEDY=!LEDY; LEDG=1;
	BCF         LATD0_bit+0, BitPos(LATD0_bit+0) 
	BTG         LATD1_bit+0, BitPos(LATD1_bit+0) 
	BSF         LATD2_bit+0, BitPos(LATD2_bit+0) 
;main.c,58 :: 		}
	GOTO        L_main15
L_main14:
;main.c,60 :: 		LEDR=!LED; LEDY=1; LEDG=1;
	BTFSC       LATA4_bit+0, BitPos(LATA4_bit+0) 
	GOTO        L__main24
	BSF         LATD0_bit+0, BitPos(LATD0_bit+0) 
	GOTO        L__main25
L__main24:
	BCF         LATD0_bit+0, BitPos(LATD0_bit+0) 
L__main25:
	BSF         LATD1_bit+0, BitPos(LATD1_bit+0) 
	BSF         LATD2_bit+0, BitPos(LATD2_bit+0) 
;main.c,61 :: 		}
L_main15:
L_main13:
;main.c,63 :: 		if(distance<50){
	MOVLW       0
	SUBWF       _distance+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main26
	MOVLW       50
	SUBWF       _distance+0, 0 
L__main26:
	BTFSC       STATUS+0, 0 
	GOTO        L_main16
;main.c,64 :: 		BUZZER=1;
	BSF         LATD3_bit+0, BitPos(LATD3_bit+0) 
;main.c,65 :: 		}
	GOTO        L_main17
L_main16:
;main.c,67 :: 		BUZZER=!BUZZER;
	BTG         LATD3_bit+0, BitPos(LATD3_bit+0) 
;main.c,68 :: 		wait(distance);
	MOVF        _distance+0, 0 
	MOVWF       FARG_wait_time+0 
	MOVF        _distance+1, 0 
	MOVWF       FARG_wait_time+1 
	CALL        _wait+0, 0
;main.c,69 :: 		}
L_main17:
;main.c,70 :: 		}
	GOTO        L_main10
;main.c,71 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
