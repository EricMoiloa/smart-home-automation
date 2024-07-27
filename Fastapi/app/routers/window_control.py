from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel
from sqlalchemy.orm import Session
from sqlalchemy.exc import SQLAlchemyError
from datetime import datetime

from app.mqtt_client import control_window
from app.database import get_db
from app.models import WindowStatus

router = APIRouter()

class WindowControlRequest(BaseModel):
    action: str  # 'open' or 'close'

class WindowStatusResponse(BaseModel):
    status: str
    timestamp: datetime

@router.post("/control/window", summary="Control the window", response_model=WindowStatusResponse)
def control_window_endpoint(request: WindowControlRequest, db: Session = Depends(get_db)):
    try:
        control_window(request.action)
        # Record the action and timestamp
        window_status = WindowStatus(status=request.action, timestamp=datetime.utcnow())
        db.add(window_status)
        db.commit()
        db.refresh(window_status)
        return WindowStatusResponse(status=window_status.status, timestamp=window_status.timestamp)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except SQLAlchemyError as e:
        raise HTTPException(status_code=500, detail="Database error")

@router.get("/window/status", summary="Get the window's status", response_model=WindowStatusResponse)
def get_window_status(db: Session = Depends(get_db)):
    try:
        status = db.query(WindowStatus).order_by(WindowStatus.timestamp.desc()).first()
        if not status:
            raise HTTPException(status_code=404, detail="Window status not found")
        return WindowStatusResponse(status=status.status, timestamp=status.timestamp)
    except SQLAlchemyError as e:
        raise HTTPException(status_code=500, detail="Database error")
