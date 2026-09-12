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
# (RunPod 공식 이슈 #91에서 확인된 필수 설정 - 표준 폴더가 아닌 타입은 자동 인식 안 됨)
COPY extra_model_paths.yaml /comfyui/extra_model_paths.yaml

# InstantID의 InsightFace 로더는 extra_model_paths.yaml을 무시하고
# folder_paths.models_dir(=/comfyui/models) 하위를 하드코딩으로 참조함.
# 컨테이너 시작 시 볼륨의 insightface 폴더를 컨테이너 로컬 경로에 심볼릭 링크로 연결한다.
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /
ENTRYPOINT ["/entrypoint.sh"]
# Tooling nodes - base64 이미지 로드 등
RUN git clone https://github.com/Acly/comfyui-tooling-nodes.git
