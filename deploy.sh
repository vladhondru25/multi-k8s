docker build -t vladhondru25/multi-client:latest -t vladhondru25/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vladhondru25/multi-server:latest -t vladhondru25/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vladhondru25/multi-worker:latest -t vladhondru25/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vladhondru25/multi-client:latest
docker push vladhondru25/multi-server:latest
docker push vladhondru25/multi-worker:latest

docker push vladhondru25/multi-client:$SHA
docker push vladhondru25/multi-server:$SHA
docker push vladhondru25/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vladhondru25/multi-server:$SHA
kubectl set image deployments/client-deployment client=vladhondru25/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vladhondru25/multi-worker:$SHA