#!/usr/bin/python

import sys
import math
import matplotlib.pyplot as plt
from matplotlib.ticker import MultipleLocator, FormatStrFormatter


##############################################################################
### This script is for plotting mean footprints with error bar of one species generated with AMBER.

###  Usage: Python plot_fp_amber.py [mean_es] [mean_vdw] [std_es] [std_vdw] 50

#############################################################################
def identify_residues(filename_1, filename_2, filename_3, filename_4, max_res):

    ### Read in the footprint csv files
    mean_es = open(filename_1,'r')
    lines_1 = mean_es.readlines()
    mean_es.close()

    mean_vdw = open(filename_2,'r')
    lines_2 = mean_vdw.readlines()
    mean_vdw.close()

    std_es = open(filename_3,'r')
    lines_3 = std_es.readlines()
    std_es.close()

    std_vdw = open(filename_4,'r')
    lines_4 = std_vdw.readlines()
    std_vdw.close()


    ### Count the number of residues in footprint csv files
    num_res_1 = 0

    for line_1 in lines_1:
        linesplit_1 = line_1.split(',')
        # Jiaye 03-03-17: footprint txt can start either with
        # 'resid' or 'frame'
        if (linesplit_1[0] != 'frame') and (linesplit_1[0] != 'resid'):
                num_res_1 += 1

    ### Extract energy info from different files and save it in a matrix
    fp_array_0 = [[0 for i in range(5)]for j in range(num_res_1)]
    
    count = 0
    for line_1 in lines_1:
        linesplit_1 = line_1.split(',')
        if (linesplit_1[0] != 'frame') and (linesplit_1[0] != 'resid'):
           fp_array_0[count][0] = linesplit_1[0]
           count += 1
    count = 0
    for line_1 in lines_1:
        linesplit_1 = line_1.split(',')
        if (linesplit_1[0] != 'frame') and (linesplit_1[0] != 'resid'):
           fp_array_0[count][1] = float(linesplit_1[1])
           count += 1
 
    
    count = 0
    for line_2 in lines_2:
        linesplit_2 = line_2.split(',')
        if (linesplit_2[0] != 'frame') and (linesplit_2[0] != 'resid'):
           fp_array_0[count][2] = float(linesplit_2[1])
           count += 1
   
    count = 0
    for line_3 in lines_3:
        linesplit_3 = line_3.split(',')
        if (linesplit_3[0] != 'frame') and (linesplit_3[0] != 'resid'):
           fp_array_0[count][3] = float(linesplit_3[1])
           count += 1


    count = 0
    for line_4 in lines_4:
        linesplit_4 = line_4.split(',')
        if (linesplit_4[0] != 'frame') and (linesplit_4[0] != 'resid'):
           fp_array_0[count][4] = float(linesplit_4[1])
           count += 1
    ### Create an array to analyze the footprint info
    fp_array = [[0 for i in range(2)]for j in range(num_res_1)]
    for count in range(num_res_1):
        fp_array[count][0] = count+1
        fp_array[count][1] = max(math.fabs(float(fp_array_0[count][1])), math.fabs(float(fp_array_0[count][2])))
    
    ### Sort the list by number of hits in count
    fp_array.sort(key=lambda x: x[1])
    resindex_selected = []
    resindex_remainder = []
    ### Get the index list for the residues with the highest counts and the remainder
    for i in range(max_res):
        resindex_selected.append(fp_array[(num_res_1-1)-i][0])
    for i in range(num_res_1 - max_res):
        resindex_remainder.append(fp_array[i][0])

    resindex_selected.sort()
    resindex_remainder.sort()
    del fp_array[:][:]
    return resindex_selected, resindex_remainder, fp_array_0
     
####################################################################################################

