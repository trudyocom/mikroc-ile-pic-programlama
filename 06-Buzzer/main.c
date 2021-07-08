// Connections
sbit LED at LATA4_bit;

sbit BUTTON at RB0_bit;
sbit BUUZER at LATD0_bit;

// Global Variables
unsigned short i,j;

void Tone1() {
  Sound_Play(659, 250);   // Frequency = 659Hz, duration = 250ms
}

void Tone2() {
  Sound_Play(698, 250);   // Frequency = 698Hz, duration = 250ms
}

void Tone3() {
  Sound_Play(784, 250);   // Frequency = 784Hz, duration = 250ms
}

void Melody() {           // Plays the melody "Yellow house"
  Tone1(); Tone2(); Tone3(); Tone3();
  Tone1(); Tone2(); Tone3(); Tone3();
  Tone1(); Tone2(); Tone3();
  Tone1(); Tone2(); Tone3(); Tone3();
  Tone1(); Tone2(); Tone3();
  Tone3(); Tone3(); Tone2(); Tone2(); Tone1();
}

void ToneA() {
  Sound_Play( 880, 50);
}
void ToneC() {
  Sound_Play(1046, 50);
}
void ToneE() {
  Sound_Play(1318, 50);
}

void Melody2() {
  unsigned short i;
  for (i = 9; i > 0; i--) {
    ToneA(); ToneC(); ToneE();
  }
}

void wait(unsigned int time){
  while(time--)
    delay_ms(1);
}

void main() {
  TRISA=0b00000000; // [][][][LED][][][][]
  TRISB=0b00000001; // [][][][][][][][BUTTON]
  TRISD=0b00000000; // [][][][][][][][BUZZER]

  LATA=0x00;
  LATB=0x00;
  LATD=0x00;
  
  ADCON1=0xFF;

  Sound_Init(&PORTD, 0);
  Sound_Play(800, 1000);

  i=0;
  while(1){
    if(!BUTTON){
      switch(i){
        case 0: Tone1();   break;
        case 1: Tone2();   break;
        case 2: Tone3();   break;
        case 3: Melody();  break;
        case 4: ToneA();   break;
        case 5: ToneC();   break;
        case 6: ToneE();   break;
        case 7: Melody2(); break;
        default: 
          i=0;
          Sound_Play(800, 250);
          Sound_Play(400, 250);
          Sound_Play(800, 250);
          Sound_Play(400, 250);
          Sound_Play(800, 250);
          Sound_Play(400, 250);
          Sound_Play(800, 250);
          Sound_Play(400, 250);
          break;
      }
      i++;
      wait(100);
      while(!BUTTON);
    }
  }
}