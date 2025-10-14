#!/bin/bash
set -e

CONTAINER_NAME="devops-app"
IMAGE_NAME="yourdockerhubusername/devops-app:latest"

echo "🛑 Stopping old container..."
docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

echo "🚀 Running new container on port 80..."
docker run -d --name $CONTAINER_NAME -p 80:80 $IMAGE_NAME

echo "✅ Deployed at http://<server-ip>"

