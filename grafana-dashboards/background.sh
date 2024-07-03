cat <<EOF >> /root/config.example
prometheus.exporter.unix "demo" { }

prometheus.scrape "demo" {
  targets    = prometheus.exporter.unix.demo.targets
  forward_to = [prometheus.remote_write.metrics_service.receiver]
}
EOF
