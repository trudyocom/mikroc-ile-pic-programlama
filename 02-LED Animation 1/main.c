// Connections
sbit LED at LATA4_bit;

sbit LEDR at LATD0_bit;
sbit LEDG at LATD1_bit;
sbit LEDY at LATD2_bit;
sbit LEDB at LATD3_bit;

void main() {
  TRISA=0b00000000; // [][][][LED][][][][]
  TRISD=0b00000000; // [][][][][LEDB][LEDY][LEDG][LEDR]

  LATA=0x00;
  LATD=0x00;
  
  while(1){
    LED=!LED;
    /*
    LEDR=!LEDR; delay_ms(500);
    LEDG=!LEDG; delay_ms(500);
    LEDY=!LEDY; delay_ms(500);
    LEDB=!LEDB; delay_ms(500);
    */

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