#!/bin/bash

DEPLOY_KEY=$(docker exec -it chnserver-chnserver-1 sh -c "grep 'DEPLOY_KEY' /opt/config.py | awk -F'=' '{print \$2}' | tr -d '[:space:]' | tr -d \"'\"")


if [[ -z "${DEPLOY_KEY}" ]]; then
    echo "[ERROR] Could not retrieve DEPLOY_KEY from chnserver. Exiting."
    exit 1
fi


sed -i '' "s/^DEPLOY_KEY=.*/DEPLOY_KEY=${DEPLOY_KEY}/" cowrie.env
echo "Updated DEPLOY_KEY in cowrie.env."

docker-compose restart cowrie