#!/bin/bash

#
# This script will first minimize the ligand in Cartesian space using 6-12 VDW exponents.
# After minimizing, the ligand is rescored using the footprint score (also in Cartesian space,
# 6-12 VDW exponents). It is recommended to use VDW and ES cutoffs of 1 kcal/mol and 0.5 kcal/mol,
# respectively. After the rescore, a list of the "primary" residues is compiled, and a
# reference.txt file of per-residue interactions is created to be used as the reference for the
# forthcoming multigrid minimization.
#


export PRINTDIR="/gpfs/projects/rizzo/csingleton/GA/2015.ga_experiments/new_systems"
export WORKDIR="/gpfs/projects/rizzo/csingleton/GA/2015.ga_experiments/new_systems"
export FAMILYDIR="zzz.families"
export SYSTEMDIR="zzz.systems"
export DATA="zzz.data_analysis"
export SCRIPTDIR="zzz.scripts"

export MAX_GEN="1000"

#for FAMILY in ` cat ${WORKDIR}/${FAMILYDIR}/list_of_families.dat `
#for FAMILY in "BETA-TRYPSIN" "ESTROGEN_RECEPTOR" "FACTOR_XA" "HIV_PROTEASE" "HMG_COA_REDUCTASE" "NEURAMINIDASE" "REVERSE_TRANSCRIPTASE" "THERMOLYSIN" "THROMBIN" "TYROSINE_PHOSPHATASE"
#for FAMILY in "ESTROGEN_RECEPTOR"
#for FAMILY in "ESTROGEN_RECEPTOR" "NEURAMINIDASE" "REVERSE_TRANSCRIPTASE" "THROMBIN"
#for FAMILY in "NEURAMINIDASE" "REVERSE_TRANSCRIPTASE" "THROMBIN"
#for FAMILY in "NEURAMINIDASE"
for FAMILY in "THROMBIN"
do
        export FILE="${FAMILY}.test.GA.out"
        #export FILE="check.out"

	for TESTDIR in "S.ne.1mol.014k.e_max_yc_nn_share_yp_rand_ne_mg_ph4_vol"
	#for TESTDIR in "NOE.HALF.UPDATED.R.ye.E_R.1mol.014k.e_max_yc_yn_share_yp_rand_ye_mg_ph4_vol"
	#for TESTDIR in "NOE.HALF.UPDATED.R.ye.E_T.1mol.014k.e_max_yc_yn_share_yp_rand_ye_mg_ph4_vol" "NOE.UPDATED.R.ye.E_T.1mol.014k.e_max_yc_yn_share_yp_rand_ye_mg_ph4_vol" "NOE.UPDATED.R.ye.E_R.1mol.014k.e_max_yc_yn_share_yp_rand_ye_mg_ph4_vol" "NOE.HALF.UPDATED.R.ye.E_R.1mol.014k.e_max_yc_yn_share_yp_rand_ye_mg_ph4_vol"
	#for TESTDIR in "NOE.HALF.UPDATED.S.ye.E_T.1mol.014k.e_max_yc_yn_share_yp_rand_ye_mg_ph4_vol" "NOE.UPDATED.S.ye.E_T.1mol.014k.e_max_yc_yn_share_yp_rand_ye_mg_ph4_vol" "NOE.UPDATED.S.ye.E_R.1mol.014k.e_max_yc_yn_share_yp_rand_ye_mg_ph4_vol" "NOE.HALF.UPDATED.S.ye.E_R.1mol.014k.e_max_yc_yn_share_yp_rand_ye_mg_ph4_vol"

	#for TESTDIR in "UPDATED.R.ye.E_R.1mol.014k.e_max_yc_yn_share_yp_rand_ye_mg_ph4_vol" "UPDATED.R.ye.E_T.1mol.014k.e_max_yc_yn_share_yp_rand_ye_mg_ph4_vol"
	#for TESTDIR in "014g.e_max_nc_nn_yp_rand_grid_vol_lipinski" "015d.t_npvc_nc_nn_yp_rand_grid_vol_lipinski" "016c.r_yc_nn_yp_rand_grid_vol_lipinski"
        #for TESTDIR in "dude.016g.r_pvc_yc_nn_yp_rand_grid_vol_lipinski/dude_decoys"
	#for TESTDIR in "dude.016g.r_pvc_yc_nn_yp_rand_grid_vol_lipinski"
