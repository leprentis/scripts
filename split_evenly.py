import numpy
import sys

num_files   = int(sys.argv[1])
num_entries = int(sys.argv[2])
input_file  = sys.argv[3]

info = ""
entry = 0.
first = True

with open(input_file, 'r') as input:
    for line in input:
        if ("Name" in line):
            if (not first):
                with open(str(int(numpy.ceil(entry / num_entries * num_files)))+".mol2", 'a') as out:
                    out.write(info)
            first = False
            entry += 1.0
            info = ""
        info = info + line

with open(str(num_files)+".mol2", 'a') as out:
    out.write(info)
