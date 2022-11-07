#!/usr/bin/env Rscript

# FUN TO PLOT AND ANNOTATE PHYLOGENETIC TREES
plot_trees <- function(tr,df,prefix,version){
    tr <- ape::ladderize(phangorn::midpoint(tr))
    sppv <- pull(df,sciNameValid)[match(str_split_fixed(tr$tip.label,"\\|",3)[,1],pull(df,dbid))]
    monov <- spider::monophyly(tr,sppVector=sppv)
    allmono <- monov[match(sppv, unique(sppv))]
    cols <- rep("gray20",length(tr$tip.label))
    cols[which(allmono==FALSE)] <- "hotpink"
    cols[match(df$noms[which(df$nMatches>1)], tr$tip.label)] <- "green3"
    tmp.path <- paste0("reports/qc_v",version,"_",paste(month(ymd(Sys.Date()),label=TRUE),year(ymd(Sys.Date())),sep="-"))
    if(!dir.exists(here(tmp.path))){
        dir.create(here(tmp.path))
        }
    dfs <- df %>% summarise(nSeqs=sum(nHaps),nHaps=length(nHaps),nSpp=length(unique(sciNameValid)))
    tit <- paste0(str_replace_all(prefix,"\\.noprimers",""),"\n(n=",pull(dfs,nSeqs),", n haplotypes=",pull(dfs,nHaps),", n spp.=",pull(dfs,nSpp),")\nlabel format = 'dbid|Genus species|n haplotypes'\npink = non-monophyletic species\ngreen = shared haplotypes\nscroll down for tree ...")
    pdf(file=paste0(tmp.path,"/RAxML_bestTree.",prefix,".pdf"), width=15, height=length(tr$tip.label)/10)
    plot.phylo(tr, tip.col=cols, cex=0.5, font=1, label.offset=0.01, no.margin=TRUE)
    title(tit, line=-10)
    dev.off()
}
