echo "Setting up your lab...hang tight!"

kubectl create namespace my-grafana
curl https://pastebin.com/raw/Ed6XKTjE | kubectl apply --namespace=my-grafana -f - 

nohup kubectl port-forward service/grafana 8080:8080 --address 0.0.0.0 --namespace=my-grafana > /dev/null 2> /dev/null &
