FROM python:3.7
WORKDIR /app
COPY . /app
RUN pip3 install --no-cache-dir -r requirements.txt
COPY . .
CMD [ "python3", "main.py" ]