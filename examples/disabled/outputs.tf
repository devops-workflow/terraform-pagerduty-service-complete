output "cloudwatch_id" {
  description = "AWS Cloudwatch integration ID"
  value       = "${module.disabled.cloudwatch_id}"
}

output "cloudwatch_key" {
  description = "AWS Cloudwatch integration key"
  value       = "${module.disabled.cloudwatch_key}"
}

output "datadog_id" {
  description = "Datadog integration ID"
  value       = "${module.disabled.datadog_id}"
}

output "datadog_key" {
  description = "Datadog integration key"
  value       = "${module.disabled.datadog_key}"
}

output "escalation_policy_id" {
  description = "Escalation policy ID"
  value       = "${module.disabled.escalation_policy_id}"
}

output "service_id" {
  description = "Pagerduty service ID"
  value       = "${module.disabled.service_id}"
}

output "service_monitor_id" {
  description = "AWS Lambda Service Monitor integration ID"
  value       = "${module.disabled.service_monitor_id}"
}

output "service_monitor_key" {
  description = "AWS Lambda Service Monitor integration key"
  value       = "${module.disabled.service_monitor_key}"
}

#slack_id

