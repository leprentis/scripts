#!/usr/bin/python

import sys
import math
import matplotlib.pyplot as plt
import matplotlib.colors as col
import matplotlib.cm as cm
from matplotlib.ticker import MultipleLocator, FormatStrFormatter

###############################################################################
### This script is for plotting the footprints of (1)ligand; (2)ligand+water; (3)water; (4)interaction between ligand and water generated with AMBER.

### Usage: Python plot_fp_amber.py [ligand_es] [ligand_vdw] [ligands_es] [ligands_vdw] [water_es] [water_vdw] [ligwat_es] [ligwat_vdw] 50

###############################################################################
def identify_residues(filename_1, filename_2, filename_3, filename_4, filename_5, filename_6, filename_7, filename_8, max_res):

    ### Read in the six footprint csv files
    file_1 = open(filename_1,'r')
    lines_1 = file_1.readlines()
    file_1.close()

    file_2 = open(filename_2,'r')
    lines_2 = file_2.readlines()
    file_2.close()
    
    file_3 = open(filename_3,'r')
    lines_3 = file_3.readlines()
    file_3.close()

    file_4 = open(filename_4,'r')
    lines_4 = file_4.readlines()
    file_4.close()

    file_5 = open(filename_5,'r')
    lines_5 = file_5.readlines()
    file_5.close()

    file_6 = open(filename_6,'r')
    lines_6 = file_6.readlines()
    file_6.close()


    ### Count the number of residues in the csv files
    num_res_1 = 0

    for line_1 in lines_1:
        linesplit_1 = line_1.split(',')
        if (linesplit_1[0] != 'resid'):
                num_res_1 += 1

    num_res_2 = 0

    for line_2 in lines_2:
        linesplit_2 = line_2.split(',')
        if (linesplit_2[0] != 'resid'):
                num_res_2 += 1

    num_res_3 = 0

    for line_3 in lines_3:
        linesplit_3 = line_3.split(',')
        if (linesplit_3[0] != 'resid'):
                num_res_3 += 1

    num_res_4 = 0

    for line_4 in lines_4:
        linesplit_4 = line_4.split(',')
        if (linesplit_4[0] != 'resid'):
                num_res_4 += 1
    

    num_res_5 = 0

    for line_5 in lines_5:
        linesplit_5 = line_5.split(',')
        if (linesplit_5[0] != 'resid'):
                num_res_5 += 1

    num_res_6 = 0

    for line_6 in lines_6:
        linesplit_6 = line_6.split(',')
        if (linesplit_6[0] != 'resid'):
                num_res_6 += 1


    ### Extract energy info from different files and save it in a matrix
    fp_array_0 = [[0 for i in range(7)]for j in range(num_res_1)]

    count = 0
    for line_1 in lines_1:
        linesplit_1 = line_1.split(',')
        if (linesplit_1[0] != 'resid'):
           fp_array_0[count][0] = linesplit_1[0]
           count += 1
    count = 0
    for line_1 in lines_1:
        linesplit_1 = line_1.split(',')
        if (linesplit_1[0] != 'resid'):
           fp_array_0[count][1] = float(linesplit_1[1])
           count += 1

    count = 0
    for line_2 in lines_2:
        linesplit_2 = line_2.split(',')
        if (linesplit_2[0] != 'resid'):
           fp_array_0[count][2] = float(linesplit_2[1])
           count += 1

    count = 0
    for line_3 in lines_3:
        linesplit_3 = line_3.split(',')
        if (linesplit_3[0] != 'resid'):
           fp_array_0[count][3] = float(linesplit_3[1])
           count += 1

    count = 0
    for line_4 in lines_4:
        linesplit_4 = line_4.split(',')
        if (linesplit_4[0] != 'resid'):
           fp_array_0[count][4] = float(linesplit_4[1])
           count += 1

    count = 0
    for line_5 in lines_5:
        linesplit_5 = line_5.split(',')
        if (linesplit_5[0] != 'resid'):
           fp_array_0[count][5] = float(linesplit_5[1])
           count += 1

    count = 0
    for line_6 in lines_6:
        linesplit_6 = line_6.split(',')
        if (linesplit_6[0] != 'resid'):
           fp_array_0[count][6] = float(linesplit_6[1])
           count += 1

    ### Create an array to analyze the footprint info
    fp_array_1 = [[0 for i in range(2)]for j in range(num_res_1)]
    for count in range(num_res_1):
        fp_array_1[count][0] = count+1
        fp_array_1[count][1] = max(math.fabs(float(fp_array_0[count][1])), math.fabs(float(fp_array_0[count][2])), math.fabs(float(fp_array_0[count][3])), math.fabs(float(fp_array_0[count][4])))

    fp_array_2 = [[0 for i in range(2)]for j in range(num_res_1)]
    for count in range(num_res_1):
        fp_array_2[count][0] = count+1
        fp_array_2[count][1] = max(math.fabs(float(fp_array_0[count][5])), math.fabs(float(fp_array_0[count][6])))


    ### Sort the list by number of hits in count
    fp_array_1.sort(key=lambda x: x[1])
    resindex_selected_1 = []
    resindex_remainder_1 = []

    fp_array_2.sort(key=lambda x: x[1])
    resindex_selected_2 = []
    resindex_remainder_2 = []
   
    ### Get the index list for the residues with the highest counts and the remainder
    for i in range(max_res):
        resindex_selected_1.append(fp_array_1[(num_res_1-1)-i][0])

    for i in range(num_res_1 - max_res):
        resindex_remainder_1.append(fp_array_1[i][0])

    resindex_selected_1.sort()
    resindex_remainder_1.sort()
    del fp_array_1[:][:]

    for i in range(max_res):
        resindex_selected_2.append(fp_array_2[(num_res_2-1)-i][0])

    for i in range(num_res_2 - max_res):
        resindex_remainder_2.append(fp_array_2[i][0])

    resindex_selected_2.sort()
    resindex_remainder_2.sort()
    del fp_array_2[:][:]


    return resindex_selected_1, resindex_remainder_1, resindex_selected_2, resindex_remainder_2, fp_array_0

