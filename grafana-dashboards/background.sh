ARCH="amd64" GCLOUD_HOSTED_METRICS_URL="https://prometheus-prod-13-prod-us-east-0.grafana.net/api/prom/push" GCLOUD_HOSTED_METRICS_ID="1278241" GCLOUD_SCRAPE_INTERVAL="60s" GCLOUD_HOSTED_LOGS_URL="https://logs-prod-006.grafana.net/loki/api/v1/push" GCLOUD_HOSTED_LOGS_ID="738166" GCLOUD_RW_API_KEY="glc_eyJvIjoiOTg1ODQwIiwibiI6InN0YWNrLTc4NTE3MC1pbnRlZ3JhdGlvbi13b3Jrc2hvcCIsImsiOiI0MUFQOEU1QjkweDM1elhNeDhCTWZ5TjkiLCJtIjp7InIiOiJwcm9kLXVzLWVhc3QtMCJ9fQ==" /bin/sh -c "$(curl -fsSL https://storage.googleapis.com/cloud-onboarding/alloy/scripts/install-linux.sh)"

cat <<EOF >> /etc/alloy/config.alloy
prometheus.exporter.unix "demo" { }

prometheus.scrape "demo" {
  targets    = prometheus.exporter.unix.demo.targets
  forward_to = [prometheus.remote_write.metrics_service.receiver]
}
EOF
