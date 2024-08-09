import sys

def getcount(infile):
	f=open(infile, "r")
	for i, line in enumerate(f):
		if i>=2:
			line=line.strip()
			line=line.split()
			ss=line[0]+"\t"+line[-1]
			print(ss)
	f.close()

if __name__=="__main__":
	infile=sys.argv[1]
	getcount(infile)
