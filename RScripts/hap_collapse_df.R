#!/usr/bin/env Rscript

# COLLAPSES HAPLOTYPES (FROM A DATAFRAME FORMAT TO A DATAFRAME FORMAT)
# need to specify columns that contain sequence lengths, and nucleotides
# hap_collapse_df(df=mydataframe,lengthcol="lengthFrag",nuccol="nucleotidesFrag")
# add a number of each haplotype
hap_collapse_df <- function(df,lengthcol,nuccol,cores){
    odf <- df[order(df[[lengthcol]],decreasing=TRUE),]
    if(cores==1) {
        reps <- mapply(FUN=function(x) which(str_detect(string=odf[[nuccol]], pattern=x) == TRUE)[1], odf[[nuccol]], SIMPLIFY=TRUE, USE.NAMES=FALSE)
    } else {
        reps <- mcmapply(FUN=function(x) which(str_detect(string=odf[[nuccol]], pattern=x) == TRUE)[1], odf[[nuccol]], SIMPLIFY=TRUE, USE.NAMES=FALSE, mc.cores=cores)
    }
    ind <- unique(reps)
    dat <- odf[ind,]
    dat[["nHaps"]] <- as.numeric(table(reps))
    return(dat)
}
