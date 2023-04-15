#!/bin/bash

kubectl delete all --selector="app=pyclient"
kubectl delete all --selector="app=pyserver"

docker build -t pyserver src/pyserver
minikube image load pyserver:latest
docker build -t pyclient --no-cache src/pyclient
minikube image load pyclient:latest

kubectl apply -f infra/pyserver.yml
kubectl apply -f infra/pyclient.yml

## Delete
kubectl logs -l "app=pyclient" 