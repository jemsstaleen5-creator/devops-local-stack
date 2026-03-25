#!/bin/bash
set -e

IMAGE_NAME=$1

if [ -z "$IMAGE_NAME" ]; then
  echo "Usage: ./deploy.sh <image-name>"
  exit 1
fi

echo "Deploying image: $IMAGE_NAME"

kubectl set image deployment/flask-app flask-app=$IMAGE_NAME

echo "Waiting for rollout..."

if kubectl rollout status deployment flask-app; then
  echo "Deployment Successful 🚀"
else
  echo "Deployment Failed ❌ Rolling back..."
  kubectl rollout undo deployment flask-app
  echo "Rollback Complete ✅"
fi
