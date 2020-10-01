import sys

inputfilename = sys.argv[1]
outputfilename = sys.argv[2]
inputfile = open(inputfilename, 'r')
outputfile = open(outputfilename, 'w')

for line in inputfile:
    if ("ZINC" in line):
        lauren = line.split()
        rangeoflist = len(lauren)
        for x in range(0, rangeoflist):
            if (lauren[x].startswith('ZINC')):
                if (";" in lauren[x]):
                    newlauren = lauren[x].replace(";","\n")
                    outputfile.write(newlauren)
                else:
                    newlauren3 = lauren[x] + "\n"
                    outputfile.write(newlauren3)
