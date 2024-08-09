for i in UCSD.025-*/25*input*/mapping/*.txt; do echo $i; grep UNPAIRED $i; done; 

for i in UCSD.025-*/25*input*/deduplicate/*.unique.report.txt; do echo $i; grep UNPAIRED $i; done; 

for i in UCSD.025*/25*K*/mapping/*.txt; do echo $i; grep UNPAIRED $i; done;

for i in UCSD.025*/25*K*/deduplicate/*.unique.report.txt; do echo $i; grep UNPAIRED $i; done;
