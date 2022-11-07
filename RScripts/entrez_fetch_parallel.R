#!/usr/bin/env Rscript

# FUNCTION TO RUN PARALLEL ENTREZ FETCH 
entrez_fetch_parallel <- function(search,key){
    start_time <- Sys.time()
    fas.path <- here("temp/fasta-temp",paste0(search$web_history$WebEnv,".fas"))
    Sys.sleep(time=runif(n=1,min=0,max=2))
        for(i in seq(0,search$count,as.integer(9999))){
        n.res <- entrez_fetch(db="nuccore",web_history=search$web_history,retstart=i,retmax=as.integer(9999),rettype="fasta",api_key=key)
        write(n.res,file=fas.path,append=TRUE)
        }
    end_time <- Sys.time()
    writeLines(paste("Query",search$web_history$WebEnv,"written to file.","Download took",round(as.numeric(end_time-start_time),digits=2),"seconds.",sep=" "))
}
