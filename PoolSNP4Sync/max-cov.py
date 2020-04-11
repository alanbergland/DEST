import sys
from collections import defaultdict as d
from optparse import OptionParser, OptionGroup
import math

#Author: Martin Kapun

#########################################################   HELP   #########################################################################
usage="""\npython %prog \
      --sync data.sync.gz \
      --contig 2L \
      --cutoff 0.95 \
      --out data_2L.cov"""
parser = OptionParser(usage=usage)
group=OptionGroup(parser,
"""
H E L P:
____________

Calculate the maximum coverage threshold for a contig based on the the percentile of the overall coverage distribution

""")
#########################################################   CODE   #########################################################################

parser.add_option("--sync", dest="sync", help="sync file")
parser.add_option("--contig", dest="cont", help="target contig")
parser.add_option("--cutoff", dest="cut", help="threshold")
parser.add_option("--out", dest="out", help="outputfile ")

(options, args) = parser.parse_args()
parser.add_option_group(group)

def load_data(x):
  ''' import data either from a gzipped or or uncrompessed file or from STDIN'''

  import gzip
  if x=="-":
      y=sys.stdin
  elif x.endswith(".gz"):
      y=gzip.open(x,"rt", encoding="latin-1")
  else:
      y=open(x,"r", encoding="latin-1")
  return y

def sync2string(x):
    ''' convert sync format to string of nucleotides  where x is a string in sync format '''
    string=""
    if x==".:.:.:.:.:." or x=="0:0:0:0:0:0":
        return "na"
    alleles=["A","T","C","G"]
    ah=dict(zip(alleles,map(int,x.split(":")[:4])))
    for k,v in ah.items():
        string+=v*k
    return string
cutoff=float(options.cut)
covh=d(lambda:d(int))

## read in all coverages
start=0
try:
    load_data(options.sync)
except:
    sys.exit()

c=1
for l in load_data(options.sync):
    a=l.rstrip().split()
    libl=len(a)-3
    if c==1 and cutoff>=1:

        out=open(options.out,"w")
        out.write(options.cont+"\t"+",".join([str(int(cutoff))]*libl)+"\n")
        sys.exit()
    if c%100000==0:
        print(options.cont+":",c,"positions processed")
    c+=1
    if a[0]!=options.cont:
        if start==1:
            break
        elif start==0:
            continue
    start=1

    #print coverage
    for i in range(libl):
        covh[i][0]
        covh[i][len(sync2string(a[i+3]))]+=1
        covh[i][-1]+=1
#print covh
maximumcov=[]
out=open(options.out,"w")
for i in range(libl):
    tot=0
    if list(set(covh[i]))==[0]:
        maximumcov.append(0)
        continue
    t=0
    for c,val in sorted(covh[i].items()):
        #print i,covh[i],c,val,tot,covh[i][-1],tot/float(covh[i][-1])
        if c==-1:
            continue
        elif tot/float(covh[i][-1])>cutoff:
            t=1
            maximumcov.append(c)
            break
        else:
            tot+=val
    if t==0:
        maximumcov.append(c)

out.write(options.cont+"\t"+",".join(map(str,maximumcov))+"\n")
print(options.cont,"done")
