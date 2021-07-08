
_wait:

;main.c,6 :: 		void wait(unsigned int time){
;main.c,7 :: 		while(time--)
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
;main.c,8 :: 		delay_ms(1);
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
;main.c,9 :: 		}
L_end_wait:
	RETURN      0
; end of _wait

_InitTimer0:

;main.c,14 :: 		void InitTimer0(){
;main.c,15 :: 		T0CON	 = 0x87;
	MOVLW       135
	MOVWF       T0CON+0 
;main.c,16 :: 		TMR0H	 = 0x48;
	MOVLW       72
	MOVWF       TMR0H+0 
;main.c,17 :: 		TMR0L	 = 0xE5;
	MOVLW       229
	MOVWF       TMR0L+0 
;main.c,18 :: 		GIE_bit	 = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;main.c,19 :: 		TMR0IE_bit	 = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;main.c,20 :: 		}
L_end_InitTimer0:
	RETURN      0
; end of _InitTimer0

_Interrupt:

;main.c,22 :: 		void Interrupt(){
;main.c,24 :: 		if (TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_Interrupt3
;main.c,25 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;main.c,26 :: 		TMR0H	 = 0x48;
	MOVLW       72
	MOVWF       TMR0H+0 
;main.c,27 :: 		TMR0L	 = 0xE5;
	MOVLW       229
	MOVWF       TMR0L+0 
;main.c,30 :: 		TMR0IE_bit=0;
	BCF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;main.c,31 :: 		}
L_Interrupt3:
;main.c,32 :: 		}
L_end_Interrupt:
L__Interrupt14:
	RETFIE      1
; end of _Interrupt

_main:

;main.c,34 :: 		void main() {
;main.c,35 :: 		TRISA=0b00000001; // [][][][LED][][][][SOUND]
	MOVLW       1
	MOVWF       TRISA+0 
;main.c,37 :: 		LATA=0x00;
	CLRF        LATA+0 
;main.c,39 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;main.c,41 :: 		while(1){
L_main4:
;main.c,42 :: 		temp=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
;main.c,43 :: 		if(temp<100){
	MOVLW       0
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main16
	MOVLW       100
	SUBWF       R0, 0 
L__main16:
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;main.c,45 :: 		wait(50);
	MOVLW       50
	MOVWF       FARG_wait_time+0 
	MOVLW       0
	MOVWF       FARG_wait_time+1 
	CALL        _wait+0, 0
;main.c,47 :: 		counter=1;
	MOVLW       1
	MOVWF       _counter+0 
	MOVLW       0
	MOVWF       _counter+1 
;main.c,48 :: 		InitTimer0();
	CALL        _InitTimer0+0, 0
;main.c,49 :: 		}
L_main6:
;main.c,50 :: 		while(TMR0IE_bit){
L_main7:
	BTFSS       TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
	GOTO        L_main8
;main.c,51 :: 		temp=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
;main.c,52 :: 		if(temp<100){
	MOVLW       0
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main17
	MOVLW       100
	SUBWF       R0, 0 
L__main17:
	BTFSC       STATUS+0, 0 
	GOTO        L_main9
;main.c,53 :: 		counter++;
	INFSNZ      _counter+0, 1 
	INCF        _counter+1, 1 
;main.c,54 :: 		wait(50);
	MOVLW       50
	MOVWF       FARG_wait_time+0 
	MOVLW       0
	MOVWF       FARG_wait_time+1 
	CALL        _wait+0, 0
;main.c,55 :: 		}
L_main9:
;main.c,56 :: 		}
	GOTO        L_main7
L_main8:
;main.c,58 :: 		if(counter==2) LED=!LED;
	MOVLW       0
	XORWF       _counter+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main18
	MOVLW       2
	XORWF       _counter+0, 0 
L__main18:
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
	BTG         LATA4_bit+0, BitPos(LATA4_bit+0) 
L_main10:
;main.c,59 :: 		counter=0;
	CLRF        _counter+0 
	CLRF        _counter+1 
;main.c,60 :: 		}
	GOTO        L_main4
;main.c,61 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
