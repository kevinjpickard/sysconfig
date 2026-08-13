#!/bin/bash
set -e

echo "Setting root and user passwords..."
echo "root:testpassword" | chpasswd
useradd -m -g wheel -s /bin/zsh kevin 2>/dev/null || true
echo "kevin:testpassword" | chpasswd
echo 'kevin ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/kevin

echo "Configuring OpenSSH for Packer..."
mkdir -p /etc/ssh/sshd_config.d
cat <<EOF > /etc/ssh/sshd_config.d/packer.conf
PermitRootLogin yes
PasswordAuthentication yes
KbdInteractiveAuthentication yes
EOF

echo "Restarting sshd..."
systemctl restart sshd || systemctl start sshd
