#!/bin/bash

# Script to help with troubleshooting ingress

NAMESPACE="default"
INGRESS_NAME="freshrss-ingress"
SERVICE_NAME="freshrss"
INGRESS_CONTROLLER_NAMESPACE="ingress-nginx"
INGRESS_CONTROLLER_LABEL="app.kubernetes.io/name=ingress-nginx"

echo "Inspecting Ingress Resource..."
kubectl get ingress $INGRESS_NAME -n $NAMESPACE -o yaml

echo "Checking Service Configuration..."
kubectl get service $SERVICE_NAME -n $NAMESPACE -o yaml

echo "Inspecting Endpoints..."
kubectl get endpoints $SERVICE_NAME -n $NAMESPACE

echo "Testing Service Connectivity..."
kubectl run -i --tty busybox --image=busybox --restart=Never --rm -- wget --spider --timeout=1 http://$SERVICE_NAME.$NAMESPACE.svc.cluster.local:80

echo "Testing Ingress Connectivity..."
curl -I http://rss.egroupus.com

echo "Checking Ingress Controller Logs..."
kubectl logs -n $INGRESS_CONTROLLER_NAMESPACE $(kubectl get pods -n $INGRESS_CONTROLLER_NAMESPACE -l $INGRESS_CONTROLLER_LABEL -o jsonpath='{.items[0].metadata.name}')

