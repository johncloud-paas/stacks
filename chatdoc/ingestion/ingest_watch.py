import os
import time
import hashlib
import mimetypes
from pathlib import Path
from threading import Thread

import fitz  # PyMuPDF for PDFs
import docx
import openpyxl
import pytesseract
from PIL import Image
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

from openai import OpenAI
from qdrant_client import QdrantClient
from qdrant_client.http.models import PointStruct, Distance, VectorParams, Filter, FieldCondition, MatchValue

# === CONFIG ===
DOCS_PATH = Path("/docs")
COLLECTION_NAME = "documents"
EMBEDDING_MODEL = "text-embedding-ada-002"
CHUNK_SIZE = 1000
CHUNK_OVERLAP = 200

qdrant = QdrantClient(host=os.environ["QDRANT_HOST"], port=int(os.envir_]()
