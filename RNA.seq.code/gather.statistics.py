import sys
import os

def gatherstats(infile):
	gene=[]
	f=open(infile, "r")
	for line in f:
		line=line.strip()
		line=line.split()
		v=float(line[1])
		if v>0:
			gene.append(v)
	f.close()
	
	number=len(gene)
	total=sum(gene)
	ss=infile+"\t"+str(number)+"\t"+str(total)
	print(ss)

if __name__=="__main__":
	infile=sys.argv[1]
	gatherstats(infile)	
