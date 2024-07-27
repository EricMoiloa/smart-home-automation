import paho.mqtt.client as mqtt
import json
from datetime import datetime
from sqlalchemy.sql import text
from sqlalchemy.orm import Session
from .database import SessionLocal
from .models import SensorData, LEDControl, GateStatus,WindowStatus


# MQTT configuration
MQTT_BROKER = "192.168.0.100"
MQTT_PORT = 1883
MQTT_TOPICS = [
    "sensors/motion",
    "sensors/dht",
    "sensors/smoke",
    "sensors/ir",
   "home/led",
    "home/gate",
    "home/fan",
    "home/window"
]
MQTT_LED_TOPIC = "home/led"
MQTT_GATE_TOPIC = "home/gate"
MQTT_FAN_TOPIC = "home/fan"
MQTT_WINDOW_TOPIC = "home/window"

# The callback for when the client receives a CONNACK response from the server
def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))
    for topic in MQTT_TOPICS:
        client.subscribe(topic)
        print(f"Subscribed to topic: {topic}")

# The callback for when a PUBLISH message is received from the server
def on_message(client, userdata, msg):
    try:
        # Decode the payload
        payload = msg.payload.decode()
        # print(f"Received message on topic {msg.topic}: {payload}")

        # Handle the LED control topic separately
        if msg.topic == "home/led":
            handle_led_message(payload)
            return

        # Handle the gate control topic separately
        if msg.topic == "home/gate":
            handle_gate_message(payload)
            return

        if msg.topic == "home/window":
            handle_window_message(payload)
            return

        # Parse the payload as JSON
        payload = json.loads(payload)
        
        sensor_id = payload.get("sensor_id")
        sensor_type = payload.get("sensor_type")
        timestamp = payload.get("timestamp")
        sensor_value = payload.get("sensor_value")
        location = payload.get("location")
        humidity = payload.get("humidity") if sensor_type == "dht" else None
        temperature = payload.get("temperature") if sensor_type == "dht" else None

        if None in (sensor_id, sensor_type, timestamp, location):
            print("Payload is missing required properties:", payload)
            return

        # Convert timestamp to the correct format
        timestamp = datetime.utcfromtimestamp(timestamp / 1000.0)

        # Insert or update the data into the PostgreSQL database
        db = SessionLocal()
        try:
            query = text("""
            INSERT INTO sensor_data (sensor_id, sensor_type, timestamp, sensor_value, location, humidity, temperature)
            VALUES (:sensor_id, :sensor_type, :timestamp, :sensor_value, :location, :humidity, :temperature)
            ON CONFLICT (sensor_id) DO UPDATE
            SET sensor_type = EXCLUDED.sensor_type, timestamp = EXCLUDED.timestamp, 
                sensor_value = EXCLUDED.sensor_value, location = EXCLUDED.location,
                humidity = EXCLUDED.humidity, temperature = EXCLUDED.temperature;
            """)
            db.execute(query, {
                'sensor_id': sensor_id,
                'sensor_type': sensor_type,
                'timestamp': timestamp,
                'sensor_value': sensor_value,
                'location': location,
                'humidity': humidity,
                'temperature': temperature
            })
            db.commit()
            # print("Data inserted/updated:", payload)
        except Exception as e:
            print(f"Database error: {e}")
        finally:
            db.close()

    except (json.JSONDecodeError, Exception) as e:
        print(f"Error processing message: {e}")


def handle_led_message(payload):
    try:
        # Convert the payload to an integer (1 or 0)
        state = int(payload)
        db = SessionLocal()
        try:
            # Add or update LED control state in the database
            led_control = db.query(LEDControl).first()
            if led_control:
                led_control.state = bool(state)
            else:
                led_control = LEDControl(state=bool(state))
                db.add(led_control)
            db.commit()
            db.refresh(led_control)
            print("LED state updated in database:", state)
        except Exception as e:
            print(f"Database error while handling LED message: {e}")
        finally:
            db.close()
    except ValueError:
        print(f"Invalid LED state received: {payload}")

