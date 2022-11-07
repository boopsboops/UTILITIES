#!/usr/bin/env Rscript

# FUN TO ANNOTATE A REFERENCE LIBRARY TABLE WITH NUMBER HAPLOTYPES PER SPECIES
haps2fas <- function(df){
    df <- bind_rows(mcmapply(FUN=function(x) hap_collapse_df(df=x,lengthcol="lengthFrag",nuccol="nucleotidesFrag",cores=1), split(df,pull(df,sciNameValid)), SIMPLIFY=FALSE,mc.cores=1))
    sames <- mclapply(FUN=function(x) get_sames(df=df,ids="dbid",nucs="nucleotidesFrag",sppVec="sciNameValid",query=x), pull(df,nucleotidesFrag), mc.cores=1)
    df %<>% mutate(nMatches=sapply(sames, function(x) length(unique(x))), matchTax=sapply(sames, function(x) paste(unique(x),collapse=" | ")))
    df %<>% mutate(noms=paste(dbid,str_replace_all(sciNameValid," |:|'","_"),nHaps,sep="|")) %>% arrange(class,order,family,genus,sciNameValid,lengthFrag,dbid)
    return(df)
}
