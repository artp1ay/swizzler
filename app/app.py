import os
from flask import Flask, jsonify
from config import db
from models import Table

# Connecting to DB and create tables
db.connect()
db.create_tables([Table])


app = Flask(__name__)


@app.route("/ping", methods=["GET"])
def index():
    return jsonify({"response": "pong"})


if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=5000,
        debug=os.environ.get("DEBUG", False),
    )
