#!/usr/bin/env Rscript

# FUNCTION TO RUN PARALLEL NCBI_BYID WITH TIMEOUT AND REPEAT
ncbi_byid_parallel <- function(accs){
    start_time <- Sys.time()
    Sys.sleep(time=runif(n=1,min=0,max=3))
    crul::set_opts(http_version=2)
    ncbi.tab <- traits::ncbi_byid(accs,verbose=FALSE)
    if(class(ncbi.tab)!="data.frame") {
        #writeLines("Error found! Repeating ...")
        Sys.sleep(time=3)
        crul::set_opts(http_version=2)
        ncbi.tab <- traits::ncbi_byid(accs,verbose=FALSE)
    } else {
        ncbi.tab <- ncbi.tab
    }
    if(class(ncbi.tab)!="data.frame") {
        stop(writeLines("Searches failed ... aborted")) 
    } else {
        end_time <- Sys.time()
        writeLines(paste0("Metadata for ",length(accs)," accessions downloaded (starting ",accs[1],"). Download took ",round(as.numeric(end_time-start_time),digits=2)," seconds."))
        return(ncbi.tab)
    }
}
