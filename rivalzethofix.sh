#!/bin/bash

# Turkish Translator by Postuldak

SERVICE_FILE="/etc/systemd/system/eth0-config.service"

if [ "$EUID" -ne 0 ]; then
  echo "Lutfen root olarak calistiriniz"
  exit 1
fi


if ! command -v ethtool &> /dev/null; then
  echo "ethtool bulunamadi, yukleniyor..."
  apt-get update
  apt-get install -y ethtool
fi


cat <<EOL > $SERVICE_FILE
[Unit]
Description=Configure eth0 network interface
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/sbin/ethtool -s eth0 speed 1000 duplex full autoneg off
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOL


systemctl daemon-reload


systemctl enable eth0-config.service


systemctl start eth0-config.service

echo "eth0-config servisi yuklendi ve baslatildi."
