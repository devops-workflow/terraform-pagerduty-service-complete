# escalation-policy.json

Currently Terraform is not capable of dynamically created the data structure
needed to define a Pagerduty escalation policy. So, a
[json file](escalation-policy.json-example) is used to specify the escalation
policy details and a script does lookups in Pagerduty for details, then creates
variables in HCL format for Terraform to consume.

The [json file](escalation-policy.json-example) contains details for
2 variables: escalation-rules and teams

Escalation-rules is a list of maps. Each map defines an escalation rule. Each
escalation rule has fields: escalation_delay and targets. escalation_delay
is the delay in minutes between rules. This maps directly to Pagerduty.
Targets is a list of targets for the escalation rule. Targets can be user
email addresses or schedule names. These will be looked up in Pagerduty and
ignored if not found.

Teams is a list of team names. These will be looked up in Pagerduty and
ignored if not found.

Both variables are required. If teams are not being used, use "teams": []

[Example](escalation-policy.json-example):

```json
{
  "escalation-rules": [
    {
      "escalation_delay": "11",
      "targets": [
        [
          "user1@example.com",
          "Schedule1"
        ],
        [
          "schedule2"
        ]
      ]
    },
    {
      "escalation_delay": "12",
      "targets": [
        ["user2@corp.com"],
        ["schedule2"]
      ]
    }
  ],
  "teams": [
    "team1",
    "team2"
  ]
}
```
