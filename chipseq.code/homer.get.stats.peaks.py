import sys
import numpy as np
import matplotlib 
matplotlib.use('Agg')
import matplotlib.pyplot as plt


#cleanup the notes at the beginning of the homer output
#reorderfile is just the reordered column file with all the outptu
#the locionly output is a filtered loci by length of the region
def peaks(infile, sample, lenplot, foldplot):
	lenlist=[]
	foldlist=[]
	f=open(infile, "r")
	for line in f:
		line=line.strip()
		if not line.startswith("#"):
			line=line.strip()
			line=line.split()
			loci="\t".join(str(x) for x in line[1:4])
			l1=int(line[2])
			l2=int(line[3])
			region=np.log10(l2-l1)
			fold=np.log2(float(line[-3]))
			lenlist.append(region)
			foldlist.append(fold)
	f.close()
	
	#length plot
	lenplottitle=sample+" region length histgram (log10)"
	plt.figure()
	plt.hist(lenlist, bins='auto')
	plt.title(lenplottitle)
	plt.savefig(lenplot)

	#fold plot
	foldplottitle=sample+" foldchange histgram (log2)"
	plt.figure()
	plt.hist(foldlist, bins='auto')
	plt.title(foldplottitle)
	plt.savefig(foldplot)

if __name__=="__main__":
	infile=sys.argv[1]
	sample=sys.argv[2]
	lenplot=sys.argv[3]
	foldplot=sys.argv[4]
	peaks(infile, sample, lenplot, foldplot)
