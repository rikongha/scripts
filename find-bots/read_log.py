import re

logs = open('logs.log', 'r')
lines = logs.readlines()
bots = set()
sessions = {}
userdict  = {}
constraint = {'user logged in', 'user changed password', 'user logged off'}

def add_to_sessions(time, user, action):
    if time in sessions:
        if user in sessions[time]:
            sessions[time][user].append(action)
        else:
            userdict[user].append(action)
            sessions[time] = userdict
    else:
        sessions[time] = {user: [action]}
    

for line in lines:
    time = re.findall("[0-9]{2}:[0-9]{2}:[0-9]{2}", line)[0]
    userDetails = re.findall("(?<=\|).+?(?=\|)", line)
    username = userDetails[1]
    action = userDetails[3]

    add_to_sessions(time, username, action)

for time, usernames in sessions.items():
    for name, actions in usernames.items():
        if(constraint == (set(actions))):
            bots.add(name)

print("\n".join(bots))