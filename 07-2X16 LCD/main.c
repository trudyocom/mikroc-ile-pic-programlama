// Connections
sbit LED at LATA4_bit;
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
unsigned short i,j;

void wait(unsigned int time){
  while(time--)
    delay_ms(1);
}

void main() {
  TRISA=0b00000000; // [][][][LED][][][][]
  TRISD=0b00000000; // [][LCD_BACKLIGHT][LCD_D7][LCD_D6][LCD_D5][LCD_D4][LCD_EN][LCD_RS]

  LATA=0x00;
  LATD=0x00;

  Lcd_Init();
  LCD_BACKLIGHT=1;
  
  Lcd_Out(1,1,"Hello trudyo!");
  Lcd_Cmd(_LCD_CURSOR_OFF);
  while(1){
    for(i=0;i<3;i++){
      Lcd_Cmd(_LCD_SHIFT_RIGHT);
      wait(500);
    }
    for(i=0;i<3;i++){
      Lcd_Cmd(_LCD_SHIFT_LEFT);
      wait(500);
    }
  }
}