#!/bin/bash

#
# This script will first minimize the ligand in Cartesian space using 6-12 VDW exponents.
# After minimizing, the ligand is rescored using the footprint score (also in Cartesian space,
# 6-12 VDW exponents). It is recommended to use VDW and ES cutoffs of 1 kcal/mol and 0.5 kcal/mol,
# respectively. After the rescore, a list of the "primary" residues is compiled, and a
# reference.txt file of per-residue interactions is created to be used as the reference for the
# forthcoming multigrid minimization.
#


export PRINTDIR="/gpfs/projects/rizzo/leprentis/FABP"
export WORKDIR="/gpfs/projects/rizzo/leprentis/FABP"
export FAMILYDIR="STK15"
export SYSTEMDIR="LIF5_conga"
export DATA="ga_output.data_analysis"
export SCRIPTDIR="ga_output.scripts"
export MAX_GEN="1000"

for FAMILY in ""
do
        export FILE="LIF5.de_novo.out"

for TESTDIR in "014h.e_max_yc_nn_yp_rand_mg_lipinski" "014h.e_max_yc_nn_yp_rand_grid_vol_cutoff" "014h.e_max_yc_nn_yp_rand_grid_vol_lipinski" "015j.t_pvc_yc_nn_yp_rand_mg_lipinski" "015j.t_pvc_yc_nn_yp_rand_grid_vol_cutoff" "015j.t_pvc_yc_nn_yp_rand_grid_vol_lipinski"
do
	cd ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}
	echo ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}

	if [ -e "${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/ga_output.restart${MAX_GEN}.mol2.gz" ]  || [ -e "${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/ga_output.restart${MAX_GEN}.mol2" ]; 
	then

        #rm -r ${DATA}
        mkdir -p ${DATA}
	cd ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${DATA}

        for REC in `cat ${WORKDIR}/${FAMILYDIR}/${FAMILY}_rec.dat`
        do

        ### Remove any dat files that exist
        rm *.dat

	## Un-gzip
	if [ -e "${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE}.gz" ];
	then 
		gunzip -f ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE}.gz
		echo "${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE}.gz"
	fi
### Grep information in the order it is displayed in the out file
# CROSSOVER DATA #
# Num Gens
grep "For GA round " ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > num_gen.dat
# Num parents
grep "new size of parents"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $11}' > size_parents.dat
# Mols generated from crossover
grep "In breeding, size of children"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $7}' > size_cross.dat
# Mols with valid bond environments
grep "Total number with valid tor"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $7}' > cross_torenv.dat
# Total mols made from crossover
grep "Total number with valid descriptors"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $7}' > cross_descript.dat
#Num pair sampled
grep "Number of unique pairs" ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $7}' > sampled_pairs.dat
#Max number of pairs
grep "Number of unique pairs" ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $9}' > max_pairs.dat
#Xover Hungarian similarity pruning
grep "xovers prevented by Hun"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $9}' > xover_similarity.dat
# TOtal number of molecules involved in crossovers
grep "parents involved in xover:" ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $9}' > xover_parents.dat



# MINIMIZATION
# Mols after internal energy
grep "energy/internal energy prune"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $7}' > energy_prune.dat
# Mols deleted (in pair-wise pruning after minimization) + ones from mut
#grep "compounds were removed because of similarity to other children" ${FILE} | awk '{print $1}' > pruned.dat
grep "after similarity pruning"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $7}' > pruned.dat

#Final number of offspring after minimization
grep "molecules after minimizat"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $8}' > size_minimized.dat
# Final number of offspring from crossover and pruning - before mutations
grep "molecules after fitness"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $9}' > size_premut.dat



# MUTATION DATA #
# FOR PARENTS
# Number of mutants 
grep "For this round of GA, parent mutation"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $9}' > num_pmuts.dat
# Number of cycles completed
grep "Expected number of parent mut"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $12}' > pmut_cycles.dat
# Expected number of mutation
grep "Expected number of parent mut"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $7}' > expected_pmuts.dat

# FOR OFFSPRING
# Number of mutants 
grep "For this round of GA, offspring mutation"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $9}' > num_omuts.dat
# Number of cycles completed
grep "Expected number of offspring mut"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $12}' > omut_cycles.dat
# Expected number of mutation
grep "Expected number of offspring mut"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $7}' > expected_omuts.dat

# Descriptors
# FOR PARENTS
# Success rates
grep "Successful parent deletions:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > success_pdel.dat
grep "Successful parent deletions:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $6}' > attempts_pdel.dat
grep "Successful parent addition"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > success_padd.dat
grep "Successful parent addition"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $6}' > attempts_padd.dat
grep "Successful parent substitutions:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > success_psub.dat
grep "Successful parent substitutions:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $6}' > attempts_psub.dat
grep "Successful parent replacements:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > success_prep.dat
grep "Successful parent replacements:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $6}' > attempts_prep.dat


