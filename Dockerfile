FROM ubuntu:22.10
# FROM continuumio/miniconda3:latest
FROM python:3.8.16

WORKDIR /home/docker_user

# ENV PATH /opt/conda/bin:$PATH

ADD CutLER ./CutLER
ADD detectron2 ./detectron2

# ARG PATH="/root/miniconda3/bin:${PATH}"


# SHELL ["/bin/bash", "-i", "-c"] 

# RUN apt-get update
RUN python3.8 -m venv cutler
RUN . cutler/bin/activate
# RUN conda create --name cutler python=3.8 -y
# RUN . /root/miniconda3/etc/profile.d/conda.sh && conda activate cutler
# RUN pip install pytorch==1.8.1 torchvision==0.9.1 torchaudio==0.8.1 -c pytorch
RUN pip install torch==1.8.1+cpu torchvision==0.9.1+cpu torchaudio==0.8.1 -f https://download.pytorch.org/whl/torch_stable.html
RUN pip install git+https://github.com/lucasb-eyer/pydensecrf.git
RUN pip install -e detectron2
RUN pip install git+https://github.com/cocodataset/panopticapi.git
RUN pip install git+https://github.com/mcordts/cityscapesScripts.git
RUN pip install -r CutLER/requirements.txt

RUN mkdir -p images/reference && mkdir -p images/outputs/output1 && mkdir -p images/outputs/output2

# TODO: put diff and result of my run
COPY diff.jpg images/reference

COPY entrypoint.sh test.py ./

RUN chmod +x entrypoint.sh

ENTRYPOINT ./entrypoint.sh
