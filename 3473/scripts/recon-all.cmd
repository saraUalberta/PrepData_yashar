

#---------------------------------
# New invocation of recon-all Mon Jan  8 18:43:34 UTC 2018 

 mri_convert /home/ubuntu/sMRI/3473.nii /usr/local/freesurfer/subjects/3473/mri/orig/001.mgz 

#--------------------------------------------
#@# MotionCor Mon Jan  8 18:43:40 UTC 2018

 cp /usr/local/freesurfer/subjects/3473/mri/orig/001.mgz /usr/local/freesurfer/subjects/3473/mri/rawavg.mgz 


 mri_convert /usr/local/freesurfer/subjects/3473/mri/rawavg.mgz /usr/local/freesurfer/subjects/3473/mri/orig.mgz --conform 


 mri_add_xform_to_header -c /usr/local/freesurfer/subjects/3473/mri/transforms/talairach.xfm /usr/local/freesurfer/subjects/3473/mri/orig.mgz /usr/local/freesurfer/subjects/3473/mri/orig.mgz 

#--------------------------------------------
#@# Talairach Mon Jan  8 18:43:52 UTC 2018

 mri_nu_correct.mni --no-rescale --i orig.mgz --o orig_nu.mgz --n 1 --proto-iters 1000 --distance 50 


 talairach_avi --i orig_nu.mgz --xfm transforms/talairach.auto.xfm 

talairach_avi log file is transforms/talairach_avi.log...

 cp transforms/talairach.auto.xfm transforms/talairach.xfm 

#--------------------------------------------
#@# Talairach Failure Detection Mon Jan  8 18:49:00 UTC 2018

 talairach_afd -T 0.005 -xfm transforms/talairach.xfm 


 awk -f /usr/local/freesurfer/bin/extract_talairach_avi_QA.awk /usr/local/freesurfer/subjects/3473/mri/transforms/talairach_avi.log 


 tal_QC_AZS /usr/local/freesurfer/subjects/3473/mri/transforms/talairach_avi.log 

#--------------------------------------------
#@# Nu Intensity Correction Mon Jan  8 18:49:12 UTC 2018

 mri_nu_correct.mni --i orig.mgz --o nu.mgz --uchar transforms/talairach.xfm --n 2 


 mri_add_xform_to_header -c /usr/local/freesurfer/subjects/3473/mri/transforms/talairach.xfm nu.mgz nu.mgz 

#--------------------------------------------
#@# Intensity Normalization Mon Jan  8 18:59:26 UTC 2018

 mri_normalize -g 1 -mprage nu.mgz T1.mgz 

#--------------------------------------------
#@# Skull Stripping Mon Jan  8 19:03:31 UTC 2018

 mri_em_register -rusage /usr/local/freesurfer/subjects/3473/touch/rusage.mri_em_register.skull.dat -skull nu.mgz /usr/local/freesurfer/average/RB_all_withskull_2016-05-10.vc700.gca transforms/talairach_with_skull.lta 


 mri_watershed -rusage /usr/local/freesurfer/subjects/3473/touch/rusage.mri_watershed.dat -T1 -brain_atlas /usr/local/freesurfer/average/RB_all_withskull_2016-05-10.vc700.gca transforms/talairach_with_skull.lta T1.mgz brainmask.auto.mgz 


 cp brainmask.auto.mgz brainmask.mgz 

#-------------------------------------
#@# EM Registration Mon Jan  8 19:46:57 UTC 2018

 mri_em_register -rusage /usr/local/freesurfer/subjects/3473/touch/rusage.mri_em_register.dat -uns 3 -mask brainmask.mgz nu.mgz /usr/local/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.lta 

#--------------------------------------
#@# CA Normalize Mon Jan  8 20:22:10 UTC 2018

 mri_ca_normalize -c ctrl_pts.mgz -mask brainmask.mgz nu.mgz /usr/local/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.lta norm.mgz 

#--------------------------------------
#@# CA Reg Mon Jan  8 20:25:24 UTC 2018

 mri_ca_register -rusage /usr/local/freesurfer/subjects/3473/touch/rusage.mri_ca_register.dat -nobigventricles -T transforms/talairach.lta -align-after -mask brainmask.mgz norm.mgz /usr/local/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.m3z 

#--------------------------------------
#@# SubCort Seg Tue Jan  9 03:09:11 UTC 2018

 mri_ca_label -relabel_unlikely 9 .3 -prior 0.5 -align norm.mgz transforms/talairach.m3z /usr/local/freesurfer/average/RB_all_2016-05-10.vc700.gca aseg.auto_noCCseg.mgz 

