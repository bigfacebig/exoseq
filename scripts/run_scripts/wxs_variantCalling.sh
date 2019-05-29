#!/bin/bash

# The purpose of this script is to run the LosicLab's custom fork of nextflow's whole exome sequencing processing pipeline for fastq->vcf.


# Run directory. Pipeline outputs to $rundir/preprocessing
rundir=$PWD"testdata/tiny"

# Reference genome to use [Default: GRCh38; other refs not yet supported]
ref="GRCh38"

# Path to directory containing the pipeline to run
pipeline='/sc/orga/projects/losicb01a/common_folder/nextflow-pipelines/sandbox/exoseq'
#mkdir -p $rundir
cd $rundir

module purge
module load openssl
module load anaconda
module load nextflow/0.30.2

nID='Normal' # identifier for normal sample
tID='Tumor' # identifier for tumor sample
       # (leave blank & comment out lines using this variable if no somatic mutation calling)

nbam="GATK_ApplyBQSR/"$nID"/tiny*.bam"
tbam="GATK_ApplyBQSR/"$tID"/tiny*.bam"

nextflow run $pipeline/variantCalling.nf --nbam "$nbam" --tbam "$tbam" --genome $ref -resume -profile chimera_local
