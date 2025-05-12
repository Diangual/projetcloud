package test

import (
  "testing"
  "github.com/gruntwork-io/terratest/modules/terraform"
)

func TestEKSClusterCreation(t *testing.T) {
  terraformOptions := &terraform.Options{
    TerraformDir: "../../examples/basic-eks",
  }

  defer terraform.Destroy(t, terraformOptions)
  terraform.InitAndApply(t, terraformOptions)
}
