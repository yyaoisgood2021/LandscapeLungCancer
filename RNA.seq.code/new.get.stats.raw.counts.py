import sys
import numpy as np

#input1 file is the raw gene counts generated from featurecount
#input2 file is the statistics summary generated from featurecount
#output file is the statistics of this gene raw counts file

def get_stats(input1,input2, output):
	nonzero=0
	genecount=[]
	genename=[]
	stat=[]
	statsvalue=[]
	f1=open(input1, "r")
	for i, line in enumerate(f1):
		if i>=2:
			line=line.strip()
			line=line.split()
			genecount.append(float(line[1]))
			genename.append(line[0])
			if float(line[1])!=0:
				nonzero=nonzero+1
	f1.close()
	
	x=[]
	f2=open(input2, "r")
	for i, line in enumerate(f2):
		if i>=1:
			line=line.strip()
			line=line.split()
			x.append(float(line[1]))
	f2.close()
				
	gene_total_count=sum(genecount)
	total_count=sum(x)
	successful_assigned_percentage=x[0]*1.0/total_count
	min_gene_count=np.min(genecount)
	max_gene_count=np.max(genecount)
	median_gene_count=np.median(genecount)
	mean_gene_count=np.mean(genecount)
	stat.append("gene_total_count")
	stat.append("total_count")
	stat.append("successful_assigned_percentage")
	stat.append("gene_coverage_number")
	stat.append("min_gene_count")
	stat.append("max_gene_count")
	stat.append("median_gene_count")
	stat.append("mean_gene_count")
	statsvalue.append(gene_total_count)
	statsvalue.append(total_count)
	statsvalue.append(successful_assigned_percentage)
	statsvalue.append(nonzero)
	statsvalue.append(min_gene_count)
	statsvalue.append(max_gene_count)
	statsvalue.append(median_gene_count)
	statsvalue.append(mean_gene_count)
	
	l=len(stat)
	f3=open(output, "w")
	for i in xrange(l):
		sentence=str(stat[i])+"\t"+str(statsvalue[i])+"\n"
		f3.write(sentence)
	f3.close()

if __name__=="__main__":
	input1=sys.argv[1]
	input2=sys.argv[2]
	output=sys.argv[3]
	get_stats(input1, input2, output)