#for TESTDIR in `cat ${WORKDIR}/zzz.experiments/pmut_EXPERIMENTB_comprehensive.txt`
#for TESTDIR in "014h.e_max_yc_nn_yp_rand_grid_vol_seed2_lipinski" "014h.e_max_yc_nn_yp_rand_grid_vol_seed3_lipinski" "014h.e_max_yc_nn_yp_rand_grid_vol_seed4_lipinski" "014h.e_max_yc_nn_yp_rand_grid_vol_seed5_lipinski"
#for TESTDIR in "015j.t_pvc_yc_nn_yp_rand_grid_vol_seed2_lipinski" "015j.t_pvc_yc_nn_yp_rand_grid_vol_seed3_lipinski" "015j.t_pvc_yc_nn_yp_rand_grid_vol_seed4_lipinski" "015j.t_pvc_yc_nn_yp_rand_grid_vol_seed5_lipinski"
#for TESTDIR in "016g.r_pvc_yc_nn_yp_rand_grid_vol_seed2_lipinski" "016g.r_pvc_yc_nn_yp_rand_grid_vol_seed3_lipinski" "016g.r_pvc_yc_nn_yp_rand_grid_vol_seed4_lipinski" "016g.r_pvc_yc_nn_yp_rand_grid_vol_seed5_lipinski"
#for TESTDIR in "014h.e_max_yc_nn_yp_rand_grid_vol_lipinski" "015j.t_pvc_yc_nn_yp_rand_grid_vol_lipinski" "016g.r_pvc_yc_nn_yp_rand_grid_vol_lipinski"
#for TESTDIR in "014h.e_max_yc_nn_yp_rand_mg_cutoff" "015j.t_pvc_yc_nn_yp_rand_mg_cutoff"
#for TESTDIR in "014h.e_max_yc_nn_yp_rand_mg_lipinski" "014h.e_max_yc_nn_yp_rand_grid_vol_cutoff" "014h.e_max_yc_nn_yp_rand_grid_vol_lipinski" "015j.t_pvc_yc_nn_yp_rand_mg_lipinski" "015j.t_pvc_yc_nn_yp_rand_grid_vol_cutoff" "015j.t_pvc_yc_nn_yp_rand_grid_vol_lipinski"
#for TESTDIR in "dude.015j.t_pvc_nc_nn_yp_rand_mg/dude_actives"
#for TESTDIR in "016g.r_pvc_yc_nn_yp_rand_mg.correct"
#for TESTDIR in "014h.e_max_yc_nn_yp_rand_mg"
do
	cd ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}
	echo ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}

	#if [ -e "${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${MAX_GEN}.mol2.gz" ]  || [ -e "${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${MAX_GEN}.mol2" ]; 
	#then

        rm -r ${DATA}
        mkdir -p ${DATA}
	cd ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${DATA}

        for REC in `cat ${WORKDIR}/${FAMILYDIR}/${FAMILY}_rec.dat`
        do

        ### Remove any dat files that exist
        #rm *.dat

	## Un-gzip
	if [ -e "${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE}.gz" ];
	then 
		gunzip -f ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE}.gz
		sleep 2
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
grep "Successful parent subsitutions:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > success_psub.dat
grep "Successful parent subsitutions:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $6}' > attempts_psub.dat
grep "Successful parent replacements:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > success_prep.dat
grep "Successful parent replacements:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $6}' > attempts_prep.dat


# FOR OFFSPRING
# Success rates
grep "Successful offspring deletions:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > success_odel.dat
grep "Successful offspring deletions:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $6}' > attempts_odel.dat
grep "Successful offspring addition"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > success_oadd.dat
grep "Successful offspring addition"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $6}' > attempts_oadd.dat
grep "Successful offspring subsitutions:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $4}' > success_osub.dat
grep "Successful offspring subsitutions:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE} | awk '{print $6}' > attempts_osub.dat
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


