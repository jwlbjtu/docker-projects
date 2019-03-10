docker build -t jwlbjtu/multi-client:latest -t jwlbjtu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jwlbjtu/multi-server:latest -t jwlbjtu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jwlbjtu/multi-worker:latest -t jwlbjtu/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jwlbjtu/multi-client:latest
docker push jwlbjtu/multi-server:latest
docker push jwlbjtu/multi-worker:latest

docker push jwlbjtu/multi-client:$SHA
docker push jwlbjtu/multi-server:$SHA
docker push jwlbjtu/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=jwlbjtu/multi-client:$SHA
kubectl set image deployments/server-deployment server=jwlbjtu/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jwlbjtu/multi-worker:$SHA