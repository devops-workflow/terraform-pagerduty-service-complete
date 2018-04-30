variable "escalation_rules" {
  type = "list"

  default = [
    {
      "escalation_delay_in_minutes" = "11"

      "target" = [
        {
          "type" = "user_reference"
          "id"   = "PDBFXEO"
        },
      ]
    },
  ]
}

variable "teams" {
  type = "list"

  default = [
    "PIUEF8D",
  ]
}
