#!/bin/bash

for subj in {017..018}
#{001..016}
do


#copy and rename tstat files

	for gap in {1..2}
do

cd /archive/tayjonat/Documents/gapclass/imagine/${subj}/imagine${gap}.feat/

nvols=`fslnvols filtered_func_data`


#echo "/archive/tayjonat/Documents/gapclass/york/multivariate/pertrialbetas/${subj}/gap${gap}/trial${trial}+.feat/"
cd /archive/tayjonat/Documents/gapclass/imagine/${subj}/imagine${gap}.feat/stats/
nvols2=`fslnvols tstat1.nii.gz`

if (($nvols2 == 0)); then

echo "Dataset: " ${subj} "RUN:" $gap  "Volumes: " $nvols " Vols2 " $nvols2
cd /archive/tayjonat/Documents/gapclass/imagine/${subj}/
rm -r imagine${gap}.feat

echo "/usr/lib/fsl/5.0/feat /psyhome/u7/tayjonat/Documents/gapclass/york/fsf_files/univariate/full_analysis/${subj}_imagine${gap}_Edsmooth.fsf" > tmpscript
qsub -q all.q tmpscript ;
fi
cp /archive/tayjonat/Documents/gapclass/imagine/${subj}/imagine${gap}.feat/filtered_func_data.nii.gz /archive/tayjonat/Documents/gapclass/imagine_data/imagine${gap}/${subj}_preprocessed_data.nii.gz
echo "Dataset: " $subj "RUN:" $gap  "Volumes: " $nvols " Vols2 " $nvols2
done
done
##cd /archive/margeris/Preprocessing_20sub_90secHP_melodic_zeroSS/PP_S$I/
##find . -type d -name "t*.feat" -exec rm -rf "{}" \;
done
