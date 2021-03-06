#!/usr/bin/env bash
#
#SBATCH -J touchup # A single job name for the array
#SBATCH -t 48:00:00 ### 6 hours
#SBATCH --cpus-per-task=16
#SBATCH -o /scratch/aob2x/dest/slurmOutput/touchup.%A_%a.out # Standard output
#SBATCH -e /scratch/aob2x/dest/slurmOutput/touchup.%A_%a.err # Standard error
#SBATCH -p standard
#SBATCH --account berglandlab

#SLURM_ARRAY_TASK_ID=1; SLURM_CPUS_PER_TASK=1
### run as: sbatch --array=1-$( tail -n1 /scratch/aob2x/fastq/todl.csv | cut -f3 -d',' ) ${wd}/DEST/misc_obsolete/runTouchup.sh
### sacct -j 12773686

module load singularity
wd=/scratch/aob2x/dest

#cp /scratch/aob2x/fastq/todl.csv /project/berglandlab/.

sranum=$( grep ",${SLURM_ARRAY_TASK_ID}$" /scratch/aob2x/fastq/todl.csv | cut -f2 -d',' )
sampName=$( grep ",${SLURM_ARRAY_TASK_ID}$" /scratch/aob2x/fastq/todl.csv | cut -f1 -d',' )

echo $sampName " / " $sranum

cd /scratch/aob2x/test

singularity run \
/scratch/aob2x/dest/dmelsync_hpc.sif \
/scratch/aob2x/fastq/${sranum}_1.fastq.gz \
/scratch/aob2x/fastq/${sranum}_1.fastq.gz \
${sampName} \
${sampName} \
-c $SLURM_CPUS_PER_TASK \
-dps


#cd PA_li_12_fall; mv PA_li_12_fall /project/berglandlab/DEST/dest_mapped/
#cd UA_Che_14_28; mv UA_Che_14_28 /project/berglandlab/DEST/dest_mapped/
#cd ..; cd UA_Che_14_29; mv UA_Che_14_29 /project/berglandlab/DEST/dest_mapped/
#cd ..; cd UA_Che_14_47; mv UA_Che_14_47 /project/berglandlab/DEST/dest_mapped/
#cd ..; cd UA_Che_14_48; mv UA_Che_14_48 /project/berglandlab/DEST/dest_mapped/
#cd ..; cd UA_Pir_14_26; mv UA_Pir_14_26 /project/berglandlab/DEST/dest_mapped/
#cd ..; cd VA_ch_12_fall; mv VA_ch_12_fall /project/berglandlab/DEST/dest_mapped/
#cd ..; cd WA_se_14_spring; mv WA_se_14_spring /project/berglandlab/DEST/dest_mapped/
