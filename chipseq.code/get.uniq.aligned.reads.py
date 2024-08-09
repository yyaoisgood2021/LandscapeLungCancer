import sys

def getuniq(infile, sample):
	f=open(infile, "r")
	for i, line in enumerate(f):
		if i==7:
			line=line.strip()
			line=line.split()
			number=line[1]
	f.close()

	ss=sample+"\t"+str(number)
	print(ss)

if __name__=="__main__":
	infile=sys.argv[1]
	sample=sys.argv[2]
	getuniq(infile, sample)
