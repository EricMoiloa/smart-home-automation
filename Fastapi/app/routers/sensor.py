from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from pydantic import BaseModel
from datetime import datetime
from ..database import get_db
from .. import models

router = APIRouter()

class SensorData(BaseModel):
    sensor_id: int
    sensor_type: str
    timestamp: int
    sensor_value: float
    location: str

@router.post("/sensors")
def create_sensor(data: SensorData, db: Session = Depends(get_db)):
    try:
        timestamp = datetime.utcfromtimestamp(data.timestamp / 1000.0)
        sensor_data = models.SensorData(
            sensor_id=data.sensor_id,
            sensor_type=data.sensor_type,
            timestamp=timestamp,
            sensor_value=data.sensor_value,
            location=data.location
        )
        db.merge(sensor_data)
        db.commit()
        return {"message": "Sensor data inserted/updated successfully"}
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))
