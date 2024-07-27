from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from pydantic import BaseModel
from ..database import get_db
from .. import models
import paho.mqtt.client as mqtt

# MQTT configuration
MQTT_BROKER = "192.168.0.100"
MQTT_PORT = 1883
MQTT_TOPIC = "home/led"

# Initialize MQTT client
mqtt_client = mqtt.Client()

def connect_mqtt_client():
    try:
        mqtt_client.connect(MQTT_BROKER, MQTT_PORT, 60)
        mqtt_client.loop_start()
        print("MQTT client connected and loop started")
    except Exception as e:
        print(f"Error connecting to MQTT broker: {e}")

connect_mqtt_client()

router = APIRouter()

class LEDControlRequest(BaseModel):
    state: bool

@router.post("/led/")
def control_led(data: LEDControlRequest, db: Session = Depends(get_db)):
    try:
        if not mqtt_client.is_connected():
            connect_mqtt_client()
        
        message = "1" if data.state else "0"
        result = mqtt_client.publish(MQTT_TOPIC, message)
        
        if result.rc != mqtt.MQTT_ERR_SUCCESS:
            raise HTTPException(status_code=500, detail=f"Failed to publish MQTT message, result code: {result.rc}")
        
        print(f'Published "{message}" to {MQTT_TOPIC}')
        
        # Insert the LED control state into the database
        led_control = models.LEDControl(state=data.state)
        db.add(led_control)
        db.commit()
        db.refresh(led_control)
        
        return {"message": "LED state updated", "state": data.state}
    except HTTPException as e:
        db.rollback()
        raise e
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))

# Ensure the client is properly connected before publishing messages
def connect_mqtt_client():
    try:
        mqtt_client.connect(MQTT_BROKER, MQTT_PORT, 60)
        mqtt_client.loop_start()
        print("MQTT client connected and loop started")
    except Exception as e:
        print(f"Error connecting to MQTT broker: {e}")

connect_mqtt_client()
