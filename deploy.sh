docker build -t hfcdevops/multi-client:latest -t hfcdevops/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t hfcdevops/multi-server:latest t hfcdevops/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t hfcdevops/multi-worker:latest -t hfcdevops/multi-worker:$SHA -f ./worker/Dockerfile ./worker 

docker push hfcdevops/multi-client:latest 
docker push hfcdevops/multi-server:latest  
docker push hfcdevops/multi-worker:latest  

docker push hfcdevops/multi-client:$SHA
docker push hfcdevops/multi-server:$SHA 
docker push hfcdevops/multi-worker:$SHA

kubectl apply -f k8s 
kubectl set image deployments/server-deployment server=hfcdevops/multi-server:$SHA
kubectl set image deployments/client-deployment client=hfcdevops/multi-client:$SHA
kubectl set image deployments/worker-deployment client=hfcdevops/multi-worker:$SHA 