####################################################################################################

def plot_footprints(filename_1, filename_2, filename_3, filename_4, filename_5, filename_6, filename_7, filename_8, resindex_selected_1, resindex_remainder_1, resindex_selected_2, resindex_remainder_2, fp_array_0):

    ### Read in the files
        footprint_1 = open(filename_1,'r')
        lines_1 = footprint_1.readlines()
        footprint_1.close()

        footprint_2 = open(filename_2,'r')
        lines_2 = footprint_2.readlines()
        footprint_2.close()

        footprint_3 = open(filename_3,'r')
        lines_3 = footprint_3.readlines()
        footprint_3.close()

        footprint_4 = open(filename_4,'r')
        lines_4 = footprint_4.readlines()
        footprint_4.close()

        footprint_5 = open(filename_5,'r')
        lines_5 = footprint_5.readlines()
        footprint_5.close()

        footprint_6 = open(filename_6,'r')
        lines_6 = footprint_6.readlines()
        footprint_6.close()

        footprint_7 = open(filename_7,'r')
        lines_7 = footprint_7.readlines()
        footprint_7.close()
 
        footprint_8 = open(filename_8,'r')
        lines_8 = footprint_8.readlines()
        footprint_8.close()

    ### Count the residue numbers for file 7 and 8
        num_res_7 = 0

        for line_7 in lines_7:
            linesplit_7 = line_7.split(',')
            if (linesplit_7[0] != 'resid'):
                num_res_7 += 1

        num_res_8 = 0 

        for line_8 in lines_8:
            linesplit_8 = line_8.split(',')
            if (linesplit_8[0] != 'resid'):
                num_res_8 += 1


    ### Store the resname, resid, and fp information for each input appropriately; from now on "_1", "_2" and "_3" represent ligand/ligands, water and the single-point interaction respectively instead of file 1, 2 and 3.
        resname = []; vdw_ref_1 = []; es_ref_1 = []; vdw_pose_1 = []; es_pose_1 = []
        vdw_ref_2 = []; es_ref_2 = []; vdw_pose_2 = []; es_pose_2 = []
        resname_3 = []; vdw_pose_3 = 0; es_pose_3 = 0
        ligands_total_VDW = 0; ligands_total_ES = 0

        for i in (resindex_selected_1):

            vdw_ref_1.append(float(fp_array_0[i-1][4]))
            es_ref_1.append(float(fp_array_0[i-1][3]))
            vdw_pose_1.append(float(fp_array_0[i-1][2]))
            es_pose_1.append(float(fp_array_0[i-1][1]))

        for i in (resindex_selected_2):

            vdw_ref_2.append(float(fp_array_0[i-1][6]))
            es_ref_2.append(float(fp_array_0[i-1][5]))
            vdw_pose_2.append(float(fp_array_0[i-1][6]))
            es_pose_2.append(float(fp_array_0[i-1][5]))

        for line_7 in lines_7:
            linesplit_7 = line_7.split(',')
        es_pose_3 += float(linesplit_7[1])

        for line_8 in lines_8:
            linesplit_8 = line_8.split(',')
        vdw_pose_3 += float(linesplit_8[1])

        for i in range(len(lines_3)-1):
            ligands_total_VDW += float(fp_array_0[i][4])
            ligands_total_ES += float(fp_array_0[i][3])

        ### Put the selected residues onto a selected array
        vdw_ref_selected_1 = []; es_ref_selected_1 = []; vdw_pose_selected_1 = []; es_pose_selected_1 = []
        vdw_ref_selected_2 = []; es_ref_selected_2 = []; vdw_pose_selected_2 = []; es_pose_selected_2 = []
        temp = []
        temp_1 = []
        temp_2 = []
        resindex_selected = []
        resname_selected = []
        inter_1 = []
        inter_2 = []


        for i in (resindex_selected_1):
            temp.append(i)
        for i in (resindex_selected_2):
            temp.append(i)
          
        temp.sort()
            
        for i in range(len(temp)-1):
            if (temp[i] != temp[i+1]):
               resindex_selected.append(temp[i])
        resindex_selected.append(temp[len(temp)-1])
       
        for i in (resindex_selected):
            resname_selected.append(fp_array_0[i-1][0])

       # print resindex_selected_1
       # print resindex_selected_2
       # print resindex_selected
        ### Find out the residues that are in the remainder and the selected union at the same time
        for i in (resindex_remainder_1):
            temp_1.append(i)
        for i in (resindex_selected):
            temp_1.append(i)

        temp_1.sort()
        for i in range(len(temp_1)-1):
            if (temp_1[i] == temp_1[i+1]):
               inter_1.append(temp_1[i])

        for i in (resindex_remainder_2):
            temp_2.append(i)

        for i in (resindex_selected):
            temp_2.append(i)

        temp_2.sort()
        for i in range(len(temp_2)-1):
            if (temp_2[i] == temp_2[i+1]):
               inter_2.append(temp_2[i])

        # print inter_1
       # print inter_2
             
        for i in (resindex_selected):
            vdw_ref_selected_1.append(float(fp_array_0[i-1][4]))
            es_ref_selected_1.append(float(fp_array_0[i-1][3]))
            vdw_pose_selected_1.append(float(fp_array_0[i-1][2]))
            es_pose_selected_1.append(float(fp_array_0[i-1][1]))
        for i in (resindex_selected):
            vdw_ref_selected_2.append(float(fp_array_0[i-1][6]))
            es_ref_selected_2.append(float(fp_array_0[i-1][5]))
            vdw_pose_selected_2.append(float(fp_array_0[i-1][6]))
            es_pose_selected_2.append(float(fp_array_0[i-1][5]))



        ### Compute the sums for the remainder residues
        vdw_ref_remainder_1 = 0; es_ref_remainder_1 = 0; vdw_pose_remainder_1 = 0; es_pose_remainder_1 = 0
        vdw_ref_remainder_2 = 0; es_ref_remainder_2 = 0; vdw_pose_remainder_2 = 0; es_pose_remainder_2 = 0
        
        for i in (resindex_remainder_1):
            vdw_ref_remainder_1 += float(fp_array_0[i-1][4])
            es_ref_remainder_1 += float(fp_array_0[i-1][3])
            vdw_pose_remainder_1 += float(fp_array_0[i-1][2])
            es_pose_remainder_1 += float(fp_array_0[i-1][1])
        for i in (inter_1):
            vdw_ref_remainder_1 -= float(fp_array_0[i-1][4])
            es_ref_remainder_1 -= float(fp_array_0[i-1][3])
            vdw_pose_remainder_1 -= float(fp_array_0[i-1][2])
            es_pose_remainder_1 -= float(fp_array_0[i-1][1])

        for i in (resindex_remainder_2):
            vdw_ref_remainder_2 += float(fp_array_0[i-1][6])
            es_ref_remainder_2 += float(fp_array_0[i-1][5])
            vdw_pose_remainder_2 += float(fp_array_0[i-1][6])
            es_pose_remainder_2 += float(fp_array_0[i-1][5])
 
        for i in (inter_2):
            vdw_ref_remainder_2 -= float(fp_array_0[i-1][6])
            es_ref_remainder_2 -= float(fp_array_0[i-1][5])
            vdw_pose_remainder_2 -= float(fp_array_0[i-1][6])
            es_pose_remainder_2 -= float(fp_array_0[i-1][5])


        ### Append each of the remainders to the end of the selected array
        resname_selected.append('REMAIN')
        vdw_ref_selected_1.append(float(vdw_ref_remainder_1))
        es_ref_selected_1.append(float(es_ref_remainder_1))
        vdw_pose_selected_1.append(float(vdw_pose_remainder_1))
        es_pose_selected_1.append(float(es_pose_remainder_1))

        vdw_ref_selected_2.append(float(vdw_ref_remainder_2))
        es_ref_selected_2.append(float(es_ref_remainder_2))
        vdw_pose_selected_2.append(float(vdw_pose_remainder_2))
        es_pose_selected_2.append(float(es_pose_remainder_2))
        

        ### Create an index for plotting
        residue = []

        for i in range(len(resname_selected)):
            residue.append(i)
        print residue    
        print resname_selected 
        ### Define the upper and lower limits of the plots
        #vdw_uplim = 0; vdw_lolim = 0; es_uplim = 0; es_lolim = 0
        #if (max(max(vdw_ref_1, vdw_pose_1))> vdw_ref_2 and min(min(vdw_ref_1, vdw_pose_1))< vdw_ref_2):
        #    vdw_uplim = max(max(vdw_ref_1, vdw_pose_1))
        #    vdw_lolim = min(min(vdw_ref_1, vdw_pose_1))
        #else:
        #     if(max(max(vdw_ref_1, vdw_pose_1))< vdw_ref_2):
        #        vdw_uplim = vdw_ref_2
        #        vdw_lolim = min(min(vdw_ref_1, vdw_pose_1))
        #     else:
        #        vdw_uplim = max(max(vdw_ref_1, vdw_pose_1))
        #        vdw_lolim = vdw_ref_2
    
        #if (max(max(es_ref_1, es_pose_1))> es_ref_2 and min(min(es_ref_1, es_pose_1))< es_ref_2):
        #    es_uplim = max(max(es_ref_1, es_pose_1))
        #    es_lolim = min(min(es_ref_1, es_pose_1))
        #else:
        #     if(max(max(es_ref_1, es_pose_1))< es_ref_2):
        #        es_uplim = es_ref_2
        #        es_lolim = min(min(es_ref_1, es_pose_1))
        #     else:
        #        es_uplim = max(max(es_ref_1, es_pose_1))
        #        es_lolim = es_ref_2
  
        cdict = {'red': ((0.0, 0.0, 0.0),
                     (0.3, 0.5, 0.5),
                     (0.6, 0.7, 0.7),
                     (0.9, 0.8, 0.8),
                     (1.0, 0.8, 0.8)),
         'green': ((0.0, 0.0, 0.0),
                   (0.3, 0.8, 0.8),
                   (0.6, 0.7, 0.7),
                   (0.9, 0.0, 0.0),
                   (1.0, 0.7, 0.7)),
         'blue': ((0.0, 1.0, 1.0),
                  (0.3, 1.0, 1.0),
                  (0.6, 0.0, 0.0),
                  (0.9, 0.0, 0.0), 
                  (1.0, 1.0, 1.0))}

 

        ### Plot figure
        fig = plt.figure(figsize=(12, 11))
        ax1 = fig.add_subplot(2,1,1)
        ax1.set_title('1XKK Water#4') 
