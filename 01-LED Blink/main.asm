
_main:

;main.c,4 :: 		void main() {
;main.c,5 :: 		TRISA=0b00000000; // [][][][LED][][][][]
	CLRF        TRISA+0 
;main.c,7 :: 		LATA=0x00;
	CLRF        LATA+0 
;main.c,9 :: 		while(1){
L_main0:
;main.c,13 :: 		LED=!LED; delay_ms(100);
	BTG         LATA4_bit+0, BitPos(LATA4_bit+0) 
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       23
	MOVWF       R12, 0
	MOVLW       106
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
;main.c,14 :: 		}
	GOTO        L_main0
;main.c,15 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
