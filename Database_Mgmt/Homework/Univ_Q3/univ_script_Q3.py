import xml.etree.ElementTree as et

tree = et.parse('/users/patrickcorynichols/desktop/univ_schema_Q3.xml')
root = tree.getroot()  

# zip method
instname = []
instsal = []

for child in root.findall('INSTRUCTOR'):
    instcheck = ['Comp. Sci.','Elec. Eng.']
    if child[2].text in instcheck:
        instname.append(child[1].text)
        instsal.append(child[3].text)

hwilist = sorted(zip(instsal,instname),reverse=True)

names = []
ids =[]
depts = []

for child in root.findall('STUDENT'):
    names.append(child[1].text)    
    ids.append(child[0].text)
    depts.append(child[2].text)

hwslist = sorted(zip(names,ids,depts))        

with open('/Users/PatrickCoryNichols/Desktop/univ_output_Q3.xml','w') as outfile:
    outfile.write('<?xml version="1.0"?>\n')  
    outfile.write('<studentinstructor>\n')
    for i in hwslist:    
        outfile.write('    <student>\n')
        outfile.write('        <name>'+str(i[0])+'</name>\n')
        outfile.write('        <sid>'+str(i[1])+'</sid>\n')
        outfile.write('        <department>'+str(i[2])+'</department>\n')
        outfile.write('    </student>\n')
    for j in hwilist:
        outfile.write('    <instructor>\n')
        outfile.write('        <name>'+str(j[1])+'</name>\n')
        outfile.write('        <salary>'+str(j[0])+'</salary>\n')
        outfile.write('    </instructor>\n')
    outfile.write('</studentinstructor>')