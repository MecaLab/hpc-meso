# HPC-Meso
High performance computing on the [Aix-Marseille université mesocentre](https://mesocentre.univ-amu.fr/)
## Objectives
This repository aims at pointing to pertinent documentation pages 
and providing templates for main common processing steps (e.g. data importation, 
job submission) in the mesocentre. 


## Submitting jobs with Slurm

`sbatch` slurm command executes instructions stored in a ``.sh`` or ``.slurm`` script. 
```bash
sbatch my_script.slurm
```

 [sbatch 17.02.7 documentation](https://slurm.schedmd.com/archive/slurm-17.02.07/sbatch.html) (current version installed in the mesocentre).

### Slurm template files


The 
``slurm_templates`` 
directory contains ``.slurm`` scripts with preset values. 

 
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

## Data importation
Users are allowed to transfer data from and to the mesocentre 
using ``scp``, ``rsync`` and ``sftp`` commands. Data transfer can be performed in two 
different ways (https://mesocentre.univ-amu.fr/sauvegarde-donnees):
1. using the `login@mesocentre.univ-amu.fr` machine, if transfer does not exceed 30 min 
  (few data). In this way, no processing time is consumed.
2. using a dedicated node either in interactive (srun) or passive (sbatch) mode for 
  larger data import
  
In order to achieved secured data copy, we only provide `rsync` based slurm template 
file. Know that `rsync` is not optimized (very slow) for huge data through Wide Area Network 
(WAN).

```bash
# Content of the import_data.slurm file
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

# default optimised syntax ((we already are logged in login.mesocentre.univ-amu.fr and
# need to copy >1G0 data)
rsync -aHAXxv --numeric-ids --delete --progress -e "ssh -T -o Compression=no -x" <login>@<host>:<path> <path_dest>

# a practical example to copy data from /envau to mesocentre
rsync -aHAXxv --numeric-ids --delete --progress -e "ssh -T -o Compression=no -x" 
<login>@<frioul.int.univ-amu.fr>:/envau/<path_source>
/scratch/<mesocentre_login>/<path_dest>

```

