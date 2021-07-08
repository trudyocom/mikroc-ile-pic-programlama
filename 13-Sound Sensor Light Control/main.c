// Connections
sbit LED at LATA4_bit;

unsigned int temp,counter;

void wait(unsigned int time){
  while(time--)
    delay_ms(1);
}
    //Timer0
//Prescaler 1:256; TMR0 Preload = 18661; Actual Interrupt Time : 1

//Place/Copy this part in declaration section
void InitTimer0(){
  T0CON	 = 0x87;
  TMR0H	 = 0x48;
  TMR0L	 = 0xE5;
  GIE_bit	 = 1;
  TMR0IE_bit	 = 1;
}

void Interrupt(){
  // 1000ms
  if (TMR0IF_bit){
    TMR0IF_bit = 0;
    TMR0H	 = 0x48;
    TMR0L	 = 0xE5;
    //Enter your code here
    
    TMR0IE_bit=0;
  }
}

void main() {
  TRISA=0b00000001; // [][][][LED][][][][SOUND]

  LATA=0x00;
  
  ADC_Init();
  
  while(1){
    temp=ADC_Read(0);
    if(temp<100){
      //LED=!LED;
      wait(50);

      counter=1;
      InitTimer0();
    }
    while(TMR0IE_bit){
      temp=ADC_Read(0);
      if(temp<100){
        counter++;
        wait(50);
      }
    }
    
    if(counter==2) LED=!LED;
    counter=0;
  }
}