# **Análisis de microbiota**

## Objetivo
1. Análizar datos de microbioma de suelo.
2. Evaluar diversidad filogenética, alfa y beta.
3. Evaluar toxonomía y abundacia de microbioma.

## Requerimientos 
instalar conda -> liga de descarga. 
### Crear entorno 
El archivo enronment.yml ya contiene todo lo necesario para que el proyecto pueda ser corrido en cualquier entorno. 

`conda env create -f environment.yml `

Una vez creado el entorno se debe inicializar para tener las dependencias activas y poder ejecutar el proyecto. 

`conda activate qiime2-amplicon-2023.9`

| https://docs.qiime2.org/2024.10/ 
---

## Explicación del proyecto
## Worflow 
**_1. Obtener los datos:_** 
Ingresamos al directorio y se descargan los metadatos en un archivo llamado sample_metadata.tsv. 
descarga con comando wget o curl. 
| apt-get install wget
| apt-get install curl

**_2. Crear artefacto de qiime2 con las secuencias:_** 
Qiime2 trabaja con archivos llamados artefactos (extensión de archivos .qza)
| emp-paired-end-sequences.qza

**_3. Demultiplex reads:_** 
Se separan las lecturas en conjuntos específicos para cada muestra usando los barcodes (secuencias cortas únicas asociadas a cada muestra). Esto asegura que los datos de diferentes muestras analizadas en paralelo durante la secuenciación no se mezclen. 
Archivos:
| demux-full.qza
| demux-details.qza
| demux-subsample.qzv (https://view.qiime2.org/)

**_4.  Filtrar muestras que tienen menos de 100 reads:_** 
Las muestras con menos de 100 reads tienen una cobertura insuficiente para representar con precisión la diversidad microbiana de la muestra, por lo que incluir estas muestras podría introducir sesgos en los análisis de diversidad o taxonomía.
Archivos:
| demux.qza
 
**_5. Revisar calidad y realizar denoising:_** 
En este paso limpiamos y estandarizamos al seleccionar secuencias con un largo fijo de 150 nucleótidos aseguramos la consistencia entre las lecturas por lo que mejora la comparabilidad entre muestras y reduce el ruido generado por lecturas de longitudes variables.
Archivos:
| table.qza (tabla de OTUs, aquí llamados “features”) 
| rep-seqs.qza (Secuencias de los OTUs)
| denoising-stats.qza (estadísticas de la remoción de ruido)
Visualizaciones (https://view.qiime2.org/):
| table.qzv
| denoising-stats.qzv
| rep-seqs.qzv

**_5. Generar árbol para análisis de diversidad filogenética:_**
Árboles filogenéticos nos permite establecer como están relacionadas evolutivamente las secuencias de las muestras.
Archivos: 
| aligned-rep-seqs.qza
| masked-aligned-rep-seqs.qza
| unrooted-tree.qza
| rooted-tree.qza
