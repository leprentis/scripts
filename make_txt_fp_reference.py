import sys

inputname = sys.argv[1]
outputname = sys.argv[2]

inputfile = open(inputname,'r')
lines = inputfile.readlines()
inputfile.close()

outputfile = open(outputname,'w')

for line in lines :
	linesplit = line.split()

	if len(linesplit) == 8 and linesplit[0] != "resname":
		outputfile.write(linesplit[0]+"  "+linesplit[1]+"  "+linesplit[2]+"  "+linesplit[3]+"  "+linesplit[4]+"\n")

outputfile.close()
