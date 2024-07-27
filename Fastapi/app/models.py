from sqlalchemy import Table, Column, Integer, String, Boolean,ForeignKey,Float
from sqlalchemy.sql.expression import text
from . database import Base
from sqlalchemy.sql.sqltypes import TIMESTAMP
from sqlalchemy.types import Enum
import enum


class Post(Base):
    __tablename__ = "posts"

    id = Column(Integer, primary_key = True, nullable = False)
    title = Column(String, nullable = False)
    content = Column(String, nullable = False)
    published = Column(Boolean, server_default = "TRUE", nullable = False)
    created_at = Column(TIMESTAMP(timezone = True), nullable=False, server_default = text('now()'),)
    owner_id = Column(Integer, ForeignKey("users.id",ondelete="CASCADE"), nullable= False)


class User(Base):
    __tablename__ = "users"
    id = Column(Integer, primary_key = True, nullable = False)
    username = Column(String, nullable = False)# for name controller
    email = Column(String, nullable = False, unique = True)#email
    password = Column(String, nullable= False)#password
    created_at = Column(TIMESTAMP(timezone = True), nullable=False, server_default = text('now()'),)


class SensorData(Base):
    __tablename__ = "sensor_data"
 
    id = Column(Integer, primary_key=True, index=True)
    sensor_id = Column(Integer, index=True)
    sensor_type = Column(String, index=True)
    timestamp = Column(TIMESTAMP(timezone = True), nullable=False, server_default = text('now()'),)
    sensor_value = Column(Float, nullable=True)  # Allow sensor_value to be nullable
    location = Column(String)
    humidity = Column(Float, nullable=True)  # Add humidity column
    temperature = Column(Float, nullable=True)  

class LEDControl(Base):
    __tablename__ = "led_control"
    id = Column(Integer, primary_key=True, index=True)
    state = Column(Boolean, default=False)
    timestamp = Column(TIMESTAMP(timezone = True), nullable=False, server_default = text('now()'),)


class GateStatusEnum(enum.Enum):
    open = "open"
    close = "close"

class GateStatus(Base):
    __tablename__ = 'gate_status'

    id = Column(Integer, primary_key=True, index=True)
    timestamp = Column(TIMESTAMP(timezone=True), nullable=False, server_default=text('CURRENT_TIMESTAMP'))
    status = Column(Enum(GateStatusEnum), nullable=False)

    def __repr__(self):
        return f"<GateStatus(id={self.id}, timestamp={self.timestamp}, status={self.status})>"




class WindowStatusEnum(enum.Enum):
    open = "open"
    close = "close"

class WindowStatus(Base):
    __tablename__ = 'window_status'

    id = Column(Integer, primary_key=True, index=True)
    status = Column(Enum(WindowStatusEnum), nullable=False)
    timestamp = Column(TIMESTAMP(timezone=True), nullable=False, server_default=text('CURRENT_TIMESTAMP'))
    

    def __repr__(self):
        return f"<WindowStatus(id={self.id}, timestamp={self.timestamp}, status={self.status})>"

class FanStatusEnum(enum.Enum):
    open = "on"
    close = "off"
        

class FanStatus(Base):
    __tablename__ = "fan_status"
    id = Column(Integer, primary_key=True, index=True)
    status = Column(String, index=True)
    timestamp = Column(TIMESTAMP(timezone = True), nullable=False, server_default = text('now()'),)
    def __repr__(self):
        return f"<FanStatus(id={self.id}, timestamp={self.timestamp}, status={self.status})>"