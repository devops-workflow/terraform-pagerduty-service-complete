output "cloudwatch_id" {
  description = "AWS Cloudwatch integration ID"
  value       = "${pagerduty_service_integration.cloudwatch.id}"
}

output "cloudwatch_key" {
  description = "AWS Cloudwatch integration key"
  value       = "${pagerduty_service_integration.cloudwatch.integration_key}"
}

output "datadog_id" {
  description = "Datadog integration ID"
  value       = "${pagerduty_service_integration.datadog.id}"
}

output "datadog_key" {
  description = "Datadog integration key"
  value       = "${pagerduty_service_integration.datadog.integration_key}"
}

output "escalation_policy_id" {
  description = "Escalation policy ID"
  value       = "${pagerduty_escalation_policy.this.id}"
}

output "service_id" {
  description = "Pagerduty service ID"
  value       = "${pagerduty_service.this.id}"
}

output "service_monitor_id" {
  description = "AWS Lambda Service Monitor integration ID"
  value       = "${pagerduty_service_integration.service_monitor.id}"
}

output "service_monitor_key" {
  description = "AWS Lambda Service Monitor integration key"
  value       = "${pagerduty_service_integration.service_monitor.integration_key}"
}

#slack_id

