
_wait:

;main.c,9 :: 		void wait(unsigned int time){
;main.c,10 :: 		while(time--)
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
;main.c,11 :: 		delay_ms(1);
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
;main.c,12 :: 		}
L_end_wait:
	RETURN      0
; end of _wait

_Tone1:

;main.c,14 :: 		void Tone1() {
;main.c,15 :: 		Sound_Play(659, 250);   // Frequency = 659Hz, duration = 250ms
	MOVLW       147
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       2
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       250
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;main.c,16 :: 		}
L_end_Tone1:
	RETURN      0
; end of _Tone1

_Tone2:

;main.c,18 :: 		void Tone2() {
;main.c,19 :: 		Sound_Play(698, 250);   // Frequency = 698Hz, duration = 250ms
	MOVLW       186
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       2
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       250
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;main.c,20 :: 		}
L_end_Tone2:
	RETURN      0
; end of _Tone2

_Tone3:

;main.c,22 :: 		void Tone3() {
;main.c,23 :: 		Sound_Play(784, 250);   // Frequency = 784Hz, duration = 250ms
	MOVLW       16
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       250
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;main.c,24 :: 		}
L_end_Tone3:
	RETURN      0
; end of _Tone3

_Melody:

;main.c,26 :: 		void Melody() {           // Plays the melody "Yellow house"
;main.c,27 :: 		Tone1(); Tone2(); Tone3(); Tone3();
	CALL        _Tone1+0, 0
	CALL        _Tone2+0, 0
	CALL        _Tone3+0, 0
	CALL        _Tone3+0, 0
;main.c,28 :: 		Tone1(); Tone2(); Tone3(); Tone3();
	CALL        _Tone1+0, 0
	CALL        _Tone2+0, 0
	CALL        _Tone3+0, 0
	CALL        _Tone3+0, 0
;main.c,29 :: 		Tone1(); Tone2(); Tone3();
	CALL        _Tone1+0, 0
	CALL        _Tone2+0, 0
	CALL        _Tone3+0, 0
;main.c,30 :: 		Tone1(); Tone2(); Tone3(); Tone3();
	CALL        _Tone1+0, 0
	CALL        _Tone2+0, 0
	CALL        _Tone3+0, 0
	CALL        _Tone3+0, 0
;main.c,31 :: 		Tone1(); Tone2(); Tone3();
	CALL        _Tone1+0, 0
	CALL        _Tone2+0, 0
	CALL        _Tone3+0, 0
;main.c,32 :: 		Tone3(); Tone3(); Tone2(); Tone2(); Tone1();
	CALL        _Tone3+0, 0
	CALL        _Tone3+0, 0
	CALL        _Tone2+0, 0
	CALL        _Tone2+0, 0
	CALL        _Tone1+0, 0
;main.c,33 :: 		}
L_end_Melody:
	RETURN      0
; end of _Melody

_ToneA:

;main.c,35 :: 		void ToneA() {
;main.c,36 :: 		Sound_Play( 880, 50);
	MOVLW       112
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       50
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;main.c,37 :: 		}
L_end_ToneA:
	RETURN      0
; end of _ToneA

_ToneC:

;main.c,38 :: 		void ToneC() {
;main.c,39 :: 		Sound_Play(1046, 50);
	MOVLW       22
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       4
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       50
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;main.c,40 :: 		}
L_end_ToneC:
	RETURN      0
; end of _ToneC

_ToneE:

;main.c,41 :: 		void ToneE() {
;main.c,42 :: 		Sound_Play(1318, 50);
	MOVLW       38
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       5
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       50
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;main.c,43 :: 		}
L_end_ToneE:
	RETURN      0
; end of _ToneE

_Melody2:

