#!/usr/bin/env Rscript
# script to subset desired references

# load up cleaning fun
subset_references <- function(df,frag) {
    frag <- paste0("nucleotidesFrag.",frag,".noprimers")
    reflib.sub <- df %>% dplyr::filter(!is.na(!!as.name(frag))) %>%
        dplyr::mutate(nucleotidesFrag=!!as.name(frag), lengthFrag=!!as.name(str_replace_all(frag,"nucleotides","length"))) %>%
        select(-contains("Frag"))
    return(reflib.sub)
}
