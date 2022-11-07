#!/usr/bin/env Rscript

# FUNCTION TO GET RETRIEVE SPECIES NAMES OF SEQUENCES WITH AN IDENTICAL HAPLOTYPE AS YOUR QUERY 
# works on a dataframe
# get_sames(df=mydataframe,ids="dbid",nucs="nucleotidesFrag",sppVec="sciNameValid",query=mydataframe$nucleotidesFrag[[1]])
get_sames <- function(df,ids,nucs,sppVec,query){
    per.ind <- df[[sppVec]][str_detect(df[[nucs]], query)]
    return(per.ind)
}
