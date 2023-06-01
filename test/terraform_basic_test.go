package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"os"
	"testing"
)

func TestEmptyTestTerraform(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// website::tag::1::Set the path to the Terraform code that will be tested.
		// The path to where our Terraform code is located
		TerraformDir: "../examples/test",

		// 		Variables to pass to our Terraform code using -var options
		// 		Vars: map[string]interface{}{},
		// Targets: []string{"module.vault_tfc_backends.vault_jwt_auth_backend.this"},
		// Variables to pass to our Terraform code using -var-file options
		//Uncomment VarFiles line below if you need to test locally.
		VarFiles: []string{"test.empty.tfvars"},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	})

	// website::tag::2::Run "terraform init" and "terraform apply".
	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	if "apply" != os.Getenv("TF_COMMAND") {
		output := terraform.InitAndPlan(t, terraformOptions)

		assert.Contains(t, output, "workspaces = {}")

	} else {
		// no test
	}
}

func TestWorkspacesTestTerraform(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		// website::tag::1::Set the path to the Terraform code that will be tested.
		// The path to where our Terraform code is located
		TerraformDir: "../examples/test",

		// 		Variables to pass to our Terraform code using -var options
		// 		Vars: map[string]interface{}{},
		// Targets: []string{"module.vault_tfc_backends.vault_jwt_auth_backend.this"},
		// Variables to pass to our Terraform code using -var-file options
		//Uncomment VarFiles line below if you need to test locally.
		VarFiles: []string{"test.ws.tfvars"},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	})

	// website::tag::2::Run "terraform init" and "terraform apply".
	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	if "apply" != os.Getenv("TF_COMMAND") {
		output := terraform.InitAndPlan(t, terraformOptions)

		assert.Contains(t, output, "vault_role_name")
		assert.Contains(t, output, "terratest-test-role")
		assert.Contains(t, output, "vault_namespace_key  = \"root\"")
		assert.Contains(t, output, "identity_name           = \"tfc-test-org-ws-test-name-1-workspace1\"")
		assert.Contains(t, output, "vault_entity_alias   = \"organization:test-org:project:Test Project:workspace:ws-test-name-1\"")
		assert.Contains(t, output, "Plan: 4 to add, 0 to change, 0 to destroy.")

	} else {
		// no test
	}
}