### change name

        plt.plot(residue, vdw_ref_selected_1, 'magenta', linewidth=3)
        plt.plot(residue, vdw_pose_selected_1, 'magenta', linewidth=3)
        plt.plot(residue, vdw_ref_selected_2, '#2C64DF', linewidth=3)

        ax2 = fig.add_subplot(2,1,2)
        plt.plot(residue, es_ref_selected_1, 'magenta', linewidth=3)
        plt.plot(residue, es_pose_selected_1, 'magenta', linewidth=3)
        plt.plot(residue, es_ref_selected_2, '#2C64DF', linewidth=3)

### Append the water molecule to the end of the selected arrays
        resname_selected.append('LIG-WAT')  

        residue = []

        for i in range(len(resname_selected)):
            residue.append(i)
        

        ax1 = fig.add_subplot(2,1,1)
        plt.plot(len(resname_selected)-1, vdw_pose_3, 'ko') 
        ax1.set_ylabel('VDW Energy (kcal/mol)')
        #ax1.set_ylim(int(vdw_lolim)-1,int(vdw_uplim)+1)
        ax1.set_ylim(-4, 2) ### change range
        ax1.set_xticklabels([])
        ax1.set_yticklabels(['-4','-3','-2','-1','0','1','2'],fontsize=20)
        ax1.set_xlim(0, len(resname_selected))
        ax1.xaxis.set_major_locator(MultipleLocator(1))
        ax1.xaxis.set_major_formatter(FormatStrFormatter('%s'))
        ax1.set_xticks(residue)
        ax1.xaxis.grid(which='major', color='black', linestyle='solid')
        #ax1.set_xticklabels(resname_selected, rotation=90)
        #ax1.annotate(ligands_total_VDW, xy=(20,-6), backgroundcolor='white', bbox={'facecolor':'white', 'alpha':1.0, 'pad':10})
        ax1.axhline(y=0,color='k',ls='dashed')

        ax2 = fig.add_subplot(2,1,2)
        plt.plot(len(resname_selected)-1, es_pose_3, 'ko')
        ax2.set_ylabel('ES Energy (kcal/mol)')
        #ax2.set_ylim(int(es_lolim)-1,int(es_uplim)+1)
        ax2.set_ylim(-4, 2) 
        ax2.set_xticklabels([])
        ax2.set_yticklabels(['-4','-3','-2','-1','0','1','2'],fontsize=20)
        ax2.tick_params(direction='in', pad=15)
