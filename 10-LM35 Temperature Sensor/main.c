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
char txt[7];

void wait(unsigned int time){
  while(time--)
    delay_ms(1);
}

unsigned int getTemperature(){
  unsigned int temp;

  temp=ADC_Read(0);
  temp*=4.8828125;

  return temp;
}

void main() {
  TRISA=0b00000001; // [][][][LED][][][][LM35]
  TRISD=0b00000000; // [][LCD_BACKLIGHT][LCD_D7][LCD_D6][LCD_D5][LCD_D4][LCD_EN][LCD_RS]

  LATA=0x00;
  LATD=0x00;

  Lcd_Init();
  LCD_BACKLIGHT=1;

  Lcd_Out(1,1,"LM35 Temp.Sensor");
  Lcd_Out(2,1,"Value:         C");
  Lcd_Cmd(_LCD_CURSOR_OFF);
  
  while(1){
    IntToStr(getTemperature(),txt);

    Lcd_Chr(2,8,txt[0]);
    Lcd_Chr(2,9,txt[1]);
    Lcd_Chr(2,10,txt[2]);
    Lcd_Chr(2,11,txt[3]);
    Lcd_Chr(2,12,txt[4]);
    Lcd_Chr(2,13,'.');
    Lcd_Chr(2,14,txt[5]);
    wait(1000);
  }
}