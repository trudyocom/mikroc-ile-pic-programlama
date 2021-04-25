
_wait:

;main.c,24 :: 		void wait(unsigned int time){
;main.c,25 :: 		while(time--)
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
;main.c,26 :: 		delay_ms(1);
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
;main.c,27 :: 		}
L_end_wait:
	RETURN      0
; end of _wait

_main:

;main.c,29 :: 		void main() {
;main.c,30 :: 		TRISA=0b00000000; // [][][][LED][][][][]
	CLRF        TRISA+0 
;main.c,31 :: 		TRISD=0b00000000; // [][LCD_BACKLIGHT][LCD_D7][LCD_D6][LCD_D5][LCD_D4][LCD_EN][LCD_RS]
	CLRF        TRISD+0 
;main.c,33 :: 		LATA=0x00;
	CLRF        LATA+0 
;main.c,34 :: 		LATD=0x00;
	CLRF        LATD+0 
;main.c,36 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;main.c,37 :: 		LCD_BACKLIGHT=1;
	BSF         LATD6_bit+0, BitPos(LATD6_bit+0) 
;main.c,39 :: 		Lcd_Out(1,1,"Hello trudyo!");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_main+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_main+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;main.c,40 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;main.c,41 :: 		while(1){
L_main3:
;main.c,42 :: 		for(i=0;i<3;i++){
	CLRF        _i+0 
L_main5:
	MOVLW       3
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;main.c,43 :: 		Lcd_Cmd(_LCD_SHIFT_RIGHT);
	MOVLW       28
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;main.c,44 :: 		wait(500);
	MOVLW       244
	MOVWF       FARG_wait_time+0 
	MOVLW       1
	MOVWF       FARG_wait_time+1 
	CALL        _wait+0, 0
;main.c,42 :: 		for(i=0;i<3;i++){
	INCF        _i+0, 1 
;main.c,45 :: 		}
	GOTO        L_main5
L_main6:
;main.c,46 :: 		for(i=0;i<3;i++){
	CLRF        _i+0 
L_main8:
	MOVLW       3
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main9
;main.c,47 :: 		Lcd_Cmd(_LCD_SHIFT_LEFT);
	MOVLW       24
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;main.c,48 :: 		wait(500);
	MOVLW       244
	MOVWF       FARG_wait_time+0 
	MOVLW       1
	MOVWF       FARG_wait_time+1 
	CALL        _wait+0, 0
;main.c,46 :: 		for(i=0;i<3;i++){
	INCF        _i+0, 1 
;main.c,49 :: 		}
	GOTO        L_main8
L_main9:
;main.c,50 :: 		}
	GOTO        L_main3
;main.c,51 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
