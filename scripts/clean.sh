#!/bin/bash
set -e

echo "🚨 COMPLETE CLEANUP - This will remove everything!"
echo "Press Ctrl+C to cancel, or Enter to continue..."
read

echo "🧹 Starting complete cleanup..."

# 1. Uninstall Helm releases
echo "📦 Removing Helm releases..."
helm uninstall traefik -n traefik-system 2>/dev/null || echo "Traefik not found"
helm uninstall cert-manager -n cert-manager 2>/dev/null || echo "cert-manager not found"

# 2. Delete all certificates, orders, challenges
echo "🔐 Removing certificates and challenges..."
kubectl delete certificates --all -A 2>/dev/null || echo "No certificates found"
kubectl delete orders --all -A 2>/dev/null || echo "No orders found" 
kubectl delete challenges --all -A 2>/dev/null || echo "No challenges found"
kubectl delete certificaterequests --all -A 2>/dev/null || echo "No certificate requests found"

# 3. Delete ClusterIssuers
echo "🏗️  Removing ClusterIssuers..."
kubectl delete clusterissuer --all 2>/dev/null || echo "No ClusterIssuers found"

# 4. Delete namespaces (this will clean up everything in them)
echo "🗂️  Removing namespaces..."
kubectl delete namespace traefik-system 2>/dev/null || echo "traefik-system not found"
kubectl delete namespace cert-manager 2>/dev/null || echo "cert-manager not found"
kubectl delete namespace registry 2>/dev/null || echo "registry not found"

# 5. Clean up CRDs (Custom Resource Definitions)
echo "📋 Removing CRDs..."
kubectl delete crd $(kubectl get crd | grep cert-manager | awk '{print $1}') 2>/dev/null || echo "No cert-manager CRDs"
kubectl delete crd $(kubectl get crd | grep traefik | awk '{print $1}') 2>/dev/null || echo "No Traefik CRDs"

# 6. Remove any stuck finalizers (force cleanup)
echo "🔧 Force cleaning any stuck resources..."
kubectl patch crd certificates.cert-manager.io -p '{"metadata":{"finalizers":[]}}' --type=merge 2>/dev/null || echo "No certificates CRD"
kubectl patch crd clusterissuers.cert-manager.io -p '{"metadata":{"finalizers":[]}}' --type=merge 2>/dev/null || echo "No clusterissuers CRD"

# 7. Clean up any remaining secrets
echo "🔑 Removing secrets..."
kubectl delete secret --all -n kube-system 2>/dev/null || echo "No secrets in kube-system"

# 8. Remove Helm repositories
echo "📚 Cleaning Helm repositories..."
helm repo remove traefik 2>/dev/null || echo "Traefik repo not found"
helm repo remove jetstack 2>/dev/null || echo "Jetstack repo not found"

echo "✅ Cleanup complete!"
echo ""
echo "🔍 Verification:"
kubectl get namespaces | grep -E "(traefik|cert-manager|registry)" || echo "✅ All namespaces cleaned"
kubectl get crd | grep -E "(traefik|cert-manager)" || echo "✅ All CRDs cleaned"  
helm list -A || echo "✅ No Helm releases"

echo ""
echo "🎯 Current cluster status:"
kubectl get all -A
