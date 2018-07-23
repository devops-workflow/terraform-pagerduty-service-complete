# TODO:
#   enabled and len esc rules > 0
#   standard naming
# How to specify Slack channel?
#   This might not work. Could have to script
#   Check for issues/PRs
#   Script to manage Slack channels
# TF Module to setup/deploy lambda service monitor for service

module "enabled" {
  source  = "devops-workflow/boolean/local"
  version = "0.1.2"
  value   = "${var.enabled}"
}

locals {
  enabled = "${module.enabled.value && length(var.escalation_rules) > 0 ? 1 : 0}"
}

/*
data "pagerduty_extension_schema" "slack" {
  name = "slack"
}
/**/

data "pagerduty_vendor" "cloudwatch" {
  count = "${local.enabled}"
  name  = "Cloudwatch"
}

data "pagerduty_vendor" "datadog" {
  count = "${local.enabled}"
  name  = "Datadog"
}

resource "pagerduty_escalation_policy" "this" {
  count       = "${local.enabled}"
  name        = "${var.policy_name}"
  description = "${var.policy_description}"
  num_loops   = "${var.policy_loops}"
  teams       = ["${var.teams}"]
  rule        = ["${var.escalation_rules}"]
}

resource "pagerduty_service" "this" {
  count                   = "${local.enabled}"
  name                    = "${var.service_name}"
  description             = "${var.service_description}"
  auto_resolve_timeout    = "${var.auto_resolve_timeout}"
  acknowledgement_timeout = "${var.acknowledgement_timeout}"
  escalation_policy       = "${element(concat(pagerduty_escalation_policy.this.*.id, list("")), 0)}"
  alert_creation          = "create_alerts_and_incidents"
}

resource "pagerduty_service_integration" "cloudwatch" {
  count   = "${local.enabled}"
  name    = "${element(concat(data.pagerduty_vendor.cloudwatch.*.name, list("")), 0)}"
  service = "${element(concat(pagerduty_service.this.*.id, list("")), 0)}"
  vendor  = "${element(concat(data.pagerduty_vendor.cloudwatch.*.id, list("")), 0)}"
}

resource "pagerduty_service_integration" "datadog" {
  count   = "${local.enabled}"
  name    = "${element(concat(data.pagerduty_vendor.datadog.*.name, list("")), 0)}"
  service = "${element(concat(pagerduty_service.this.*.id, list("")), 0)}"
  vendor  = "${element(concat(data.pagerduty_vendor.datadog.*.id, list("")), 0)}"
}

resource "pagerduty_service_integration" "service_monitor" {
  count   = "${local.enabled}"
  name    = "Lambda AWS Service Monitor"
  type    = "events_api_v2_inbound_integration"
  service = "${element(concat(pagerduty_service.this.*.id, list("")), 0)}"
}

# Attributes: id, integration_key, html_url


/*
resource "pagerduty_extension" "slack"{
  name = "${var.slack_extension_name}"
  endpoint_url = "null"
  extension_schema = "${data.pagerduty_extension_schema.slack.id}"
  extension_objects    = ["${pagerduty_service.this.id}"]
}
# Attributes: id, html_url
/**/


/*
{
  "name": "Slack-Channel-X",
  "extension_objects": [
    {
      "self": "https://api.pagerduty.com/services/PWXXXXX",
      "type": "service_reference",
      "id": "PWXXXXX",
      "html_url": "https://company.pagerduty.com/services/PWXXXXX",
      "summary": "[Service] Channel X"
    }
  ],
  "authorization_url": "https://app.pagerduty.com/slack_oauth?webhook=PLXXXXX",
  "type": "webhook",
  "self": "https://api.pagerduty.com/webhooks/PLXXXXX",
  "summary": "Slack-Channel-X",
  "html_url": null,
  "id": "PLXXXXX",
  "authorized": true,
  "extension_schema": {
    "self": "https://api.pagerduty.com/extension_schemas/PDXXXXX",
    "type": "extension_schema_reference",
    "id": "PDXXXXX",
    "html_url": null,
    "summary": "Slack"
  },
  "config": {
    "ok": true,
    "user_id": "U6SCXXXX",
    "access_token": "slack token",
    "bot": {
      "bot_user_id": "U2XXXXXX"
    },
    "incoming_webhook": {
      "url": "https://hooks.slack.com/services/TTTTTTTT/BBBBBBBB/xxxxxx",
      "channel_id": "CAXXXXXXX",
      "channel": "#mon-channel-x",
      "configuration_url": "https://company.slack.com/services/BAXXXXXXX"
    },
    "restrict": "any",
    "team_id": "TTTTTTT",
    "scope": "identify,bot,incoming-webhook,channels:read,groups:read,im:read,users:read,users:read.email,chat:write:bot,groups:write",
    "team_name": "Developers",
    "notify_types": {
      "assignments": true,
      "resolve": true,
      "acknowledge": true
    }
  },
  "endpoint_url": null
},
/**/

