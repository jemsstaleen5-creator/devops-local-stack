#!/bin/bash
set -e

IMAGE_TAG=$1

if [ -z "$IMAGE_TAG" ]; then
  echo "Usage: ./deploy.sh <image-tag>"
  exit 1
fi

echo "Deploying using Helm with tag: $IMAGE_TAG"

helm upgrade my-app ./helm-chart/devops-app \
  --set image.tag=$IMAGE_TAG

echo "Waiting for rollout..."

kubectl rollout status deployment flask-app

echo "Deployment Successful 🚀"
