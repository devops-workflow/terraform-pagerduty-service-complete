import json
import os
import pypd
import sys

#import errno

# TODO:
#   Convert to use logger
#   Make exceptions more specific
#   Handle all errors

# Read json file (escalation-rules.json) with
#   multiple service sets
#       list of emails and/or schedule names
#       escalation delay
# Determine which are users and schedules
# Get IDs
# Build rule data structure
# output HCL
config_file = "escalation-policy.json"
output_file = "variables-generated-escalation-policy.tf"
default_escalation_delay = 10

def convert_hcl_var(var):
    # TODO:
    #   Should always be a dict, but should determine object type of value
    if isinstance(var, dict):
        #print("Convert dict: {}".format(json.dumps(var, indent=2)))
        hcl = json.dumps(var, indent=2).replace("{\n", "variable", 1)
        hcl = hcl.replace(":", ' {\ntype = "list"\ndefault =', 1)
        hcl = hcl.replace(":", "=")
    elif isinstance(var, list):
        print("Convert list: {}".format(json.dumps(var, indent=2)))
    else:
        print("Unsupported object type")
    return hcl

def get_id(name):
    # Determine if name is user email or schedule name
    test_schedule = False
    id = ""
    type = ""
    #print("Looking up ID for: " + name)
    if "@" in name:
        user = pypd.User.find_one(email=name)
        type = "user_reference"
        try:
            id = user.id
            #print("User ID: " + id)
        except:
            print("INFO: Not valid email: " + name)
            test_schedule = True
    if "@" not in name or test_schedule:
        schedule = pypd.Schedule.find_one(name=name)
        type = "schedule_reference"
        try:
            id = schedule.id
            #print("Schedule ID: " + id)
        except:
            type = ""
            print("WARN: Not valid schedule: " + name)
    return id, type

def get_team_id(name):
    id = ""
    #print("Looking up ID for team: " + name)
    team = pypd.Team.find_one(name=name)
    #print(team)
    try:
        id = team.id
        #print("Team ID: " + id)
    except:
        print("ERROR: team not found: " + name)
        #sys.exit(1)
    return id

if "TF_VAR_pagerduty_token" in os.environ:
    pypd.api_key = os.environ["TF_VAR_pagerduty_token"]
else:
    print("ERROR: Environment variable TF_VAR_pagerduty_token is required")
    sys.exit(1)

###
### Process escalation rules
###
try:
    with open(config_file) as f:
        config = json.load(f)
except IOError:
    print("ERROR: Config file not found. Creating blank variables")
    config = { "escalation-rules":[], "teams":[] }
    #sys.exit(2)
#except ValueError:
    # JSONDecodeError
    # create failures and verify error type raised
    # handle error json decode
#print("Config: " + json.dumps(escalation_rules_config))

escalation_rules = []
for rule_config in config["escalation-rules"]:
    #print("Processing rule: {}".format(json.dumps(rule_config, indent=2)))
    escalation_delay = rule_config.get("escalation_delay", default_escalation_delay)
    for target_list in rule_config["targets"]:
        #print("Processing target list: {}".format(json.dumps(target_list, indent=2)))
        targets = []
        for target in target_list:
            #print("Processing target: {}".format(json.dumps(target, indent=2)))
            id, type = get_id(target)
            if id != "" and type != "":
                #print("ID: {} Type: {}".format(id, type))
                targets.append({"id" : id, "type": type})
        if len(targets) > 0:
            rule = { "escalation_delay_in_minutes" : escalation_delay, "target" : targets }
            escalation_rules.append(rule)
#print(json.dumps(escalation_rules, indent=2))

hcl_wrapper = { "escalation_rules": escalation_rules }
hcl_escalation_policy = convert_hcl_var(hcl_wrapper)
#print("HCL: " + hcl)

###
### Process teams
###
teams = []
for team in config["teams"]:
    id = get_team_id(team)
    if len(id) > 0:
        teams.extend([id])
hcl_teams = convert_hcl_var({ "teams" : teams})

# Output looks good
with open(output_file, 'w') as tf_hcl:
    tf_hcl.write(hcl_escalation_policy)
    tf_hcl.write("\n\n")
    tf_hcl.write(hcl_teams)
