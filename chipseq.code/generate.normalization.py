import sys 

def generate(infile, date, cpu, memory):
	f=open(infile, "r")
	for line in f:
		line=line.strip()
		if "--ntasks" in line:
			print("#SBATCH --ntasks="+str(cpu))
		elif "--mem" in line:
			print("#SBATCH --mem="+str(memory))
		elif "bash /home/lina/lung.chipseq.project/chipseq.code/peak.calling.sh" in line:
			line=line.split(" ")
			runcode="/home/lina/lung.chipseq.project/chipseq.code/normalization.sh"
			signal=line[2]
			sname=line[3]
			control=line[4]
			ss="bash "+str(runcode)+" "+str(signal)+" "+str(sname)+" "+str(control)+" "+str(date)
			print(ss)
		else:
			print(line)
	f.close()

if __name__=="__main__":
	infile=sys.argv[1]
	date=sys.argv[2]
	cpu=sys.argv[3]
	memory=sys.argv[4]
	generate(infile, date, cpu, memory)

	
