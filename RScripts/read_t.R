#!/usr/bin/env Rscript

# fun to load mrbayes trees
read_t <- function(basename,run,burnin){    
    tree.file.name <- paste0(basename,run,".t")
    mrbayes.trees <- ape::read.nexus(here(tree.file.name))
    mrbayes.trees.burnin <- mrbayes.trees[burnin:length(mrbayes.trees)]
    return(mrbayes.trees.burnin)
}
