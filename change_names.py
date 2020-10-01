#!/usr/bin/python
import sys
import os
import fileinput
import string

Counter=1
with open(sys.argv[1],"r") as fin:
    with open("temp.mol2","w")as fout:
        for line in fin:
            if line.strip()=="ZINC77781215":
                fout.write(line.replace("ZINC77781215","mg_a10-"+str(Counter)))
                Counter+=1
            else:        
                fout.write(line)
fin.close()
fout.close()
