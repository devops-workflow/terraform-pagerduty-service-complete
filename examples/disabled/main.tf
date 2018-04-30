module "disabled" {
  source                  = "../../"
  acknowledgement_timeout = 28800
  auto_resolve_timeout    = 900
  policy_description      = "TF Testing policy description"
  policy_loops            = 3
  policy_name             = "TF Testing policy"
  service_description     = "TF Testing service description"
  service_name            = "TF Testing service"
  slack_extension_name    = ""
  teams                   = "${var.teams}"
  escalation_rules        = "${var.escalation_rules}"
}
