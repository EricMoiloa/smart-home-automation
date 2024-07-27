from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel
from sqlalchemy.orm import Session
from sqlalchemy.exc import SQLAlchemyError
from datetime import datetime

from app.mqtt_client import control_gate
from app.database import get_db
from app.models import GateStatus

router = APIRouter()

class GateControlRequest(BaseModel):
    action: str  # 'open' or 'close'

class GateStatusResponse(BaseModel):
    status: str
    timestamp: datetime

@router.post("/control/gate", summary="Control the gate", response_model=GateStatusResponse)
def control_gate_endpoint(request: GateControlRequest, db: Session = Depends(get_db)):
    try:
        control_gate(request.action)
        # Record the action and timestamp
        gate_status = GateStatus(status=request.action, timestamp=datetime.utcnow())
        db.add(gate_status)
        db.commit()
        db.refresh(gate_status)
        return GateStatusResponse(status=gate_status.status, timestamp=gate_status.timestamp)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except SQLAlchemyError as e:
        raise HTTPException(status_code=500, detail="Database error")

@router.get("/gate/status", summary="Get the gate's status", response_model=GateStatusResponse)
def get_gate_status(db: Session = Depends(get_db)):
    try:
        status = db.query(GateStatus).order_by(GateStatus.timestamp.desc()).first()
        if not status:
            raise HTTPException(status_code=404, detail="Gate status not found")
        return GateStatusResponse(status=status.status, timestamp=status.timestamp)
    except SQLAlchemyError as e:
        raise HTTPException(status_code=500, detail="Database error")
