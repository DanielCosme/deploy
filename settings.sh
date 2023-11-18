USER=cloud-user
SERVER=$SERVER
PORT=22
SSH_KEY=$SSH_KEY
SSH_OPTIONS="-i $SSH_KEY -o StrictHostKeyChecking=no"
ROOT_SSH_ARGS="root@$SERVER -p $PORT $SSH_OPTIONS"
APP_SSH_ARGS="$USER@$SERVER -p $PORT $SSH_OPTIONS"
SCP_ARGS="-P $PORT $SSH_OPTIONS"

fail() {
  echo "Failed:" $1
  exit 1
}
ssh_as_root () {
  ssh $ROOT_SSH_ARGS $@
}
ssh_as_user () {
  ssh $APP_SSH_ARGS $@
}