# MUltigrid only from zzz.restart*.mol2
#export START=1
#for NUMBER in {${START}..${MAX_GEN}} 
for NUMBER in {0..1000}
do
   if [ -e "${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2.gz" ];
   then 
   gunzip -f ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2.gz
   sleep 2
   fi
   #echo ${NUMBER}
   # GRID SCORE
   grep "Descriptor_Score"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2 | awk '{print $3}' > descript${NUMBER}.dat
   grep "Grid_vdw"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2 | awk '{print $3}' > grid_vdw${NUMBER}.dat
   grep "Grid_es"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2 | awk '{print $3}' > grid_es${NUMBER}.dat
   grep "Grid Score"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2 | awk '{print $4}' > grid${NUMBER}.dat

   # FPS
   #grep "vdweuc"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2 | awk '{print $3}' > vdweuc${NUMBER}.dat
   #grep "eseuc"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2 | awk '{print $3}' > eseuc${NUMBER}.dat
  #awk 'NR==FNR{a[NR]=$1;next}{print $1+a[FNR],$2}' eseuc${NUMBER}.dat vdweuc${NUMBER}.dat > fps${NUMBER}.dat
   #grep "Ph4_Score"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2 | awk '{print $3}' > ph4${NUMBER}.dat
   grep "Geometric Volume"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2 | awk '{print $5}' > gvol${NUMBER}.dat
   grep "Rank:"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2 | awk '{print $3}' > rank${NUMBER}.dat
   grep "Crowding Distance"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2 | awk '{print $4}' > crowding${NUMBER}.dat
   grep "Fitness Score"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2 | awk '{print $4}' > fitness${NUMBER}.dat
   grep "Molecular Weight"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2 | awk '{print $4}' > mw${NUMBER}.dat
   grep "Rotatable Bonds"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2 | awk '{print $4}' > rotb${NUMBER}.dat
   grep "Hydrogen Acceptors"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2 | awk '{print $4}' > ha${NUMBER}.dat
   grep "Hydrogen Donors"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2 | awk '{print $4}' > hd${NUMBER}.dat
   grep "Formal Charge"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2 | awk '{print $4}' > charge${NUMBER}.dat

   #grep "vdw_fp:" footprint${NUMBER}.output_scored.mol2 | awk '{print $3}' > vdweuc${NUMBER}.dat
   #grep "es_fp:" footprint${NUMBER}.output_scored.mol2 | awk '{print $3}' > eseuc${NUMBER}.dat
   #grep "FPS_Score" footprint${NUMBER}.output_scored.mol2 | awk '{print $3}' > fpstemp${NUMBER}.dat
   #grep "Ph4_Score" pharm${NUMBER}.output_scored.mol2 | awk '{print $3}' > ph4temp${NUMBER}.dat
   #sort -n fpstemp${NUMBER}.dat > fps${NUMBER}.dat
   #sort -n ph4temp${NUMBER}.dat > ph4${NUMBER}.dat
   #rm fpstemp${NUMBER}.dat
   #rm ph4temp${NUMBER}.dat
   gzip -f ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart${NUMBER}.mol2
   gzip -f ${WORKDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/unique_crossover${NUMBER}.mol2
  
done 

# GENERATION ZERO info - this will change depending on the input file
export INPUTFILE="zzz.restart0.mol2"
if [ -e "${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE}.gz" ];
then 
   gunzip -f ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE}.gz
   sleep 2
fi
   grep "Grid_vdw"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart0.mol2 | awk '{print $3}' > grid_vdw00.dat
   grep "Grid_es"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart0.mol2 | awk '{print $3}' > grid_es00.dat
   grep "Grid Score"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/zzz.restart0.mol2 | awk '{print $4}' > grid00.dat
