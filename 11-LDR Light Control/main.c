// Connections
sbit LED at LATA4_bit;

void wait(unsigned int time){
  while(time--)
    delay_ms(1);
}

unsigned int getLDRVoltage(){
  unsigned int temp;

  temp=ADC_Read(0);
  temp*=0.48828125;

  return temp;
}

void main() {
  TRISA=0b00000001; // [][][][LED][][][][LM35]

  LATA=0x00;
  
  while(1){
    if(getLDRVoltage()>300) LED=1;
    else LED=0;
    
    wait(250);
  }
}