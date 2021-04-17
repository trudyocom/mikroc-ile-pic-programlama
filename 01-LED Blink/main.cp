#line 1 "C:/Users/ueminiscan/Documents/GitHub/mikroc-ile-pic-programlama/01-LED Blink/main.c"

sbit LED at LATA4_bit;

void main() {
 TRISA=0b00000000;

 LATA=0x00;

 while(1){



 LED=!LED; delay_ms(100);
 }
}
