import sys

### This script breaks larger mulitmol2 files argv1       ###
### into small chunks argv2                               ###
### Usage: python lauren_breaks_things.py library.mol2 50 ###

inputfilename = sys.argv[1]
sepint = float(sys.argv[2])+1
inputfile = open(inputfilename, 'r')
count = 1
counter = 0

for line in inputfile:
    if (counter < sepint) and ("Name:" in line):
        counter += 1
        countnum = str(count)
        name = 'mol' + countnum + '.mol2'
        outfile = file(str(name), 'a+')
        if (counter == sepint) and ("Name:" in line):
            outfile.close()
            counter = 1
            count += 1
            countnum = str(count)
            name = 'mol' + countnum + '.mol2'
            outfile = file(str(name), 'a+')
            outfile.write(line)
        else:
            outfile.write(line)
    elif (counter < sepint) and ("Name:" not in line):
        countnum = str(count)
        name = 'mol' + countnum + '.mol2'
        outfile = file(str(name), 'a+')
        outfile.write(line)
