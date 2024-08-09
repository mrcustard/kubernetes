#!/bin/bash

# Quick script to do a rolling restart of CoreDNS

NAMESPACE="kube-system"
COREDNS_LABEL="k8s-app=kube-dns"

echo "Checking CoreDNS Pods..."
kubectl get pods -n $NAMESPACE -l $COREDNS_LABEL

echo "Checking CoreDNS Logs..."
kubectl logs -n $NAMESPACE -l $COREDNS_LABEL

echo "Checking CoreDNS Deployment..."
kubectl get deployment -n $NAMESPACE coredns

echo "Describing CoreDNS Deployment..."
kubectl describe deployment -n $NAMESPACE coredns

echo "Checking CoreDNS ConfigMap..."
kubectl get configmap -n $NAMESPACE coredns -o yaml

echo "Restarting CoreDNS Pods..."
kubectl rollout restart deployment/coredns -n $NAMESPACE
