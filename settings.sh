[ -z "$SERVER" ] && SERVER=
[ -z "$SERVER_NAME" ] && SERVER_NAME=
[ -z "$PORT" ] && PORT=22
[ -z "$SSH_KEY" ] && SSH_KEY=
[ -z "$SSH_OPTIONS" ] && SSH_OPTIONS="-i $SSH_KEY -o StrictHostKeyChecking=no"
