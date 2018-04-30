# Put provider information required to test the module here. It will not be tracked by Git
provider "pagerduty" {
  token = "${var.pagerduty_token}"
}
