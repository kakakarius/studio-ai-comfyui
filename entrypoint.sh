#!/bin/bash
# 볼륨의 insightface 모델을 ComfyUI가 하드코딩으로 찾는 로컬 경로에 심볼릭 링크로 연결
# (ComfyUI_InstantID의 InstantIDFaceAnalysis 노드는 extra_model_paths.yaml을 지원하지 않고
#  folder_paths.models_dir 하위 경로만 인식하기 때문에 필요한 조치)

if [ -d "/runpod-volume/models/insightface" ]; then
  mkdir -p /comfyui/models
  if [ ! -e "/comfyui/models/insightface" ]; then
    ln -s /runpod-volume/models/insightface /comfyui/models/insightface
    echo "[entrypoint] Linked /comfyui/models/insightface -> /runpod-volume/models/insightface"
  fi
fi

# 원래 RunPod worker-comfyui의 기본 시작 스크립트 실행
exec /start.sh "$@"
