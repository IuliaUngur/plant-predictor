#include <IRremote.h>

//Extra inputs
int LED_PIN = 13; // output
int BUTTON_PIN = 3; // input
int BUZZER_PIN = 5; // output
int POTENTIOMETER_PIN = A0; // input

//Sensors - inputs
int ULTRASONIC_TRIG_PIN = 2;
int ULTRASONIC_ECHO_PIN = 6;
int RAINDROP_DIGITAL_PIN = 8;
int RAINDROP_ANALOG_PIN = A5;
int LIGHT_PIN = A2;
int TEMPERATURE_PIN = A1;
int HUMIDITY_DIGITAL_PIN = 9;
int HUMIDITY_ANALOG_PIN = A4;
int VIBRATION_PIN = A3;

//Remote control
int RECV_PIN = 11; //input

//Variables
IRrecv irrecv(RECV_PIN);
decode_results results;
bool startReadings;

//IR codes
// 0 = 0xFF4AB5;
// 1 = 0xFF6897;
// 2 = 0xFF9867;
// 3 = 0xFFB04F;
// 4 = 0xFF30CF;
// 5 = 0xFF18E7;
// 6 = 0xFF7A85;
// 7 = 0xFF10EF;
// 8 = 0xFF38C7;
// 9 = 0xFF5AA5;
// OK = 0xFF02FD;

//Modules
//TO DO: wifi module

void save(){
  //saveToFile();
  //save  to server;
}

float ultrasonicReading(){
  float distance, distances[20];
  memset(distances,0,sizeof(distances));

  int i=0;
  do{
    delay(10);
    digitalWrite(ULTRASONIC_TRIG_PIN, LOW);
    delayMicroseconds(2);

    digitalWrite(ULTRASONIC_TRIG_PIN, HIGH);
    delayMicroseconds(10);

    digitalWrite(ULTRASONIC_TRIG_PIN, LOW);

    distance = pulseIn(ULTRASONIC_ECHO_PIN, HIGH);
    distance = distance/58; // Compute distance

    if (i==0){
      distances[i] = distance;
    }
    else{
      if(abs(distances[i-1] - distance) <= (distances[i-1]*0.4)){
        distances[i] = distance;
      }
    }
    i++;
  }while( i < 20);

  distance = 0;
  for(int j=0;j<i;j++)
    distance += distances[j]/i;

  return distance;
}

void readSensorValues(){
  String sensors[6]={"temperature", "light", "vibration", "distance", "humidity", "raindrop"};
  String data[6]={};

  // temperature
  float voltage, degreesC;

  voltage = analogRead(TEMPERATURE_PIN) * 0.004882814;
  degreesC = (voltage - 0.5) * 100.0;
  data[0] = degreesC;

  // light
  int light, brightness;
  String lightDegrees[5] = {"DARK", "MOONLIGHT", "FOG", "CLEAR", "SUNNY"};

  light = analogRead(LIGHT_PIN);
  brightness = map(light, 0, 1023, 0, 4);

  data[1] = lightDegrees[brightness];

  // vibrations
  int vibration;

  vibration = analogRead(VIBRATION_PIN);
  data[2] = vibration;

  //ultrasonic
  float distance = ultrasonicReading();
  data[3] = distance;

  //humidity
  int humidity, procentHumidity;

  humidity = analogRead(HUMIDITY_ANALOG_PIN);
  procentHumidity = map(humidity, 1023, 0, 0, 100);
  data[4] = procentHumidity;

  //rain drops
  int rainDrops, rainValues;
  String rainDegrees[5] = {"DRY", "CONDENSE", "DRIZZLE", "HEAVY RAIN", "FLOOD"};

  rainDrops = analogRead(RAINDROP_ANALOG_PIN);
  rainValues = map(rainDrops, 1023, 0, 0, 4);

  data[5] = rainDegrees[rainValues];

  Serial.println("");
  Serial.print("{");
  ///////////////////
  for(int i=0; i<5; i++){
      Serial.print("\"" + sensors[i] + "\":");
      Serial.print("\"" + data[i] + "\"");
      Serial.print(", ");
  }
  Serial.print("\"" + sensors[5] + "\":");
  Serial.print("\"" + data[5] + "\"");
  Serial.print("}");
}

void setup() {
  Serial.begin(9600);
  irrecv.enableIRIn(); // Start the receiver

  pinMode(BUTTON_PIN, INPUT);
  pinMode(LED_PIN, OUTPUT);
  pinMode(BUZZER_PIN, OUTPUT);
  pinMode(POTENTIOMETER_PIN, INPUT);

  pinMode(ULTRASONIC_TRIG_PIN, OUTPUT);
  pinMode(ULTRASONIC_ECHO_PIN, INPUT);
  pinMode(RAINDROP_DIGITAL_PIN, INPUT);
  pinMode(RAINDROP_ANALOG_PIN, INPUT);
  pinMode(LIGHT_PIN, INPUT);
  pinMode(TEMPERATURE_PIN, INPUT);
  pinMode(HUMIDITY_DIGITAL_PIN, INPUT);
  pinMode(HUMIDITY_ANALOG_PIN, INPUT);
  pinMode(VIBRATION_PIN, INPUT);

  startReadings = false;
}

void loop() {
  if (irrecv.decode(&results)) {
    if(results.value == 0xFF02FD){
      startReadings = !startReadings;
      analogWrite(BUZZER_PIN,1024);// for a louder sound
      delay(300);
      digitalWrite(BUZZER_PIN,LOW);
    }
    irrecv.resume();
  }
  if(startReadings){
    readSensorValues();
    save();
  }

  int readingTime,timeDelay;
  readingTime = analogRead(POTENTIOMETER_PIN);
  timeDelay = map(readingTime, 0, 1023, 1000, 10000);
  delay(timeDelay);
}
