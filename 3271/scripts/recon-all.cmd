

#---------------------------------
# New invocation of recon-all Tue Jan  2 15:38:22 UTC 2018 

 mri_convert /home/ubuntu/sMRI/3271.nii /usr/local/freesurfer/subjects/3271/mri/orig/001.mgz 

#--------------------------------------------
#@# MotionCor Tue Jan  2 15:38:38 UTC 2018

 cp /usr/local/freesurfer/subjects/3271/mri/orig/001.mgz /usr/local/freesurfer/subjects/3271/mri/rawavg.mgz 


 mri_convert /usr/local/freesurfer/subjects/3271/mri/rawavg.mgz /usr/local/freesurfer/subjects/3271/mri/orig.mgz --conform 


 mri_add_xform_to_header -c /usr/local/freesurfer/subjects/3271/mri/transforms/talairach.xfm /usr/local/freesurfer/subjects/3271/mri/orig.mgz /usr/local/freesurfer/subjects/3271/mri/orig.mgz 

#--------------------------------------------
#@# Talairach Tue Jan  2 15:39:02 UTC 2018

 mri_nu_correct.mni --no-rescale --i orig.mgz --o orig_nu.mgz --n 1 --proto-iters 1000 --distance 50 


 talairach_avi --i orig_nu.mgz --xfm transforms/talairach.auto.xfm 

talairach_avi log file is transforms/talairach_avi.log...

 cp transforms/talairach.auto.xfm transforms/talairach.xfm 

#--------------------------------------------
#@# Talairach Failure Detection Tue Jan  2 15:47:21 UTC 2018

 talairach_afd -T 0.005 -xfm transforms/talairach.xfm 


 awk -f /usr/local/freesurfer/bin/extract_talairach_avi_QA.awk /usr/local/freesurfer/subjects/3271/mri/transforms/talairach_avi.log 


 tal_QC_AZS /usr/local/freesurfer/subjects/3271/mri/transforms/talairach_avi.log 

#--------------------------------------------
#@# Nu Intensity Correction Tue Jan  2 15:47:21 UTC 2018

 mri_nu_correct.mni --i orig.mgz --o nu.mgz --uchar transforms/talairach.xfm --n 2 

