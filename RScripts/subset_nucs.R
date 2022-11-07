#!/usr/bin/env Rscript

# FUN TO SUBSET A REFERENCE LIB FOR EACH MARKER
subset_nucs <- function(pref,df){
    df %<>% rename(nucleotidesFrag=!!as.name(paste0("nucleotidesFrag.",pref)), lengthFrag=!!as.name(paste0("lengthFrag.",pref)))
    df %<>% filter(!is.na(nucleotidesFrag))
    return(df)
}
