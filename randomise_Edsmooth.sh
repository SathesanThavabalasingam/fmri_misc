#!/bin/bash
#$ -cwd
#$ -pe smp

export FSLPARALLEL=true

##MODIFY THE FOLLOWING
for contrst in 13 ; do  #{11..14}

######

echo "CONTRAST:" ${contrst}

#full brain
#echo "/usr/share/fsl/5.0/bin/randomise -i ~/Documents/gapclass/york/univariate/full_analysis/Edsmooth/all/gap_rem/contrast${contrst}.gfeat/cope1.feat/filtered_func_data.nii.gz -o ~/Documents/gapclass/york/univariate/full_analysis/Edsmooth/all/gap_rem/contrast${contrst}.gfeat/cope1.feat/OneSampT -1 -T -n 10000" >tmpscript
#qsub -q all.q tmpscript ;

#rois
for roi in hc_mask.nii.gz ; do   #ppa_mask.nii rsc.nii
echo "/usr/share/fsl/5.0/bin/randomise -i ~/Documents/gapclass/york/univariate/full_analysis/Edsmooth/all/gap_rem/contrast${contrst}.gfeat/cope1.feat/filtered_func_data.nii.gz -o ~/Documents/gapclass/york/univariate/full_analysis/Edsmooth/all/gap_rem/contrast${contrst}.gfeat/cope1.feat/randomise_${roi} -1 -T -m /archive/tayjonat/univariate/smoothed/all/masks/${roi} -n 100000" > tmpscript
qsub -q all.q tmpscript ;

done
done
