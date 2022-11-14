# syntax=docker/dockerfile:1

FROM python:3.11.0-slim-buster
WORKDIR /app

# Install Dependencies
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY ./app/ .
RUN mkdir /srv/static

EXPOSE 5000

# Run
CMD ["python", "app.py"]
