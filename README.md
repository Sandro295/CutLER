# Homework 
Here i am trying to build and/or run Docker container with someone else's Deep Learning repository.  

Based on [Facebook's CutLER](https://paperswithcode.com/paper/cut-and-learn-for-unsupervised-object)

## How to run Docker image 
I have already built and pushed an Image to [DockerHub](https://hub.docker.com/repository/docker/sandro295/cutler/general)  

All you need to do is have Docker daemon running  

On WSL
```
sudo dockerd
```

Then pull my image    

If your CPU is x86
```
docker pull sandro295/cutler:multi-arch
```
If your CPU is ARM64  
```
docker pull sandro295/cutler:arm64
```

And run the container

```
docker run sandro295/cutler:multi-arch
```

It will run a [demo.py](./CutLER/maskcut/demo.py) on your CPU twice then it will run a [test](./test.py) which will compare two generated images with what i got on my machine. If they are similar it will print "Test passed".

After that the container will stop and output files will be availiable for copying

```
docker ps -a
docker cp <container_id>:/home/docker_user/images/outputs ~/<your_folder>
```

## How to build Docker image
If you are brave enough you can try to build an image all by yourself.  

Firstly clone this repository recursively

```
git clone https://github.com/Sandro295/CutLER.git --recursive
cd CutLER
```
Make sure you have Docker installed and your Docker daemon is running  
Then build an image
```
docker build -t cutler .
```

You can try to run it with 
```
docker run cutler
```
