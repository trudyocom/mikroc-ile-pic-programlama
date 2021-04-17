#line 1 "C:/Users/ueminiscan/Documents/GitHub/mikroc-ile-pic-programlama/02-LED Animation 1/main.c"

sbit LED at LATA4_bit;

sbit LEDR at LATD0_bit;
sbit LEDG at LATD1_bit;
sbit LEDY at LATD2_bit;
sbit LEDB at LATD3_bit;

void main() {
 TRISA=0b00000000;
 TRISD=0b00000000;

 LATA=0x00;
 LATD=0x00;

 while(1){
 LED=!LED;
#line 25 "C:/Users/ueminiscan/Documents/GitHub/mikroc-ile-pic-programlama/02-LED Animation 1/main.c"
 LEDR=1; delay_ms(50); LEDR=0; delay_ms(50);
 LEDR=1; delay_ms(50); LEDR=0; delay_ms(50);
 LEDR=1; delay_ms(50); LEDR=0; delay_ms(50);
 LEDR=1; delay_ms(50); LEDR=0; delay_ms(50);
 LEDR=1; delay_ms(50); LEDR=0; delay_ms(50);

 LEDB=1; delay_ms(50); LEDB=0; delay_ms(50);
 LEDB=1; delay_ms(50); LEDB=0; delay_ms(50);
 LEDB=1; delay_ms(50); LEDB=0; delay_ms(50);
 LEDB=1; delay_ms(50); LEDB=0; delay_ms(50);
 LEDB=1; delay_ms(50); LEDB=0; delay_ms(50);
 }
}
