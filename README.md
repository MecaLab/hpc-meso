# HPC-Meso
High performance computing on the [Aix-Marseille université mesocentre](https://mesocentre.univ-amu.fr/)
## Objectives
This repository aims at providing useful pointers toward existing documentations and 
providing template script to ease high performance computations on the Mesocentre
## Getting started
This section is a sum-up of some of the mesocentre tutorial

## Running jobs in passive mode (Slurm)
### Documentation
`sbatch` slurm command executes instructions stored in a ``.sh`` or ``.slurm`` script. 
```bash
sbatch my_script.slurm
```
+ [slurm mesocentre documentation](https://mesocentre.univ-amu.fr/slurm/)
+ [sbatch 17.02.7 documentation](https://slurm.schedmd.com/archive/slurm-17.02.07/sbatch.html) (current version installed in the mesocentre).
+ about conditional jobs execution
### Templates


The 
``slurm_templates`` 
directory of the present repository contains ``.slurm`` templates ready to be modified 
files. 
```bash
# Content of the deep_learning.slurm file
#!/bin/bash
#-----------------------------------------------------#
# TEMPLATE FOR TYPICAL DEEP-LEARNING JOBS EXECUTION   #
#-----------------------------------------------------#

# Generic configuration
#SBATCH --account=<project_id>  # identifier of the related Mesocentre Project

# Mailing configuration
#SBATCH --mail-type=ALL  # Mail notification of the events concerning the job : start time, end time,…
#SBATCH --mail-user=<email_address>

# Files pattern
#SBATCH --job-name=<job_name>
#SBATCH -e %x_%j.err    #pattern is jobname_jobid
#SBATCH -o %x_%j.out    #pattern is jobname_jobid

# Computing resources
#SBATCH --partition=volta, pascal, kepler   # partition with gpu
#SBATCH --gres=gpu:1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --time=96:00:00
```

