# Overview

Grafana Alloy is a distribution of the OpenTelemetry (OTel) Collector that allows you to easily collect metrics, logs, and more using tools like Loki, Prometheus, and more. In this section, you will use Grafana Cloud to simplify the install of Alloy on an Ubuntu host, then build a dashboard using the collected metrics.

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
  ```

2. Restart the Alloy service, and confirm it is up and running.

  ```
  systemctl restart alloy
  systemctl --no-pager status alloy
  ```

Alloy is now configured to send host metrics to the hosted instance of Prometheus in Grafana Cloud. 🎉

# Start your dashboard

1. From the right-hand menu, click **Dashboards**. Then, in the upper-left, click by **New ▶ New dashboard**.
2. Next, click **Add visualization**.
3. From the dropdown menu, select the first (and default) Grafana Cloud Prometheus data source. This will open the **Edit panel** screen.
  ![Prometheus Data Source](https://i.imgur.com/w8ameGB.png)
4. In the upper-left, input a Title/Description as metadata for the panel, and change the visualization to be a "Gauge". 
5. Input the following as the query, which will display the amount of memory of a system in GBs:
  ```
  node_memory_MemFree_bytes / 1024 / 1024 / 1024
  ```
  ![Query](https://i.imgur.com/gp1wgiS.png)
6. Test the query by clicking **Run quries**. The gauge will populate with some data!
7. Next, let's clean up the gauge. On the left-hand side, scroll down to _Standard options_. Change the **Unit** into **Data > Gigabytes** and set the min and max values to `0` and `4`. 
8. Help future SRE's by changing adding some color to your gauge. Change the **Thresholds** settings to the following configuration, so that low memory is represented in red:
  ![Memory](https://i.imgur.com/nQFcBer.png)
9. Click **Save** to return to the dashboard.
> **Extra challenge**: Try and build another panel with the following query:
>  ```
>  sum(rate(node_network_transmit_bytes_total[1m])) / 1024 / 1024
>  ```

# Testing the dashboard

Let's confirm the dashboard is working as intended and have the memory spike on our system.

1. From the Ubuntu host, run the following command:

  ```
  head -c 2G /dev/zero | tail
  ```

  > This command will generate a process that consumes exactly 2GB of memory.

2. Return to your Grafana dashboard, and watch the gauge increase as Prometheus scrapes the new metrics.
