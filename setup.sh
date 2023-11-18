#!/usr/bin/env bash
set -euo pipefail

DIR=`dirname "$(readlink -f "$0")"`
source $DIR/settings.sh

# Setup deploy user
ssh_as_root 'bash -s' <<-STDIN || fail "Adding $USER"
  set -euo pipefail
  useradd $USER
  su - $USER -c 'mkdir ~/.ssh'
  su - $USER -c 'touch ~/.ssh/authorized_keys'
  cat /root/.ssh/authorized_keys >> /home/$USER/.ssh/authorized_keys
  chmod 700 /home/$USER/.ssh
  chmod 600 /home/$USER/.ssh/authorized_keys
  usermod -a -G wheel $USER
  passwd -l root
STDIN

# Disable root
ssh_as_user 'bash -s' <<-STDIN || fail "Disabling root"
  sudo chage -E 0 root
STDIN

# Install web server
ssh_as_user 'bash -s' <<-STDIN || fail "Installing NGINX"
  sudo dnf install -y nginx
STDIN
