
_wait:

;main.c,11 :: 		void wait(unsigned int time){
;main.c,12 :: 		while(time--)
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
;main.c,13 :: 		delay_ms(1);
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
;main.c,14 :: 		}
L_end_wait:
	RETURN      0
; end of _wait

_SetRGB:

;main.c,16 :: 		void SetRGB(unsigned short R,unsigned short G,unsigned short B){
;main.c,17 :: 		dutyLEDR=R;
	MOVF        FARG_SetRGB_R+0, 0 
	MOVWF       _dutyLEDR+0 
;main.c,18 :: 		dutyLEDG=G;
	MOVF        FARG_SetRGB_G+0, 0 
	MOVWF       _dutyLEDG+0 
;main.c,19 :: 		dutyLEDB=B;
	MOVF        FARG_SetRGB_B+0, 0 
	MOVWF       _dutyLEDB+0 
;main.c,21 :: 		PWM1_Set_Duty(dutyLEDR);
	MOVF        FARG_SetRGB_R+0, 0 
	MOVWF       FARG_PWM1_Set_Duty_new_duty+0 
	CALL        _PWM1_Set_Duty+0, 0
;main.c,22 :: 		PWM2_Set_Duty(dutyLEDG);
	MOVF        _dutyLEDG+0, 0 
	MOVWF       FARG_PWM2_Set_Duty_new_duty+0 
	CALL        _PWM2_Set_Duty+0, 0
;main.c,23 :: 		}
L_end_SetRGB:
	RETURN      0
; end of _SetRGB

_AnimateRGB:

;main.c,27 :: 		void AnimateRGB(unsigned short R,unsigned short G,unsigned short B){
;main.c,28 :: 		while((dutyLEDR != R)|| (dutyLEDG != G)||(dutyLEDB != B)){
L_AnimateRGB3:
	MOVF        _dutyLEDR+0, 0 
	XORWF       FARG_AnimateRGB_R+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__AnimateRGB29
	MOVF        _dutyLEDG+0, 0 
	XORWF       FARG_AnimateRGB_G+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__AnimateRGB29
	MOVF        _dutyLEDB+0, 0 
	XORWF       FARG_AnimateRGB_B+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__AnimateRGB29
	GOTO        L_AnimateRGB4
L__AnimateRGB29:
;main.c,29 :: 		if(R>dutyLEDR) dutyLEDR++;
	MOVF        FARG_AnimateRGB_R+0, 0 
	SUBWF       _dutyLEDR+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AnimateRGB7
	INCF        _dutyLEDR+0, 1 
	GOTO        L_AnimateRGB8
L_AnimateRGB7:
;main.c,30 :: 		else if(R<dutyLEDR) dutyLEDR--;
	MOVF        _dutyLEDR+0, 0 
	SUBWF       FARG_AnimateRGB_R+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AnimateRGB9
	DECF        _dutyLEDR+0, 1 
L_AnimateRGB9:
L_AnimateRGB8:
;main.c,32 :: 		if(G>dutyLEDG) dutyLEDG++;
	MOVF        FARG_AnimateRGB_G+0, 0 
	SUBWF       _dutyLEDG+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AnimateRGB10
	INCF        _dutyLEDG+0, 1 
	GOTO        L_AnimateRGB11
L_AnimateRGB10:
;main.c,33 :: 		else if(G<dutyLEDG) dutyLEDG--;
	MOVF        _dutyLEDG+0, 0 
	SUBWF       FARG_AnimateRGB_G+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AnimateRGB12
	DECF        _dutyLEDG+0, 1 
L_AnimateRGB12:
L_AnimateRGB11:
;main.c,35 :: 		if(B>dutyLEDB) dutyLEDB++;
	MOVF        FARG_AnimateRGB_B+0, 0 
	SUBWF       _dutyLEDB+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AnimateRGB13
	INCF        _dutyLEDB+0, 1 
	GOTO        L_AnimateRGB14
L_AnimateRGB13:
;main.c,36 :: 		else if(B<dutyLEDB) dutyLEDB--;
	MOVF        _dutyLEDB+0, 0 
	SUBWF       FARG_AnimateRGB_B+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AnimateRGB15
	DECF        _dutyLEDB+0, 1 
L_AnimateRGB15:
L_AnimateRGB14:
;main.c,38 :: 		wait(10);
	MOVLW       10
	MOVWF       FARG_wait_time+0 
	MOVLW       0
	MOVWF       FARG_wait_time+1 
	CALL        _wait+0, 0
;main.c,39 :: 		}
	GOTO        L_AnimateRGB3
L_AnimateRGB4:
;main.c,40 :: 		}
L_end_AnimateRGB:
	RETURN      0
