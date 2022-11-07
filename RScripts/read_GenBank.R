#!/usr/bin/env Rscript

# MODIFIED `read.GenBank` FUN INCLUDES API KEY FOR NCBI 
read_GenBank <- function (access.nb, seq.names = access.nb, species.names = FALSE, 
    as.character = FALSE, chunk.size = 200, quiet = FALSE, api.key) 
{
    chunk.size <- as.integer(chunk.size)
    N <- length(access.nb)
    a <- 1L
    b <- if (N > chunk.size) 
        chunk.size
    else N
    fl <- paste0(tempfile(pattern=paste0(access.nb[1],"_"),tmpdir=here::here("temp/fasta-temp")), ".fas")
    if (!quiet) 
        #cat("Note: chunk.size =", chunk.size, "(max nb of sequences downloaded together)\n")
    repeat {
        if (!quiet) 
            cat("\rDownloading sequences:", b, "/", N, "...")
        URL <- paste0("https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=", 
            paste(access.nb[a:b], collapse = ","), "&rettype=fasta&retmode=text&api_key=", api.key)
        X <- scan(file = URL, what = "", sep = "\n", quiet = TRUE)
        cat(X, sep = "\n", file = fl, append = TRUE)
        if (b == N) 
            break
        a <- b + 1L
        b <- b + chunk.size
        if (b > N) 
            b <- N
    }
    if (!quiet) {
        cat(" Done.")
        #cat("\nReading sequences...")
    }
    res <- read.FASTA(fl)
    if (is.null(res)) 
        return(NULL)
    attr(res, "description") <- names(res)
    if (length(access.nb) != length(res)) {
        names(res) <- gsub("\\..*$", "", names(res))
        failed <- paste(access.nb[!access.nb %in% names(res)], 
            collapse = ", ")
        warning(paste0("cannot get the following sequence(s):\n", 
            failed))
    }
    else names(res) <- access.nb
    if (as.character) 
        res <- as.character(res)
    if (!quiet) 
        cat("\n")
    if (species.names) {
        a <- 1L
        b <- if (N > chunk.size) 
            chunk.size
        else N
        sp <- character(0)
        repeat {
            if (!quiet) 
                cat("\rDownloading species names:", b, "/", N)
            URL <- paste("https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=", 
                paste(access.nb[a:b], collapse = ","), "&rettype=gb&retmode=text&api_key=", api.key,
                sep = "")
            X <- scan(file = URL, what = "", sep = "\n", quiet = TRUE, 
                n = -1)
            sp <- c(sp, gsub(" +ORGANISM +", "", grep("ORGANISM", 
                X, value = TRUE)))
            if (b == N) 
                break
            a <- b + 1L
            b <- b + chunk.size
            if (b > N) 
                b <- N
        }
        if (!quiet) 
            cat(".\n")
        attr(res, "species") <- gsub(" ", "_", sp)
    }
    Sys.sleep(time=runif(n=1,min=0,max=2))
    res
}