# FOR OFFSPRING
# Success rates
grep "Successful offspring deletions:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > success_odel.dat
grep "Successful offspring deletions:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $6}' > attempts_odel.dat
grep "Successful offspring addition"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > success_oadd.dat
grep "Successful offspring addition"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $6}' > attempts_oadd.dat
grep "Successful offspring substitutions:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > success_osub.dat
grep "Successful offspring substitutions:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $6}' > attempts_osub.dat
grep "Successful offspring replacements:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > success_orep.dat
grep "Successful offspring replacements:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $6}' > attempts_orep.dat


# POP Information"
# Preselection Offspring size
grep "Final offspring size before"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $7}' > final_osize.dat
# Preselection Parent size
grep "Final parent size before"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $7}' > final_psize.dat
# Offspring gen + scores
#grep "Survivors score from gen"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $5 " " $6}' > offspring_score.dat
grep "Average survivoris score from gen"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $6 " " $7}' > ave_score_off.dat
# Survivor gen + score
#grep "Survivors score from gen"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $5 " " $6}' > survivors_score.dat
grep "Average survivors score from gen"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $6 " " $7}' > ave_score_parents.dat




# Time
grep "Elapsed time:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $3}' > timing.dat
#grep "Elapsed time Initialize"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $5}' > initial_time.dat
grep "Elapsed time Breeding"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > breeding_time.dat
grep "Elapsed time fitness"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $5}' > fp_time.dat
grep "Minimize + Prune"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $6}' > mini_time.dat
grep "Elapsed time segment"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > seg_ids_time.dat
grep "Elapsed time deletions"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > del_time.dat
grep "Elapsed time additions"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > add_time.dat
grep "Elapsed time replacement"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > rep_time.dat
grep "Elapsed time mutation"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > mut_sel_time.dat
grep "Elapsed time Parents Mutations"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $5}' > final_mut_ptime.dat
grep "Pruning-Mutate Parents"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $5}' > final_mut-prune_ptime.dat
grep "Elapsed time Offspring Mutations"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $5}' > final_mut_otime.dat
grep "Pruning-Mutate Offspring"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $5}' > final_mut-prune_otime.dat
grep "Elapsed time P-O pruning"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $5}' > p_o_time.dat
grep "Elapsed time selection"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > sel_time.dat


#grep "exceeded MW"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $2}' > mw_cut.dat
#grep "exceeded the rot"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $1}' > rot_cut.dat
#grep "exceeded the HA"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $1}' > HA_cut.dat
#grep "exceeded the HB"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $1}' > HB_cut.dat


