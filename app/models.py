import datetime
from peewee import (
    Model,
    CharField,
    DateTimeField,
    BooleanField,
    ForeignKeyField,
    FloatField,
)
from config import db


class BaseModel(Model):
    @classmethod
    def get_as_dict(cls, expr):
        query = cls.select().where(expr).dicts()
        return query.get()

    class Meta:
        database = db


class Table(BaseModel):
    uuid = CharField(unique=True)
    name = CharField(max_length=255, null=True)
    created = DateTimeField(default=datetime.datetime.now())
    is_active = BooleanField(default=True)

    class Meta:
        table_name = "table"
