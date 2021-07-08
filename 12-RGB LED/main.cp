#line 1 "C:/Users/ueminiscan/Documents/GitHub/mikroc-ile-pic-programlama/12-RGB LED/main.c"

sbit LED at LATA4_bit;
sbit LEDR at LATC2_bit;
sbit LEDG at LATC1_bit;
sbit LEDB at LATD0_bit;

unsigned short dutyLEDR=0,dutyLEDG=0,dutyLEDB=0;
unsigned short counterLEDR=0,counterLEDG=0,counterLEDB=0;
unsigned int i;

void wait(unsigned int time){
 while(time--)
 delay_ms(1);
}

void SetRGB(unsigned short R,unsigned short G,unsigned short B){
 dutyLEDR=R;
 dutyLEDG=G;
 dutyLEDB=B;

 PWM1_Set_Duty(dutyLEDR);
 PWM2_Set_Duty(dutyLEDG);
}



void AnimateRGB(unsigned short R,unsigned short G,unsigned short B){
 while((dutyLEDR != R)|| (dutyLEDG != G)||(dutyLEDB != B)){
 if(R>dutyLEDR) dutyLEDR++;
 else if(R<dutyLEDR) dutyLEDR--;

 if(G>dutyLEDG) dutyLEDG++;
 else if(G<dutyLEDG) dutyLEDG--;

 if(B>dutyLEDB) dutyLEDB++;
 else if(B<dutyLEDB) dutyLEDB--;

 wait(10);
 }
}

void InitTimer0(){
 T0CON = 0x88;
 TMR0H = 0x88;
 TMR0L = 0x78;
 GIE_bit = 1;
 TMR0IE_bit = 1;
}
void InitTimer1(){
 T1CON = 0x01;
 TMR1IF_bit = 0;
 TMR1H = 0xFF;
 TMR1L = 0x88;
 TMR1IE_bit = 1;
 INTCON = 0xC0;
}


void Interrupt(){

 if (TMR0IF_bit){
 TMR0IF_bit = 0;
 TMR0H = 0x88;
 TMR0L = 0x78;

 if(dutyLEDR) LEDR=1;
 if(dutyLEDG) LEDG=1;
 if(dutyLEDB) LEDB=1;

 counterLEDR=0;
 counterLEDG=0;
 counterLEDB=0;
 }

 if (TMR1IF_bit){
 TMR1IF_bit = 0;
 TMR1H = 0xFF;
 TMR1L = 0x88;

 if(counterLEDR>=dutyLEDR) LEDR=0;
 if(counterLEDG>=dutyLEDG) LEDG=0;
 if(counterLEDB>=dutyLEDB) LEDB=0;

 if(counterLEDR<255) counterLEDR++;
 if(counterLEDG<255) counterLEDG++;
 if(counterLEDB<255) counterLEDB++;
 }

}
void main() {
 TRISA=0b00000000;
 TRISC=0b00000000;
 TRISD=0b00000000;

 LATA=0x00;
 LATC=0x00;
 LATD=0x00;
#line 107 "C:/Users/ueminiscan/Documents/GitHub/mikroc-ile-pic-programlama/12-RGB LED/main.c"
 InitTimer0();
 InitTimer1();

 while(1){
#line 142 "C:/Users/ueminiscan/Documents/GitHub/mikroc-ile-pic-programlama/12-RGB LED/main.c"
 AnimateRGB(255,0,0);
 AnimateRGB(0,255,0);
 AnimateRGB(0,0,255);
 AnimateRGB(255,127,0);
 AnimateRGB(255,0,150);
 AnimateRGB(255,255,255);
 }
}
