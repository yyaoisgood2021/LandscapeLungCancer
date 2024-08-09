import sys
import os

#this file is to generate multiple jobsubmission process bash files. original template is ~/lung.chipseq.project/chipseq.code/jobsubmit.sh
#use the individual data info to substitute the SAMPLENAME, FASTQ, and OUTDIR in the original template

# datanamelist: for example:/home/lina/lung.chipseq.project/data/chipseq.11202020/UCSD.025-5.data.info.list
#the format is: sampleindex_mark-replicateindex_otherinfo.fastq.gz

# the datadir is the dir to contain the fastq data dir, for example: /home/lina/lung.chipseq.project/data/chipseq.11202020/igm-storage2.ucsd.edu/201120_K00180_0997_AHKCCCBBXY_SR_75_Combo/

# the outdir is the alignment work directory: for example,  /home/lina/lung.chipseq.project/data/chipseq.11202020/process/UCSD.025-5/ is the directory to contain the chipseq data with UCSD.025-5 patient 

#the codedir is the dir contains the each sample running codes, for example: /home/lina/lung.chipseq.project/data/chipseq.11202020/codes/UCSD.025-5/align/


def generatebash(datanamelist, datadir, outdir, codedir):
	f=open(datanamelist, "r")
	for line in f:
		line=line.strip()
		line=line.split()
		fastqfile=datadir+"/"+line[0]
		namelist=line[0].split("_")
		sample=namelist[0]+"_"+namelist[1]+"_"+namelist[2]
		outputdir=outdir+"/"+sample+"/"
		
		#create the outputfolder:
		createcommand="mkdir "+outputdir	
		print(createcommand)
		os.system(createcommand)
		

		outputtemp=codedir+"/"+sample+".align.temp.sh"
		f2=open(outputtemp, "a+")
		f1=open("/home/lina/lung.chipseq.project/chipseq.code/jobsubmit.sh", "r")
		for line in f1:
			line=line.strip()
			if line.startswith("bash"):
				line=line.strip()
				line=line.split(" ")
				ss=line[0]+" "+line[1]+ " "+fastqfile+" "+outputdir
				f2.write(ss)
			else:
				line=line.strip()
				ss=line+"\n"
				f2.write(ss)
		f1.close()
		f2.close()			

		#revise the template jobsubmission
		command1="sed -e s/SAMPLENAME/"+sample+"/g " + codedir+"/"+sample+".align.temp.sh > "+codedir+"/"+sample+".align.sh" 
		print(command1)
		os.system(command1)
	
		command2="rm -f "+codedir+"/"+sample+".align.temp.sh"
		print(command2)
		os.system(command2)	

if __name__=="__main__":
	datanamelist=sys.argv[1]
	datadir=sys.argv[2]
	outdir=sys.argv[3]
	codedir=sys.argv[4]
	generatebash(datanamelist, datadir, outdir, codedir)	
