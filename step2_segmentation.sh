#!/bin/bash 

export FREESURFER_HOME=/Applications/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh

for j in 017;  do  # 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016 016 018
# Label Legend
#--206 CA1
#--208 CA3
#--209 CA4
#--210 DG
#--205 Subiculum
#--203 Parasubiculum
#--204 Presubiculum

#---------Prep subject directories for masks------------------------------------------------------------------------------

cd ~/Documents/hc_subfields/s${j}/mri/

#---------Extract Left + Right CA2/CA3/DG in to a single ROI---------------------------------------------------------------
mri_extract_label lh.hippoSfLabels-T1.v10.mgz 208 209 210 LCA2_CA3_DG.mgz
mri_extract_label rh.hippoSfLabels-T1.v10.mgz 208 209 210 RCA2_CA3_DG.mgz

#---------Extract Left + Right CA1-----------------------------------------------------------------------------------------
mri_extract_label lh.hippoSfLabels-T1.v10.mgz 206 LCA1.mgz
mri_extract_label rh.hippoSfLabels-T1.v10.mgz 206 RCA1.mgz

#---------Extract Left + Right Subiclulum----------------------------------------------------------------------------------
mri_extract_label lh.hippoSfLabels-T1.v10.mgz 205 LSub.mgz
mri_extract_label rh.hippoSfLabels-T1.v10.mgz 205 RSub.mgz


#--------Resample extracted roi in to highres anatomical space (1.5 x 1.5 x 1.75mm)----------------------------------------
mri_convert LCA2_CA3_DG.mgz -rl rawavg.mgz /Volumes/Sath/gapclass/masks/highres/store/s${j}/LCA2_CA3_DG.nii.gz
mri_convert RCA2_CA3_DG.mgz -rl rawavg.mgz /Volumes/Sath/gapclass/masks/highres/store/s${j}/RCA2_CA3_DG.nii.gz

mri_convert LCA1.mgz -rl rawavg.mgz /Volumes/Sath/gapclass/masks/highres/store/s${j}/LCA1.nii.gz
mri_convert RCA1.mgz -rl rawavg.mgz /Volumes/Sath/gapclass/masks/highres/store/s${j}/RCA1.nii.gz

mri_convert LSub.mgz -rl rawavg.mgz /Volumes/Sath/gapclass/masks/highres/store/s${j}/LSub.nii.gz
mri_convert RSub.mgz -rl rawavg.mgz /Volumes/Sath/gapclass/masks/highres/store/s${j}/RSub.nii.gz

#---------Bind Left + Right ROIS to bilat----------------------------------------------------------------------------------
cd /Volumes/Sath/gapclass/masks/highres/store/s${j}/

fslmaths LCA2_CA3_DG.nii.gz -add RCA2_CA3_DG.nii.gz biCA2_CA3_DG.nii.gz
fslmaths LCA1.nii.gz -add RCA1.nii.gz biCA1.nii.gz
fslmaths LSub.nii.gz -add RSub.nii.gz biSub.nii.gz

#---------Coregister and reslice to image----------------------------------------------------------------------------------
/usr/local/fsl/bin/flirt -in /Volumes/Sath/gapclass/masks/highres/store/s${j}/biCA2_CA3_DG.nii.gz -applyxfm -init /Volumes/Sath/gapclass/transform/s${j}/gap1/highres2example_func.mat -out /Volumes/Sath/gapclass/masks/native/store/s${j}/biCA2_CA3_DG.nii.gz -paddingsize 0.0 -interp trilinear -ref /Volumes/Sath/gapclass/betas/100s_HP_data/native/realigned/${j}_gap1_tstat_allcond_native_realigned.nii.gz
/usr/local/fsl/bin/flirt -in /Volumes/Sath/gapclass/masks/highres/store/s${j}/LCA2_CA3_DG.nii.gz -applyxfm -init /Volumes/Sath/gapclass/transform/s${j}/gap1/highres2example_func.mat -out /Volumes/Sath/gapclass/masks/native/store/s${j}/LCA2_CA3_DG.nii.gz -paddingsize 0.0 -interp trilinear -ref /Volumes/Sath/gapclass/betas/100s_HP_data/native/realigned/${j}_gap1_tstat_allcond_native_realigned.nii.gz
/usr/local/fsl/bin/flirt -in /Volumes/Sath/gapclass/masks/highres/store/s${j}/RCA2_CA3_DG.nii.gz -applyxfm -init /Volumes/Sath/gapclass/transform/s${j}/gap1/highres2example_func.mat -out /Volumes/Sath/gapclass/masks/native/store/s${j}/RCA2_CA3_DG.nii.gz -paddingsize 0.0 -interp trilinear -ref /Volumes/Sath/gapclass/betas/100s_HP_data/native/realigned/${j}_gap1_tstat_allcond_native_realigned.nii.gz


