// Connections
sbit LED at LATA4_bit;
sbit TRIG at LATB0_bit;
sbit ECHO at RB1_bit;
sbit LCD_BACKLIGHT at LATD6_bit;
// Lcd pinout settings
sbit LCD_RS at RD0_bit;
sbit LCD_EN at RD1_bit;
sbit LCD_D7 at RD5_bit;
sbit LCD_D6 at RD4_bit;
sbit LCD_D5 at RD3_bit;
sbit LCD_D4 at RD2_bit;

// Pin direction
sbit LCD_RS_Direction at TRISD0_bit;
sbit LCD_EN_Direction at TRISD1_bit;
sbit LCD_D7_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD2_bit;


// Global Variables
unsigned int distance;
char txt[7];

void wait(unsigned int time){
  while(time--)
    delay_ms(1);
}

unsigned int getDistance(){
  unsigned int temp;
  T0CON=0b01000110;
  TMR0H=0;
  TMR0L=0;
  
  TRIG=1;
  delay_us(10);
  TRIG=0;
  
  while(!ECHO);
  TMR0ON_bit=1;
  while(ECHO && TMR0L<250);
  
  temp=1.8303*TMR0L;
  
  return temp;
}

void main() {
  TRISA=0b00000000; // [][][][LED][][][][]
  TRISB=0b00000010; // [][][][][][][ECHO][TRIG]
  TRISD=0b00000000; // [][LCD_BACKLIGHT][LCD_D7][LCD_D6][LCD_D5][LCD_D4][LCD_EN][LCD_RS]

  LATA=0x00;
  LATB=0x00;
  LATD=0x00;
  
  ADCON1=0x0F;

  Lcd_Init();
  LCD_BACKLIGHT=1;
  
  Lcd_Out(1,1,"Mesafe:       mm");
  Lcd_Cmd(_LCD_CURSOR_OFF);
  while(1){
    distance=getDistance();
    IntToStr(distance,txt);
    
    if(distance>300) Lcd_Out(1,8,"   MAX");
    else Lcd_Out(1,8,txt);
    
    wait(100);
  }
}