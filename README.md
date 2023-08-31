# nginx-proxy-connect

I have no idea if this repo is being used, please give a star if you find it useful.

## Usage

```sh
kubectl create ns proxy-connect
kubectl apply -f complete-proxyConnect-deployment.yaml -n proxy-connect
kubectl exec -i -t -n proxy-connect deployments/curlpod -- curl https://g.co
kubectl logs deployments/proxy-connect
```

or simply:

```sh
k apply -f https://raw.githubusercontent.com/jessegoodier/nginx-proxy-connect/main/complete-proxyConnect-deployment.yaml
```

## Build Dockerfile

```sh
docker buildx create --name builder-proxy-connect --use --bootstrap
docker buildx build --push \
--platform linux/amd64,linux/arm64 \
--tag jgoodier/proxy-connect:latest .
```