#!/usr/bin/env Rscript

# FUNCTION TO WRITE OUT REFERENCE LIBRARIES IN VARIOUS FORMATS
write_references_fasta <- function(df,path=NULL) {
# create labels
    df.labs <- df %>% 
        dplyr::mutate(kingdom="Animalia") %>%
        dplyr::arrange(kingdom,phylum,class,order,family,genus,sciNameValid,dbid) %>% 
        dplyr::mutate(labelSintax=paste0(dbid,";tax=k:",kingdom,",p:",phylum,",c:",class,",o:",order,",f:",family,",g:",genus,",s:",sciNameValid)) %>% 
        dplyr::mutate(labelSintax=str_replace_all(labelSintax," ","_")) %>%
        dplyr::mutate(labelDadaTaxonomy=paste0(phylum,";",class,";",order,";",family,";",genus,";",sciNameValid,";")) %>%
        dplyr::mutate(labelDadaSpecies=paste(dbid,str_split_fixed(sciNameValid," ",2)[,1],str_split_fixed(sciNameValid," ",2)[,2]))
        # get version
        gbv <- paste0("v",unique(pull(df.labs,genbankVersion))[1])
        mbc <- unique(pull(df.labs,metabarcode))
    
    # make filenames
    filename.dbid <- paste("references",mbc,"dbid",gbv,"fasta",sep=".")
    filename.sintax <- paste("references",mbc,"sintax",gbv,"fasta",sep=".")
    filename.dada.taxonomy <- paste("references",mbc,"dada.taxonomy",gbv,"fasta",sep=".")
    filename.dada.species <- paste("references",mbc,"dada.species",gbv,"fasta",sep=".")
    filename.table <- paste("references",mbc,"cleaned",gbv,"csv",sep=".")

    # add paths
    if(is.null(path)) {
        Sys.sleep(0.1)
    } else {
        filename.dbid <- here::here(path,filename.dbid)
        filename.sintax <- here::here(path,filename.sintax)
        filename.dada.taxonomy <- here::here(path,filename.dada.taxonomy)
        filename.dada.species <- here::here(path,filename.dada.species)
        filename.table <- here::here(path,filename.table)
    }

    # convert to fasta file and write out all formatted fasta file
    ape::write.FASTA(tab2fas(df=df.labs,seqcol="nucleotides",namecol="dbid"), file=filename.dbid)
    ape::write.FASTA(tab2fas(df=df.labs,seqcol="nucleotides",namecol="labelSintax"), file=filename.sintax)
    ape::write.FASTA(tab2fas(df=df.labs,seqcol="nucleotides",namecol="labelDadaTaxonomy"), file=filename.dada.taxonomy)
    ape::write.FASTA(tab2fas(df=df.labs,seqcol="nucleotides",namecol="labelDadaSpecies"), file=filename.dada.species)
    
    # write table
    df.labs.write <- df.labs %>% 
        dplyr::select(c(-labelSintax,-labelDadaTaxonomy,-labelDadaSpecies)) %>%
        dplyr::relocate(kingdom,.before=phylum) %>%
        dplyr::relocate(metabarcode,nHaps,.before=length) %>%
        dplyr::rename(numberHaplotypes=nHaps)
    #glimpse(df.labs.write)
    readr::write_csv(df.labs.write,file=filename.table)
}
# write_references_fasta(df=reflib.sub)
# write_references_fasta(df=reflib.sub,path=here::here("assets/fasta"))
