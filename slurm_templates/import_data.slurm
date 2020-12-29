#!/bin/bash
#-----------------------------------------------------#
# TEMPLATE FOR DATA IMPORTATION SBATCH JOBS EXECUTION #
#-----------------------------------------------------#

# Generic configuration
#SBATCH --account=<project_id>  # identifier of the related Mesocentre Project

# Mailing configuration
#SBATCH --mail-type=ALL  # Mail notification of the events concerning the job : start time, end time,…
#SBATCH --mail-user=<email_address>

# Files pattern
#SBATCH --job-name=<job_name>
#SBATCH -e %x_%j.err  #pattern is jobname_jobid
#SBATCH -o %x_%j.out

# Computing resources
#SBATCH --partition=skylake  # partition with cpu only and /scratch available
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=96:00:00

# default example copy data from /envau/work  to /scratch/apron/data/datasets
rsync -avzh --progress <frioul_login>@frioul.int.univ-amu.fr:/envau/work/<to_be_completed> /scratch/<mesocentre_login>/data/datasets/

# optimised data copy (use this if you want to copy >1G0 data volume)
rsync -aHAXxv --numeric-ids --delete --progress -e "ssh -T -o Compression=no -x"
<frioul_login>@frioul.int.univ-amu.fr:/envau/work/<to_be_completed> /scratch/<mesocentre_login>/data/dataset