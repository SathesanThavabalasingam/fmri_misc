#!/bin/bash
#This generates Full firstlevel fsf's as well as per trial betas for the subegs specified on the #3 lines below

#for subj in {003..016}
#do
#for imagine in 1 2
#do
#for trial in {1..16}
#do
#echo "/usr/lib/fsl/5.0/feat /psyhome/u7/tayjonat/Documents/gapclass/york/fsf_files/multivariate/pertrialbetas/${subj}_imagine${imagine}trial${trial}.fsf" > tmpscript
#echo "Submitted .fsf file for ${subj} imagine${imagine} trial${trial} to qmon!"
#qsub -q all.q tmpscript ;

#done
#done
#done

for subj in {001..018}
do
for gap in {1..2}
do
for trial in {1..16}
#for trial in 17 18
do
echo "/usr/lib/fsl/5.0/feat /psyhome/u7/tayjonat/Documents/gapclass/york/fsf_files/multivariate/pertrialbetas/${subj}_imagine${gap}trial${trial}.fsf" > tmpscript
echo "Submitted .fsf file for ${subj} gap${gap} trial${trial} to qmon!"
qsub -q all.q tmpscript ;

done
done
done
