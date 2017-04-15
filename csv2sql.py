# converting csv file to sql input

import csv


teams={}
data_teams='nfl_teams.csv'

cnt=0
with open(data_teams, 'r') as g:
    
    reader=csv.reader(g)
    next(reader)
    
    for row in reader:
        row[0]=int(row[0])
        teams[row[3]]=row    # key=abbr_name, value=[id, full_name, city, abbr]
        cnt+=1   

# for k, v in teams.items():
#     print("insert into nfl_team values('%d', '%s', '%s', '%s');" % (v[0], v[1], v[2], v[3]))


d={}

years=['2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016']

cnt=0

for year in years:
    
    data_players = 'players_'+year+'.csv'

    with open(data_players, 'r') as f:

        reader=csv.reader(f)
        next(reader)
        for row in reader:
            d[cnt]=row
            cnt+=1



allPlayers={}

for k, v in d.items():
    
    name = v[0]
    nfl_player_id = v[1]
    team = v[3]
    position = v[4]
    
    if nfl_player_id not in allPlayers:
        if position in ['N/A', 'n/a']:
            position=''
        allPlayers[nfl_player_id]={'name':name, 'nfl_team':[teams[team][0]], 'position':position}
        
    else:
        if teams[team][0] not in allPlayers[nfl_player_id]['nfl_team']:
            allPlayers[nfl_player_id]['nfl_team'].append(teams[team][0])


all_positions=[]
for k, v in allPlayers.items():
    if v['position'] not in all_positions:
        if v['position'] not in ['', ' '] and '' not in all_positions:
            all_positions.append('') 
        else:
            all_positions.append(v['position']) 
   
all_positions=sorted(all_positions)         
        
for i, j in enumerate(all_positions):
    print("insert into player_position values('%d', '%s');" % (i, j))
    
print()
print()


for k, v in allPlayers.items():
    
    for idx, pos in enumerate(all_positions):
        if pos==v['position']:
            position_id=idx
    #print(k, v)
    print("insert into nfl_players values('%s', '%s', %d, %d, %d, %s);" % (k, v['name'], position_id, v['nfl_team'][0], v['nfl_team'][0], 'NULL'))

    
# print(len(allPlayers))
# print(no_position)
# print(with_one_position)
# print(more_than_one_position)
