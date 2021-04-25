
_wait:

;main.c,27 :: 		void wait(unsigned int time){
;main.c,28 :: 		while(time--)
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
;main.c,29 :: 		delay_ms(1);
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
;main.c,30 :: 		}
L_end_wait:
	RETURN      0
; end of _wait

_getDistance:

;main.c,32 :: 		unsigned int getDistance(){
;main.c,34 :: 		T0CON=0b01000110;
	MOVLW       70
	MOVWF       T0CON+0 
;main.c,35 :: 		TMR0H=0;
	CLRF        TMR0H+0 
;main.c,36 :: 		TMR0L=0;
	CLRF        TMR0L+0 
;main.c,38 :: 		TRIG=1;
	BSF         LATB0_bit+0, BitPos(LATB0_bit+0) 
;main.c,39 :: 		delay_us(10);
	MOVLW       39
	MOVWF       R13, 0
L_getDistance3:
	DECFSZ      R13, 1, 1
	BRA         L_getDistance3
	NOP
	NOP
;main.c,40 :: 		TRIG=0;
	BCF         LATB0_bit+0, BitPos(LATB0_bit+0) 
;main.c,42 :: 		while(!ECHO);
L_getDistance4:
	BTFSC       RB1_bit+0, BitPos(RB1_bit+0) 
	GOTO        L_getDistance5
	GOTO        L_getDistance4
L_getDistance5:
;main.c,43 :: 		TMR0ON_bit=1;
	BSF         TMR0ON_bit+0, BitPos(TMR0ON_bit+0) 
;main.c,44 :: 		while(ECHO && TMR0L<250);
L_getDistance6:
	BTFSS       RB1_bit+0, BitPos(RB1_bit+0) 
	GOTO        L_getDistance7
	MOVLW       250
	SUBWF       TMR0L+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_getDistance7
L__getDistance14:
	GOTO        L_getDistance6
L_getDistance7:
;main.c,46 :: 		temp=1.8303*TMR0L;
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
;main.c,48 :: 		return temp;
;main.c,49 :: 		}
L_end_getDistance:
	RETURN      0
; end of _getDistance

_main:

;main.c,51 :: 		void main() {
;main.c,52 :: 		TRISA=0b00000000; // [][][][LED][][][][]
	CLRF        TRISA+0 
;main.c,53 :: 		TRISB=0b00000010; // [][][][][][][ECHO][TRIG]
	MOVLW       2
	MOVWF       TRISB+0 
;main.c,54 :: 		TRISD=0b00000000; // [][LCD_BACKLIGHT][LCD_D7][LCD_D6][LCD_D5][LCD_D4][LCD_EN][LCD_RS]
	CLRF        TRISD+0 
;main.c,56 :: 		LATA=0x00;
	CLRF        LATA+0 
;main.c,57 :: 		LATB=0x00;
	CLRF        LATB+0 
;main.c,58 :: 		LATD=0x00;
	CLRF        LATD+0 
;main.c,60 :: 		ADCON1=0x0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;main.c,62 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;main.c,63 :: 		LCD_BACKLIGHT=1;
	BSF         LATD6_bit+0, BitPos(LATD6_bit+0) 
;main.c,65 :: 		Lcd_Out(1,1,"Mesafe:       mm");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr1_main+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr1_main+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;main.c,66 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;main.c,67 :: 		while(1){
L_main10:
;main.c,68 :: 		distance=getDistance();
	CALL        _getDistance+0, 0
	MOVF        R0, 0 
	MOVWF       _distance+0 
	MOVF        R1, 0 
	MOVWF       _distance+1 
;main.c,69 :: 		IntToStr(distance,txt);
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;main.c,71 :: 		if(distance>300) Lcd_Out(1,8,"   MAX");
	MOVF        _distance+1, 0 
	SUBLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__main18
	MOVF        _distance+0, 0 
	SUBLW       44
L__main18:
	BTFSC       STATUS+0, 0 
	GOTO        L_main12
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr2_main+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr2_main+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_main13
L_main12:
;main.c,72 :: 		else Lcd_Out(1,8,txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       8
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_main13:
;main.c,74 :: 		wait(100);
	MOVLW       100
	MOVWF       FARG_wait_time+0 
	MOVLW       0
	MOVWF       FARG_wait_time+1 
	CALL        _wait+0, 0
;main.c,75 :: 		}
	GOTO        L_main10
;main.c,76 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
