#!/bin/bash


#Descargar librería
echo "Iniciando descarga de libería.."
curl -sL "https://data.qiime2.org/2023.5/tutorials/atacama-soils/sample_metadata.tsv" > "sample-metadata.tsv" &

PID_PROCESO=$!
wait "$PID_PROCESO"

#Crear carpetas de metadata 
mkdir emp-paired-end-sequences

echo "Iniciando descarga de metadata"
#Descarga de archivos de metadata
curl -sL "https://data.qiime2.org/2023.5/tutorials/atacama-soils/10p/forward.fastq.gz" > "emp-paired-end-sequences/forward.fastq.gz" &
PID_PROCESO=$!
wait "$PID_PROCESO"
curl -sL "https://data.qiime2.org/2023.5/tutorials/atacama-soils/10p/reverse.fastq.gz" > "emp-paired-end-sequences/reverse.fastq.gz" &
PID_PROCESO=$!
wait "$PID_PROCESO"
curl -sL "https://data.qiime2.org/2023.5/tutorials/atacama-soils/10p/barcodes.fastq.gz" > "emp-paired-end-sequences/barcodes.fastq.gz" &
PID_PROCESO=$!
wait "$PID_PROCESO"

echo "Descarga de metadata completado..."

