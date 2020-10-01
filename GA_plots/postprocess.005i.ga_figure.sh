#!/bin/bash

#
# This script will first minimize the ligand in Cartesian space using 6-12 VDW exponents.
# After minimizing, the ligand is rescored using the footprint score (also in Cartesian space,
# 6-12 VDW exponents). It is recommended to use VDW and ES cutoffs of 1 kcal/mol and 0.5 kcal/mol,
# respectively. After the rescore, a list of the "primary" residues is compiled, and a
# reference.txt file of per-residue interactions is created to be used as the reference for the
# forthcoming multigrid minimization.
#


export WORKDIR="/gpfs/projects/rizzo/csingleton/GA/2015.ga_experiments/new_systems"
export PRINTDIR="/gpfs/projects/rizzo/csingleton/GA/2015.ga_experiments/new_systems"
export FAMILYDIR="zzz.families"
export SYSTEMDIR="zzz.systems"
export DATA="zzz.data_analysis"
export SCRIPTDIR="zzz.scripts"
export FINALDIR="yyy.GA_paper_properties"

export MAX_GEN="1000"


	cd ${PRINTDIR}
	#rm -r ${FINALDIR}
	mkdir -p ${FINALDIR}
#for FAMILY in ` cat ${WORKDIR}/${FAMILYDIR}/list_of_families.dat `
#for  FAMILY in "BETA-TRYPSIN"
for FAMILY in "ESTROGEN_RECEPTOR" "NEURAMINIDASE" "REVERSE_TRANSCRIPTASE" "THROMBIN"
#for FAMILY in "ESTROGEN_RECEPTOR" "THROMBIN"
#for FAMILY in "ESTROGEN_RECEPTOR"
#for FAMILY in "NEURAMINIDASE"
#for FAMILY in "REVERSE_TRANSCRIPTASE"
#for FAMILY in "THROMBIN"
#for FAMILY in "NEURAMINIDASE" "REVERSE_TRANSCRIPTASE" "THROMBIN"
#for FAMILY in "HMG_COA_REDUCTASE" "REVERSE_TRANSCRIPTASE" "THROMBIN"
do
	cd ${PRINTDIR}/${FINALDIR}/
	mkdir -p ${FAMILY}

        for REC in `cat ${WORKDIR}/${FAMILYDIR}/${FAMILY}_rec.dat`
        do

		if [ ${FAMILY} == "ESTROGEN_RECEPTOR" ]; then
			export YMIN="-120"
			export YMAX="20"
		fi
		if [ ${FAMILY} == "NEURAMINIDASE" ]; then
			export YMIN="-140"
			export YMAX="-20"
		fi
		if [ ${FAMILY} == "REVERSE_TRANSCRIPTASE" ]; then
			export YMIN="-115"
			export YMAX="-30"
		fi
		if [ ${FAMILY} == "THROMBIN" ]; then
			export YMIN="-110"
			export YMAX="-40"
		fi

	#for TESTDIR in `cat ${WORKDIR}/zzz.experiments/pmut_EXPERIMENTA_complete.txt`
	#for TESTDIR in "016g.r_pvc_yc_nn_yp_rand_grid_vol_lipinski"
	#for TESTDIR in "014h.e_max_yc_nn_yp_rand_grid_vol_lipinski" "015j.t_pvc_yc_nn_yp_rand_grid_vol_lipinski" "016g.r_pvc_yc_nn_yp_rand_grid_vol_lipinski"
	#for TESTDIR in "NOE.HALF.UPDATED.R.ye.E_T.1mol.014k.e_max_yc_yn_share_yp_rand_ye_mg_ph4_vol" "NOE.UPDATED.R.ye.E_T.1mol.014k.e_max_yc_yn_share_yp_rand_ye_mg_ph4_vol" "NOE.UPDATED.R.ye.E_R.1mol.014k.e_max_yc_yn_share_yp_rand_ye_mg_ph4_vol" "NOE.HALF.UPDATED.R.ye.E_R.1mol.014k.e_max_yc_yn_share_yp_rand_ye_mg_ph4_vol"
	for TESTDIR in "UPDATED.R.ye.E_R.1mol.014k.e_max_yc_yn_share_yp_rand_ye_mg_ph4_vol" "UPDATED.R.ye.E_T.1mol.014k.e_max_yc_yn_share_yp_rand_ye_mg_ph4_vol"
	#for TESTDIR in "014h.e_max_yc_nn_yp_rand_grid_vol_lipinski"
	do

		cd ${WORKDIR}/${SYSTEMDIR}/${FAMILY}/${TESTDIR}/${DATA}
		pwd
		if [ -e "descript00.dat" ];
		then
			cp descript00.dat descript0.dat
		fi
		if [ -e "fps00.dat" ];
		then
			cp fps00.dat fps0.dat
		fi
		if [ -e "mg00.dat" ];
		then
			cp mg00.dat mg0.dat
		fi
		if [ -e "gvol00.dat" ];
		then
			cp gvol00.dat gvol0.dat
		fi

		python ${WORKDIR}/${SCRIPTDIR}/figure_descript_std_all_updated.py ${MAX_GEN} descript ${FAMILY}
		python ${WORKDIR}/${SCRIPTDIR}/figure_descript_TOP_all_LARGER.py ${MAX_GEN} descript ${FAMILY}
		#python ${WORKDIR}/${SCRIPTDIR}/figure_descript_std_all_updated.py ${MAX_GEN} grid ${FAMILY}
		#python ${WORKDIR}/${SCRIPTDIR}/figure_descript_std_all_updated.py ${MAX_GEN} grid_es ${FAMILY}
		#python ${WORKDIR}/${SCRIPTDIR}/figure_descript_std_all_updated.py ${MAX_GEN} grid_vdw ${FAMILY}
		#python ${WORKDIR}/${SCRIPTDIR}/figure_descript_std_all_updated.py ${MAX_GEN} gvol ${FAMILY}


		# FOR  MOL PROPERTIES
		if [ -e "mw00.dat" ]; then
			cp mw00.dat mw0.dat
		fi
		if [ -e "rotb00.dat" ]; then
			cp rotb00.dat rotb0.dat
		fi
		if [ -e "charge00.dat" ]; then
			cp charge00.dat charge0.dat
		fi
		if [ -e "ha00.dat" ]; then
			cp ha00.dat ha0.dat
		fi
		if [ -e "hd00.dat" ]; then
			cp hd00.dat hd0.dat
		fi
		python ${WORKDIR}/${SCRIPTDIR}/figure_descript_std_all_updated.py ${MAX_GEN} mw ${FAMILY}
		python ${WORKDIR}/${SCRIPTDIR}/figure_descript_std_all_updated.py ${MAX_GEN} rotb ${FAMILY}
		python ${WORKDIR}/${SCRIPTDIR}/figure_descript_std_all_updated.py ${MAX_GEN} charge ${FAMILY}
		python ${WORKDIR}/${SCRIPTDIR}/figure_descript_std_all_updated.py ${MAX_GEN} ha ${FAMILY}
		python ${WORKDIR}/${SCRIPTDIR}/figure_descript_std_all_updated.py ${MAX_GEN} hd ${FAMILY}

		echo Printing Fitness STD Plot
		#python ${WORKDIR}/${SCRIPTDIR}/figure_data.py ${MAX_GEN} descript ${FAMILY} ${YMIN} ${YMAX}
		#python ${WORKDIR}/${SCRIPTDIR}/figure_descript_std_all_updated_ylim.py ${MAX_GEN} descript ${FAMILY} ${YMIN} ${YMAX}
		#cp figure_${FAMILY}_descript_std_assymetric.png ${WORKDIR}/${FINALDIR}/${FAMILY}/${TESTDIR}.figure_${FAMILY}_descript_std_assymetric.png
	
		#echo Printing Fitness Compoenets Plots
		#python ${WORKDIR}/${SCRIPTDIR}/figure_descript_std_all_components_scatter_updated_ylim.py ${MAX_GEN} ${FAMILY} -150 50 descript grid_vdw grid_es gvol 
		#cp figure_${FAMILY}_descript_std_wComponentsScatter.png ${WORKDIR}/${FINALDIR}/${FAMILY}/${TESTDIR}.figure_${FAMILY}_descript_std_wComponentsScatter.png
		#python ${WORKDIR}/${SCRIPTDIR}/figure_descript_std_all_components_scatter_updated_ylim.py ${MAX_GEN} ${FAMILY} -150 50 descript grid gvol 
		#cp figure_${FAMILY}_descript_std_wComponentsScatter2.png ${WORKDIR}/${FINALDIR}/${FAMILY}/${TESTDIR}.figure_${FAMILY}_descript_std_wComponentsScatter2.png
		#python ${WORKDIR}/${SCRIPTDIR}/figure_footprint_scatter_multi.py  ${MAX_GEN} ${FAMILY} fps mg
		#python ${WORKDIR}/${SCRIPTDIR}/figure_footprint_scatter_multi_sharex.py  ${MAX_GEN} ${FAMILY} grid gvol
		#cp *_fitnessComponents.png ${WORKDIR}/${FINALDIR}/${FAMILY}/${TESTDIR}.figure_${FAMILY}_descript_fitnessComponents.png
		#cp *_fitnessComponentsReversed.png ${WORKDIR}/${FINALDIR}/${FAMILY}/${TESTDIR}.figure_${FAMILY}_descript_fitnessComponentsReversed.png

	done



	
	#COMPARE DIFFERENT TYPES
	cd ${PRINTDIR}/${FINALDIR}/
	mkdir -p ${FAMILY}
	cd ${FAMILY}
	#for TESTDIR in "014h.e_max_yc_nn_yp_rand_grid_vol_lipinski" "015j.t_pvc_yc_nn_yp_rand_grid_vol_lipinski" "016g.r_pvc_yc_nn_yp_rand_grid_vol_lipinski"
	#do
	export dirOne="${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/014h.e_max_yc_nn_yp_rand_grid_vol_lipinski/${DATA}"
	export dirTwo="${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/015j.t_pvc_yc_nn_yp_rand_grid_vol_lipinski/${DATA}"
	export dirThree="${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/016g.r_pvc_yc_nn_yp_rand_grid_vol_lipinski/${DATA}"
		if [ ${FAMILY} == "ESTROGEN_RECEPTOR" ]; then
			export YMIN="-120"
			export YMAX="-60"
		fi
		if [ ${FAMILY} == "NEURAMINIDASE" ]; then
			export YMIN="-130"
			export YMAX="-90"
		fi
		if [ ${FAMILY} == "REVERSE_TRANSCRIPTASE" ]; then
			export YMIN="-120"
			export YMAX="-80"
		fi
		if [ ${FAMILY} == "THROMBIN" ]; then
			export YMIN="-110"
			export YMAX="-80"
		fi
	#OLDpython ${WORKDIR}/${SCRIPTDIR}/figure_multi_descript_std_all_updated_ylim.py ${MAX_GEN} descript ${FAMILY} ${YMIN} ${YMAX} ${dirOne} ${dirTwo} ${dirThree} 
	#OLDpython ${WORKDIR}/${SCRIPTDIR}/figure_multi_descript_std_all_updated_ylim_LARGER.py ${MAX_GEN} descript ${FAMILY} ${YMIN} ${YMAX} ${dirOne} ${dirTwo} ${dirThree} 
	#python ${WORKDIR}/${SCRIPTDIR}/figure_multi_descript_TOP_all_updated_ylim_LARGER.py ${MAX_GEN} descript ${FAMILY} ${YMIN} ${YMAX} ${dirOne} ${dirTwo} ${dirThree} 
	#done

	#for SUB in "014h.e_max_yc_nn_yp_rand_grid_vol" 
	for SUB in "016g.r_pvc_yc_nn_yp_rand_grid_vol"
	do
	export dirOne="${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${SUB}_lipinski/${DATA}"
	export dirTwo="${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${SUB}_seed2_lipinski/${DATA}"
	export dirThree="${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${SUB}_seed3_lipinski/${DATA}"
	export dirFour="${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${SUB}_seed4_lipinski/${DATA}"
	export dirFive="${PRINTDIR}/${SYSTEMDIR}/${FAMILY}/${SUB}_seed5_lipinski/${DATA}"
		if [ ${FAMILY} == "ESTROGEN_RECEPTOR" ]; then
			export YMIN="-120"
			export YMAX="20"
		fi
		if [ ${FAMILY} == "NEURAMINIDASE" ]; then
			export YMIN="-140"
			export YMAX="0"
		fi
		if [ ${FAMILY} == "REVERSE_TRANSCRIPTASE" ]; then
			export YMIN="-115"
			export YMAX="-15"
		fi
		if [ ${FAMILY} == "THROMBIN" ]; then
			export YMIN="-110"
			export YMAX="-40"
		fi
	#python ${WORKDIR}/${SCRIPTDIR}/figure_multi_descript_std_all_updated_ylim_multiExp.py ${MAX_GEN} descript ${FAMILY} ${YMIN} ${YMAX} ${dirOne} ${dirTwo} ${dirThree} ${dirFour} ${dirFive}
	#python ${WORKDIR}/${SCRIPTDIR}/figure_multi_descript_std_all_ylim_multiExp_modified.py ${MAX_GEN} descript ${FAMILY} ${YMIN} ${YMAX} ${dirOne} ${dirTwo} ${dirThree} ${dirFour} ${dirFive}
	#python ${WORKDIR}/${SCRIPTDIR}/figure_multi_descript_std_all_ylim_multiExp_splitY_larger.py ${MAX_GEN} descript 016g.${FAMILY} ${YMIN} ${YMAX} ${dirOne} ${dirTwo} ${dirThree} ${dirFour} ${dirFive}
	done
	done
done	
