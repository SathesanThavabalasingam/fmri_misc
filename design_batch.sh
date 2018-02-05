#!/bin/bash
# reads template design.fsf file and generates for all subjects and run that is
# subsequently used to run analyses in parallel. Should be modified to cater
# the level of analysis. For group-level stats 'j' should indicate series of
# copes that will be run.


for j in 01 02;  do
for r in 1 2 3; do
echo "RUN:" ${r}
echo "Dataset: " ${j}
nvols=`fslnvols /Volumes/Sath/VMEM7MR/Raw/TIME_${j}/TIME_${j}_run${r}.nii`
echo "Volumes: " $nvols #number of raw volumes for the subject being run

cat /Volumes/Sath/VMEM7MR/Analysis/preprocdesign.fsf |sed "s/run1/run${r}/g" |sed "s/01/${j}/g" |sed "s/351/${nvols}/g">/Volumes/Sath/VMEM7MR/Analysis/tmp_s${j}_r${r}.fsf ;

done
done
