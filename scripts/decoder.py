
import json
import sys

input = sys.stdin.read()

with open('input.txt', 'w') as the_file:
    the_file.write(input)

# json decode, loop keys, decode each
json_in = json.loads(input)
#json_2 = {}
with open('decoded.json', 'w') as the_file:
#    with json_in["rules"] as rules:
#        the_file.write(rules)
#        the_file.write('\n')
#        rules = rules.replace('"{', '{')
#        rules = rules.replace('}"', '}')
#        the_file.write(rules)
#        json_2 = json.loads(rules)
    for key in json_in:
        the_file.write(json_in[key])
        the_file.write('\n')
        json_in[key] = json_in[key].replace('"{', '{')
        json_in[key] = json_in[key].replace('}"', '}')
        #json_in[key] = json_in[key].replace(' ', '')
        the_file.write(json_in[key])
        json_2 = json.loads(json_in[key])

with open('decoded_final.json', 'w') as the_file:
    the_file.write(json.dumps(json_2, separators=(',',':')))

#print(json.dumps(json_2, separators=(',',':')))
print('{}')
