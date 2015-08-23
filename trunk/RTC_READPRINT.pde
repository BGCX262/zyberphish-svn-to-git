#include <OneWire.h>

int oldseconds = 0;
  byte RTCaddr[8];
    OneWire ds(8);  // on pin 10
void setup(void) {
  Serial.begin(9600);
  SetupRTC();
}

void SetupRTC()
{

 ds.search(RTCaddr);
 ds.reset_search();
}



int GetTimestamp()
{
uint32_t timestamp;
  byte data[8];
  int i;  
  ds.reset();
  ds.select(RTCaddr);
  ds.write(0x66,1);   // read RTC
  for ( i = 0; i < 5; i++) {
    data[i] = ds.read();
  }
      timestamp = data[4];
      timestamp = timestamp << 8;
      timestamp |= data[3];
      timestamp = timestamp << 8;
      timestamp |= data[2];
      timestamp = timestamp << 8;
      timestamp |= data[1];
  return timestamp;
}

void loop(void) {
  uint32_t timestamp;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;  

timestamp = GetTimestamp();    
Serial.println(timestamp);
seconds = timestamp%60;
minutes = (timestamp%3600)/60;
hours = (timestamp%86400)/3600;

if (seconds != oldseconds)
{
if(hours < 10)
{
  Serial.print(0);
}
Serial.print(hours);
Serial.print(":");
if(minutes < 10)
{
  Serial.print(0);
}
Serial.print(minutes);
Serial.print(":");
if(seconds < 10)
{
  Serial.print(0);
}
Serial.print(seconds);
Serial.print("\n");
}
oldseconds = seconds;
delay(500);
}



