#ifdef ESP8266
#include <ESP8266WiFi.h>  // WiFi library for ESP8266
#else
#include <WiFi.h>  // WiFi library for ESP32
#endif
#include <Wire.h>
#include <PubSubClient.h>
#include "DHT.h"
#include <Servo.h>
int currentposition = 0;
// const int led1 = D5; // Pin for LED 1
// const int led2 = D6; // Pin for LED 2
// const int led3 = D7; // Pin for LED 3
// WiFi and MQTT configuration
const char* wifi_ssid = "Eric0";
const char* wifi_password = "19719810Eric.";
const char* mqtt_server = "192.168.0.100";
const int mqtt_port = 1883;  // Standard MQTT port

//Motor B
const int motorBspeed = D8;
const int motorPin3 = D7;  // Pin  7 of L293
const int motorPin4 = D6;  // Pin  2 of L293

// Smoke sensor
const int buzzer = D5;
const int smokeA0 = A0;
const int sensorThres = 400;

// DHT11
#define DHTPIN D2      // Digital pin for DHT11
#define DHTTYPE DHT11  // DHT 11 type
DHT dht(DHTPIN, DHTTYPE);

// Motion sensor
const int motionSensorPin = D1;  // Changed to digital pin

// MQTT topics
const char* motion_topic = "sensors/motion";
const char* smoke_topic = "sensors/smoke";
const char* dht_topic = "sensors/dht";
const char* ir_topic = "sensors/ir";
const char* led_topic = "home/led";
const char* gate_topic = "home/gate";
const char* window_topic = "home/window";
const char* fan_topic = "home/fan";

WiFiClient espClient;
PubSubClient client(espClient);
Servo windowServo;
int pos = 0;  // position of servo motor
const int servoPin = D4;
const int statusPin = D3;  // Digital pin for status LED

// Threshold temperature for turning the fan on/off
const float temp_threshold_high = 30.0;  // High threshold (in Celsius)
const float temp_threshold_low = 25.0;   // Low threshold (in Celsius)

// Global variable to store LED state
bool ledState = false;
bool ledState1 = false;
bool fanState = false;         // False means fan is off, true means fan is on
bool windowStateMQTT = false;  // State based on MQTT messages
bool windowStateSmoke = false;  // State based on smoke sensor
bool windowCurrentState = false;  // Current state of the window

bool motionDetected = false;   // Tracks motion detection
bool mqttControlled = false;   // Tracks MQTT control
bool fanStateMQTT = false;  // State based on MQTT messages
bool fanStateTemp = false;  // State based on temperature threshold
bool fanCurrentState = false;  // Current state of the fan