; end of _AnimateRGB

_InitTimer0:

;main.c,42 :: 		void InitTimer0(){
;main.c,43 :: 		T0CON             = 0x88;
	MOVLW       136
	MOVWF       T0CON+0 
;main.c,44 :: 		TMR0H             = 0x88;
	MOVLW       136
	MOVWF       TMR0H+0 
;main.c,45 :: 		TMR0L      = 0x78;
	MOVLW       120
	MOVWF       TMR0L+0 
;main.c,46 :: 		GIE_bit    = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;main.c,47 :: 		TMR0IE_bit = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;main.c,48 :: 		}
L_end_InitTimer0:
	RETURN      0
; end of _InitTimer0

_InitTimer1:

;main.c,49 :: 		void InitTimer1(){
;main.c,50 :: 		T1CON      = 0x01;
	MOVLW       1
	MOVWF       T1CON+0 
;main.c,51 :: 		TMR1IF_bit = 0;
	BCF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;main.c,52 :: 		TMR1H             = 0xFF;
	MOVLW       255
	MOVWF       TMR1H+0 
;main.c,53 :: 		TMR1L      = 0x88;
	MOVLW       136
	MOVWF       TMR1L+0 
;main.c,54 :: 		TMR1IE_bit = 1;
	BSF         TMR1IE_bit+0, BitPos(TMR1IE_bit+0) 
;main.c,55 :: 		INTCON     = 0xC0;
	MOVLW       192
	MOVWF       INTCON+0 
;main.c,56 :: 		}
L_end_InitTimer1:
	RETURN      0
; end of _InitTimer1

_Interrupt:

;main.c,59 :: 		void Interrupt(){
;main.c,61 :: 		if (TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_Interrupt16
;main.c,62 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;main.c,63 :: 		TMR0H         = 0x88;
	MOVLW       136
	MOVWF       TMR0H+0 
;main.c,64 :: 		TMR0L         = 0x78;
	MOVLW       120
	MOVWF       TMR0L+0 
;main.c,66 :: 		if(dutyLEDR) LEDR=1;
	MOVF        _dutyLEDR+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Interrupt17
	BSF         LATC2_bit+0, BitPos(LATC2_bit+0) 
L_Interrupt17:
;main.c,67 :: 		if(dutyLEDG) LEDG=1;
	MOVF        _dutyLEDG+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Interrupt18
	BSF         LATC1_bit+0, BitPos(LATC1_bit+0) 
L_Interrupt18:
;main.c,68 :: 		if(dutyLEDB) LEDB=1;
	MOVF        _dutyLEDB+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_Interrupt19
	BSF         LATD0_bit+0, BitPos(LATD0_bit+0) 
L_Interrupt19:
;main.c,70 :: 		counterLEDR=0;
	CLRF        _counterLEDR+0 
;main.c,71 :: 		counterLEDG=0;
	CLRF        _counterLEDG+0 
;main.c,72 :: 		counterLEDB=0;
	CLRF        _counterLEDB+0 
;main.c,73 :: 		}
L_Interrupt16:
;main.c,75 :: 		if (TMR1IF_bit){
	BTFSS       TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
	GOTO        L_Interrupt20
;main.c,76 :: 		TMR1IF_bit = 0;
	BCF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;main.c,77 :: 		TMR1H         = 0xFF;
	MOVLW       255
	MOVWF       TMR1H+0 
;main.c,78 :: 		TMR1L         = 0x88;
	MOVLW       136
	MOVWF       TMR1L+0 
;main.c,80 :: 		if(counterLEDR>=dutyLEDR) LEDR=0;
	MOVF        _dutyLEDR+0, 0 
	SUBWF       _counterLEDR+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Interrupt21
	BCF         LATC2_bit+0, BitPos(LATC2_bit+0) 
L_Interrupt21:
;main.c,81 :: 		if(counterLEDG>=dutyLEDG) LEDG=0;
	MOVF        _dutyLEDG+0, 0 
	SUBWF       _counterLEDG+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Interrupt22
	BCF         LATC1_bit+0, BitPos(LATC1_bit+0) 
L_Interrupt22:
;main.c,82 :: 		if(counterLEDB>=dutyLEDB) LEDB=0;
	MOVF        _dutyLEDB+0, 0 
	SUBWF       _counterLEDB+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_Interrupt23
	BCF         LATD0_bit+0, BitPos(LATD0_bit+0) 
L_Interrupt23:
;main.c,84 :: 		if(counterLEDR<255) counterLEDR++;
	MOVLW       255
	SUBWF       _counterLEDR+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Interrupt24
	INCF        _counterLEDR+0, 1 
L_Interrupt24:
;main.c,85 :: 		if(counterLEDG<255) counterLEDG++;
	MOVLW       255
	SUBWF       _counterLEDG+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Interrupt25
	INCF        _counterLEDG+0, 1 
L_Interrupt25:
;main.c,86 :: 		if(counterLEDB<255) counterLEDB++;
	MOVLW       255
	SUBWF       _counterLEDB+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Interrupt26
	INCF        _counterLEDB+0, 1 
L_Interrupt26:
;main.c,87 :: 		}
L_Interrupt20:
;main.c,89 :: 		}
L_end_Interrupt:
L__Interrupt36:
	RETFIE      1
