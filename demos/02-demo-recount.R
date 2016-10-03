#!/usr/bin/env Rscript
#
# Demo 2: ReCount / ExpressionSet
# See: http://bowtie-bio.sourceforge.net/recount/
#

# Load the Illumina BodyMap ExpressionSet RData file from ReCount
load('data/bodymap_eset.RData')

# Re-alias the variable to save on typing...
eset <- bodymap.eset

# You can often learn a good amount about Bioconductor 
# objects by simply printing them to the screen
eset

# At the core of the ExpressionSet is a matrix of expression values, in
# this case counts
dim(eset)

# The primary advantage of working with classes like ExpressionSet and
# SummarizedExperiment is that they keep track of both the data, and the
# corresponding metadata.

# phenoData() can be used to access "phenotype" (sample) metadata
phenoData(eset)

# it stores a data frame with one row for each sample
dim(phenoData(eset))
colnames(phenoData(eset))

# to access the metadata, we can use the $ accessor, e.g.:
phenoData(eset)$tissue.type

# featureData() can be used to access "feature" (usually gene) information
featureData(eset)
dim(featureData(eset))

# in this case there is no extra metadata associated with the genes; just
# the gene identifiers
colnames(featureData(eset))

# Finally, we can use the "exprs()" function to retrieve the actual
# expression data:
exprs(eset)[1:4,1:4]
dim(exprs(eset))
