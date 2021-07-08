#line 1 "C:/Users/ueminiscan/Documents/GitHub/mikroc-ile-pic-programlama/09-HC-SR04 Park Sensor/main.c"

sbit LED at LATA4_bit;
sbit TRIG at LATB0_bit;
sbit ECHO at RB1_bit;

sbit LEDR at LATD0_bit;
sbit LEDY at LATD1_bit;
sbit LEDG at LATD2_bit;
sbit BUZZER at LATD3_bit;



unsigned int distance;
char txt[7];

void wait(unsigned int time){
 while(time--)
 delay_ms(1);
}

unsigned int getDistance(){
 unsigned int temp;
 T0CON=0b01000110;
 TMR0H=0;
 TMR0L=0;

 TRIG=1;
 delay_us(10);
 TRIG=0;

 while(!ECHO);
 TMR0ON_bit=1;
 while(ECHO && TMR0L<250);

 temp=1.8303*TMR0L;

 return temp;
}

void main() {
 TRISA=0b00000000;
 TRISB=0b00000010;
 TRISD=0b00000000;

 LATA=0x00;
 LATB=0x00;
 LATD=0x00;

 ADCON1=0x0F;
 while(1){
 distance=getDistance();

 if(distance>200){
 LEDR=0; LEDY=0; LEDG=!LEDG;
 }
 else if(distance>100){
 LEDR=0; LEDY=!LEDY; LEDG=1;
 }
 else{
 LEDR=!LED; LEDY=1; LEDG=1;
 }

 if(distance<50){
 BUZZER=1;
 }
 else{
 BUZZER=!BUZZER;
 wait(distance);
 }
 }
}