void setup_wifi() {
  delay(10);
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(wifi_ssid);

  WiFi.begin(wifi_ssid, wifi_password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

void reconnect() {
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    if (client.connect("ESP8266Client")) {
      Serial.println("connected");
      client.subscribe(led_topic);  // Subscribe to LED control topic
      client.subscribe(gate_topic);
      client.subscribe("home/window");
      client.subscribe("home/fan");
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      delay(5000);
    }
  }
}

void publishMotionData() {
  int motionValue = digitalRead(motionSensorPin);
  unsigned long timestamp = millis();
  String payload = "{\"sensor_id\": 2, \"sensor_type\": \"motion\", \"timestamp\": " + String(timestamp) + ", \"sensor_value\": " + String(motionValue) + ", \"location\": \"living_room\"}";
  client.publish(motion_topic, payload.c_str());

  // Update motion detection state
  motionDetected = (motionValue == HIGH);
  updateLEDState();
}

void controlLED(String payload) {
  int state = payload.toInt();
  mqttControlled = (state == 1);
  updateLEDState();
}

void updateLEDState() {
  // LED should be ON if either motion is detected or MQTT controlled it to be ON
  if (motionDetected || mqttControlled) {
    digitalWrite(statusPin, HIGH);
  } else {
    digitalWrite(statusPin, LOW);
  }
}

void publishSmokeData() {
  int smokeValue = analogRead(smokeA0);
  unsigned long timestamp = millis();
  String payload = "{\"sensor_id\": 3, \"sensor_type\": \"smoke\", \"timestamp\": " + String(timestamp) + ", \"sensor_value\": " + String(smokeValue) + ", \"location\": \"Kitchen\"}";
  client.publish(smoke_topic, payload.c_str());
}
void publishDHTData() {
  float h = dht.readHumidity();
  float t = dht.readTemperature();
  float f = dht.readTemperature(true);

  if (isnan(h) || isnan(t) || isnan(f)) {
    Serial.println("Failed to read from DHT sensor!");
    return;
  }

  unsigned long timestamp = millis();
  String payload = "{\"sensor_id\": 4, \"sensor_type\": \"dht\", \"timestamp\": " + String(timestamp) + ", \"humidity\": " + String(h) + ", \"temperature\": " + String(t) + ", \"location\": \"living_room\"}";
  client.publish(dht_topic, payload.c_str());

  // Update fan state based on temperature
  if (t >= temp_threshold_high) {
    fanStateTemp = true;  // Set fan state based on temperature to ON
  } else if (t <= temp_threshold_low) {
    fanStateTemp = false;  // Set fan state based on temperature to OFF
  }

  updateFanState();  // Update the fan state based on both variables
}



void controlGate(String payload) {
  Serial.println("Gate state received: " + payload);

  if (payload == "open") {
   
    Serial.println("Gate:1");  // Send '1' command to Arduino
  } else if (payload == "close") {
    
    Serial.println("Gate:0");  // Send '0' command to Arduino
  } else {
    Serial.println("Invalid command received for gate");
  }
}

void controlWindow(String payload) {
  Serial.println("Window state received: " + payload);
  if (payload == "open") {
    windowStateMQTT = true;  // Set window state based on MQTT to OPEN
  } else if (payload == "close") {
    windowStateMQTT = false;  // Set window state based on MQTT to CLOSED
  }
  updateWindowState();  // Update the window state based on both variables
}

void checkSmokeSensor() {
  int smokeValue = analogRead(smokeA0);
  if (smokeValue > sensorThres) {
    digitalWrite(buzzer, HIGH);
    windowStateSmoke = true;  // Set window state based on smoke sensor to OPEN
  } else {
    digitalWrite(buzzer, LOW);
    windowStateSmoke = false;  // Set window state based on smoke sensor to CLOSED
  }
  updateWindowState();  // Update the window state based on both variables
}

void updateWindowState() {
  bool newState = windowStateMQTT || windowStateSmoke;
  if (newState != windowCurrentState) {
    if (newState) {
      unlockWindow();  // Open the window
    } else {
      closeWindow();  // Close the window
    }
    windowCurrentState = newState;
  }
}



void controlFan(String payload) {
  Serial.println("Fan state received: " + payload);
  if (payload == "on") {
    Serial.println("Turning fan on via MQTT");
    fanStateMQTT = true;  // Set fan state based on MQTT to ON
  } else if (payload == "off") {
    Serial.println("Turning fan off via MQTT");
    fanStateMQTT = false;  // Set fan state based on MQTT to OFF
  }
  updateFanState();  // Update the fan state based on both variables
}

void updateFanState() {
  bool newState = fanStateMQTT || fanStateTemp;
  if (newState != fanCurrentState) {
    if (newState) {
      forward();  // Turn on the fan
    } else {
      stop();  // Turn off the fan
    }
    fanCurrentState = newState;
  }
}



void callback(char* topic, byte* payload, unsigned int length) {
  String message;
  for (unsigned int i = 0; i < length; i++) {
    message += (char)payload[i];
  }

  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  Serial.println(message);

  if (String(topic) == led_topic) {


    controlLED(message);
  }
  if (String(topic) == gate_topic) {

    controlGate(message);
  }
  if (String(topic) == window_topic) {
    controlWindow(message);
  }
  if (String(topic) == fan_topic) {

    controlFan(message);
  }
}

void setup() {
  Serial.begin(9600);
  pinMode(motionSensorPin, INPUT);
  pinMode(statusPin, OUTPUT);
  pinMode(buzzer, OUTPUT);
  pinMode(smokeA0, INPUT);


  pinMode(motorPin3, OUTPUT);
  pinMode(motorPin4, OUTPUT);
  pinMode(motorBspeed, OUTPUT);


  windowServo.attach(servoPin);

  dht.begin();
  setup_wifi();
  client.setServer(mqtt_server, mqtt_port);
  client.setCallback(callback);
}

void forward() {
  Serial.println("Fan forward()");
  analogWrite(motorBspeed, 255);  // Set motor speed to maximum (for ESP8266)
  digitalWrite(motorPin3, HIGH);
  digitalWrite(motorPin4, LOW);
}

void backward() {

  digitalWrite(motorPin3, LOW);
  digitalWrite(motorPin4, HIGH);
}

void stop() {

  digitalWrite(motorPin3, LOW);
  digitalWrite(motorPin4, LOW);
}

void loop() {
  if (!client.connected()) {
    reconnect();
  }
  client.loop();

  publishMotionData();
  publishSmokeData();
  publishDHTData();


  int smokeValue = analogRead(smokeA0);
  if (smokeValue > sensorThres) {
    digitalWrite(buzzer, HIGH);
    unlockWindow();
  } else {
    digitalWrite(buzzer, LOW);
  }
  updateLEDState();
  checkSmokeSensor();

 

 

  delay(2000);
}

void unlockWindow() {

  windowServo.write(180);  // Move servo to 90 degrees
}

void closeWindow() {

  windowServo.write(0);  // Move servo to 0 degrees
}
