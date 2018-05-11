output "cloudwatch_endpoint" {
  description = "Endpoint for webhook events (Integration URL)"
  value       = "${element(concat(pagerduty_service_integration.cloudwatch.*.html_url, list("")), 0)}"
}

output "cloudwatch_id" {
  description = "AWS Cloudwatch integration ID"
  value       = "${element(concat(pagerduty_service_integration.cloudwatch.*.id, list("")), 0)}"
}

output "cloudwatch_key" {
  description = "AWS Cloudwatch integration key"
  value       = "${element(concat(pagerduty_service_integration.cloudwatch.*.integration_key, list("")), 0)}"
}

output "datadog_id" {
  description = "Datadog integration ID"
  value       = "${element(concat(pagerduty_service_integration.datadog.*.id, list("")), 0)}"
}

output "datadog_key" {
  description = "Datadog integration key"
  value       = "${element(concat(pagerduty_service_integration.datadog.*.integration_key, list("")), 0)}"
}

output "escalation_policy_id" {
  description = "Escalation policy ID"
  value       = "${element(concat(pagerduty_escalation_policy.this.*.id, list("")), 0)}"
}

output "service_id" {
  description = "Pagerduty service ID"
  value       = "${element(concat(pagerduty_service.this.*.id, list("")), 0)}"
}

output "service_monitor_id" {
  description = "AWS Lambda Service Monitor integration ID"
  value       = "${element(concat(pagerduty_service_integration.service_monitor.*.id, list("")), 0)}"
}

output "service_monitor_key" {
  description = "AWS Lambda Service Monitor integration key"
  value       = "${element(concat(pagerduty_service_integration.service_monitor.*.integration_key, list("")), 0)}"
}

#slack_id
