import sys
import numpy as np

def readfile(infile):
	f=open(infile, "r")
	for line in f:
		line=line.strip()
		line=line.split()
		value=line[2].split(",")
		vlist=[int(x) for x in value]
		if vlist[0]>0:
			v=vlist[0]
		elif vlist[1]>0:
			v=vlist[1]
		else:
			v=vlist[2]

	f.close()

	vv=int(v/2)
	print(str(vv))

if __name__=="__main__":
	infile=sys.argv[1]
	readfile(infile)

	
