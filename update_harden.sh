#!/usr/bin/env bash
# update_harden.sh — aktualizacje + podstawowe twardnienie dla Debian/Ubuntu
set -euo pipefail

echo "[*] Aktualizacje systemu..."
sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove

echo "[*] Konfiguracja UFW (SSH, HTTP/HTTPS)..."
if command -v ufw >/dev/null 2>&1; then
  sudo ufw allow OpenSSH || true
  sudo ufw allow 80/tcp || true
  sudo ufw allow 443/tcp || true
  sudo ufw --force enable || true
else
  echo "[!] UFW nie znaleziono — pomijam"
fi

echo "[*] Twardnienie SSH (wyłączenie hasła, włączenie kluczy)..."
SSHD="/etc/ssh/sshd_config"
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' "$SSHD"
sudo sed -i 's/^#\?PubkeyAuthentication.*/PubkeyAuthentication yes/' "$SSHD"
sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin prohibit-password/' "$SSHD"
sudo systemctl restart ssh || sudo systemctl restart sshd || true

echo "[*] Logrotate — wymuszenie rotacji..."
sudo logrotate -f /etc/logrotate.conf || true

echo "[✓] Gotowe. Sprawdź dostęp przez klucze SSH przed wylogowaniem!"
