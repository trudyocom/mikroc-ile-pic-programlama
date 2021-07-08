// Connections
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
  T0CON             = 0x88;
  TMR0H             = 0x88;
  TMR0L      = 0x78;
  GIE_bit    = 1;
  TMR0IE_bit = 1;
}  
void InitTimer1(){
  T1CON      = 0x01;
  TMR1IF_bit = 0;
  TMR1H             = 0xFF;
  TMR1L      = 0x88;
  TMR1IE_bit = 1;
  INTCON     = 0xC0;
}


void Interrupt(){
  // 2550us=2.55ms
  if (TMR0IF_bit){
    TMR0IF_bit = 0;
    TMR0H         = 0x88;
    TMR0L         = 0x78;
    //Enter your code here
    if(dutyLEDR) LEDR=1;
    if(dutyLEDG) LEDG=1;
    if(dutyLEDB) LEDB=1;

    counterLEDR=0;
    counterLEDG=0;
    counterLEDB=0;
  }
  // 10us
  if (TMR1IF_bit){
    TMR1IF_bit = 0;
    TMR1H         = 0xFF;
    TMR1L         = 0x88;
    //Enter your code here
    if(counterLEDR>=dutyLEDR) LEDR=0;
    if(counterLEDG>=dutyLEDG) LEDG=0;
    if(counterLEDB>=dutyLEDB) LEDB=0;
    
    if(counterLEDR<255) counterLEDR++;
    if(counterLEDG<255) counterLEDG++;
    if(counterLEDB<255) counterLEDB++;
  }

}
void main() {
  TRISA=0b00000000; // [][][][LED][][][][]
  TRISC=0b00000000; // [][][][][][LEDR][LEDG][]
  TRISD=0b00000000; // [][][][][][][][LEDB]

  LATA=0x00;
  LATC=0x00;
  LATD=0x00;
  
  /*
  PWM1_Init(5000);
  PWM1_Set_Duty(dutyLEDR);
  PWM1_Start();
  PWM2_Init(5000);
  PWM2_Set_Duty(dutyLEDG);
  PWM2_Start();
  */
  InitTimer0();
  InitTimer1();
  
  while(1){
    /*LEDR=0; LEDG=0; LEDB=0; wait(1000);
    LEDR=1; LEDG=0; LEDB=0; wait(1000);
    LEDR=0; LEDG=1; LEDB=0; wait(1000);
    LEDR=0; LEDG=0; LEDB=1; wait(1000); */
    /*
    for(i=0;i<255;i++){
      PWM1_Set_Duty(i);
      wait(10);
    }
    for(i=0;i<255;i++){
      PWM1_Set_Duty(255-i);
      wait(10);
    }
    
    for(i=0;i<255;i++){
      PWM2_Set_Duty(i);
      wait(10);
    }
    for(i=0;i<255;i++){
      PWM2_Set_Duty(255-i);
      wait(10);
    } */
    
    /*
    SetRGB(255,0,0); wait(500);
    SetRGB(0,255,0); wait(500);
    SetRGB(0,0,255); wait(500);
    SetRGB(255,127,0); wait(500);
    SetRGB(255,0,150); wait(500);
    SetRGB(255,255,255); wait(500);  */

    AnimateRGB(255,0,0);
    AnimateRGB(0,255,0);
    AnimateRGB(0,0,255);
    AnimateRGB(255,127,0);
    AnimateRGB(255,0,150);
    AnimateRGB(255,255,255);
  }
}