echo "Setting up your lab...hang tight!"

# kubectl create namespace my-grafana
# curl https://pastebin.com/raw/Ed6XKTjE | kubectl apply --namespace=my-grafana -f -

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install my-kube-prometheus-stack prometheus-community/kube-prometheus-stack

kubectl expose service kube-prometheus-stack-prometheus --type=NodePort --target-port=9090 --name=prometheus-node-port-service
kubectl expose service kube-prometheus-stack-grafana --type=NodePort --target-port=3000 --name=grafana-node-port-service

kubectl get secret --namespace default kube-prometheus-stack-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
