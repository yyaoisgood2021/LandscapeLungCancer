import sys

#filter the peaks calling based on the length (region<=50kb)
#cleanup the notes at the beginning of the homer output
#reorderfile is just the reordered column file with all the outptu
#the locionly output is a filtered loci by length of the region
def peaks(infile, reorderfile, locionly):
	f=open(infile, "r")
	f1=open(reorderfile, "w")
	f2=open(locionly, "w")
	for line in f:
		line=line.strip()
		if not line.startswith("#"):
			line=line.strip()
			line=line.split()
			loci="\t".join(str(x) for x in line[1:4])
			ss=loci+"\t"+"\t".join(str(x) for x in line)+"\n"
			f1.write(ss)
			l1=int(line[2])
			l2=int(line[3])
			region=l2-l1
			if region<=50000:
				f2.write(loci+"\n")
	f.close()
	f1.close()
	f2.close()

if __name__=="__main__":
	infile=sys.argv[1]
	reorderfile=sys.argv[2]
	locionly=sys.argv[3]
	peaks(infile, reorderfile, locionly)
