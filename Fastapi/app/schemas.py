from pydantic import BaseModel, EmailStr
from datetime import datetime
from typing import Optional

class OurBaseModelRes(BaseModel):
    class Config:
        from_attributes = True

class PostBase(BaseModel):
    title: str
    content: str
    published: bool = True


class PostCreate(PostBase):
    pass

#response data schema


class Post(PostBase):
    id: int
    created_at: datetime
    owner_id: int


    class Config:
        from_attributes = True

#register user model
class UserCreate(BaseModel):
    username: str
    email: EmailStr
    password: str

#response
class UserOut(OurBaseModelRes):
    id: int
    username: str
    email:str
    created_at: datetime


class UserLogin(BaseModel):
    email: EmailStr
    password: str

#Authentication
class UserLogin(BaseModel):
    email: EmailStr
    password: str


class Token(BaseModel):
    access_token:str
    token_type: str


class TokenData(BaseModel):
    id: Optional[str] = None

    