/usr/local/fsl/bin/flirt -in /Volumes/Sath/gapclass/masks/highres/store/s${j}/biCA1.nii.gz -applyxfm -init /Volumes/Sath/gapclass/transform/s${j}/gap1/highres2example_func.mat -out /Volumes/Sath/gapclass/masks/native/store/s${j}/biCA1.nii.gz -paddingsize 0.0 -interp trilinear -ref /Volumes/Sath/gapclass/betas/100s_HP_data/native/realigned/${j}_gap1_tstat_allcond_native_realigned.nii.gz
/usr/local/fsl/bin/flirt -in /Volumes/Sath/gapclass/masks/highres/store/s${j}/LCA1.nii.gz -applyxfm -init /Volumes/Sath/gapclass/transform/s${j}/gap1/highres2example_func.mat -out /Volumes/Sath/gapclass/masks/native/store/s${j}/LCA1.nii.gz -paddingsize 0.0 -interp trilinear -ref /Volumes/Sath/gapclass/betas/100s_HP_data/native/realigned/${j}_gap1_tstat_allcond_native_realigned.nii.gz
/usr/local/fsl/bin/flirt -in /Volumes/Sath/gapclass/masks/highres/store/s${j}/RCA1.nii.gz -applyxfm -init /Volumes/Sath/gapclass/transform/s${j}/gap1/highres2example_func.mat -out /Volumes/Sath/gapclass/masks/native/store/s${j}/RCA1.nii.gz -paddingsize 0.0 -interp trilinear -ref /Volumes/Sath/gapclass/betas/100s_HP_data/native/realigned/${j}_gap1_tstat_allcond_native_realigned.nii.gz


/usr/local/fsl/bin/flirt -in /Volumes/Sath/gapclass/masks/highres/store/s${j}/biSub.nii.gz -applyxfm -init /Volumes/Sath/gapclass/transform/s${j}/gap1/highres2example_func.mat -out /Volumes/Sath/gapclass/masks/native/store/s${j}/biSub.nii.gz -paddingsize 0.0 -interp trilinear -ref /Volumes/Sath/gapclass/betas/100s_HP_data/native/realigned/${j}_gap1_tstat_allcond_native_realigned.nii.gz
/usr/local/fsl/bin/flirt -in /Volumes/Sath/gapclass/masks/highres/store/s${j}/LSub.nii.gz -applyxfm -init /Volumes/Sath/gapclass/transform/s${j}/gap1/highres2example_func.mat -out /Volumes/Sath/gapclass/masks/native/store/s${j}/LSub.nii.gz -paddingsize 0.0 -interp trilinear -ref /Volumes/Sath/gapclass/betas/100s_HP_data/native/realigned/${j}_gap1_tstat_allcond_native_realigned.nii.gz
/usr/local/fsl/bin/flirt -in /Volumes/Sath/gapclass/masks/highres/store/s${j}/RSub.nii.gz -applyxfm -init /Volumes/Sath/gapclass/transform/s${j}/gap1/highres2example_func.mat -out /Volumes/Sath/gapclass/masks/native/store/s${j}/RSub.nii.gz -paddingsize 0.0 -interp trilinear -ref /Volumes/Sath/gapclass/betas/100s_HP_data/native/realigned/${j}_gap1_tstat_allcond_native_realigned.nii.gz



#At this point it is a good idea to visually inspect your masks in 'store' before finalizing them and putting them in the root native/highres directory.

done

echo "All done! Check your masks and verify they are transformed correctly before entering step 3 [Final]"

#do 12 and 16 and 26