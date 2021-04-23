### calculate pn/ps for SNAPE and PoolSNP

# SNAPE
python3 /Users/mkapun/Documents/GitHub/DEST/utils/PNPS4VCF.py \
--input /Volumes/MartinResearch2/DEST/data/dest.PoolSeq.SNAPE.NA.NA.10Nov2020.ann.vcf.gz \
--output /Users/mkapun/Documents/GitHub/DEST/Analyses/pnps/SNAPE_full.pnps.gz \
--MAF 0,0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1,0.15,0.2


# PoolSNP
python3 /Users/mkapun/Documents/GitHub/DEST/utils/PNPS4VCF.py \
--input /Volumes/MartinResearch2/DEST/data/dest.all.PoolSNP.001.50.10Nov2020.ann.vcf.gz \
--output /Users/mkapun/Documents/GitHub/DEST/Analyses/pnps/PoolSNP_full.pnps.gz \
--MAF 0
