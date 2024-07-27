from typing import Optional, List
from fastapi import FastAPI, Response, status, HTTPException, Depends
from fastapi.params import Body
from pydantic import BaseModel
from typing import Optional
from random import randrange


from sqlalchemy.orm import Session
from sqlalchemy.sql.functions import mode
from . import models, schemas, utils
from . database import engine, get_db
from . routers import post, user, auth, sensor, led,gate_control, window_control,fan_control
from .mqtt_client import start_mqtt_client, stop_mqtt_client
from fastapi.middleware.cors import CORSMiddleware

#from . import mqtt_to_postgresql


models.Base.metadata.create_all(bind=engine)

app = FastAPI()

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,

    allow_methods=["*"],
    allow_headers=["*"],
)
app.include_router(post.router)
app.include_router(user.router)
app.include_router(auth.router)
app.include_router(sensor.router)
app.include_router(led.router)
app.include_router(fan_control.router) 
app.include_router(window_control.router) 
app.include_router(gate_control.router) 

# Start MQTT client on startup
@app.on_event("startup")
def startup_event():
    start_mqtt_client()

# Stop MQTT client on shutdown
@app.on_event("shutdown")
def shutdown_event():
    mqtt_client.loop_stop()
    mqtt_client.disconnect()

@app.get("/")
def root():
    return {"message": "Hello World"}
