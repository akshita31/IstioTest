#!/bin/bash

kubectl delete all --selector="app=pyclient"
kubectl delete all --selector="app=pyserver"

docker build -t pyserver src/pyserver
minikube image load pyserver:latest
docker build -t pyclient --no-cache src/pyclient
minikube image load pyclient:latest

kubectl apply -f infra/pyserver.yml
kubectl apply -f infra/pyclient.yml

#kubectl logs -l "app=pyclient" 

#kubectl exec $(kubectl get pod --selector app=pyclient --output jsonpath='{.items[0].metadata.name}') -c istio-proxy -- curl -X POST http://localhost:15000/clusters | grep pyserver | grep upstream

#kubectl exec -it pyserver-v1-74cf97d7d4-dtc2d -c istio-proxy -n default  -- pilot-agent request GET server_info --log_as_json | jq {version}

#istioctl proxy-config cluster pyserver-v1-74cf97d7d4-dtc2d --fqdn pyserver.default.svc.cluster.local -o json

#istioctl proxy-config cluster pyclient-5fdf4b5cb5-rktc7 --fqdn pyclient.default.svc.cluster.local -o json
