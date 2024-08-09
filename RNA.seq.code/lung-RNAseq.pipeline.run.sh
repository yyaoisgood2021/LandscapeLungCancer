#$1 fastq1 input
#$2 working directory
#$3 sample name

source /home/lina/programfile/miniconda/miniconda2/etc/profile.d/conda.sh


######set java temporary environment#####
mkdir $2/temporary/
export _JAVA_OPTIONS=-Djava.io.tmpdir=$2/temporary/

######fastqc and trim reads######
#single-end
#qc at Q20
#adapter trimming according to the quality control report
mkdir $2/ori_fastqc_results
fastqc -o $2/ori_fastqc_results $1

conda activate cutadaptenv
mkdir $2/fastqc_trim_results
trim_galore --fastqc --stringency 5 -o $2/fastqc_trim_results $1

conda deactivate

mv $2/fastqc_trim_results/*_trimmed.fq.gz $2/fastqc_trim_results/rnaseq.1.fq.gz
#cp $1 $2/fastqc_trim_results/rnaseq.1.fq.gz

#####mapping#####
mkdir $2/mapping
STAR --runThreadN 16 --runMode alignReads --readFilesIn $2/fastqc_trim_results/rnaseq.1.fq.gz  --readFilesCommand zcat --genomeDir /home/lina/star.reference/star.index.hg19/  --outFileNamePrefix $2/mapping/STARoutput --outSAMtype BAM SortedByCoordinate --outReadsUnmapped unmapped_ 

#####gene.coverage.stats#####
mkdir $2/quality.stats
qualimap rnaseq -bam $2/mapping/STARoutputAligned.sortedByCoord.out.bam -gtf /home/lina/star.reference/hg19.gtf.gff/gencode.v19.annotation.gtf -outdir $2/quality.stats -outfile report.pdf -outformat PDF:HTML --java-mem-size=50G

#####counts quantification (Q30)#####
mkdir $2/count

#featureCounts -O -M -Q 30 -p -a ~/star.reference/hg19.gtf.gff/gencode.v19.annotation.gtf -o outputfile ../mapping/STARoutputAligned.sortedByCoord.out.bam

featureCounts -t exon -g gene_name -T 10 -Q 30 -O -a ~/star.reference/hg19.gtf.gff/gencode.v19.annotation.gtf -o $2/count/`basename $3`.outputfile $2/mapping/STARoutputAligned.sortedByCoord.out.bam

~/programfile/anaconda/bin/python2.7 /home/lina/lung.chipseq.project/RNA.seq.code/get.rnaseq.count.file.py $2/count/`basename $3`.outputfile | sort -k 1 > $2/count/`basename $3`.readcounts.txt 
