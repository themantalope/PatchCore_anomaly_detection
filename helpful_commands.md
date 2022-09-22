# docker
docker build . --tag patchcore:latest

docker run -d -v <datalocation>:/opt/patchcore/data -v <codelocation>:/opt/patchcore/code --name patchcore  --gpus all --shm-size 64G  -p 9000:8888 patchcore:latest

docker run -d -v /mnt/data/matt/chexpert:/opt/patchcore/data -v /home/maq081/matt/PatchCore_anomaly_detection:/opt/patchcore/code --name patchcore  --gpus all --shm-size 64G -p 8887:8888 patchcore:latest

docker run -v /mnt/backup/data/matt/chexpert:/opt/patchcore/data -v /home/maq081/matt/PatchCore_anomaly_detection:/opt/patchcore/code -p 8887:8888 --name patchcore  --gpus all --shm-size 64G  patchcore:latest # troubleshooting

docker exec -it patchcore /bin/bash

# ssh tunnel

ssh -N -f -L localhost:10000:localhost:10000 $FSM_LOGIN
ssh -N -f -L localhost:10001:localhost:10001 $FSM_LOGIN
ssh -N -f -L localhost:8887:localhost:8887 $FSM_LOGIN

# run jupyter
nohup jupyter-lab --allow-root --port 8888 --no-browser --ip=0.0.0.0  &