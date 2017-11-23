library(dplyr)
library(seqinr)
library(data.table)

gene_files <- list.files(pattern = "_gene")

gene_res_filter <- data.frame()
for (i in 1:length(gene_files)){
      df <- read.csv(gene_files[i], sep = '\t')
      df$Abundance <- df$Hits/sum(df$Hits)
      df_filter <- df 
      gene_res_filter <- rbind(gene_res_filter, df_filter)
}

gene_res_filter <- as.data.table(gene_res_filter)
gene_res_filter <- filter(gene_res_filter, Hits > 100)
gene_res_filter$group <- sapply(strsplit(as.character(gene_res_filter$Gene), '\\|'), function(x) tail(x, 1)) 

pat <- as.character(unique(gene_res_filter$Sample))

megares_db <- read.fasta('/data5/bio/runs-jeniaole/tools/megares/database/megares_database_v1.01.fasta', 
                         seqtype = "DNA",as.string = TRUE, set.attributes = FALSE, forceDNAtolower = F)

for (i in 1:length(pat)){
      df <- gene_res_filter %>% 
            filter(Sample %in% pat[[i]]) %>% 
            mutate(Group = group) %>% 
            select(Gene, Group, Hits) %>% 
            group_by(Group) %>% 
            top_n(1, Hits)
      
      subset_megares_db <- megares_db[c(which(names(megares_db) %in% as.character(df$Gene)))]
      names_files <- paste(sapply(strsplit(names(subset_megares_db), '\\|'), 
                                  function(x) tail(x, 1)) , '.fasta', sep = '')
      
      gene_dir <- paste0('metacherchant/', pat[i])
      
      write.fasta(subset_megares_db, file.out = paste0(gene_dir,'/', "genes.fasta"), names = names(subset_megares_db))      
}
