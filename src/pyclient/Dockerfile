FROM python:3-alpine

# Create app directory
WORKDIR /app

RUN apk -y update; apk add curl

# Install app dependencies
COPY requirements.txt ./

RUN pip install -r requirements.txt

# Bundle app source
COPY . .

EXPOSE 5000
CMD [ "python", "app.py"]