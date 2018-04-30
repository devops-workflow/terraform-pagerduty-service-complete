# TODO:
#   enabled and len esc rules > 0
#   standard naming
# How to specify Slack channel?
#   This might not work. Could have to script
#   Check for issues/PRs
#   Script to manage Slack channels
# TF Module to setup/deploy lambda service monitor for service

/*
data "pagerduty_extension_schema" "slack" {
  name = "slack"
}
/**/
data "pagerduty_vendor" "cloudwatch" {
  name = "Cloudwatch"
}

data "pagerduty_vendor" "datadog" {
  name = "Datadog"
}

resource "pagerduty_escalation_policy" "this" {
  #count     = "${length(keys(var.escalation_rules))}"
  name        = "${var.policy_name}"
  description = "${var.policy_description}"
  num_loops   = "${var.policy_loops}"
  teams       = ["${var.teams}"]
  rule        = ["${var.escalation_rules}"]
}

resource "pagerduty_service" "this" {
  name                    = "${var.service_name}"
  description             = "${var.service_description}"
  auto_resolve_timeout    = "${var.auto_resolve_timeout}"
  acknowledgement_timeout = "${var.acknowledgement_timeout}"
  escalation_policy       = "${pagerduty_escalation_policy.this.id}"
  alert_creation          = "create_alerts_and_incidents"
}

resource "pagerduty_service_integration" "cloudwatch" {
  name    = "${data.pagerduty_vendor.cloudwatch.name}"
  service = "${pagerduty_service.this.id}"
  vendor  = "${data.pagerduty_vendor.cloudwatch.id}"
}

resource "pagerduty_service_integration" "datadog" {
  name    = "${data.pagerduty_vendor.datadog.name}"
  service = "${pagerduty_service.this.id}"
  vendor  = "${data.pagerduty_vendor.datadog.id}"
}

resource "pagerduty_service_integration" "service_monitor" {
  name    = "Lambda AWS Service Monitor"
  type    = "events_api_v2_inbound_integration"
  service = "${pagerduty_service.this.id}"
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
      "self": "https://api.pagerduty.com/services/PWDXXXX",
      "type": "service_reference",
      "id": "PWDXXXX",
      "html_url": "https://company.pagerduty.com/services/PWDXXXX",
      "summary": "[Service] Channel X"
    }
  ],
  "authorization_url": "https://app.pagerduty.com/slack_oauth?webhook=PL6XXXX",
  "type": "webhook",
  "self": "https://api.pagerduty.com/webhooks/PL6XXXX",
  "summary": "Slack-Channel-X",
  "html_url": null,
  "id": "PL6XXXX",
  "authorized": true,
  "extension_schema": {
    "self": "https://api.pagerduty.com/extension_schemas/PD8XXXX",
    "type": "extension_schema_reference",
    "id": "PD8XXXX",
    "html_url": null,
    "summary": "Slack"
  },
  "config": {
    "ok": true,
    "user_id": "U6SCXXXX",
    "access_token": "slack token",
    "bot": {
      "bot_user_id": "U2P6XXXX"
    },
    "incoming_webhook": {
      "url": "https://hooks.slack.com/services/TTTTTTTT/BBBBBBBB/xxxxxx",
      "channel_id": "CAC0BXXXX",
      "channel": "#mon-channel-x",
      "configuration_url": "https://company.slack.com/services/BACDNXXXX"
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
