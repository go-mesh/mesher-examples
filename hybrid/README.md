hybrid
-----
   
This is a sample demo to deploy microservices with servicecomb
   
## Quick start

Step 1 install servicecomb components
```bash
cd hybrid/infrastructure/kubernetes
bash -x install.sh
```

Step 2 install demos
```bash
cd hybrid/infrastructure/kubernetes
kubectl apply -f example.yaml
```

## Clean up

```bash
cd hybrid/infrastructure/kubernetes
kubectl delete -f example.yaml
bash -x uninstall.sh
```
