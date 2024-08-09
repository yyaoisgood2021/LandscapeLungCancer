#$1 fastq1 input
#$2 fastq2 input
#$3 working directory
#$4 sample name

######set java temporary environment#####
mkdir $3/temporary/
export _JAVA_OPTIONS=-Djava.io.tmpdir=$3/temporary/

######fastqc and trim reads######
#pair-end
#qc at Q20
#adapter trimming according to the quality control report
#mkdir $3/ori_fastqc_results
#fastqc -o $3/ori_fastqc_results $1 $2

#mkdir $3/fastqc_trim_results
#trim_galore --paired --fastqc --stringency 5 -o $3/fastqc_trim_results $1 $2

#cp $3/fastqc_trim_results/*_val_1.fq.gz $3/fastqc_trim_results/1.fq.gz
#cp $3/fastqc_trim_results/*_val_2.fq.gz $3/fastqc_trim_results/2.fq.gz

#####mapping#####
mkdir $3/mapping
STAR --runThreadN 16 --runMode alignReads --readFilesIn $3/fastqc_trim_results/1.fq.gz $3/fastqc_trim_results/2.fq.gz --readFilesCommand zcat --genomeDir /home/lina/star.reference/star.index.hg19/  --outFileNamePrefix $3/mapping/STARoutput --outSAMtype BAM SortedByCoordinate --outReadsUnmapped unmapped_ 

#####gene.coverage.stats#####
mkdir $3/quality.stats
qualimap rnaseq -bam $3/mapping/STARoutputAligned.sortedByCoord.out.bam -gtf /home/lina/star.reference/hg19.gtf.gff/gencode.v19.annotation.gtf -outdir $3/quality.stats -pe yes -outfile report.pdf -outformat PDF:HTML --java-mem-size=50G

#####counts quantification (QC30)#####
mkdir $3/count

##if need isoform##
#cufflinks $3/mapping/STARoutputAligned.sortedByCoord.out.bam -o $3/count/ -p 16 -G /home/lina/star.reference/hg19.gtf.gff/gencode.v19.annotation.gtf 

#htseq-count -f bam -s no -a 30 $3/mapping/STARoutputAligned.sortedByCoord.out.bam /home/lina/star.reference/hg19.gtf.gff/gencode.v19.annotation.gff3 > $3/count/$4.raw.counts.txt

#htseq-count -f bam -s no -a 30 -i gene_name $3/mapping/STARoutputAligned.sortedByCoord.out.bam /home/lina/star.reference/hg19.gtf.gff/gencode.v19.annotation.gff3 > $3/count/$4.gene.raw.counts.txt

#/home/lina/programfile/anaconda/bin/python2.7 ~/single.cell.pipeline/get.stats.raw.counts.py $3/count/$4.gene.raw.counts.txt $3/count/$4.pure.gene.raw.counts.txt $3/count/$4.gene.raw.counts.stats.txt

#featureCounts -O -M -Q 30 -p -a ~/star.reference/hg19.gtf.gff/gencode.v19.annotation.gtf -o outputfile ../mapping/STARoutputAligned.sortedByCoord.out.bam

featureCounts -O -M -Q 30 -p -g gene_name -P -B -F GTF -a ~/star.reference/hg19.gtf.gff/gencode.v19.annotation.gtf -o outputfile $3/mapping/STARoutputAligned.sortedByCoord.out.bam

featureCounts -p -t exon -g gene_id -Q 30 -O -a ~/star.reference/hg19.gtf.gff/gencode.v19.annotation.gtf -G GTF -o outputfile ../mapping/STARoutputAligned.sortedByCoord.out.bam


featureCounts -p -t exon -g gene_name -T 8 -B -Q 30 -O -a ~/star.reference/hg19.gtf.gff/gencode.v19.annotation.gtf -o outputfile ../mapping/STARoutputAligned.sortedByCoord.out.bam(good)
