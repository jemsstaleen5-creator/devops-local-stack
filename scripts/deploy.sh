#!/bin/bash

IMAGE_NAME=$1

if [ -z "$IMAGE_NAME" ]; then
  echo "Usage: ./deploy.sh <image-name>"
  exit 1
fi

echo "Deploying image: $IMAGE_NAME"

kubectl set image deployment/flask-app flask-app=$IMAGE_NAME

kubectl rollout status deployment flask-app

echo "Deployment Successful 🚀"
