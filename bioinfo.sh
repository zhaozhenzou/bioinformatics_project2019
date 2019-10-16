# Usage: bash bioinfo.sh

# Create one reference file for each gene

for file in ./ref_sequences/mcrAgene*
do 
cat $file >> mcrAgene.ref
done

for file in ./ref_sequences/hsp70gene*
do 
cat $file >> hsp70gene.ref
done

# Alignment using muscle

../muscle -in mcrAgene.ref -out mcrAgene.align
../muscle -in hsp70gene.ref -out hsp70gene.align

# builds HMM profile using hmmbuild

../hmmer-3.2.1/bin/hmmbuild hsp70gene.hmm hsp70gene.align
../hmmer-3.2.1/bin/hmmbuild mcrAgene.hmm mcrAgene.align

# use hmmsearch to search genome for markers

for file in ./proteomes/*.fasta
do
echo $file >> resultsmcrA.txt
../hmmer-3.2.1/bin/hmmsearch --tblout mcrAgene.match mcrAgene.hmm $file | grep ">>" | wc -l >> resultsmcrA.txt
echo $file >> resultshsp70.txt
../hmmer-3.2.1/bin/hmmsearch --tblout hsp70gene.match hsp70gene.hmm $file | grep ">>" | wc -l >> resultshsp70.txt
done

