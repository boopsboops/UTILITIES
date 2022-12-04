#!/usr/bin/env Rscript

# FUNCTION TO DEREPLICATE AND FILTER REFERENCE LIBRARIES
derep_filter <- function(df,derep,proplen,cores=1) {
    if(isTRUE(derep)) {
    df.haps <- df %>% 
        dplyr::group_by(sciNameValid) %>% 
        dplyr::group_modify(~ hap_collapse_df(df=.x,lengthcol="length",nuccol="nucleotides",cores=cores)) %>% 
        dplyr::ungroup() %>%
        dplyr::filter(length >= (median(length)*proplen))
    } else {
    df.haps <- df %>% 
        dplyr::filter(length >= (median(length)*proplen))
    }
    return(df.haps)
}
#derep_filter(df=reflib.sub,derep=TRUE,proplen=0.5,cores=1)
