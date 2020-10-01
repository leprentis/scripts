import shutil
import os,sys
import copy

with open("6LU7_lig_wCYX.mol2", "r+") as in_file:
    buf = in_file.readlines()

with open("6LU7_new_lig_wCYX.mol2", "w") as out_file:
    bool = 0
    for line in buf:
        newline=line.split()
        if (len(newline) == 9):
            var1 = newline[7]
            var2 = newline[6]
            var3 = " " +newline[6]+ " "
            newnewline = line.replace(var1, "LIG")
            newnewnewline = newnewline.replace(var3, " 1 ")
            #print(line)
            #print(newnewline)
            #print(newnewnewline)
            out_file.write(newnewnewline)
        else:
            out_file.write(line)
                       
