import numpy as np
import xml.etree.ElementTree as et

# get text files from desktop after mysql export, clean, append to list

with open('/users/patrickcorynichols/desktop/baseball_salaries_2003.txt','rU') as infile: 
    teams = []     
    infile.next()     
    for i in infile:
        teams.append(i.rstrip('\n').split(','))

# more cleaning, strip blanks, replace quotes
teamsfinal = []
for team in teams:
    teamsfinal.append([i.replace('"','').strip() for i in team])


#write up basic XML
with open('/users/patrickcorynichols/desktop/baseball_salaries_q1.xml','w') as outfile:
    outfile.write('<?xml version="1.0"?>\n')
    outfile.write('<baseball_stats>\n')
    for i in range(len(teamsfinal)): 
        outfile.write('    <player name="'+teamsfinal[i][1]+'">\n')
        outfile.write('        <team>'+teamsfinal[i][0]+'</team>\n')
        outfile.write('        <salary>'+teamsfinal[i][2]+'</salary>\n')
        outfile.write('        <position>'+str(teamsfinal[i][3])+'</position>\n')
        outfile.write('    </player>\n')
    outfile.write('</baseball_stats>')       

# parse XML just created
tree = et.parse('/users/patrickcorynichols/desktop/baseball_salaries_q1.xml')
root = tree.getroot()

# set up dictionaries for analysis
positionary = {}
breakdwn = {}

# dictionary method start - build keys
for child in root.findall('player'): # build all position keys
    positionary[child[2].text] = []

# append values to keys
for child in root.findall('player'): # append salaries to position keys
    positionary[child[2].text].append(float(child[1].text))

# calculate means with numpy
for k,v in positionary.iteritems(): # get average of salaries by position, put into new dict
    breakdwn[str(k)] = (round(np.mean(v),2))

# print out data to csv
with open('/users/patrickcorynichols/desktop/baseball_output_q2.csv','w') as xmlout: # create printout list
    for line in sorted(breakdwn.items(), key=lambda x:x[1],reverse = True):
        xmlout.write(str(line)+'\n')


    
