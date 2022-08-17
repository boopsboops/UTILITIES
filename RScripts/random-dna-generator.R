#!/usr/bin/env Rscript


# random DNA function
random_DNA <- function(length,gc,seed) {
    gc.prop <- gc/2
    at.prop <- (1-gc)/2
    set.seed(seed)
    seq <- sample(c("A","C","T","G"),replace=TRUE,size=length,prob=c(at.prop,gc.prop,at.prop,gc.prop))
    seq.cat <- paste(seq,collapse="")
    return(seq.cat)
}


# random seed gen
seed_generator <- function(n,mseed) {
    set.seed(mseed)
    rnd.list <- runif(n=n, min=1, max=9999999)
    rnd.list.round <- floor(rnd.list)
    return(rnd.list.round)
}


# get seeds
#seed.list <- seed_generator(n=100,mseed=42)
# get DNAs
#dnas.rnd <- mapply(function(x) random_DNA(length=81,gc=0.55,seed=x),x=seed.list)
#random_DNA(length=50000,gc=0.55,seed=42)

# print
#print(dnas.rnd)

# write out as fasta
#write(paste0(">dna",seed.list,"\n",dnas.rnd),file="length81-seed42-gc55.fas")
