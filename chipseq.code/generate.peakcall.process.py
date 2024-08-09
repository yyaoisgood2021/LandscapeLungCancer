import sys
import os

#this file is to generate multiple jobsubmission process bash files. original template is /home/lina/lung.chipseq.project/chipseq.code/peakcall.jobsubmit.sh 
#use the individual data info to substitute the SAMPLENAME, FASTQ, and OUTDIR in the original template

# datanamelist: for example:/home/lina/lung.chipseq.project/data/chipseq.11202020/UCSD.025-5.data.info.list
#the format is: sampleindex_mark-replicateindex_otherinfo.fastq.gz

# the datadir: is the directory containing bam file to call peak

# the outdir is the peakcall work directory: for example, /home/lina/lung.chipseq.project/data/chipseq.11202020/process/UCSD.025-5/ is the directory to contain the chipseq data with UCSD.025-5 patient, but have to add the chipseq mark name and the peakcaling folder 

#inputfile: the chipseq input

#the codedir is the dir contains the each sample running codes, for example: /home/lina/lung.chipseq.project/data/chipseq.11202020/codes/UCSD.025-5/align/


def generatebash(datanamelist, datadir, outdir, inputfile, codedir):
	f=open(datanamelist, "r")
	for line in f:
		line=line.strip()
		line=line.split()
		namelist1=line[0].split(".")
		namelist=line[0].split("_")
		sample=namelist[0]+"_"+namelist[1]+"_"+namelist[2]	
		target=datadir+sample+"/deduplicate/"+namelist1[0]+".sorted.dedup.Q10.bam"
		outputdir=outdir+"/"+sample+"/peakcalling/"
		
		outputtemp=codedir+"/"+sample+".peakcall.temp.sh"
		f2=open(outputtemp, "a+")
		f1=open("/home/lina/lung.chipseq.project/chipseq.code/peakcall.jobsubmit.sh", "r")
		for line in f1:
			line=line.strip()
			if line.startswith("bash"):
				line=line.strip()
				line=line.split(" ")
				ss=line[0]+" "+line[1]+ " "+target+" SAMPLENAME "+inputfile+" "+outputdir
				f2.write(ss)
			else:
				line=line.strip()
				ss=line+"\n"
				f2.write(ss)
		f1.close()
		f2.close()			

		#revise the template jobsubmission
		command1="sed -e s/SAMPLENAME/"+sample+"/g " + codedir+"/"+sample+".peakcall.temp.sh > "+codedir+"/"+sample+".peakcall.sh" 
		print(command1)
		os.system(command1)
	
		command2="rm -f "+codedir+"/"+sample+".peakcall.temp.sh"
		print(command2)
		os.system(command2)	

if __name__=="__main__":
	datanamelist=sys.argv[1]
	datadir=sys.argv[2]
	outdir=sys.argv[3]
	inputfile=sys.argv[4]
	codedir=sys.argv[5]
	generatebash(datanamelist, datadir, outdir, inputfile, codedir)	
