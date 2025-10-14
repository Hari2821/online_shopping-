#!/bin/bash
set -e

IMAGE_NAME="nginx-app"
CONTAINER_NAME="nginx-app"

echo "🔄 Stopping old container (if any)..."
docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

echo "🐳 Building image..."
docker build -t $IMAGE_NAME .

echo "🚀 Running container on port 80..."
docker run -d --name $CONTAINER_NAME -p 80:80 $IMAGE_NAME

echo "✅ App is live at: http://localhost"

