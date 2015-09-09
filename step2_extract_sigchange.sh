#!/bin/bash

#This script will concatenate extracted signal output for all subjects into a single file 'roi_pe_Results.txt'

for j in TIME_01 TIME_02 TIME_03 TIME_04 TIME_05 TIME_06 TIME_07 TIME_08 TIME_09 TIME_10 TIME_11 TIME_12 TIME_13 TIME_14 TIME_15 TIME_16 TIME_17 TIME_18;  do

          for n in hippmask; do
             
               for i in 1 2 3 4 5 6 7 8; do
         
					echo "storing: " ${j}
					
					cd /Volumes/Sath/VMEM7MR/extracted_signals

					for filename in /Volumes/Sath/VMEM7MR/Analysis/${j}/new_${j}_fixed.gfeat/cope${i}.feat/${n}/report.txt;  do
					#All featquery outputs appended to Results_${n}.txt
     				echo Printing \'${filename}\'
    				cat ${filename} >> Result_${n}.txt
    				 
    				done
				done
          done
done
         
              
for n in hippmask; do
         
		echo ${n}

		cd  /Volumes/Sath/VMEM7MR/extracted_signals/
		# Parameter estimates extracted from Results_${n}.txt and appended to 'roi_pe_Results${n}.txt'
		grep "stats/pe" Result_${n}.txt >> out_pe_Result${n}.txt
		cat Result_${n}.txt | grep "stats/pe" | awk '{print $6}' >> roi_pe_Result${n}.txt
		
		#mv roi_result_* ~/Trash/;
		#mv out_pe_* ~/Trash/;

done

