# .terraform/modules/modules.json from current directory after init is run
jq -r '.Modules[] | select(.Source == "devops-workflow/service-complete/pagerduty") | .Dir' modules.json

# Testing
#jq -r '.Modules[] | select(.Source == "../..") | .Dir' modules.json