; end of _Interrupt

_main:

;main.c,90 :: 		void main() {
;main.c,91 :: 		TRISA=0b00000000; // [][][][LED][][][][]
	CLRF        TRISA+0 
;main.c,92 :: 		TRISC=0b00000000; // [][][][][][LEDR][LEDG][]
	CLRF        TRISC+0 
;main.c,93 :: 		TRISD=0b00000000; // [][][][][][][][LEDB]
	CLRF        TRISD+0 
;main.c,95 :: 		LATA=0x00;
	CLRF        LATA+0 
;main.c,96 :: 		LATC=0x00;
	CLRF        LATC+0 
;main.c,97 :: 		LATD=0x00;
	CLRF        LATD+0 
;main.c,107 :: 		InitTimer0();
	CALL        _InitTimer0+0, 0
;main.c,108 :: 		InitTimer1();
	CALL        _InitTimer1+0, 0
;main.c,110 :: 		while(1){
L_main27:
;main.c,142 :: 		AnimateRGB(255,0,0);
	MOVLW       255
	MOVWF       FARG_AnimateRGB_R+0 
	CLRF        FARG_AnimateRGB_G+0 
	CLRF        FARG_AnimateRGB_B+0 
	CALL        _AnimateRGB+0, 0
;main.c,143 :: 		AnimateRGB(0,255,0);
	CLRF        FARG_AnimateRGB_R+0 
	MOVLW       255
	MOVWF       FARG_AnimateRGB_G+0 
	CLRF        FARG_AnimateRGB_B+0 
	CALL        _AnimateRGB+0, 0
;main.c,144 :: 		AnimateRGB(0,0,255);
	CLRF        FARG_AnimateRGB_R+0 
	CLRF        FARG_AnimateRGB_G+0 
	MOVLW       255
	MOVWF       FARG_AnimateRGB_B+0 
	CALL        _AnimateRGB+0, 0
;main.c,145 :: 		AnimateRGB(255,127,0);
	MOVLW       255
	MOVWF       FARG_AnimateRGB_R+0 
	MOVLW       127
	MOVWF       FARG_AnimateRGB_G+0 
	CLRF        FARG_AnimateRGB_B+0 
	CALL        _AnimateRGB+0, 0
;main.c,146 :: 		AnimateRGB(255,0,150);
	MOVLW       255
	MOVWF       FARG_AnimateRGB_R+0 
	CLRF        FARG_AnimateRGB_G+0 
	MOVLW       150
	MOVWF       FARG_AnimateRGB_B+0 
	CALL        _AnimateRGB+0, 0
;main.c,147 :: 		AnimateRGB(255,255,255);
	MOVLW       255
	MOVWF       FARG_AnimateRGB_R+0 
	MOVLW       255
	MOVWF       FARG_AnimateRGB_G+0 
	MOVLW       255
	MOVWF       FARG_AnimateRGB_B+0 
	CALL        _AnimateRGB+0, 0
;main.c,148 :: 		}
	GOTO        L_main27
;main.c,149 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
