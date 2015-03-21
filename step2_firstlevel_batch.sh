#!/bin/bash
for j in 01;  do
for r in 2 3; do
echo "RUN:" ${r}
echo "Dataset: " ${j}
nvols=`fslnvols /Volumes/Sath/VMEM7MR/Raw/TIME_${j}/TIME_${j}_run${r}.nii`
echo "Volumes: " $nvols #number of raw volumes for the subject being run

##iterate through runs and subjects to produce tmp .fsf files. Uses to run analyses in parallel##
cat /Volumes/Sath/VMEM7MR/Analysis/firstleveldesign.fsf |sed "s/run1/run${r}/g" |sed "s/01/${j}/g" |sed "s/351/${nvols}/g">/Volumes/Sath/VMEM7MR/Analysis/tmp_s${j}_r${r}.fsf ;
#cd /synapse/Danielle/Imp_Scns/analyses/${j};
#feat /synapse/Danielle/Imp_Scns/analyses/${j}/tmp_s${j}.fsf;

done
done

