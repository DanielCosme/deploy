#!/usr/bin/env bash
set -euo pipefail

DIR=`dirname "$(readlink -f "$0")"`
source $DIR/settings.sh

scp $SCP_ARGS $DIR/index.html $USER@$SERVER:index.html || fail "Copying index.html"

ssh_as_user 'bash -s' <<-STDIN || fail "Restarting service"
  set -euo pipefail
  sudo mv ~/index.html /usr/share/nginx/html/index.html
  sudo chown root:root /usr/share/nginx/html/index.html
  sudo chcon -t httpd_sys_content_t \
    /usr/share/nginx/html/index.html
  sudo systemctl restart nginx.service
STDIN
