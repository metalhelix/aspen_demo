#!/bin/bash
if [ $# -eq 0 ]; then
  echo "Usage: $0 fastq";
fi
if [ $# -ne 1 ]; then
    echo "FASTQ file required"
    exit 1
fi

BOWTIE=$(which bowtie)
BOWTIE_INDEXES='/n/projects/srm/genomes/current_genome/ensembl/release-75/mus_musculus/bowtie_indexes/'
GENOME="${BOWTIE_INDEXES}Mus_musculus.GRCm38.75.min"

FASTQ=$1
BAM=$(basename ${FASTQ} ".fastq.gz")".bam"
CPU=8
JOB_ID="$(basename ${BAM} .bam)_${USER}"

job="${BOWTIE} -S -p ${CPU} ${GENOME} <(gunzip -c ${FASTQ}) --chunkmbs 512 -m 1 -k 1 -n 2 --best --strata | samtools view -F 4 -Sbo ${BAM} - "

qsub -N ${JOB_ID} -j y -pe by_node $CPU -cwd -M ${USER}@stowers.org -m ae -b y "$job"

