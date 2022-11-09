#!/usr/bin/env Rscript

# FUNCTION TO READ MPTP OUTPUT FILES
read_mptp <- function(file) {
    tree.name <- stringr::str_split_fixed(basename(file),"\\.",5)[,1]
    mptp.scan <- scan(file=file,what="character",sep="\n",quiet=TRUE)
    skiplines <- grep("Species 1:",mptp.scan)
    skiplines <- skiplines - 1
    writeLines(mptp.scan[1:skiplines])
    mptp.raw <- readr::read_delim(file,skip=skiplines,delim=",",col_names="label",show_col_types=FALSE)
    mptp.tab <- mptp.raw %>% 
        dplyr::mutate(mptpDelim=ifelse(grepl(":",label),label,NA)) %>%
        tidyr::fill(mptpDelim,.direction="down") %>%
        dplyr::filter(!grepl(":",label)) %>%
        dplyr::mutate(mptpDelim=stringr::str_replace_all(mptpDelim,":","")) %>%
        dplyr::mutate(mptpDelim=stringr::str_replace_all(mptpDelim,"Species ","")) %>%
        dplyr::mutate(mptpDelim=paste0("mptp",str_pad(mptpDelim,pad="0",width=4))) %>%
        dplyr::mutate(rep=tree.name) %>%
        dplyr::relocate(mptpDelim,.before=label) %>%
        dplyr::relocate(rep,.before=mptpDelim)
    return(mptp.tab)
}
