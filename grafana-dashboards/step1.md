# Overview

Grafana Alloy is a distribution of the OpenTelemetry (OTel) Collector that allows you to easiely collect metrics, logs, and more from your hosts. In this section, you will use Grafana Cloud to simplify the install of Alloy on an Ubuntu host.

# Generate and run install script

1. Log in to your Grafana Cloud organization, and launch the Grafana service.
2. From the right-hand menu, click **Connections ▶ Collector ▶ Alloy**. 
3. Click the **Installation** tab, and provide a new token name. Leave the remaining fields as the default.
4. Click **Create token**.
5. Run the code block beneath "Install and run Grafana Alloy" on the Ubuntu host.


# Validate install

1. Confirm Alloy was installed:

```
systemctl --no-pager status alloy 
```{{exec}}