### change range
        ax2.set_xlim(0, len(resname_selected))
        ax2.xaxis.set_major_locator(MultipleLocator(1))
        ax2.xaxis.set_major_formatter(FormatStrFormatter('%s'))
        ax2.set_xticks(residue)
        ax2.xaxis.grid(which='major', color='black', linestyle='solid')
        ax2.set_xticklabels(resname_selected, rotation=90)
#	ax2.legend(['Ligand + Water', 'Ligand', 'Water', 'Lig interact Wat'], 'lower right')
        #ax2.annotate(ligands_total_ES, xy=(20,-5), backgroundcolor='white', bbox={'facecolor':'white', 'alpha':1.0, 'pad':10})
        ax2.axhline(y=0,color='k',ls='dashed')

        plt.show()
        plt.close()





        del vdw_ref_1[:]
        del vdw_ref_2[:]
        del es_ref_1[:]
        del es_ref_2[:]
        del vdw_pose_1[:]
        del vdw_pose_2[:]
        del es_pose_1[:]
        del es_pose_2[:]
        del vdw_ref_selected_1[:]
        del vdw_ref_selected_2[:]
        del es_ref_selected_1[:]
        del es_ref_selected_2[:]
        del vdw_pose_selected_1[:]
        del vdw_pose_selected_2[:]
        del es_pose_selected_1[:]
        del es_pose_selected_2[:]
        del residue[:]
        del temp[:]
        del resindex_selected[:]
        del resname_selected[:]
        del resname_3[:]
        del vdw_pose_3
        del es_pose_3


    	return


####################################################################################################

def main():

    ### Get the command line arguments
    filename_1 = sys.argv[1]
    filename_2 = sys.argv[2]
    filename_3 = sys.argv[3]
    filename_4 = sys.argv[4]
    filename_5 = sys.argv[5]
    filename_6 = sys.argv[6]
    filename_7 = sys.argv[7]
    filename_8 = sys.argv[8]
    max_res = int(sys.argv[9])

    ### Go through the first time to identify interactions above the threshold
    (resindex_selected_1, resindex_remainder_1, resindex_selected_2, resindex_remainder_2, fp_array_0) = identify_residues(filename_1, filename_2, filename_3, filename_4, filename_5, filename_6, filename_7, filename_8, max_res)


    ### Go through a second time to write plots to file
    plot_footprints(filename_1, filename_2, filename_3, filename_4, filename_5, filename_6, filename_7, filename_8, resindex_selected_1, resindex_remainder_1, resindex_selected_2, resindex_remainder_2, fp_array_0)


    return

####################################################################################################

main()
