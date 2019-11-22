#!/usr/bin/env bash
#
#SBATCH -J filterFinal # A single job name for the array
#SBATCH --ntasks-per-node=1 # one core
#SBATCH -N 1 # on one node
#SBATCH -t 0:10:00 ### ten minutes
#SBATCH --mem 9G
#SBATCH -o /scratch/aob2x/dest/slurmOutput/filterFinal.%A_%a.out # Standard output
#SBATCH -e /scratch/aob2x/dest/slurmOutput/filterFinal.%A_%a.err # Standard error
#SBATCH -p standard
#SBATCH --account berglandlab

module load gcc/7.1.0 bedops/2.4.1

### remove regions in RepeatMasker & TRF output

bedops -n \
/scratch/aob2x/dest/dest/dgn_drosRTEC_drosEU.sites.dm6.bed \
/scratch/aob2x/dest/referenceGenome/r6/dm6.rep.bed |
bedops -n \
- \
/scratch/aob2x/dest/referenceGenome/r6/dm6.trf.bed >
/scratch/aob2x/dest/dest/dgn_drosRTEC_drosEU.sites.dm6.noRep.bed

~/liftOver \
/scratch/aob2x/dest/dest/dgn_drosRTEC_drosEU.sites.dm6.noRep.bed \
/scratch/aob2x/dest/dgn/liftoverChains/dm6ToDm3.over.chain \
/scratch/aob2x/dest/dest/dgn_drosRTEC_drosEU.sites.dm3.noRep.bed \
/scratch/aob2x/dest/dest/dgn_drosRTEC_drosEU.sites.unmapped.bed
