import re
import string

bots = set()
sessions = {}
usernamedict = {}
constraint = ['user logged in', 'user changed password', 'user logged off']

logs = open('logs.log', 'r')
lines = logs.readlines()

def add_to_username(key, value, outer_key):
    try:
        usernamedict[key].append(value)
    except KeyError:
        usernamedict[key] = [value]
    except AttributeError:
        usernamedict[key] = [usernamedict[key], value]
    sessions[outer_key] = usernamedict


for line in lines:
    time = re.findall("[0-9]{2}:[0-9]{2}:[0-9]{2}", line)[0]
    userDetails = re.findall("(?<=\|).+?(?=\|)", line)
    username = userDetails[1]
    action = userDetails[3]
    add_to_username(username, action, time)

for entry in sessions:
    for username in usernamedict:
        if sessions[entry][username] == constraint:
            bots.add(username)

print("\n".join(bots))