def plot_footprints(filename_1, filename_2, filename_3, filename_4, resindex_selected, resindex_remainder, fp_array_0):

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


        ### Put the selected residues onto selected arrays
        vdw_mean_selected = []; es_mean_selected = []; vdw_std_selected = []; es_std_selected = []; resname_selected = []
        
        
        for i in (resindex_selected):
            
            vdw_mean_selected.append(float(fp_array_0[i-1][2]))
            es_mean_selected.append(float(fp_array_0[i-1][1]))
            vdw_std_selected.append(float(fp_array_0[i-1][4]))
            es_std_selected.append(float(fp_array_0[i-1][3]))
            resname_selected.append(fp_array_0[i-1][0])

  
        ### Compute the sums for the remainder residues
        vdw_mean_remainder = 0; es_mean_remainder = 0

        for j in (resindex_remainder):
            vdw_mean_remainder += float(fp_array_0[j-1][2])
            es_mean_remainder += float(fp_array_0[j-1][1])
 
        ### Append the remainders to the end of the selected arrays
        resname_selected.append('REMAIN')
        resindex_selected.append('REMAIN')
        vdw_mean_selected.append(vdw_mean_remainder)
        es_mean_selected.append(es_mean_remainder)
        vdw_std_selected.append(0)
        es_std_selected.append(0)
        
        ### Create an index for plotting
        residue = []

        for i in range(len(resindex_selected)):
            residue.append(i)
        ### Plot the figure
        fig = plt.figure(figsize=(11, 8))
        ax1 = fig.add_subplot(2,1,1)
        #ax1.set_title('PARP1 Water site #2 (236/1000)',fontsize=18)
        plt.errorbar(residue, vdw_mean_selected, vdw_std_selected, color='black',linestyle='None', marker='.',elinewidth=2)
        plt.plot(residue, vdw_mean_selected, 'b', linewidth=3)
        #ax1.set_ylabel('VDW Energy (kcal/mol)', fontsize=16)
        ax1.set_ylim(-6, 2)
        ax1.set_xlim(0, len(resindex_selected))
        ax1.xaxis.set_major_locator(MultipleLocator(1))
        ax1.xaxis.set_major_formatter(FormatStrFormatter('%s'))
        ax1.set_xticks(residue)
        ax1.xaxis.grid(which='major', color='black', linestyle='solid')
        ax1.set_xticklabels([])
        ax1.set_yticklabels(['-6','','-4','','-2','','0','','2'],fontsize=18)
        ax1.tick_params(direction='in', pad=10)
        ax1.axhline(y=0,color='k',ls='dashed')

        ax2 = fig.add_subplot(2,1,2)
        plt.errorbar(residue, es_mean_selected, es_std_selected, color='black',linestyle='None', marker='.',elinewidth=2)
        plt.plot(residue, es_mean_selected, 'b', linewidth=3)
        #ax2.set_ylabel('ES Energy (kcal/mol)', fontsize=16)
        ax2.set_ylim(-6, 2)
        ax2.set_xlim(0, len(resindex_selected))
        ax2.xaxis.set_major_locator(MultipleLocator(1))
        ax2.xaxis.set_major_formatter(FormatStrFormatter('%s'))
        ax2.set_xticks(residue)
        ax2.xaxis.grid(which='major', color='black', linestyle='solid')
        ax2.set_xticklabels(resname_selected, rotation=90,fontsize=18)
        ax2.set_yticklabels(['-6','','-4','','-2','','0','','2'],fontsize=18)
        ax2.tick_params(direction='in', pad=10)
        ax2.axhline(y=0,color='k',ls='dashed')

        #plt.savefig('site2_fp_eb.png')
        plt.tight_layout(pad=0.4)
	#plt.show()
        plt.savefig('S1_mean_fp_eb_update.png',dpi=900)
        plt.show()
        plt.close()

       #del resname[:]
        del vdw_mean_selected[:]
        del es_mean_selected[:]
        del vdw_std_selected[:]
        del es_std_selected[:]
        del residue[:]
        del fp_array_0[:][:]

    	return

####################################################################################################

def main():

    ### Get the command line arguments
    filename_1 = sys.argv[1]
    filename_2 = sys.argv[2]
    filename_3 = sys.argv[3]
    filename_4 = sys.argv[4]
    max_res = int(sys.argv[5])
  

    ### Go through the first time to identify interactions above the threshold
    (resindex_selected, resindex_remainder, fp_array_0) = identify_residues(filename_1, filename_2, filename_3, filename_4, max_res)

    #print resindex_selected; print "\n"; print resindex_remainder
    #print "\n"; print len(resindex_selected); print len(resindex_remainder)

    ### Go through a second time to write plots to file
    plot_footprints(filename_1, filename_2, filename_3, filename_4, resindex_selected, resindex_remainder, fp_array_0)


    return

####################################################################################################

main()

