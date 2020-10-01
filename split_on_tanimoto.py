import sys 

start_num = 0
if (len(sys.argv) > 1):
    start_num = int(sys.argv[1])

with open('rescore_scored.mol2', 'r') as fil:
    mol = ""
    tan_vals = []
    fil_dest = 0
    first_line = True
    for line in fil:
        if (( 'Name:' in line ) and ( not first_line  ) ):
            with open('temp.split.'+str(start_num + fil_dest)+'.mol2', 'a') as out:
                out.write(mol)
            mol = ""
        mol = mol + line
        if (first_line):
            first_line = False
        if ( 'Tanimoto' in line ):
            spl = line.split()
            tan = spl[2].rstrip()

            seen_val = False
            for i in range( len(tan_vals)):
                if ( tan == tan_vals[i] ):
                    seen_val = True
                    fil_dest = i
            if (not seen_val):
                fil_dest = len(tan_vals)
                tan_vals.append(tan)
                    
    with open('temp.split.'+str(start_num + fil_dest)+'.mol2', 'a') as out:
            out.write(mol)        
