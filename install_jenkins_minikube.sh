#!/bin/bash

# Start Minikube
minikube start --memory=4096 --cpus=2 --driver=docker

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Add bitnami repo and test Helm
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install nginx bitnami/nginx
helm uninstall nginx

# Create namespace
kubectl create namespace jenkins

# Create admin credentials securely
kubectl create secret generic jenkins-admin-secret \
  --from-literal=jenkins-admin-user=admin \
  --from-literal=jenkins-admin-password=admin123 \
  -n jenkins

# Install Jenkins
helm install jenkins ./charts/jenkins -n jenkins

# Wait and access service
sleep 30
minikube service jenkins -n jenkins
