FROM ubuntu:22.10
# FROM continuumio/miniconda3:latest
FROM python:3.8.16

WORKDIR /home/docker_user

# ENV PATH /opt/conda/bin:$PATH

ADD CutLER ./CutLER
ADD detectron2 ./detectron2

# SHELL ["/bin/bash", "-i", "-c"] 

RUN apt-get -y install libgl1-mesa-glx

RUN python3.8 -m venv cutler
# RUN conda create --name cutler python=3.8 -y
# RUN . /root/miniconda3/etc/profile.d/conda.sh && conda activate cutler
# RUN pip install pytorch==1.8.1 torchvision==0.9.1 torchaudio==0.8.1 -c pytorch
RUN . cutler/bin/activate && pip install torch==1.8.1+cpu torchvision==0.9.1+cpu torchaudio==0.8.1 -f https://download.pytorch.org/whl/torch_stable.html && \
    pip install git+https://github.com/lucasb-eyer/pydensecrf.git && \
    pip install -e detectron2 && \
    pip install git+https://github.com/cocodataset/panopticapi.git && \
    pip install git+https://github.com/mcordts/cityscapesScripts.git && \
    pip install -r CutLER/requirements.txt

RUN mkdir -p images/reference && mkdir -p images/outputs/output1 && mkdir -p images/outputs/output2

COPY diff.jpg images/reference
COPY entrypoint.sh test.py testcfg.ini ./

RUN chmod +x entrypoint.sh

ENTRYPOINT ./entrypoint.sh
