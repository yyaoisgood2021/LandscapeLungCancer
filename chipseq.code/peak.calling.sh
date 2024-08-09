source /home/lina/programfile/miniconda/miniconda2/etc/profile.d/conda.sh

target=$1
CHIPNAME=$2
input=$3
wk=$4

mkdir $wk/standard/
mkdir $wk/blueprint/
mkdir $wk/standard/narrow/
mkdir $wk/standard/broad/
mkdir $wk/blueprint/narrow/
mkdir $wk/blueprint/broad/
mkdir $wk/blueprint/halfsize.narrow/
mkdir $wk/blueprint/halfsize.broad/

#####standard default
#narrow
macs2 callpeak -t $target -c $input -g hs -n $CHIPNAME -f BAM -q 0.05 --outdir $wk/standard/narrow/

#broad
macs2 callpeak -t $target -c $input -g hs -n $CHIPNAME -f BAM --broad --broad-cutoff 0.05 --outdir $wk/standard/broad/

####blueprint process
size="$(/home/lina/programfile/anaconda/bin/python2.7 /home/lina/lung.chipseq.project/chipseq.code/read.fragment.estimate.py $wk/params.out)"

halfsize="$(/home/lina/programfile/anaconda/bin/python2.7 /home/lina/lung.chipseq.project/chipseq.code/read.fragment.estimate.half.py $wk/params.out)"

#broad
macs2 callpeak -t $target -n $CHIPNAME -g hs -c $input --nomodel --shift $size --broad --broad-cutoff 0.05 --outdir $wk/blueprint/broad/
#narrow
macs2 callpeak -t $target -n $CHIPNAME -g hs -c $input -q 0.05 --nomodel --shift $size --outdir $wk/blueprint/narrow/


#half size broad
macs2 callpeak -t $target -n $CHIPNAME -g hs -c $input --nomodel --shift $halfsize --broad --broad-cutoff 0.05 --outdir $wk/blueprint/halfsize.broad/
#half size narrow
macs2 callpeak -t $target -n $CHIPNAME -g hs -c $input -q 0.05 --nomodel --shift $halfsize --outdir $wk/blueprint/halfsize.narrow/

#normalization
mkdir $wk/normalization/
bamCompare -b1 $target -b2 $input --scaleFactorsMethod None --operation log2 --pseudocount 1 --binSize 100  --skipZeroOverZero --normalizeUsing RPKM --numberOfProcessors max/2 -o $wk/normalization/`basename $CHIPNAME`.to.input.log2ratio.rpkm.bw
/home/lina//programfile/ucsc.tools/bigWigToBedGraph $wk/normalization/`basename $CHIPNAME`.to.input.log2ratio.rpkm.bw $wk/normalization/`basename $CHIPNAME`.to.input.log2ratio.rpkm.bedGraph

bamCompare -b1 $target -b2 $input --scaleFactorsMethod None --operation subtract --binSize 100  --skipZeroOverZero --normalizeUsing RPKM --numberOfProcessors max/2 -o $wk/normalization/`basename $CHIPNAME`.to.input.subtract.rpkm.bw
/home/lina//programfile/ucsc.tools/bigWigToBedGraph $wk/normalization/`basename $CHIPNAME`.to.input.subtract.rpkm.bw $wk/normalization/`basename $CHIPNAME`.to.input.subtract.rpkm.bedGraph

#get Sicer peakcalling for the broad peaks
#using epic2 software
mkdir $wk/epic2.broadpeak/

epic2out=$wk/epic2.broadpeak/`basename $CHIPNAME`.epic2.broadpeaks.txt
source ~/programfile/epic2/venv/bin/activate
epic2 --treatment $target --control $input --genome hg19 --bin-size 1000 --gaps-allowed 3 --output $epic2out
deactivate

#get homer broadpeaks calling
#using findpeaks
mkdir $wk/homer/
mkdir $wk/homer/output.tag/
mkdir $wk/homer/control.tag/
cd $wk/homer/
homersignaltagdir=$wk/homer/output.tag/
homercontroltagdir=$wk/homer/control.tag/
suffix=".bam"
homersignalfile=${target/%$suffix}.bed
homercontrolfile=${input/%$suffix}.bed
makeTagDirectory $homersignaltagdir $homersignalfile -format bed
makeTagDirectory $homercontroltagdir $homercontrolfile -format bed
findPeaks $homersignaltagdir -style histone -region -size 1000 -minDist 2500 -o auto -i $homercontroltagdir
cp $homersignaltagdir/regions.txt $wk/homer/`basename $CHIPNAME`.homer.broadpeaks.txt
tar -czvf $wk/homer/signal.tag.tar.gz $homersignaltagdir
tar -czvf $wk/homer/control.tag.tar.gz $homercontroltagdir
rm -rf $homercontroltagdir
rm -rf $homersignaltagdir


