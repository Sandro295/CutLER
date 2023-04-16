#!/bin/bash

cd /home/docker_user/CutLER/maskcut

. /home/docker_user/cutler/bin/activate

# /home/docker_user/images/reference && mkdir -p /home/docker_user/images/output

python demo.py --img-path /home/docker_user/CutLER/maskcut/imgs/demo1.jpg \
    --N 3 --tau 0.15 --vit-arch base --patch-size 8 --cpu \
    --output_path /home/docker_user/images/outputs/output1

# demo.py creates demo.jpg at the output_path location
python demo.py --img-path /home/docker_user/CutLER/maskcut/imgs/demo1.jpg \
    --N 3 --tau 0.15 --vit-arch base --patch-size 8 --cpu \
    --output_path /home/docker_user/images/outputs/output2

cd /home/docker_user

python test.py
