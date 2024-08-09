import sys
#locionly is the region with filtered by length <=50000bp
def cleanup(infile, locionly):
	f=open(infile, "r")
	f1=open(locionly, "w")
	for line in f:
		line=line.strip()
		if not line.startswith("#"):
			line=line.split()
			l1=int(line[1])
			l2=int(line[2])
			region=l2-l1
			if region<=50000:
				loci="\t".join(str(x) for x in line[0:3])+"\n"
				f1.write(loci)
	f.close()
	f1.close()

if __name__=="__main__":
	infile=sys.argv[1]
	locionly=sys.argv[2]
	cleanup(infile, locionly)
			
		
