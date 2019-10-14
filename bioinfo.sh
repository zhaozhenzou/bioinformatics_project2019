# Create one reference file for each gene

for file in mcrAgene*
do 
cat $file >> mcrAgene.ref
done

for file in hsp70gene*
do 
cat $file >> hsp70gene.ref
done

# Alignment using muscle

../../muscle -in mcrAgene.ref -out mcrAgene.align
../../muscle -in hsp70gene.ref -out hsp70gene.align
