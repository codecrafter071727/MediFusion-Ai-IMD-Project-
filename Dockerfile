FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc g++ && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY . .

ENV OMP_NUM_THREADS=1
ENV MKL_NUM_THREADS=1
ENV OPENBLAS_NUM_THREADS=1
ENV PYTHONUNBUFFERED=1

# Render (and others) inject PORT; default 8000 for local Docker.
EXPOSE 8000
CMD ["sh", "-c", "uvicorn api.main:app --host 0.0.0.0 --port ${PORT:-8000}"]