;main.c,45 :: 		void Melody2() {
;main.c,47 :: 		for (i = 9; i > 0; i--) {
	MOVLW       9
	MOVWF       Melody2_i_L0+0 
L_Melody23:
	MOVF        Melody2_i_L0+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Melody24
;main.c,48 :: 		ToneA(); ToneC(); ToneE();
	CALL        _ToneA+0, 0
	CALL        _ToneC+0, 0
	CALL        _ToneE+0, 0
;main.c,47 :: 		for (i = 9; i > 0; i--) {
	DECF        Melody2_i_L0+0, 1 
;main.c,49 :: 		}
	GOTO        L_Melody23
L_Melody24:
;main.c,50 :: 		}
L_end_Melody2:
	RETURN      0
; end of _Melody2

_main:

;main.c,53 :: 		void main() {
;main.c,54 :: 		TRISA=0b00000000; // [][][][LED][][][][]
	CLRF        TRISA+0 
;main.c,55 :: 		TRISB=0b00000001; // [][][][][][][][BUTTON]
	MOVLW       1
	MOVWF       TRISB+0 
;main.c,56 :: 		TRISD=0b00000000; // [][][][][][][][BUZZER]
	CLRF        TRISD+0 
;main.c,58 :: 		LATA=0x00;
	CLRF        LATA+0 
;main.c,59 :: 		LATB=0x00;
	CLRF        LATB+0 
;main.c,60 :: 		LATD=0x00;
	CLRF        LATD+0 
;main.c,62 :: 		ADCON1=0xFF;
	MOVLW       255
	MOVWF       ADCON1+0 
;main.c,64 :: 		Sound_Init(&PORTD, 0);
	MOVLW       PORTD+0
	MOVWF       FARG_Sound_Init_snd_port+0 
	MOVLW       hi_addr(PORTD+0)
	MOVWF       FARG_Sound_Init_snd_port+1 
	CLRF        FARG_Sound_Init_snd_pin+0 
	CALL        _Sound_Init+0, 0
;main.c,65 :: 		Sound_Play(880, 1000);             // Play sound at 880Hz for 1 second
	MOVLW       112
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       232
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
;main.c,67 :: 		i=0;
	CLRF        _i+0 
;main.c,68 :: 		while(1){
L_main6:
;main.c,69 :: 		if(!BUTTON){
	BTFSC       RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L_main8
;main.c,71 :: 		switch(i){
	GOTO        L_main9
;main.c,72 :: 		case 0: Tone1(); break;
L_main11:
	CALL        _Tone1+0, 0
	GOTO        L_main10
;main.c,73 :: 		case 1: Tone2(); break;
L_main12:
	CALL        _Tone2+0, 0
	GOTO        L_main10
;main.c,74 :: 		case 2: Tone3(); break;
L_main13:
	CALL        _Tone3+0, 0
	GOTO        L_main10
;main.c,75 :: 		case 3: Melody(); break;
L_main14:
	CALL        _Melody+0, 0
	GOTO        L_main10
;main.c,76 :: 		case 4: ToneA(); break;
L_main15:
	CALL        _ToneA+0, 0
	GOTO        L_main10
;main.c,77 :: 		case 5: ToneC(); break;
L_main16:
	CALL        _ToneC+0, 0
	GOTO        L_main10
;main.c,78 :: 		case 6: ToneE(); break;
L_main17:
	CALL        _ToneE+0, 0
	GOTO        L_main10
;main.c,79 :: 		case 7: Melody2(); break;
L_main18:
	CALL        _Melody2+0, 0
	GOTO        L_main10
;main.c,80 :: 		default: Sound_Play(100, 1000);  break;
L_main19:
	MOVLW       100
	MOVWF       FARG_Sound_Play_freq_in_hz+0 
	MOVLW       0
	MOVWF       FARG_Sound_Play_freq_in_hz+1 
	MOVLW       232
	MOVWF       FARG_Sound_Play_duration_ms+0 
	MOVLW       3
	MOVWF       FARG_Sound_Play_duration_ms+1 
	CALL        _Sound_Play+0, 0
	GOTO        L_main10
;main.c,81 :: 		}
L_main9:
	MOVF        _i+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main11
	MOVF        _i+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main12
	MOVF        _i+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
	MOVF        _i+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main14
	MOVF        _i+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_main15
	MOVF        _i+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
	MOVF        _i+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_main17
	MOVF        _i+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_main18
	GOTO        L_main19
L_main10:
;main.c,83 :: 		if(i<7) i++;
	MOVLW       7
	SUBWF       _i+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main20
	INCF        _i+0, 1 
	GOTO        L_main21
L_main20:
;main.c,84 :: 		else i=0;
	CLRF        _i+0 
L_main21:
;main.c,85 :: 		wait(100);
	MOVLW       100
	MOVWF       FARG_wait_time+0 
	MOVLW       0
	MOVWF       FARG_wait_time+1 
	CALL        _wait+0, 0
;main.c,86 :: 		while(!BUTTON);
L_main22:
	BTFSC       RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L_main23
	GOTO        L_main22
L_main23:
;main.c,87 :: 		}
L_main8:
;main.c,88 :: 		}
	GOTO        L_main6
;main.c,89 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
