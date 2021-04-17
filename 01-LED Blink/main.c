// Connections
sbit LED at LATA4_bit;

void main() {
  TRISA=0b00000000; // [][][][LED][][][][]
  
  LATA=0x00;
  
  while(1){
    //LED=1; delay_ms(100);
    //LED=0; delay_ms(100);
    
    LED=!LED; delay_ms(100);
  }
}