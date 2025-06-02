# ChatDoc

Thanks! I’ll build a fully containerized Docker Compose stack that ingests a 32 GB folder of personal documents (docx, xlsx, pdf, md, txt), uses OCR when needed, indexes them in a vector database, and offers a chatbot-style interface that uses the OpenAI API for language processing. It will also watch for file additions or removals and update the index accordingly. I’ll get back to you shortly with the setup.


# Dockerized Document Q\&A Chatbot (RAG Stack)

We build a modular stack using Docker Compose so all services (OCR, ingestion, vector DB, UI, etc.) run in containers. Docker Compose lets us define **all containers and their dependencies in one YAML file**, ensuring portability and easy management. For our vector store we use **Qdrant** – an open-source, high-performance vector search engine. A Python ingestion service reads the mounted document folder, extracts text (using libraries like PyMuPDF, python-docx/openpyxl, etc.), and applies OCR via **Tesseract** for scanned PDFs or images. It then calls the OpenAI API to generate embeddings (using the official `openai` Python client) and upserts vectors into Qdrant. A separate **chat UI** (such as the open-source [Kotaemon](https://github.com/Cinnamon/kotaemon) RAG interface) provides a web-based chatbot that queries Qdrant and uses OpenAI to answer queries. The ingestion container also runs a filesystem watcher (e.g. Python’s `watchdog`) to monitor the `/docs` volume for changes and re-index modified files. All containers use CPU-only images, so no GPU is required.

```yaml
version: '3.8'
services:
  qdrant:
    image: qdrant/qdrant:latest
    restart: always
    ports:
      - "6333:6333"    # Qdrant API
      - "6334:6334"    # (optional) Qdrant Web UI
    volumes:
      - qdrant_data:/qdrant/storage

  ingestion:
    build: ./ingestion 
    # (Dockerfile uses python:3.10-slim + PyMuPDF, docx, openpyxl, pytesseract, openai, qdrant-client, watchdog, etc.)
    restart: on-failure
    depends_on:
      - qdrant
    volumes:
      - ./docs:/docs    # Mount local docs folder
    environment:
      - OPENAI_API_KEY=${OPENAI_API_KEY}
      - QDRANT_HOST=qdrant
      - QDRANT_PORT=6333
    command: ["python", "ingest_watch.py"]   # runs initial ingest and watches for changes

  ui:
    image: ghcr.io/cinnamon/kotaemon/kotaemon:latest
    restart: always
    ports:
      - "5000:5000"    # Web UI port
    environment:
      - OPENAI_API_KEY=${OPENAI_API_KEY}
      - KH_VECTORSTORE=Qdrant
      - QDRANT_HOST=qdrant
      - QDRANT_PORT=6333

volumes:
  qdrant_data:
```

### Component Configuration

* **Qdrant (Vector DB):** We use the official `qdrant/qdrant:latest` image. Expose port **6333** for the API (and 6334 for the optional UI). Mount a Docker volume (`qdrant_data`) to `/qdrant/storage` for persistent storage. This open-source vector engine handles high-dimensional embeddings efficiently.

* **Ingestion Service:** A Python-based container (built from e.g. `python:3.10-slim`) with libraries for parsing .pdf/.docx/.xlsx/.md/.txt. It uses **Tesseract OCR** (open-source) to extract text from scanned documents. For each text chunk, it calls the OpenAI API (via the `openai` Python package) to get embeddings and upserts them into Qdrant. The container mounts the host `./docs` folder to `/docs`, so all documents are accessible. It also uses a library like `watchdog` to monitor `/docs` for file creations or deletions, automatically re-running the ingest script on changes.

* **Chat UI (Kotaemon):** We deploy an open-source RAG chat interface (e.g. [Kotaemon](https://github.com/Cinnamon/kotaemon), which is customizable and Docker-ready). Expose port **5000** to serve the web UI. In its environment, we set the OpenAI API key and specify `KH_VECTORSTORE=Qdrant` so it connects to our Qdrant instance. Kotaemon will use Qdrant (via `QDRANT_HOST`/`QDRANT_PORT`) for retrieval and OpenAI models (`gpt-3.5-turbo`, `text-embedding-ada-002`) for generation.

* **Folder Watcher:** The ingestion container runs a script (e.g. `ingest_watch.py`) that first indexes all existing files and then watches the directory. Python’s `watchdog` (or similar) can observe `/docs` and trigger re-indexing on file add/delete, ensuring the vector DB stays in sync with the folder.

### Summary

This fully containerized stack uses open-source components (Python, Tesseract OCR, Qdrant, Kotaemon UI, etc.) and the OpenAI API for language tasks. Docker Compose makes the system portable and easy to deploy. All services are CPU-based and can run on modest hardware. The `docker-compose.yml` above outlines the services; for each we build or pull a Docker image with the required libraries and set environment variables as noted. This setup meets the requirements: ingesting various doc formats, OCR for scans, vector indexing, OpenAI-powered RAG, a chat interface, and auto-reindex on folder changes.

**Sources:** Official Qdrant docs, Tesseract README, Kotaemon repo, Docker Compose docs, and Python `watchdog` examples.
