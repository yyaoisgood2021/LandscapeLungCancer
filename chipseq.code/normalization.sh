source /home/lina/programfile/miniconda/miniconda2/etc/profile.d/conda.sh

target=$1
CHIPNAME=$2
input=$3
wk=/home/lina/lung.chipseq.project/data/normalization/
date=$4
blacklist=~/REFERENCE/chipseq.blacklist/merged.hg19.chipseq.blacklist.bed6format.bed

#normalization
bamCompare -b1 $target -b2 $input --scaleFactorsMethod None --blackListFileName $blacklist --operation log2 --pseudocount 1 --binSize 1000  --skipZeroOverZero --normalizeUsing RPKM --numberOfProcessors max/2 -o $wk/`basename $date`.`basename $CHIPNAME`.to.input.log2ratio.RPKM.binsize1000.remove.blacklist.bw
/home/lina//programfile/ucsc.tools/bigWigToBedGraph $wk/`basename $date`.`basename $CHIPNAME`.to.input.log2ratio.RPKM.binsize1000.remove.blacklist.bw $wk/`basename $date`.`basename $CHIPNAME`.to.input.log2ratio.RPKM.binsize1000.remove.blacklist.bedGraph

bamCompare -b1 $target -b2 $input --scaleFactorsMethod None --blackListFileName $blacklist --operation subtract --binSize 1000 --skipZeroOverZero --normalizeUsing RPKM --numberOfProcessors max/2 -o $wk/`basename $date`.`basename $CHIPNAME`.to.input.subtract.RPKM.binsize1000.remove.blacklist.bw
/home/lina//programfile/ucsc.tools/bigWigToBedGraph $wk/`basename $date`.`basename $CHIPNAME`.to.input.subtract.RPKM.binsize1000.remove.blacklist.bw $wk/`basename $date`.`basename $CHIPNAME`.to.input.subtract.RPKM.binsize1000.remove.blacklist.bedGraph

bamCompare -b1 $target -b2 $input --scaleFactorsMethod None --blackListFileName $blacklist --operation log2 --pseudocount 1 --binSize 100 --skipZeroOverZero --normalizeUsing RPKM --numberOfProcessors max/2 -o $wk/`basename $date`.`basename $CHIPNAME`.to.input.log2ratio.RPKM.binsize100.remove.blacklist.bw
/home/lina//programfile/ucsc.tools/bigWigToBedGraph $wk/`basename $date`.`basename $CHIPNAME`.to.input.log2ratio.RPKM.binsize100.remove.blacklist.bw $wk/`basename $date`.`basename $CHIPNAME`.to.input.log2ratio.RPKM.binsize100.remove.blacklist.bedGraph

bamCompare -b1 $target -b2 $input --scaleFactorsMethod None --blackListFileName $blacklist --operation subtract --binSize 100 --skipZeroOverZero --normalizeUsing RPKM --numberOfProcessors max/2 -o $wk/`basename $date`.`basename $CHIPNAME`.to.input.subtract.RPKM.binsize100.remove.blacklist.bw
/home/lina//programfile/ucsc.tools/bigWigToBedGraph $wk/`basename $date`.`basename $CHIPNAME`.to.input.subtract.RPKM.binsize100.remove.blacklist.bw $wk/`basename $date`.`basename $CHIPNAME`.to.input.subtract.RPKM.binsize100.remove.blacklist.bedGraph



