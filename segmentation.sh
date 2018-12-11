#!/bin/bash

export FREESURFER_HOME=/Applications/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh
 

for j in 016 018;  do  # 001 002 003 004 005 006 007 008 009 010 011 012 013 014 015 016



recon-all -sd ~/Documents/hc_subfields -i ~/Documents/HR_gapclass/york/raw/${j}/anat/anat_brain.nii.gz -s s${j} -all -hippocampal-subfields-T1 

echo "################################################All DONE....segmentation for SUBJECT:" ${j} "#################################################################################"


done

echo "All done!"

#do 12 and 16 and 26