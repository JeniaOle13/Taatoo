##############################################################################################################################################################

setwd("/PATH_TO_metacherchant_output_directory")

library(taxize)
 
##############################################################################################################################################################

annu <- read.csv("megares/database/megares_annotations_v1.01.csv")

genes.list <- read.csv("gene.list", header = F, stringsAsFactors = F)$V1

ds <- NULL
for (j in genes.list){
      g.names <- names(readDNAStringSet(j))
      dir.list <- list.dirs(paste0(dirname(j), "/output"))[-1]
      dir.list <- dir.list[which(is.na(str_extract(dir.list, "tsvs")))]      
      
      if (length(dir.list) != 0){
            
            dt <- NULL
            ass <- NULL
            for (i in 1:length(dir.list)){
                  if (file.size(paste0(dir.list[i], "/", "seqs.labels")) > 0){
                        lbl <- read.csv(paste0(dir.list[i], "/", "seqs.labels"), sep = "\t", header = F, stringsAsFactors = F)
                  }
                  df_dna <- readDNAStringSet(paste0(dir.list[i], "/", "seqs.fasta"))
                  nm <- sapply(str_split(names(df_dna[width(df_dna)>1000]), " "), function(x) x[2])
                  lbl <- lbl[lbl$V1 %in% nm,]
                  if (nrow(lbl) != 0){
                        ass <- data.frame(table(na.omit(sapply(str_split(lbl$V2, ";"), function(x) x[9]))))
                        if (nrow(ass) != 0){
                              ass$gene <- g.names[i]
                              ass <- unique(ass)
                              ass$sample <- gsub("\\.\\/", "", dirname(j))
                        }
                  }
                  dt <- rbind(ass, dt)
                  
            }      
      }
      
      ds <- rbind(ds, dt)            
}

ds2 <- ds[ds$Freq>5,]
ds2 <- unique(ds2[-2])
names(ds2)[1] <- "taxa"
names(ds2)[2] <- "gene_id"
ds2 <- ds2[c(3,1,2)]

ds2$taxa <- gsub("\\[|\\]", "", as.character(ds2$taxa))
ds2 <- ds2[which(is.na(str_extract(ds2$taxa, "butyrate-producing"))),]

ds2$taxa <- sapply(str_split(ds2$taxa, " "), function(x) head(x, 1))

tax.levels <- c("phylum", "class", "order", "family", "genus")

ds3 <- NULL
for (i in 1:length(ds2$taxa)){
      df <- cbind(ds2[i,], tax_name(query = ds2$taxa[i], get = tax.levels, db = "ncbi")[-c(1,2)])
      ds3 <- rbind(ds3, df)
}

ds3 <- ds3[-2]

write.table(ds3, "output.csv", sep = "\t", quote = F, row.names = F)

##############################################################################################################################################################       
