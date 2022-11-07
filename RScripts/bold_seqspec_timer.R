#!/usr/bin/env Rscript

# FUNCTION TO RUN PARALLEL BOLD WITH TIMEOUT
bold_seqspec_timer <- function(species){
    start.time.bold <- Sys.time()
    Sys.sleep(time=sample(seq(from=0,to=5,by=0.1),1))
    bold.res <- bold::bold_seqspec(species,format="tsv",sepfasta=FALSE,response=FALSE)
    end.time.bold <- Sys.time()
    if(class(bold.res)=="data.frame"){
    writeLines(paste(nrow(bold.res),"records for",length(unique(pull(bold.res,species_name))),"species downloaded from BOLD.","Download took",round(as.numeric(end.time.bold-start.time.bold, units="mins"),digits=2),"minutes.",sep=" "))
    } else {writeLines("No records found.")}
    return(bold.res)
}
