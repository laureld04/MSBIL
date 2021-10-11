# MSBIL - Multi-Scale Brain Imaging Lab
This includes general documents and details of what we do in the lab along with all of the tools we utilize for visualizing and processing data.

Still in the process of being updated.

Includes singularity container recipe files for storage and keeping track of updates made for usage on high performance computing resources for the University of Arizona.
Below is the current list of the different containers we house on the HPC:
- DeepLabCut (DLC) GUI: deeplabcut.sif (made from deeplabcut.recipe) - used for animal tracking of behavior and is created by this group: https://github.com/DeepLabCut/DeepLabCut
        - DLC has been adapted to work on the UofA HPC for research purposes in the lab. 
- Nklab-neurotools: this is a singularity container that holds a great deal of different programs utilized often within our lab and was provided by Dr.Chen's group. It houses itksnap,mrview, mrtrix, antstools, and much more. Created by Chidi Ugonda, where we utilize the recipe file and have made minor modifications to adapt for our lab use on the HPC: https://github.com/MRIresearch/NeuroPipelines/tree/master/containers/nklab-neurotools-v0.4
        - Minor updates include: 
                - %setup including all files needed to be copied instead of in %files section of definition file.
                - for MRtrix, including NUMBER_OF_PROCESSORS=1 ./build for preventing memory allocation error (described here as a common problem: https://mrtrix.readthedocs.io/en/3.0_rc3/troubleshooting/performance_and_crashes.html)
- MRtrix3: a singularity container that houses newer version of mrtrix commands since some caused errors when run from the nklab-neurotools container. 


Individual Programs we use and how to properly cite them:
-ITKSNAP
        - REF: Paul A. Yushkevich, Joseph Piven, Heather Cody Hazlett, Rachel Gimpel Smith, Sean Ho, James C. Gee, and Guido Gerig. User-guided 3D active contour segmentation of anatomical structures: Significantly improved efficiency and reliability. Neuroimage. 2006 Jul 1; 31(3):1116-28.
[bibtex] [medline] [doi:10.1016/j.neuroimage.2006.01.015] 
-TORTOISE
-MIPAV
-MRTRIX
