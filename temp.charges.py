with open ("zzz.lists/5through15.dat", "r") as fil1:
    for line1 in fil1:
        sys = line1.rstrip()
        charge = 0.0
        with open (sys+"/001.files/"+sys+".lig.am1bcc.mol2", "r") as fil2:
            for line2 in fil2:
                if (("LIG" in line2) and ("ROOT" not in line2)):
                    spl = line2.split()
                    charge += float(spl[8])
        print sys, charge