# MUltigrid only from ga_output.restart*.mol2
#export START=1
#for NUMBER in {${START}..${MAX_GEN}} 
for NUMBER in {1..1000}
do
   if [ -e "${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/ga_output.restart${NUMBER}.mol2.gz" ];
   then 
   gunzip -f ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/ga_output.restart${NUMBER}.mol2.gz
   fi
   #echo ${NUMBER}
   grep "Descriptor_Score"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/ga_output.restart${NUMBER}.mol2 | awk '{print $3}' > descript${NUMBER}.dat
   grep "MultiGrid_vdw"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/ga_output.restart${NUMBER}.mol2 | awk '{print $3}' > mg_vdw${NUMBER}.dat
   grep "MultiGrid_es"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/ga_output.restart${NUMBER}.mol2 | awk '{print $3}' > mg_es${NUMBER}.dat
  awk 'NR==FNR{a[NR]=$1;next}{print $1+a[FNR],$2}' mg_vdw${NUMBER}.dat mg_es${NUMBER}.dat > mg${NUMBER}.dat
   grep "vdweuc"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/ga_output.restart${NUMBER}.mol2 | awk '{print $3}' > vdweuc${NUMBER}.dat
   grep "eseuc"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/ga_output.restart${NUMBER}.mol2 | awk '{print $3}' > eseuc${NUMBER}.dat
  awk 'NR==FNR{a[NR]=$1;next}{print $1+a[FNR],$2}' eseuc${NUMBER}.dat vdweuc${NUMBER}.dat > fps${NUMBER}.dat
   #grep "Ph4_Score"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/ga_output.restart${NUMBER}.mol2 | awk '{print $3}' > ph4${NUMBER}.dat
   #grep "Geometric Volume"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/ga_output.restart${NUMBER}.mol2 | awk '{print $5}' > gvol${NUMBER}.dat
   grep "Rank:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/ga_output.restart${NUMBER}.mol2 | awk '{print $3}' > rank${NUMBER}.dat
   grep "Crowding Distance"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/ga_output.restart${NUMBER}.mol2 | awk '{print $4}' > crowding${NUMBER}.dat
   grep "Fitness Score"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/ga_output.restart${NUMBER}.mol2 | awk '{print $4}' > fitness${NUMBER}.dat
   grep "Molecular Weight"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/ga_output.restart${NUMBER}.mol2 | awk '{print $4}' > mw${NUMBER}.dat
   grep "Rotatable Bonds"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/ga_output.restart${NUMBER}.mol2 | awk '{print $4}' > rotb${NUMBER}.dat
   grep "Hydrogen Acceptors"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/ga_output.restart${NUMBER}.mol2 | awk '{print $4}' > ha${NUMBER}.dat
   grep "Hydrogen Donors"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/ga_output.restart${NUMBER}.mol2 | awk '{print $4}' > hd${NUMBER}.dat
   grep "Formal Charge"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/ga_output.restart${NUMBER}.mol2 | awk '{print $4}' > charge${NUMBER}.dat

   #grep "vdw_fp:" footprint${NUMBER}.output_scored.mol2 | awk '{print $3}' > vdweuc${NUMBER}.dat
   #grep "es_fp:" footprint${NUMBER}.output_scored.mol2 | awk '{print $3}' > eseuc${NUMBER}.dat
   #grep "FPS_Score" footprint${NUMBER}.output_scored.mol2 | awk '{print $3}' > fpstemp${NUMBER}.dat
   #grep "Ph4_Score" pharm${NUMBER}.output_scored.mol2 | awk '{print $3}' > ph4temp${NUMBER}.dat
   #sort -n fpstemp${NUMBER}.dat > fps${NUMBER}.dat
   #sort -n ph4temp${NUMBER}.dat > ph4${NUMBER}.dat
   #rm fpstemp${NUMBER}.dat
   #rm ph4temp${NUMBER}.dat
   #if you want to zip the results up after analysis
   #gzip -f ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2
   #gzip -f ${WORKDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/unique_crossover${NUMBER}.mol2
  
done 

# GENERATION ZERO info - this will change depending on the input file
export INPUTFILE="zzz.restart0.mol2"
if [ -e "${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE}.gz" ];
then 
   gunzip -f ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE}.gz
fi
grep "MultiGrid Score" ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $4}' > gen00.dat
grep "Descriptor_Score"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $3}' > descript00.dat
grep "MultiGrid_vdw"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $3}' > mg_vdw00.dat
grep "MultiGrid_es"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $3}' > mg_es00.dat
awk 'NR==FNR{a[NR]=$1;next}{print $1+a[FNR],$2}' mg_vdw00.dat mg_es00.dat > mg00.dat
grep "vdweuc" ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $3}' > vdweuc00.dat
grep "eseuc" ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $3}' > eseuc00.dat
 awk 'NR==FNR{a[NR]=$1;next}{print $1+a[FNR],$2}' eseuc00.dat vdweuc00.dat > fps00.dat
#grep "Ph4_Score" ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $3}' > ph400.dat
#grep "Geometric Volume"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $5}' > gvol00.dat
grep "Rank:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $3}' > rank00.dat
grep "Crowding Distance"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $4}' > crowding00.dat
grep "Fitness Score"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $4}' > fitness00.dat
grep "Molecular Weight"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $4}' > mw00.dat
grep "Rotatable Bonds"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $4}' > rotb00.dat
grep "Hydrogen Acceptors"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $4}' > ha00.dat
grep "Hydrogen Donors"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $4}' > hd00.dat
grep "Formal Charge"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $4}' > charge00.dat
#grep "vdw_fp:" parents.footprint.output_scored.mol2 | awk '{print $3}' > vdweuc00.dat
#grep "es_fp:" parents.footprint.output_scored.mol2 | awk '{print $3}' > eseuc00.dat
#grep "FPS_Score:" parents.footprint.output_scored.mol2 | awk '{print $3}' > fpstemp00.dat
#grep "Ph4_Score" parents.pharm.output_scored.mol2 | awk '{print $3}' > ph4temp00.dat
#cp ${PRINTDIR}/${masterdir}/vs_50_rescored_SGE.dat gen00.dat


#HAVE TO SORT THE INFO BASED ON THE SCORE. NEED TO GET A MOL2 as well
#sort -n fpstemp00.dat > fps00.dat
#sort -n ph4temp00.dat > ph400.dat
#rm fpstemp00.dat
#rm ph4temp00.dat
gzip -f ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE}.gz

       done
	fi
	done
done
exit
