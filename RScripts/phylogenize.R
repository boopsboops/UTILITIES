#!/usr/bin/env Rscript

# FUN TO ALIGN SEQS AND MAKE A PHYLOGENETIC TREE
phylogenize <- function(dir,fas,prefix,verbose){
    file.fas <- here("temp",dir,paste0(prefix,".fas"))
    ape::write.FASTA(fas,file=file.fas)
    tr <- raxml_ng(file=file.fas,verbose=verbose)
    return(tr)
}
