#!/usr/bin/env Rscript

# FUNCTION TO RUN MPTP
run_mptp <- function(file,threshold,minbr) {
    string.mptp <- paste0("mptp --ml --",threshold," --minbr ",minbr," --tree_file ",file," --output_file ",file,".mptp.out")
    system(command=string.mptp,ignore.stdout=FALSE)
    #return(string.mptp)
}
