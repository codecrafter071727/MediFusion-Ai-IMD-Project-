#!/usr/bin/env bash
# Start MediFusion AI (macOS: OpenMP + XGBoost/PyTorch coexistence)
set -euo pipefail
cd "$(dirname "$0")"

if [[ ! -d venv ]]; then
  python3.12 -m venv venv
  source venv/bin/activate
  pip install --upgrade pip
  pip install -r requirements.txt
else
  source venv/bin/activate
fi

export OMP_NUM_THREADS="${OMP_NUM_THREADS:-1}"
export MKL_NUM_THREADS="${MKL_NUM_THREADS:-1}"
export OPENBLAS_NUM_THREADS="${OPENBLAS_NUM_THREADS:-1}"

exec uvicorn api.main:app --host 127.0.0.1 --port 8000 --reload