grep "Descriptor_Score"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $3}' > descript00.dat
#grep "MultiGrid_vdw"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $3}' > mg_vdw00.dat
#grep "MultiGrid_es"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $3}' > mg_es00.dat
#awk 'NR==FNR{a[NR]=$1;next}{print $1+a[FNR],$2}' mg_vdw00.dat mg_es00.dat > mg00.dat
#grep "vdweuc" ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $3}' > vdweuc00.dat
#grep "eseuc" ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $3}' > eseuc00.dat
# awk 'NR==FNR{a[NR]=$1;next}{print $1+a[FNR],$2}' eseuc00.dat vdweuc00.dat > fps00.dat
#grep "Ph4_Score" ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $3}' > ph400.dat
grep "Geometric Volume"  ${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${INPUTFILE} | awk '{print $5}' > gvol00.dat
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

export INCREMENT="100"
#python ${WORKDIR}/${SCRIPTDIR}/calc_increment_time.py timing.dat ${INCREMENT} > zzz.time_sum_increment.dat
#python ${WORKDIR}/${SCRIPTDIR}/calc_percent_mut.py success_padd.dat attempts_padd.dat ${INCREMENT} p_addition > zzz.mut_padd_percent.dat
#python ${WORKDIR}/${SCRIPTDIR}/calc_percent_mut.py success_pdel.dat attempts_pdel.dat ${INCREMENT} p_deletion > zzz.mut_pdel_percent.dat
#python ${WORKDIR}/${SCRIPTDIR}/calc_percent_mut.py success_psub.dat attempts_psub.dat ${INCREMENT} p_substitution > zzz.mut_psub_percent.dat
#python ${WORKDIR}/${SCRIPTDIR}/calc_percent_mut.py success_prep.dat attempts_prep.dat ${INCREMENT} p_replacement > zzz.mut_prep_percent.dat
#python ${WORKDIR}/${SCRIPTDIR}/calc_percent_mut.py success_oadd.dat attempts_oadd.dat ${INCREMENT} o_addition > zzz.mut_oadd_percent.dat
#python ${WORKDIR}/${SCRIPTDIR}/calc_percent_mut.py success_odel.dat attempts_odel.dat ${INCREMENT} o_deletion > zzz.mut_odel_percent.dat
#python ${WORKDIR}/${SCRIPTDIR}/calc_percent_mut.py success_osub.dat attempts_osub.dat ${INCREMENT} o_substitution > zzz.mut_osub_percent.dat
#python ${WORKDIR}/${SCRIPTDIR}/calc_percent_mut.py success_orep.dat attempts_orep.dat ${INCREMENT} o_replacement > zzz.mut_orep_percent.dat

#run script to make first excel sheet with gen, parents, cross, premut, muts, final size, timins
#python ${WORKDIR}/${SCRIPTDIR}/data.to.excel1b.py > zzz.results1b.dat
#python ${WORKDIR}/${SCRIPTDIR}/data.to.excel_pmut.py > zzz.results_pmuts.dat

#export MAX_GEN=`wc -l zzz.data_analysis/timing.dat`
#echo ${MAX_GEN}

#python ${WORKDIR}/${SCRIPTDIR}/energy_scatter_plot11.16.15.py ${MAX_GEN} ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_all.01.28.16.py ${MAX_GEN} descript ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_all.01.28.16.py ${MAX_GEN} mg ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_all.01.28.16.py ${MAX_GEN} vdweuc ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_all.01.28.16.py ${MAX_GEN} eseuc ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_all.01.28.16.py ${MAX_GEN} fps ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_all.01.28.16.py ${MAX_GEN} ph4 ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_all.01.28.16.py ${MAX_GEN} grid ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_all.01.28.16.py ${MAX_GEN} gvol ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_all.01.28.16.py ${MAX_GEN} rotb ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_all.01.28.16.py ${MAX_GEN} ha ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_all.01.28.16.py ${MAX_GEN} hd ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_all.01.28.16.py ${MAX_GEN} charge ${FAMILY}

#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_all.01.28.16.py ${MAX_GEN} mw ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_top.01.28.16.py ${MAX_GEN} descript ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_top.01.28.16.py ${MAX_GEN} mg ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_top.01.28.16.py ${MAX_GEN} vdweuc ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_top.01.28.16.py ${MAX_GEN} eseuc ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_top.01.28.16.py ${MAX_GEN} fps ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_top.01.28.16.py ${MAX_GEN} ph4 ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_top.01.28.16.py ${MAX_GEN} gvol ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_top.01.28.16.py ${MAX_GEN} mw ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_top.01.28.16.py ${MAX_GEN} rotb ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_top.01.28.16.py ${MAX_GEN} ha ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_top.01.28.16.py ${MAX_GEN} hd ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/footprint_scatter_top.01.28.16.py ${MAX_GEN} charge ${FAMILY}


#python ${WORKDIR}/${SCRIPTDIR}/energy_std_plot11.16.15.py ${MAX_GEN} ${FAMILY}
#python ${WORKDIR}/${SCRIPTDIR}/energy_scatter_lastnum11.18.15.py ${MAX_GEN} ${FAMILY}
	
       gzip -f ${WORKDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${FILE}
       done
	#fi
	done
done
exit
