#!/bin/bash

#Crear artefacto
qiime tools import --type EMPPairedEndSequences --input-path emp-paired-end-sequences --output-path emp-paired-end-sequences.qza &
PID_PROCESO=$!
wait "$PID_PROCESO"

#Demultuplex reads
qiime demux emp-paired --m-barcodes-file sample-metadata.tsv --m-barcodes-column barcode-sequence --p-rev-comp-mapping-barcodes --i-seqs emp-paired-end-sequences.qza --o-per-sample-sequences demux-full.qza --o-error-correction-details demux-details.qza &
PID_PROCESO=$!
wait "$PID_PROCESO"
echo "Demultuplexado de lecturas completado..."

#Creacion de submuestra
qiime demux subsample-paired --i-sequences demux-full.qza --p-fraction 0.3 --o-subsampled-sequences demux-subsample.qza &
PID_PROCESO=$!
wait "$PID_PROCESO"
echo "Creación de submuestra completado..."

mkdir demux-subsample
#Filtrar muestras con menos de 100 reads
qiime demux summarize --i-data demux-subsample.qza --o-visualization demux-subsample.qzv &
PID_PROCESO=$!
wait "$PID_PROCESO"

qiime tools export --input-path demux-subsample.qzv --output-path ./demux-subsample/ &
PID_PROCESO=$!
wait "$PID_PROCESO"

qiime demux filter-samples --i-demux demux-subsample.qza --m-metadata-file ./demux-subsample/per-sample-fastq-counts.tsv --p-where 'CAST([forward sequence count] AS INT) > 100' --o-filtered-demux demux.qza &
PID_PROCESO=$!
wait "$PID_PROCESO"
echo "Filtrado de muestras con menos de 100 lecturas"
