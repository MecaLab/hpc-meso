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



