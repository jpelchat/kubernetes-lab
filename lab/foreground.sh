echo "Setting up your lab...hang tight!"

kubectl create namespace my-grafana
curl https://pastebin.com/raw/Ed6XKTjE | kubectl apply --namespace=my-grafana -f - 

nohup kubectl port-forward service/grafana 3000:3000 --address 0.0.0.0 --namespace=my-grafana &
