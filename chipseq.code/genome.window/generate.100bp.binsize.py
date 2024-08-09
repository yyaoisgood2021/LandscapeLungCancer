import sys

def generatebin(infile):
	dict={}
	f=open(infile, "r")
	for line in f:
		line=line.strip()
		line=line.split()
		key=line[0]
		value=int(line[1])
		dict[key]=value
	f.close()

	for key, value in dict.items():
		last=int(value/100)
		for i in range(last):
			start=i*100
			end=(i+1)*100
			ss=key+"\t"+str(start)+"\t"+str(end)
			print(ss)
		lastbin=last*100
		ss=key+"\t"+str(lastbin)+"\t"+str(value)
		print(ss)
	
if __name__=="__main__":
	infile=sys.argv[1]
	generatebin(infile)
