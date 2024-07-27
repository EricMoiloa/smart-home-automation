from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel
from sqlalchemy.orm import Session
from sqlalchemy.exc import SQLAlchemyError
from datetime import datetime

from app.mqtt_client import control_fan
from app.database import get_db
from app.models import FanStatus

router = APIRouter()

class FanControlRequest(BaseModel):
    action: str  # 'on' or 'off'

class FanStatusResponse(BaseModel):
    status: str
    timestamp: datetime

@router.post("/control/fan", summary="Control the fan", response_model=FanStatusResponse)
def control_fan_endpoint(request: FanControlRequest, db: Session = Depends(get_db)):
    try:
        control_fan(request.action)
        # Record the action and timestamp
        fan_status = FanStatus(status=request.action, timestamp=datetime.utcnow())
        db.add(fan_status)
        db.commit()
        db.refresh(fan_status)
        return FanStatusResponse(status=fan_status.status, timestamp=fan_status.timestamp)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except SQLAlchemyError as e:
        raise HTTPException(status_code=500, detail="Database error")

@router.get("/fan/status", summary="Get the fan's status", response_model=FanStatusResponse)
def get_fan_status(db: Session = Depends(get_db)):
    try:
        status = db.query(FanStatus).order_by(FanStatus.timestamp.desc()).first()
        if not status:
            raise HTTPException(status_code=404, detail="Fan status not found")
        return FanStatusResponse(status=status.status, timestamp=status.timestamp)
    except SQLAlchemyError as e:
        raise HTTPException(status_code=500, detail="Database error")
