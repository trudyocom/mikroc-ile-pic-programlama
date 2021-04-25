
_wait:

;main.c,19 :: 		void wait(unsigned int time){
;main.c,20 :: 		while(time--)
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
;main.c,21 :: 		delay_ms(1);
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
;main.c,22 :: 		}
L_end_wait:
	RETURN      0
; end of _wait

_main:

;main.c,24 :: 		void main() {
;main.c,25 :: 		TRISA=0b00000000; // [][][][LED][][][][]
	CLRF        TRISA+0 
;main.c,26 :: 		TRISB=0b00000011; // [][][][][][][BUTTON_DN][BUTTON_UP]
	MOVLW       3
	MOVWF       TRISB+0 
;main.c,27 :: 		TRISD=0b00000000; // [LEDB4][LEDB3][LEDB2][LEDB1][LEDR4][LEDR3][LEDR2][LEDR1]
	CLRF        TRISD+0 
;main.c,29 :: 		LATA=0x00;
	CLRF        LATA+0 
;main.c,30 :: 		LATB=0x00;
	CLRF        LATB+0 
;main.c,31 :: 		LATD=0x00;
	CLRF        LATD+0 
;main.c,33 :: 		ADCON1=0xFF;
	MOVLW       255
	MOVWF       ADCON1+0 
;main.c,36 :: 		while(1){
L_main3:
;main.c,37 :: 		LATD=0b00000001;
	MOVLW       1
	MOVWF       LATD+0 
;main.c,38 :: 		for(j=0;j<3;j++){
	CLRF        _j+0 
L_main5:
	MOVLW       3
	SUBWF       _j+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;main.c,39 :: 		for(i=0;i<7;i++){
	CLRF        _i+0 
L_main8:
	MOVLW       7
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main9
;main.c,40 :: 		LATD<<=1;
	MOVF        LATD+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVF        R0, 0 
	MOVWF       LATD+0 
;main.c,41 :: 		wait(75);
	MOVLW       75
	MOVWF       FARG_wait_time+0 
	MOVLW       0
	MOVWF       FARG_wait_time+1 
	CALL        _wait+0, 0
;main.c,39 :: 		for(i=0;i<7;i++){
	INCF        _i+0, 1 
;main.c,42 :: 		}
	GOTO        L_main8
L_main9:
;main.c,43 :: 		for(i=0;i<7;i++){
	CLRF        _i+0 
L_main11:
	MOVLW       7
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main12
;main.c,44 :: 		LATD>>=1;
	MOVF        LATD+0, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVF        R0, 0 
	MOVWF       LATD+0 
;main.c,45 :: 		wait(75);
	MOVLW       75
	MOVWF       FARG_wait_time+0 
	MOVLW       0
	MOVWF       FARG_wait_time+1 
	CALL        _wait+0, 0
;main.c,43 :: 		for(i=0;i<7;i++){
	INCF        _i+0, 1 
;main.c,46 :: 		}
	GOTO        L_main11
L_main12:
;main.c,38 :: 		for(j=0;j<3;j++){
	INCF        _j+0, 1 
;main.c,47 :: 		}
	GOTO        L_main5
L_main6:
;main.c,48 :: 		for(j=0;j<3;j++){
	CLRF        _j+0 
L_main14:
	MOVLW       3
	SUBWF       _j+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main15
;main.c,49 :: 		for(i=0;i<5;i++){
	CLRF        _i+0 
L_main17:
	MOVLW       5
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main18
;main.c,50 :: 		LATD=0b00001111;
	MOVLW       15
	MOVWF       LATD+0 
;main.c,51 :: 		wait(50);
	MOVLW       50
	MOVWF       FARG_wait_time+0 
	MOVLW       0
	MOVWF       FARG_wait_time+1 
	CALL        _wait+0, 0
;main.c,52 :: 		LATD=0b00000000;
	CLRF        LATD+0 
;main.c,53 :: 		wait(50);
	MOVLW       50
	MOVWF       FARG_wait_time+0 
	MOVLW       0
	MOVWF       FARG_wait_time+1 
	CALL        _wait+0, 0
;main.c,49 :: 		for(i=0;i<5;i++){
	INCF        _i+0, 1 
;main.c,54 :: 		}
	GOTO        L_main17
L_main18:
;main.c,55 :: 		for(i=0;i<5;i++){
	CLRF        _i+0 
L_main20:
	MOVLW       5
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main21
;main.c,56 :: 		LATD=0b11110000;
	MOVLW       240
	MOVWF       LATD+0 
;main.c,57 :: 		wait(50);
	MOVLW       50
	MOVWF       FARG_wait_time+0 
	MOVLW       0
	MOVWF       FARG_wait_time+1 
	CALL        _wait+0, 0
;main.c,58 :: 		LATD=0b00000000;
	CLRF        LATD+0 
;main.c,59 :: 		wait(50);
	MOVLW       50
	MOVWF       FARG_wait_time+0 
	MOVLW       0
	MOVWF       FARG_wait_time+1 
	CALL        _wait+0, 0
;main.c,55 :: 		for(i=0;i<5;i++){
	INCF        _i+0, 1 
;main.c,60 :: 		}
	GOTO        L_main20
L_main21:
;main.c,48 :: 		for(j=0;j<3;j++){
	INCF        _j+0, 1 
;main.c,61 :: 		}
	GOTO        L_main14
L_main15:
;main.c,62 :: 		}
	GOTO        L_main3
;main.c,63 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
