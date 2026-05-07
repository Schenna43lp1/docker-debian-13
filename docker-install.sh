#!/bin/bash
set -e

echo "[1/5] System aktualisieren..."
apt update
apt install -y ca-certificates curl gnupg lsb-release

echo "[2/5] Docker GPG-Key hinzufügen..."
install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/debian/gpg | \
gpg --dearmor -o /etc/apt/keyrings/docker.gpg

chmod a+r /etc/apt/keyrings/docker.gpg

echo "[3/5] Docker Repository hinzufügen..."
. /etc/os-release

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
$VERSION_CODENAME stable" > /etc/apt/sources.list.d/docker.list

echo "[4/5] Docker installieren..."
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "[5/5] Docker aktivieren..."
systemctl enable --now docker

echo ""
echo "Docker Version:"
docker --version

echo ""
echo "Docker Compose Version:"
docker compose version

echo ""
echo "Fertig."
