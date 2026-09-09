FROM runpod/worker-comfyui:5.8.5-base

WORKDIR /comfyui/custom_nodes

# InstantID - 얼굴 일관성 유지
RUN git clone https://github.com/cubiq/ComfyUI_InstantID.git
RUN pip install -r ComfyUI_InstantID/requirements.txt --no-cache-dir

# IPAdapter Plus - 스타일/바디 유지 보조
RUN git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git

# ComfyUI Essentials - 유틸리티 노드
RUN git clone https://github.com/cubiq/ComfyUI_essentials.git

# ControlNet Aux - 자세(OpenPose) 추출
RUN git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git
RUN pip install -r comfyui_controlnet_aux/requirements.txt --no-cache-dir

# Impact Pack - FaceDetailer 등 디테일 보정
RUN git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
RUN pip install -r ComfyUI-Impact-Pack/requirements.txt --no-cache-dir

WORKDIR /comfyui

# Network Volume의 instantid, insightface 등 비표준 폴더를 ComfyUI가 인식하도록 경로 등록
COPY extra_model_paths.yaml /comfyui/extra_model_paths.yaml

WORKDIR /