def control_led(state: bool):
    mqtt_client.publish(MQTT_LED_TOPIC, "1" if state else "0")
    print(f"Published '{state}' to {MQTT_LED_TOPIC}")
    record_led_status(state)

def record_led_status(state: bool):
    db: Session = SessionLocal()
    try:
        led_status = LEDControl(state=state)
        db.add(led_status)
        db.commit()
        print(f"Recorded LED status: {state}")
    except Exception as e:
        print(f"Database error while recording LED status: {e}")
    finally:
        db.close()

def handle_gate_message(payload):
    try:
        # Check if the payload is a valid action
        if payload not in ["open", "close"]:
            print(f"Invalid gate action received: {payload}")
            return

        db = SessionLocal()
        try:
            # Add or update gate control state in the database
            gate_status = GateStatus(status=payload)
            db.add(gate_status)
            db.commit()
            db.refresh(gate_status)
            print("Gate status updated in database:", payload)
        except Exception as e:
            print(f"Database error while handling gate message: {e}")
        finally:
            db.close()
    except Exception as e:
        print(f"Error processing gate message: {e}")


def control_gate(action: str):
    if action not in ["open", "close"]:
        raise ValueError("Invalid action: must be 'open' or 'close'")
    mqtt_client.publish(MQTT_GATE_TOPIC, action)
    print(f"Published '{action}' to {MQTT_GATE_TOPIC}")
    record_gate_status(action)


def record_gate_status(status: str):
    db: Session = SessionLocal()
    try:
        gate_status = GateStatus(status=status)
        db.add(gate_status)
        db.commit()
        print(f"Recorded gate status: {status}")
    except Exception as e:
        print(f"Database error while recording gate status: {e}")

def control_fan(action: str):
    if action not in ["on", "off"]:
        raise ValueError("Invalid action: must be 'on' or 'off'")
    mqtt_client.publish(MQTT_FAN_TOPIC, action)
    print(f"Published '{action}' to {MQTT_FAN_TOPIC}")
    record_fan_status(action)

def record_fan_status(status: str):
    db: Session = SessionLocal()
    try:
        fan_status = FanStatus(status=status)
        db.add(fan_status)
        db.commit()
        print(f"Recorded fan status: {status}")
    except Exception as e:
        print(f"Database error while recording fan status: {e}")

def handle_window_message(payload):
    try:
        action = payload  # Assuming payload is a simple string like "open" or "close"
        record_window_status(action)
    except Exception as e:
        print(f"Error handling window message: {e}")

def control_window(action: str):
    if action not in ["open", "close"]:
        raise ValueError("Invalid action: must be 'open' or 'close'")
    mqtt_client.publish(MQTT_WINDOW_TOPIC, action)
    print(f"Published '{action}' to {MQTT_WINDOW_TOPIC}")
    record_window_status(action)


def record_window_status(status: str):
    db: Session = SessionLocal()
    try:
        window_status = WindowStatus(status=status)
        db.add(window_status)
        db.commit()
        print(f"Recorded window status: {status}")
    except Exception as e:
        print(f"Database error while recording window status: {e}")
    finally:
        db.close()


# Create an MQTT client and attach the callback functions
mqtt_client = mqtt.Client()
mqtt_client.on_connect = on_connect
mqtt_client.on_message = on_message

def start_mqtt_client():
    try:
        mqtt_client.connect(MQTT_BROKER, MQTT_PORT, 60)
        mqtt_client.loop_start()
        print("MQTT client loop started")
    except Exception as e:
        print(f"Error connecting to MQTT broker: {e}")

def stop_mqtt_client():
    mqtt_client.loop_stop()
    mqtt_client.disconnect()
    print("MQTT client loop stopped and disconnected")