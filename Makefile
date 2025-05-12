.PHONY: docs test security

docs:
  terraform-docs markdown table --output-file README.md --output-mode inject .

test:
  cd tests/terratest && go test -v -timeout 30m

security:
  trivy config --security-checks config .
