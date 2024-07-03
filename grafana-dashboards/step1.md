# Overview

Grafana Alloy is a distribution of the OpenTelemetry (OTel) Collector that allows you to easily collect metrics, logs, and more using tools like Loki, Prometheus, and more. In this section, you will use Grafana Cloud to simplify the install of Alloy on an Ubuntu host.

# Generate and run install script

1. Log in to your Grafana Cloud organization, and launch the Grafana service.
2. From the right-hand menu, click **Connections ▶ Collector ▶ Alloy**. 
3. Click the **Installation** tab, and input a new token name (it can be anything). Leave the remaining fields as the defaults.
4. Click **Create token**.
5. Run the code block under "Install and run Grafana Alloy" on the Ubuntu host.

<br>

Great! Alloy should now be installed. 🎉

# Configure Alloy

Right now, Alloy is not collecting any useful data from your host. We can change that by leveraging the Prometheus "Node Exporter" plugin. 

> Prometheus Node Exporter exposes a wide variety of hardware- and kernel-related metrics. Plugin specifics are outside the scope of this lab. Feel free to read more about "Node Exporter" [here](https://prometheus.io/docs/guides/node-exporter/).

1. Run the following command to add the Prometheus Node Exporter plugin to Alloy's configuration.

```
cat <<EOF >> /etc/alloy/config.alloy
prometheus.exporter.unix "demo" { }

prometheus.scrape "demo" {
  targets    = prometheus.exporter.unix.demo.targets
  forward_to = [prometheus.remote_write.metrics_service.receiver]
}
EOF
```{{exec}}

2. Restart the Alloy service, and confirm it is up and running.

```
systemctl restart alloy
systemctl --no-pager status alloy
```{{exec}}

Alloy is now configured to send metrics to Grafana Cloud. 🎉