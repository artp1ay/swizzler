import os
from peewee import SqliteDatabase

db = SqliteDatabase(f'/srv/{os.environ.get("DATABASE_FILENAME", "database.db")}')
