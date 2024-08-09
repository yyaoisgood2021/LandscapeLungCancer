####chipseq processing

fastq=$1
#samplename=$2
#mark=$3
wkdir=$2

#source /home/lina/programfile/miniconda/miniconda2/etc/profile.d/conda.sh
export PATH=/opt/wangcluster/R/3.6.1/bin/:$PATH
alias R="/opt/wangcluster/R/3.6.1/bin/R"
alias Rscript="/opt/wangcluster/R/3.6.1/bin/Rscript"

#conda activate cutadaptenv

mkdir $wkdir/TrimQC
mkdir $wkdir/mapping
mkdir $wkdir/deduplicate
mkdir $wkdir/peakcalling
mkdir $wkdir/tmp

cd $wkdir

##trim QC
#conda activate cutadaptenv
#/home/lina/programfile/trim.galore/TrimGalore-0.6.5/trim_galore $fastq --gzip -o $wkdir/TrimQC --path_to_cutadapt /home/lina/programfile/miniconda/miniconda2/envs/cutadaptenv/bin/cutadapt 

##mapping
bwa mem -M -t 16 /home/lina/REFERENCE/hg19.bwa.0.7.17/hg19.fa $fastq > $wkdir/mapping/`basename $fastq .fastq.gz`.sam


#bowtie2 -x ~/REFERENCE/hg19.new.bowtie2/hg19 -U $fastq --local -p 16 -S $wkdir/mapping/`basename $fastq .fastq.gz`.sam

#sort, alignment report and deduplicate
java -Djava.io.tmpdir=$wkdir/tmp -jar ~/programfile/picard/build/libs/picard.jar SortSam INPUT=$wkdir/mapping/`basename $fastq .fastq.gz`.sam OUTPUT=$wkdir/mapping/`basename $fastq .fastq.gz`.sorted.bam SORT_ORDER=coordinate 

java -jar ~/programfile/picard/build/libs/picard.jar CollectAlignmentSummaryMetrics R=/home/lina/REFERENCE/hg19.ref/hg19.fasta I=$wkdir/mapping/`basename $fastq .fastq.gz`.sorted.bam O=$wkdir/mapping/`basename $fastq .fastq.gz`.alignment.report.txt

java -jar ~/programfile/picard/build/libs/picard.jar MarkDuplicates INPUT=$wkdir/mapping/`basename $fastq .fastq.gz`.sorted.bam OUTPUT=$wkdir/deduplicate/`basename $fastq .fastq.gz`.sorted.dedup.bam METRICS_FILE=$wkdir/deduplicate/`basename $fastq .fastq.gz`.metric.txt

#filter reads

samtools view -@ 8 -b -F 4 -q 30 $wkdir/deduplicate/`basename $fastq .fastq.gz`.sorted.dedup.bam > $wkdir/deduplicate/`basename $fastq .fastq.gz`.sorted.dedup.temp.bam

samtools view -@ 8 -b -F 1024 $wkdir/deduplicate/`basename $fastq .fastq.gz`.sorted.dedup.temp.bam > $wkdir/deduplicate/`basename $fastq .fastq.gz`.sorted.dedup.Q30.bam

bedtools bamtobed -i $wkdir/deduplicate/`basename $fastq .fastq.gz`.sorted.dedup.Q30.bam > $wkdir/deduplicate/`basename $fastq .fastq.gz`.sorted.dedup.Q30.bed

bedtools genomecov -ibam > $wkdir/deduplicate/`basename $fastq .fastq.gz`.sorted.dedup.Q30.bam > $wkdir/deduplicate/`basename $fastq .fastq.gz`.sorted.dedup.Q30.bedgraph

#uniquely mapping with MAPQ>=30, deduplicate reads report
java -jar ~/programfile/picard/build/libs/picard.jar CollectAlignmentSummaryMetrics R=/home/lina/REFERENCE/hg19.ref/hg19.fasta I=$wkdir/deduplicate/`basename $fastq .fastq.gz`.sorted.dedup.Q30.bam O=$wkdir/deduplicate/`basename $fastq .fastq.gz`.sorted.dedup.Q30.unique.report.txt


## estimate size

/opt/wangcluster/R/3.6.1/bin/Rscript /home/lina/programfile/phantompeakqualtools/phantompeakqualtools/run_spp.R -c=$wkdir/deduplicate/`basename $fastq .fastq.gz`.sorted.dedup.Q10.bam -rf -out=$wkdir/peakcalling/params.out

