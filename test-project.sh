#!/bin/bash
set -e  # Exit immediately on error

# --------------------------
# 0. Environment Setup
# --------------------------
TERRAFORM_DIR="examples/basic-eks"
TEST_DIR="tests/terratest"
export AWS_REGION="us-east-1"

echo "🔵 Starting end-to-end project validation..."

# --------------------------
# 1. Pre-Commit Checks
# --------------------------
echo "🔵 Running pre-commit checks..."
pre-commit run -a

# --------------------------
# 2. Terraform Validate & Plan
# --------------------------
echo "🔵 Validating Terraform configurations..."
cd $TERRAFORM_DIR
terraform init -backend=false
terraform validate
terraform fmt

# --------------------------
# 3. Security Scan (Trivy)
# --------------------------
echo "🔵 Running Trivy security scan..."
trivy config .

# --------------------------
# 4. Deploy Infrastructure
# --------------------------
echo "🔵 Deploying EKS cluster (this may take 15-20 mins)..."
terraform apply -auto-approve
CLUSTER_NAME=$(terraform output -raw cluster_name)

# --------------------------
# 5. Configure kubectl
# --------------------------
echo "🔵 Configuring kubectl..."
aws eks --region $AWS_REGION update-kubeconfig --name $CLUSTER_NAME
cd $TERRAFORM_DIR
kubectl get nodes

# --------------------------
# 6. Run Terratest
# --------------------------
echo "🔵 Executing Terratest..."
cd ../../$TEST_DIR
go mod tidy
go test -v -timeout 25m -run TestKubernetesAccess

# --------------------------
# 7. Smoke Test (K8s Deployment)
# --------------------------
echo "🔵 Running Kubernetes smoke test..."
kubectl create deployment nginx --image=nginx --replicas=2
kubectl expose deployment nginx --port=80 --type=LoadBalancer
kubectl wait --for=condition=available deployment/nginx --timeout=300s
kubectl get svc nginx -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'

# -----------------------------------------
# 8. Cleanup (Pour eviter les charges AWS)
# -----------------------------------------
read -p "🟡 Destroy infrastructure? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🔵 Destroying resources..."
    cd ../../$TERRAFORM_DIR
    terraform destroy -auto-approve
fi

echo "✅ All tests passed successfully!"
