#!/bin/bash

######SEGMENTATION OF ROIS USING FIRST########################################################################
echo "Segmenting for each subject..."
for j in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22;  do

for r in L_Caud R_Caud L_Puta R_Puta ; do  #Change depending on what ROIs you require

echo "Dataset: " ${j} "roi" ${r}

cd /Volumes/Sath/VMEM7MR/Raw/TIME_${j}/

cp TIME_${j}_structural_brain.nii.gz /Volumes/Sath/segmented_T3

cd /Volumes/Sath/segmented_T3/

run_first_all -i TIME_${j}_structural_brain.nii.gz -o TIME_${j} -s ${r} -b
cp TIME_${j}-${r}_corr.nii.gz /Volumes/Sath/segmented_T3/masks/

done

done

########CONCATENATE ROIS (IF APPLICABLE)######################################################################
cd /Volumes/Sath/segmented_T3/masks/ 
echo "Now concatenating in to bilateral ROIs..."
for j in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22;  do

fslmaths TIME_${j}-L_Puta_corr.nii.gz -add TIME_${j}-R_Puta_corr.nii.gz TIME_${j}-bilateral_Puta.nii.gz
fslmaths TIME_${j}-L_Caud_corr.nii.gz -add TIME_${j}-R_Caud_corr.nii.gz TIME_${j}-bilateral_Caud.nii.gz

done

########BINARIZE AND CONVERT MASKS FOR SPM######################################################################
for j in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22;  do

for r in Caud Puta; do #List first structures w/o L/R; 

echo "Dataset: " ${j} 
echo "region of interest" ${r}

cd /Volumes/Sath/segmented_T3/masks/ 

echo "Running transformation on masks...."
/usr/local/fsl/bin/flirt -in /Volumes/Sath/segmented_T3/masks/TIME_${j}-bilateral_${r}.nii.gz -applyxfm -init /Volumes/Sath/segmented_T3/transform/TIME_${j}/TIME_${j}_run1/highres2example_func.mat -out /Volumes/Sath/segmented_T3/masks/TIME_${j}-bilateral_${r}_transf.nii.gz -paddingsize 0.0 -interp trilinear -ref /Volumes/Sath/Time3_data_0mm_sprlw/TIME_${j}_r1_data.nii.gz
/usr/local/fsl/bin/flirt -in /Volumes/Sath/segmented_T3/masks/TIME_${j}-L_${r}_corr.nii.gz -applyxfm -init /Volumes/Sath/segmented_T3/transform/TIME_${j}/TIME_${j}_run1/highres2example_func.mat -out /Volumes/Sath/segmented_T3/masks/TIME_${j}-L_${r}_corr_transf.nii.gz -paddingsize 0.0 -interp trilinear -ref /Volumes/Sath/Time3_data_0mm_sprlw/TIME_${j}_r1_data.nii.gz
/usr/local/fsl/bin/flirt -in /Volumes/Sath/segmented_T3/masks/TIME_${j}-R_${r}_corr.nii.gz -applyxfm -init /Volumes/Sath/segmented_T3/transform/TIME_${j}/TIME_${j}_run1/highres2example_func.mat -out /Volumes/Sath/segmented_T3/masks/TIME_${j}-R_${r}_corr_transf.nii.gz -paddingsize 0.0 -interp trilinear -ref /Volumes/Sath/Time3_data_0mm_sprlw/TIME_${j}_r1_data.nii.gz

echo "Thresholding & binarizing segmented masks for and putting in general masks directory..."
fslmaths TIME_${j}-bilateral_${r}_transf.nii.gz -thr .50 TIME_${j}-bilateral_${r}_transf_50
fslmaths TIME_${j}-bilateral_${r}_transf_50.nii.gz -bin /Volumes/Sath/VMEM7MR/masks/native_T3/TIME_${j}_bi_${r}mask

fslmaths TIME_${j}-L_${r}_corr_transf.nii.gz -thr .50  TIME_${j}-L_${r}_corr_transf_50
fslmaths TIME_${j}-L_${r}_corr_transf_50.nii.gz -bin /Volumes/Sath/VMEM7MR/masks/native_T3/TIME_${j}_left_${r}mask

fslmaths TIME_${j}-R_${r}_corr_transf.nii.gz -thr .50 TIME_${j}-R_${r}_corr_transf_50
fslmaths TIME_${j}-R_${r}_corr_transf_50.nii.gz -bin /Volumes/Sath/VMEM7MR/masks/native_T3/TIME_${j}_right_${r}mask


cd /Volumes/Sath/VMEM7MR/masks/native_T1/
echo "Coverting masks and putting in SPM masks directory..."
fslchfiletype ANALYZE TIME_${j}_bi_${r}mask.nii.gz /Volumes/Sath/SPM/masks/native_T3/TIME_${j}_bi_${r}mask
fslchfiletype ANALYZE TIME_${j}_left_${r}mask.nii.gz /Volumes/Sath/SPM/masks/native_T3/TIME_${j}_left_${r}mask
fslchfiletype ANALYZE TIME_${j}_right_${r}mask.nii.gz /Volumes/Sath/SPM/masks/native_T3/TIME_${j}_right_${r}mask

done

done