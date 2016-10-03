#!/usr/bin/env Rscript
#
# Demo 1: AnnotationHub / OrgDb / GRanges
# See: https://bioconductor.org/packages/release/bioc/vignettes/AnnotationHub/inst/doc/AnnotationHub.html
#
library(AnnotationHub)
ah = AnnotationHub()

# overview
ah

# our AnnotationHub instance behaves a bit like a list in R...
ah[1]

# mcols can be used to retrieve a dataframe of metadata for one or more records
mcols(ah[1])

# what datatypes are availble?
table(ah$rdataclass)

# and species?
table(ah$species)

# to find a particular annotation, we can use the "query" function
# query() accepts one or more strings which are used to grep through the
# record metadata
query(ah, 'tryp')
query(ah, c('OrgDb', 'tryp'))

# to download and load the resource, use the [[ ]] syntax:
ahs <- query(ah, c('OrgDb', 'tryp'))
orgdb <- ahs[[1]]

# retrieving gene names from the OrgDb instance
columns(orgdb)
gene_ids <- head(keys(orgdb, keytype='GID'))
select(orgdb, keys=gene_ids, keytype='GID', columns='GENENAME')

# GRanges objects 
# https://bioconductor.org/packages/release/bioc/html/GenomicRanges.html
ahs <- query(ah, c('GRanges', 'sapiens'))
ahs
gr <- ahs[['AH51014']]

# GRanges entry types (same as GFF)
table(gr$type)

# Getting gene lengths
genes <- gr[gr$type == 'gene']
width(genes)
