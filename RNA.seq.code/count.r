###count the genes with annotation###
#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

library("Rsubread")
featureCounts(args[1],

	# annotation
	annot.inbuilt="hg19",
	annot.ext=args[2],
	isGTFAnnotationFile=TRUE,
	GTF.featureType="exon",
	GTF.attrType="gene_id",
	chrAliases=NULL,
	
	# level of summarization
	useMetaFeatures=TRUE,
	
	# overlap between reads and features
	allowMultiOverlap=FALSE,
	minOverlap=1,
	largestOverlap=FALSE,
	readExtension5=0,
	readExtension3=0,
	read2pos=NULL,
	
	# multi-mapping reads
	countMultiMappingReads=FALSE,
	fraction=FALSE,

	# read filtering
	minMQS=0,
	splitOnly=FALSE,
	nonSplitOnly=FALSE,
	primaryOnly=FALSE,
	ignoreDup=FALSE,
	
	# strandness
	strandSpecific=0,
	
	# exon-exon junctions
	juncCounts=FALSE,
	genome=NULL,
	
	# parameters specific to paired end reads
	isPairedEnd=TRUE,
	requireBothEndsMapped=TRUE,
	checkFragLength=TRUE,
	minFragLength=50,
	maxFragLength=600,
	countChimericFragments=TRUE,	
	autosort=TRUE,
	
	# miscellaneous
	nthreads=8,
	maxMOp=10,
	reportReads=TRUE)
