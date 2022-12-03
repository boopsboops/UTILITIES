#!/usr/bin/env Rscript

# FUNCTION TO CALCULATE SPECIES THAT DROP OUT OF A DATASET AFTER LENGTH TRIMMING
# species_lost(df=reflib,thresh=0.5)
# threshold is a proportion of the mean sequence length
species_lost <- function(df,thresh){
    removed <- df %>% filter(length < (median(length)*thresh)) %>% select(sciNameValid)
    kept <- df %>% filter(length >= (median(length)*thresh)) %>% select(sciNameValid)
    tot <- setdiff(removed$sciNameValid, kept$sciNameValid)
    return(tot)
}
