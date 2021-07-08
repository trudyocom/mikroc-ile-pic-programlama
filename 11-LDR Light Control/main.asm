
_wait:

;main.c,4 :: 		void wait(unsigned int time){
;main.c,5 :: 		while(time--)
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
;main.c,6 :: 		delay_ms(1);
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
;main.c,7 :: 		}
L_end_wait:
	RETURN      0
; end of _wait

_getLDRVoltage:

;main.c,9 :: 		unsigned int getLDRVoltage(){
;main.c,12 :: 		temp=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
;main.c,13 :: 		temp*=0.48828125;
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       125
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2word+0, 0
;main.c,15 :: 		return temp;
;main.c,16 :: 		}
L_end_getLDRVoltage:
	RETURN      0
; end of _getLDRVoltage

_main:

;main.c,18 :: 		void main() {
;main.c,19 :: 		TRISA=0b00000001; // [][][][LED][][][][LM35]
	MOVLW       1
	MOVWF       TRISA+0 
;main.c,21 :: 		LATA=0x00;
	CLRF        LATA+0 
;main.c,23 :: 		while(1){
L_main3:
;main.c,24 :: 		if(getLDRVoltage()>300) LED=1;
	CALL        _getLDRVoltage+0, 0
	MOVF        R1, 0 
	SUBLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__main10
	MOVF        R0, 0 
	SUBLW       44
L__main10:
	BTFSC       STATUS+0, 0 
	GOTO        L_main5
	BSF         LATA4_bit+0, BitPos(LATA4_bit+0) 
	GOTO        L_main6
L_main5:
;main.c,25 :: 		else LED=0;
	BCF         LATA4_bit+0, BitPos(LATA4_bit+0) 
L_main6:
;main.c,27 :: 		wait(250);
	MOVLW       250
	MOVWF       FARG_wait_time+0 
	MOVLW       0
	MOVWF       FARG_wait_time+1 
	CALL        _wait+0, 0
;main.c,28 :: 		}
	GOTO        L_main3
;main.c,29 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
