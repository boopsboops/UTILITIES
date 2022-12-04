#!/usr/bin/env Rscript
# script to subset desired references

# load up cleaning fun
subset_references <- function(df,metabarcode) {
    frag <- paste0("nucleotidesFrag.",metabarcode,".noprimers")
    reflib.sub <- df %>% dplyr::filter(!is.na(!!as.name(frag))) %>%
        dplyr::mutate(nucleotides=!!as.name(frag), length=!!as.name(str_replace_all(frag,"nucleotides","length"))) %>%
        select(-contains("Frag")) %>%
        dplyr::mutate(metabarcode=metabarcode)
    return(reflib.sub)
}
