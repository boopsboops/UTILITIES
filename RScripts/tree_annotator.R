#!/usr/bin/env Rscript

# MAKE MCC TREE
tree_annotator <- function(infile,outfile) {
        string.search <- paste("treeannotator -burninTrees 0 -heights ca",infile,outfile)
        system(command=string.search,ignore.stdout=FALSE)
}
