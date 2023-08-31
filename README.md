# nginx-proxy-connect

Usage:

```sh
kubectl create ns proxy-connect
kubectl apply -f complete-proxyConnect-deployment.yaml -n proxy-connect
kubectl exec -i -t -n proxy-connect deployments/curlpod -- curl https://g.co
kubectl logs deployments/proxy-connect
```

or simply:

```sh
kaf https://raw.githubusercontent.com/jessegoodier/nginx-proxy-connect/main/complete-proxyConnect-deployment.yaml
```
