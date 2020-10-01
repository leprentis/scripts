
import sys,urllib,urllib2

if len(sys.argv) != 3:
    print "Error: two arguments are needed"
    print "smiles = C1CCCC1"
    print "similarity = .90"
    sys.exit()

smiles     = sys.argv[1]
similarity = sys.argv[2]
url = 'http://zinc.docking.org/results/similar?structure.smiles='+smiles+'&structure.similarity='+ similarity

print "url = " + url

#page=requests.get(url)

webfile = urllib.urlopen(url)
page    = webfile.read()
webfile.close()


splitpage=page.split('\n')

for line in splitpage:
    if "zinc summary-item" in line:
       ## <li id="sub-72436952" class="zinc summary-item">
       sliteline = line.replace('<',' ').replace('>',' ').replace('-',' ').replace('=',' ').replace('"','').split()
       #print line
       #print sliteline
       zincid = sliteline[3]
       print "zinc id = " + zincid


