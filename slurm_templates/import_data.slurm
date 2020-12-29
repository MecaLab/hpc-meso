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
#SBATCH -o %x_%j.out  #pattern is jobname_jobid

# Computing resources
#SBATCH --partition=skylake  # partition with cpu only and /scratch available
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=96:00:00

# default general syntax (we already are logged in login.mesocentre.univ-amu.fr)
rsync -avzh --progress <login_host_source>@<host_source>:<path_source> <path_dest>

# default recommended syntax
rsync -avzh --progress <login>@<host>:<path> /scratch/<mesocentre_login>/<path_dest>

#default optimised syntax (if you need to copy >1G0 data)
rsync -aHAXxv --numeric-ids --delete --progress -e "ssh -T -o Compression=no -x" <login>@<host>:<path> /scratch/<mesocentre_login>/<path_dest>

# a practical example to copy data from /envau to mesocentre
rsync -aHAXxv --numeric-ids --delete --progress -e "ssh -T -o Compression=no -x"
<login>@<frioul.int.univ-amu.fr>:/envau/<path_source>
/scratch/<mesocentre_login>/<path_dest>
