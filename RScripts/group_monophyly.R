#!/usr/bin/env Rscript

# fun to run monophyly test over tree sample
group_monophyly <- function(df,trs,topo,cores) {
    res <- mcmapply(function(x) ape::is.monophyletic(phy=x,tips=pull(filter(df,clade==topo),dbidNex)), x=trs,SIMPLIFY=TRUE,USE.NAMES=FALSE,mc.cores=cores)
    res <- as.numeric(res)
    prop <- sum(res)/length(res)
    tib <- tibble(clade=topo,postCladeProb=prop)
    return(tib)
}
