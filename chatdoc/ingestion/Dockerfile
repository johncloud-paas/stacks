FROM python:3.13-alpine

RUN apt update && apt install -y \
    tesseract-ocr \
    poppler-utils \
    libgl1 \
 && pip install --no-cache-dir -r requirements.txt

WORKDIR /app
COPY ingest_watch.py .
COPY requirements.txt .

CMD ["python", "ingest_watch.py"]
