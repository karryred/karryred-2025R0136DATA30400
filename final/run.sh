#!/bin/bash

# 에러가 발생하면 즉시 스크립트 중단 (안전장치)
set -e

echo "==========================================="
echo "       Setup & Execution Started"
echo "==========================================="

# 0. 의존성 설치 (nbconvert 포함 필수)
pip install -r requirements.txt
pip install jupyter nbconvert  # 노트북 변환을 위해 필수

# 함수: 노트북을 .py로 변환하고 실행하는 함수 정의
run_notebook() {
    filename=$1
    echo "-------------------------------------------"
    echo "Running $filename..."
    
    # 1. .ipynb -> .py 변환
    jupyter nbconvert --to python "${filename}.ipynb"
    
    # 2. 변환된 .py 실행
    python "${filename}.py"
    
    echo "Finished $filename"
}

# --- 순서대로 실행 ---

# 1. generate_silver_label
run_notebook "generate_silver_label"

# 2. train
run_notebook "train"

# 3. selftrain_data
run_notebook "selftrain_data"

# 4. train_gnn
run_notebook "train_gnn"

# 5. train_deberta_gnn
run_notebook "train_deberta_gnn"

# 6. inference_ensemble
run_notebook "inference_ensemble"

echo "==========================================="
echo "       All tasks completed successfully!"
echo "==========================================="