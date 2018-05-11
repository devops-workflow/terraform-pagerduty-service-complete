[![CircleCI](https://circleci.com/gh/devops-workflow/terraform-pagerduty-service-complete.svg?style=svg)](https://circleci.com/gh/devops-workflow/terraform-pagerduty-service-complete)

# terraform-pagerduty-service-complete

This is a Terraform module to manage an opinionated PagerDuty service. It will create a service with: escalation policy and integrations for AWS Cloudwatch, Datadog, and an AWS Service endpoint monitor lambda.

The idea to define a PagerDuty service for each application with the application's deployment via Terraform. Service, escalation policy, and integrations are unique to each application.

Escalation policy is defined with a [json file](README-json.md) due to limitations in Terraform. A [script](scripts/variable-generator.py) is run to lookup information in Pagerduty and generate a HCL file with the variable definitions for Terraform to use. Generated file is `variables-generated-escaaltion-policy.tf`

Pagerduty integration keys are provided as outputs for other modules to use.

Example use:

```hcl
module "service" {
  source                  = "devops-workflow/service-complete/pagerduty"
  acknowledgement_timeout = 28800
  auto_resolve_timeout    = 900
  policy_description      = "TF Testing policy description"
  policy_loops            = 3
  policy_name             = "TF Testing policy"
  service_description     = "TF Testing service description"
  service_name            = "TF Testing service"
  teams                   = "${var.teams}"
  escalation_rules        = "${var.escalation_rules}"
}
```
