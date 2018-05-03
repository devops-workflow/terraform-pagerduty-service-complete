# terraform-pagerduty-service-complete

This is a Terraform module to manage an opinionated PagerDuty service. It will create a service with: escalation policy and integrations for AWS Cloudwatch, Datadog, and an AWS Service endpoint monitor lambda.

The idea to define a PagerDuty service for each application with the application's deployment via Terraform. Service, escalation policy, and integrations are unique to each application.

Escalation policy is defined with a [json file](README-json.md) due to limitations in Terraform.

Pagerduty integration keys are provided as outputs for other modules to use.
