#!/usr/bin/env bash
#
#SBATCH -J split_and_run # A single job name for the array
#SBATCH --ntasks-per-node=20 # one core
#SBATCH -N 1 # on one node
#SBATCH -t 4:00:00 ### 6 hours
#SBATCH --mem 10G
#SBATCH -o /scratch/aob2x/dest/slurmOutput/split_and_run.%A_%a.out # Standard output
#SBATCH -e /scratch/aob2x/dest/slurmOutput/split_and_run.%A_%a.err # Standard error
#SBATCH -p standard
#SBATCH --account berglandlab

### run as: sbatch --array=1-$( cat ${wd}/poolSNP_jobs.sample.csv | cut -f1 -d',' | sort | uniq | awk '{print NR}' | tail -n1 ) ${wd}/DEST/snpCalling/gather_poolsnp_paramtest.sh
### sacct -j 13029741
### cat /scratch/aob2x/dest/slurmOutput/split_and_run.12825614
module load htslib bcftools intel/18.0 intelmpi/18.0 parallel


wd="/scratch/aob2x/dest"
outdir="/scratch/aob2x/dest/sub_vcfs"

chr=$( cat ${wd}/poolSNP_jobs.sample.csv | cut -f1 -d',' | sort | uniq | sed "${SLURM_ARRAY_TASK_ID}q;d" )

maf=${1}
mac=${2}



ls -d $outdir/*.${maf}.${mac}.vcf.gz | sort -t"_" -k2,2 -k3g,3  | grep /${chr}_ > /scratch/aob2x/dest/sub_vcfs/vcfs_order.${chr}.${maf}.${mac}.sort

bcftools concat \
--threads 20 \
-f /scratch/aob2x/dest/sub_vcfs/vcfs_order.${chr}.${maf}.${mac}.sort \
-O v \
-n \
-o /scratch/aob2x/dest/sub_bcf/dest.July6_2020.${chr}.${maf}.${mac}.bcf