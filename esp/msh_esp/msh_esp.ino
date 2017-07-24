#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
#include <EEPROM.h>
#include <ArduinoJson.h>
#include <Ticker.h>

WiFiUDP Udp;
Ticker timers;
WiFiClient wclient;
const int module_id = 1;
const char *ssid = "Bubuka";
const char *password = "22011993";
const int localUdpPort = 2201;
const int outUdpPort=1407;

char incomingPacket[512];  // Буфер для пакету UDP

void setup_to_sta() // Налаштування пристрою в режим "Станції"
{
  Serial.print("Connecting");
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid,password); // підключення до WI-FI мережі заданої в налаштуваннях
  uint8_t i = 0;
  while (WiFi.status() != WL_CONNECTED && i++ < 20)
  {
    delay(500);
    Serial.print(".");
    if (i == 20)
    {
      Serial.print("Could not connect to");
      Serial.println("");
      delay(500);
      ESP.reset();
    }
  }
  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

void setup()
{
  Serial.begin(115200);
  EEPROM.begin(4000);
  setup_to_sta();
  Udp.begin(localUdpPort);
}

void loop()
{
  int packetSize = Udp.parsePacket();
  if (packetSize)
  {
    int len = Udp.read(incomingPacket, 512);
    if (len > 0)
    {
      incomingPacket[len] = 0;
    }
    Serial.printf("UDP in: %s\n", incomingPacket);
    proces_json (incomingPacket);
  }
}
void send_udp(char *data)
{
    Udp.beginPacket("255.255.255.255", outUdpPort);
    Udp.write(data);
    Udp.endPacket();
}
