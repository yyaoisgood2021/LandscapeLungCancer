file=$1

awk '{print $1 "\t" $2 "\t" $3}' $file > tmp.txt
awk '{print $10 "\t" $11 "\t" $12}' $file >> tmp.txt

sort -V tmp.txt> `basename $file .bed`.sorted.to.merge.bed
rm -f tmp.txt

bedtools merge -i `basename $file .bed`.sorted.to.merge.bed > `basename $file .bed`.merge.peaks.bed
