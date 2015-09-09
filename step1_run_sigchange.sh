#!/bin/bash

#This script is used to extract signal change from a predefined region of interest 

for j in TIME_01 TIME_02 TIME_03 TIME_04 TIME_05 TIME_06 TIME_07 TIME_08 TIME_09 TIME_10 TIME_11 TIME_12 TIME_13 TIME_14 TIME_15 TIME_16 TIME_17 TIME_18;  do


     for i in 1 2 3 4 5 6 7 8; do # cope number
    
          for n in hippmask; do #name of mask, *w/o .nii.gz*
                   
echo "${j} cope${i} mask ${n}"

featquery 1 /Volumes/Sath/VMEM7MR/Analysis/${j}/new_${j}_fixed.gfeat/cope${i}.feat 1 stats/pe1 ${n} -p -s /Volumes/Sath/VMEM7MR/masks/${n}.nii

done
     done
          done
