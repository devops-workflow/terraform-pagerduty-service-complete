module "disabled" {
  source           = "../../"
  enabled          = false
  policy_name      = "TF Testing policy"
  service_name     = "TF Testing service"
  teams            = "${var.teams}"
  escalation_rules = "${var.escalation_rules}"
}
