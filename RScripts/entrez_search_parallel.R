#!/usr/bin/env Rscript


# FUNCTION TO RUN PARALLEL ENTREZ SEARCHES 
entrez_search_parallel <- function(query,threads,key){  
    start_time <- Sys.time()
    n.res <- suppressWarnings(mcmapply(FUN=function(x) entrez_search(db="nuccore", term=x, retmax=as.integer(99999), api_key=key, use_history=TRUE), query, SIMPLIFY=FALSE, USE.NAMES=FALSE, mc.cores=threads))
    errs <- grepl("Error",n.res)
    if(any(errs==TRUE)) {
        n.res.rep <- suppressWarnings(mcmapply(FUN=function(x) entrez_search(db="nuccore", term=x, retmax=as.integer(99999), api_key=key, use_history=TRUE), query[which(errs==TRUE)], SIMPLIFY=FALSE, USE.NAMES=FALSE, mc.cores=1))
        n.res[which(errs==TRUE)] <- n.res.rep
    } else {
        n.res <- n.res
    }
    end_time <- Sys.time()
    errs.fin <- grepl("Error",n.res)
    if(any(errs.fin==TRUE)) { 
        stop(writeLines("Searches failed ... aborted")) 
    } else {
        writeLines(paste("Results returned for",length(which(errs.fin==FALSE)), "batches.","Search took",round(as.numeric(end_time-start_time),digits=2),"seconds.",sep=" "))
        return(n.res)
    }
}
