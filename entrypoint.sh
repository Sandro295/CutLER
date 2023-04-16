#!/bin/bash

cd /home/docker_user/CutLER/maskcut

. /home/docker_user/cutler/bin/activate

# /home/docker_user/images/reference && mkdir -p /home/docker_user/images/output

# cd /home/docker_user

# pip install torch==1.8.1+cpu torchvision==0.9.1+cpu torchaudio==0.8.1 -f https://download.pytorch.org/whl/torch_stable.html
# pip install git+https://github.com/lucasb-eyer/pydensecrf.git
# pip install -e detectron2
# pip install git+https://github.com/cocodataset/panopticapi.git
# pip install git+https://github.com/mcordts/cityscapesScripts.git
# pip install -r CutLER/requirements.txt


python /home/docker_user/CutLER/maskcut/demo.py --img-path /home/docker_user/CutLER/maskcut/imgs/demo1.jpg \
    --N 3 --tau 0.15 --vit-arch base --patch-size 8 --cpu \
    --output_path /home/docker_user/images/outputs/output1

# demo.py creates demo.jpg at the output_path location
python /home/docker_user/CutLER/maskcut/demo.py --img-path /home/docker_user/CutLER/maskcut/imgs/demo1.jpg \
    --N 3 --tau 0.15 --vit-arch base --patch-size 8 --cpu \
    --output_path /home/docker_user/images/outputs/output2

cd /home/docker_user

python test.py
