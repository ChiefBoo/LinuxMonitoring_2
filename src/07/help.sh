#!/bin/bash

#PROMETHEUS PORT 9090 localhost:9090

#wget https://github.com/prometheus/prometheus/releases/download/v2.37.0/prometheus-2.37.0.linux-amd64.tar.gz
#tar -xf prometheus-2.37.0.linux-amd64.tar.gz && mv prometheus-2.37.0.linux-amd64 /etc/prometheus

#useradd prometheus --shell=/bin/false --no-create-home

#sudo mkdir /var/lib/prometheus
#sudo cp -pr /etc/prometheus/promtool prometheus /usr/local/bin/
#sudo chown prometheus:prometheus /usr/local/bin/promtool
#sudo chown prometheus:prometheus /usr/local/bin/prometheus
#sudo chown -R prometheus:prometheus /etc/prometheus
#sudo chown -R prometheus:prometheus /var/lib/prometheus

#sudo vi /etc/systemd/system/prometheus.service

#sudo systemctl daemon-reload
#systemctl start prometheus""
#systemctl status prometheus

# GRAFANA PORT 3000 # VPN localhost:3000 
#login: admin password: admin

#sudo apt-get install -y adduser libfontconfig1 musl
#wget https://dl.grafana.com/enterprise/release/grafana-enterprise_10.3.1_amd64.deb
#sudo dpkg -i grafana-enterprise_10.3.1_amd64.deb

#sudo systemctl daemon-reload
#systemctl enable prometheus
#systemctl start prometheus
#systemctl status prometheus

#node exporer port 9100
cd /etc/prometheus/node_exporter-1.7.0.linux-amd64/
./node_exporter

