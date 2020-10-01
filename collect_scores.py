import os.path
systems = open("zzz.lists/5through15_ch2.dat", "r").readlines()
#for typ in ["grid_vdw"]:
for typ in ["mg", "fpsScale", "grid", "ph42"]:
    for sys in systems:
        sys = sys.rstrip()
        #restart and dump files
        for anc in ['1', '2', '3']:
            for lay in ['1', '2', '3', '4', '5', '6', '7', '8', '9']:
                for rd in ["root_layer", "dump"]:
                    filename = sys+"/020_bl.de-novo.focused."+typ+"/"+ \
                               sys+".final.anchor_"+anc+"."+rd+"_"+lay+".mol2"
                    if (os.path.isfile(filename)):
                        with open(filename, 'r') as hand:
                            for line in hand:
                                if ("Descriptor_Score:" in line):
                                    print lay, line.split()[2], 'ens', typ, filename
                                    if (line.split()[2] < -400):
                                        print filename
        #final
        filename = sys+"/020_bl.de-novo.focused."+typ+"/"+ \
                               sys+".final.denovo_build.mol2"
        if (os.path.isfile(filename)):
            with open(filename, 'r') as hand:
                for line in hand:
                    if ("Descriptor_Score:" in line):
                        score = line.split()[2]
                    if ("Layer_Completed:" in line):
                        print line.split()[2], score, 'fin', typ, filename
                        if (line.split()[2] < -400):
                            print filename, 'fuck'
