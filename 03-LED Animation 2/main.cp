#line 1 "C:/Users/ueminiscan/Documents/GitHub/mikroc-ile-pic-programlama/03-LED Animation 2/main.c"

sbit LED at LATA4_bit;

sbit LEDR at LATD0_bit;
sbit LEDG at LATD1_bit;
sbit LEDY at LATD2_bit;
sbit LEDB at LATD3_bit;


unsigned short i;

void wait(){
 delay_ms(50);
}

void main() {
 TRISA=0b00000000;
 TRISD=0b00000000;

 LATA=0x00;
 LATD=0x00;

 while(1){
 LED=!LED;

 for(i=0;i<5;i++){
 LEDR=1; wait(); LEDR=0; wait();
 }
 for(i=0;i<5;i++){
 LEDB=1; wait(); LEDB=0; wait();
 }
 }
}
