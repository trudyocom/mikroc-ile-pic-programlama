// Connections
sbit LED at LATA4_bit;

sbit LEDR1 at LATD0_bit;
sbit LEDR2 at LATD1_bit;
sbit LEDR3 at LATD2_bit;
sbit LEDR4 at LATD3_bit;
sbit LEDB1 at LATD4_bit;
sbit LEDB2 at LATD5_bit;
sbit LEDB3 at LATD6_bit;
sbit LEDB4 at LATD7_bit;

sbit BUTTON_UP at RB1_bit;
sbit BUTTON_DN at RB0_bit;

// Global Variables
unsigned short i;

void wait(){
  delay_ms(50);
}

void main() {
  TRISA=0b00000000; // [][][][LED][][][][]
  TRISB=0b00000011; // [][][][][][][BUTTON_DN][BUTTON_UP]
  TRISD=0b00000000; // [LEDB4][LEDB3][LEDB2][LEDB1][LEDR4][LEDR3][LEDR2][LEDR1]

  LATA=0x00;
  LATB=0x00;
  LATD=0x00;
  
  ADCON1=0xFF;
  
  LATD=0b00000001;
  
  while(1){
    for(i=0;i<7;i++){
      LATD<<=1;
      wait();
    }
    for(i=0;i<7;i++){
      LATD>>=1;
      wait();
    }
  }
}