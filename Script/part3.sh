#!/bin/bash

#Revisar calidad y realizar denoising
qiime dada2 denoise-paired --i-demultiplexed-seqs demux.qza --p-trim-left-f 13 --p-trim-left-r 13 --p-trunc-len-f 150 --p-trunc-len-r 150 --o-table table.qza --o-representative-sequences rep-seqs.qza --o-denoising-stats denoising-stats.qza &
PID_PROCESO=$!
wait "$PID_PROCESO"
echo "Revisar calidad y denoising completado..."

#Generacion de resumenes
qiime feature-table summarize --i-table table.qza --o-visualization table.qzv --m-sample-metadata-file sample-metadata.tsv &
PID_PROCESO=$!
wait "$PID_PROCESO"

qiime feature-table tabulate-seqs --i-data rep-seqs.qza --o-visualization rep-seqs.qzv &
PID_PROCESO=$!
wait "$PID_PROCESO"

qiime metadata tabulate --m-input-file denoising-stats.qza --o-visualization denoising-stats.qzv &
PID_PROCESO=$!
wait "$PID_PROCESO"
echo "Generación de resúmenes completado..."

#Generar un árbol para el análisis de diversidad filogenética
qiime phylogeny align-to-tree-mafft-fasttree --i-sequences rep-seqs.qza --o-alignment aligned-rep-seqs.qza --o-masked-alignment masked-aligned-rep-seqs.qza --o-tree unrooted-tree.qza --o-rooted-tree rooted-tree.qza &
PID_PROCESO=$!
wait "$PID_PROCESO"
echo "Generar árboles filogenéticos completado..."
