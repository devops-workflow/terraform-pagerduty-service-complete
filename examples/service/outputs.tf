output "cloudwatch_id" {
  description = "AWS Cloudwatch integration ID"
  value       = "${module.service.cloudwatch_id}"
}

output "cloudwatch_key" {
  description = "AWS Cloudwatch integration key"
  value       = "${module.service.cloudwatch_key}"
}

output "datadog_id" {
  description = "Datadog integration ID"
  value       = "${module.service.datadog_id}"
}

output "datadog_key" {
  description = "Datadog integration key"
  value       = "${module.service.datadog_key}"
}

output "escalation_policy_id" {
  description = "Escalation policy ID"
  value       = "${module.service.escalation_policy_id}"
}

output "service_id" {
  description = "Pagerduty service ID"
  value       = "${module.service.service_id}"
}

output "service_monitor_id" {
  description = "AWS Lambda Service Monitor integration ID"
  value       = "${module.service.service_monitor_id}"
}

output "service_monitor_key" {
  description = "AWS Lambda Service Monitor integration key"
  value       = "${module.service.service_monitor_key}"
}

#slack_id

