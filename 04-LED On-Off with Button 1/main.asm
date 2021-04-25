
_wait:

;main.c,19 :: 		void wait(){
;main.c,20 :: 		delay_ms(50);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_wait0:
	DECFSZ      R13, 1, 1
	BRA         L_wait0
	DECFSZ      R12, 1, 1
	BRA         L_wait0
	DECFSZ      R11, 1, 1
	BRA         L_wait0
	NOP
	NOP
;main.c,21 :: 		}
L_end_wait:
	RETURN      0
; end of _wait

_main:

;main.c,23 :: 		void main() {
;main.c,24 :: 		TRISA=0b00000000; // [][][][LED][][][][]
	CLRF        TRISA+0 
;main.c,25 :: 		TRISB=0b00000011; // [][][][][][][BUTTON_DN][BUTTON_UP]
	MOVLW       3
	MOVWF       TRISB+0 
;main.c,26 :: 		TRISD=0b00000000; // [LEDB4][LEDB3][LEDB2][LEDB1][LEDR4][LEDR3][LEDR2][LEDR1]
	CLRF        TRISD+0 
;main.c,28 :: 		LATA=0x00;
	CLRF        LATA+0 
;main.c,29 :: 		LATB=0x00;
	CLRF        LATB+0 
;main.c,30 :: 		LATD=0x00;
	CLRF        LATD+0 
;main.c,32 :: 		ADCON1=0xFF;
	MOVLW       255
	MOVWF       ADCON1+0 
;main.c,34 :: 		LATD=0b00000001;
	MOVLW       1
	MOVWF       LATD+0 
;main.c,36 :: 		while(1){
L_main1:
;main.c,37 :: 		for(i=0;i<7;i++){
	CLRF        _i+0 
L_main3:
	MOVLW       7
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main4
;main.c,38 :: 		LATD<<=1;
	MOVF        LATD+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       LATD+0 
;main.c,39 :: 		wait();
	CALL        _wait+0, 0
;main.c,37 :: 		for(i=0;i<7;i++){
	INCF        _i+0, 1 
;main.c,40 :: 		}
	GOTO        L_main3
L_main4:
;main.c,41 :: 		for(i=0;i<7;i++){
	CLRF        _i+0 
L_main6:
	MOVLW       7
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main7
;main.c,42 :: 		LATD>>=1;
	MOVF        LATD+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	MOVWF       LATD+0 
;main.c,43 :: 		wait();
	CALL        _wait+0, 0
;main.c,41 :: 		for(i=0;i<7;i++){
	INCF        _i+0, 1 
;main.c,44 :: 		}
	GOTO        L_main6
L_main7:
;main.c,45 :: 		}
	GOTO        L_main1
;main.c,46 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
