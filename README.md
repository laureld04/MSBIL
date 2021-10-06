# MSBIL
This includes general documents and details of what we do in the lab along with all of the tools we utilize for visualizing and processing data.

Still in the process of being updated.

Includes singularity container recipe files for storage and keeping track of updates made for usage on high performance computing resources for the University of Arizona.
Below is the current list of the different containers we house on the HPC:
- DeepLabCut (DLC) GUI: deeplabcut.sif (made from deeplabcut.recipe) - used for animal tracking of behavior and is created by this group: https://github.com/DeepLabCut/DeepLabCut
        - DLC has been adapted to work on the UofA HPC for research purposes in the lab. 
- Nklab-neurotools: this is a singularity container that holds a great deal of different programs utilized often within our lab and was provided by Dr.Chen's group. It houses itksnap,mrview, mrtrix, antstools, and much more. Created by Chidi Ugonda, where we utilize the recipe file and have made minor modifications to adapt for our lab use: https://github.com/chidiugonna/nklab-neuro-tools
- MRtrix3: a singularity container that houses newer version of mrtrix commands since some caused errors when run from the nklab-neurotools container. 
