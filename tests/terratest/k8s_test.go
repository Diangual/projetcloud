package test

import (
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/k8s"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestKubernetesAccess(t *testing.T) {
	t.Parallel()

	// 1. Load Terraform options
	terraformOptions := &terraform.Options{
		TerraformDir: "../../examples/basic-eks",
	}

	// Cleanup after test
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// 2. Get outputs
	clusterName := terraform.Output(t, terraformOptions, "cluster_name")
	region := terraform.Output(t, terraformOptions, "cluster_region")

	// 3. Configure kubectl
	kubectlOptions := aws.NewKubectlOptions(region, clusterName, "default")

	// 4. Test Kubernetes access
	// --- Test 1: Verify nodes are ready ---
	nodes := k8s.GetNodes(t, kubectlOptions)
	assert.True(t, len(nodes) > 0, "Expected at least 1 node")

	// --- Test 2: Deploy test pod ---
	testPod := k8s.NewKubectlOptions("", "", "default")
	testPod.ManifestPath = "test-pod.yaml"

	// Create test pod file
	k8s.KubectlApply(t, testPod, `
apiVersion: v1
kind: Pod
metadata:
  name: nginx-test
spec:
  containers:
  - name: nginx
    image: nginx:latest
    ports:
    - containerPort: 80
`)
	defer k8s.KubectlDelete(t, testPod, `
apiVersion: v1
kind: Pod
metadata:
  name: nginx-test
spec:
  containers:
  - name: nginx
    image: nginx:latest
`)

	// --- Test 3: Verify pod status ---
	k8s.WaitUntilPodAvailable(t, kubectlOptions, "nginx-test", 10, 5*time.Second)
	pod := k8s.GetPod(t, kubectlOptions, "nginx-test")
	assert.Equal(t, "Running", pod.Status.Phase, "Pod should be Running")
}
