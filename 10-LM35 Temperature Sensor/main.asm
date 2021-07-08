
_wait:

;main.c,26 :: 		void wait(unsigned int time){
;main.c,27 :: 		while(time--)
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
;main.c,28 :: 		delay_ms(1);
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
;main.c,29 :: 		}
L_end_wait:
	RETURN      0
; end of _wait

_getTemperature:

;main.c,31 :: 		unsigned int getTemperature(){
;main.c,34 :: 		temp=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
;main.c,35 :: 		temp*=4.8828125;
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       64
	MOVWF       R5 
	MOVLW       28
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _double2word+0, 0
;main.c,37 :: 		return temp;
;main.c,38 :: 		}
L_end_getTemperature:
	RETURN      0
; end of _getTemperature

_main:

;main.c,40 :: 		void main() {
;main.c,41 :: 		TRISA=0b00000001; // [][][][LED][][][][LM35]
	MOVLW       1
	MOVWF       TRISA+0 
;main.c,42 :: 		TRISD=0b00000000; // [][LCD_BACKLIGHT][LCD_D7][LCD_D6][LCD_D5][LCD_D4][LCD_EN][LCD_RS]
	CLRF        TRISD+0 
;main.c,44 :: 		LATA=0x00;
	CLRF        LATA+0 
;main.c,45 :: 		LATD=0x00;
	CLRF        LATD+0 
;main.c,47 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;main.c,48 :: 		LCD_BACKLIGHT=1;
	BSF         LATD6_bit+0, BitPos(LATD6_bit+0) 
;main.c,50 :: 		Lcd_Out(1,1,"LM35 Temp.Sensor");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_main+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_main+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;main.c,51 :: 		Lcd_Out(2,1,"Value:         C");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_main+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_main+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;main.c,52 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;main.c,54 :: 		while(1){
L_main3:
;main.c,55 :: 		IntToStr(getTemperature(),txt);
	CALL        _getTemperature+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;main.c,57 :: 		Lcd_Chr(2,8,txt[0]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _txt+0, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;main.c,58 :: 		Lcd_Chr(2,9,txt[1]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       9
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _txt+1, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;main.c,59 :: 		Lcd_Chr(2,10,txt[2]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       10
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _txt+2, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;main.c,60 :: 		Lcd_Chr(2,11,txt[3]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       11
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _txt+3, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;main.c,61 :: 		Lcd_Chr(2,12,txt[4]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _txt+4, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;main.c,62 :: 		Lcd_Chr(2,13,'.');
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       13
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVLW       46
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;main.c,63 :: 		Lcd_Chr(2,14,txt[5]);
	MOVLW       2
	MOVWF       FARG_Lcd_Chr_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Chr_column+0 
	MOVF        _txt+5, 0 
	MOVWF       FARG_Lcd_Chr_out_char+0 
	CALL        _Lcd_Chr+0, 0
;main.c,64 :: 		wait(1000);
	MOVLW       232
	MOVWF       FARG_wait_time+0 
	MOVLW       3
	MOVWF       FARG_wait_time+1 
	CALL        _wait+0, 0
;main.c,65 :: 		}
	GOTO        L_main3
;main.c,66 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
