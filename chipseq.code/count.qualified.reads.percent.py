import sys

def per(uniq, total, name):
	result=[]
	f1=open(uniq,"r")
	for i, line in enumerate(f1):
		if i ==7:
			line=line.strip()
			line=line.split()
			result.append(line[1])
	f1.close()

	f2=open(total,"r")
	for i, line in enumerate(f2):
		if i ==7:
			line=line.strip()
			line=line.split()
			result.append(line[1])
	f2.close()
	percent=round(float(result[0])/float(result[1]), 4)
	result.append(percent)

	s=str(name)+"\t"+"\t".join(str(x) for x in result)
	print(s)

if __name__=="__main__":
	uniq=sys.argv[1]
	total=sys.argv[2]
	name=sys.argv[3]
	per(uniq, total,name)
