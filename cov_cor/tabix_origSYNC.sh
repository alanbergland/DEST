#!/usr/bin/env bash
#
#SBATCH -J tabix_orig # A single job name for the array
#SBATCH --ntasks-per-node=1 # one core
#SBATCH -N 1 # on one node
#SBATCH -t 0:60:00 ### most jobs should run in 60 minutes or less; the mitochondria takes a lot longer to run through pool-snp
#SBATCH --mem 10G
#SBATCH -o /scratch/aob2x/dest/slurmOutput/tabix_orig.%A_%a.out # Standard output
#SBATCH -e /scratch/aob2x/dest/slurmOutput/tabix_orig.%A_%a.err # Standard error
#SBATCH -p standard
#SBATCH --account berglandlab

module load samtools tabix

### run as: sbatch --array=1-246 

## get job
  #SLURM_ARRAY_TASK_ID=1
  sample=$( ls /project/berglandlab/DEST/dest_mapped/pipeline_output | tr '\t' '\n' | sed "${SLURM_ARRAY_TASK_ID}q;d" )
  echo $sample


gunzip /project/berglandlab/DEST/dest_mapped/pipeline_output/${sample}/${sample}.sync.gz
bgzip /project/berglandlab/DEST/dest_mapped/pipeline_output/${sample}/${sample}.sync
tabix -s 1 -b 2 -e 2 /project/berglandlab/DEST/dest_mapped/pipeline_output/${sample}/${sample}.sync.gz
