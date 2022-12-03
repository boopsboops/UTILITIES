#!/usr/bin/env Rscript

# FUNCTION TO CALCULATE SEQUENCES REMOVED FROM A DATASET AFTER LENGTH TRIMMING
# sequences_removed(df=reflib,thresh=0.5)
# threshold is a proportion of the mean sequence length
sequences_removed <- function(df,thresh){
    removed <- df %>% filter(length < (median(length)*thresh)) %>% select(dbid)
    n.removed <- length(removed$dbid)
    return(n.removed)
}
