
_wait:

;main.c,12 :: 		void wait(){
;main.c,13 :: 		delay_ms(50);
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
;main.c,14 :: 		}
L_end_wait:
	RETURN      0
; end of _wait

_main:

;main.c,16 :: 		void main() {
;main.c,17 :: 		TRISA=0b00000000; // [][][][LED][][][][]
	CLRF        TRISA+0 
;main.c,18 :: 		TRISD=0b00000000; // [][][][][LEDB][LEDY][LEDG][LEDR]
	CLRF        TRISD+0 
;main.c,20 :: 		LATA=0x00;
	CLRF        LATA+0 
;main.c,21 :: 		LATD=0x00;
	CLRF        LATD+0 
;main.c,23 :: 		while(1){
L_main1:
;main.c,24 :: 		LED=!LED;
	BTG         LATA4_bit+0, BitPos(LATA4_bit+0) 
;main.c,26 :: 		for(i=0;i<5;i++){
	CLRF        _i+0 
L_main3:
	MOVLW       5
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main4
;main.c,27 :: 		LEDR=1; wait(); LEDR=0; wait();
	BSF         LATD0_bit+0, BitPos(LATD0_bit+0) 
	CALL        _wait+0, 0
	BCF         LATD0_bit+0, BitPos(LATD0_bit+0) 
	CALL        _wait+0, 0
;main.c,26 :: 		for(i=0;i<5;i++){
	INCF        _i+0, 1 
;main.c,28 :: 		}
	GOTO        L_main3
L_main4:
;main.c,29 :: 		for(i=0;i<5;i++){
	CLRF        _i+0 
L_main6:
	MOVLW       5
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main7
;main.c,30 :: 		LEDB=1; wait(); LEDB=0; wait();
	BSF         LATD3_bit+0, BitPos(LATD3_bit+0) 
	CALL        _wait+0, 0
	BCF         LATD3_bit+0, BitPos(LATD3_bit+0) 
	CALL        _wait+0, 0
;main.c,29 :: 		for(i=0;i<5;i++){
	INCF        _i+0, 1 
;main.c,31 :: 		}
	GOTO        L_main6
L_main7:
;main.c,32 :: 		}
	GOTO        L_main1
;main.c,33 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
