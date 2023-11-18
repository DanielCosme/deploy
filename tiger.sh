#!/usr/bin/bash
set -euo pipefail

USER=deploy
DIR=`dirname "$(readlink -f "$0")"`
SERVER=$SERVER
PORT=22
SSH_KEY=$SSH_KEY
SSH_OPTIONS="-i $SSH_KEY -o StrictHostKeyChecking=no"
SSH_ARGS="$USER@$SERVER -p $PORT $SSH_OPTIONS"
SSH_ARGS="$USER@$SERVER -p $PORT $SSH_OPTIONS"
SCP_ARGS="-P $PORT $SSH_OPTIONS"

fail() {
  echo $1
  exit 1
}
ssh_as_root () {
  ssh $
}

ssh $SSH_ARGS 'bash -s' <<-STDIN || fail "installation failed"
  set -euo pipefail
  dnf install -y nginx
STDIN

if [ -e $DIR/index.html ]; then
  scp $SCP_ARGS index.html $USER@$SERVER:/usr/share/nginx/html/index.html || fail "scp failed"
else
  fail "index.html does not exist"
fi

ssh $SSH_ARGS 'bash -s' <<-STDIN || fail "service failed"
    set -euo pipefail
    dnf install -y nginx
    systemctl restart nginx.service
STDIN
