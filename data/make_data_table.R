####################################################################################

# NOTE:
# If the R working directory is not already set to
# '/UnityForests_code_and_data/data', it MUST be set to this directory
# before running this script (this is the directory in which this script is located).

# In that case, remove the '#' from the line below and replace 'here/is/my/path/'
# with the path to the directory '/UnityForests_code_and_data/data':

# setwd("here/is/my/path/")

####################################################################################



# Datasets used in the prelimininary study:

datasets_prelim_study <- c("dataset55_rabe_266_id782.Rda", "dataset179_delta_ailerons_id803.Rda", 
              "dataset49_analcatdata_michiganacc_id771.Rda", "dataset34_machine_cpu_id733.Rda", 
              "dataset30_pwLinear_id721.Rda", "dataset66_chscase_vine2_id814.Rda", 
              "dataset41_wisconsin_id753.Rda", "dataset29_veteran_id719.Rda", 
              "dataset106_hutsof99_child_witness_id927.Rda", "dataset178_space_ga_id737.Rda", 
              "dataset177_analcatdata_supreme_id728.Rda", "dataset39_analcatdata_wildcat_id748.Rda", 
              "dataset86_no2_id886.Rda", "dataset92_chscase_geyser1_id895.Rda", 
              "dataset184_tecator_id851.Rda", "dataset181_puma8NH_id816.Rda", 
              "dataset48_strikes_id770.Rda", "dataset68_diggle_table_a1_id817.Rda", 
              "dataset216_houses_id823.Rda", "dataset103_analcatdata_seropositive_id921.Rda", 
              "dataset212_ailerons_id734.Rda", "dataset102_rabe_166_id919.Rda", "dataset76_boston_id853.Rda",
              "dataset114_arsenic-female-bladder_id949.Rda", "dataset77_bolts_id857.Rda", 
              "dataset28_rmftsa_ladata_id717.Rda", "dataset69_diggle_table_a2_id818.Rda", 
              "dataset59_elusage_id790.Rda", "dataset70_chatfield_4_id820.Rda", 
              "dataset71_sensory_id826.Rda")


	
# Load all datasets and extract relevant information:
  
alldatasets <- list.files("./datasets")
ids <- sapply(alldatasets, function(x) strsplit(x, split="_id")[[1]][2])
ids <- as.numeric(gsub(".Rda", "", ids))
alldatasets <- alldatasets[order(ids)]

dataid <- sort(ids)

# Extract the labels:
label <- sub("^dataset[0-9]+_(.*)_id[0-9]+\\.Rda$", "\\1", alldatasets)

study <- ifelse(alldatasets %in% datasets_prelim_study, "pre", "main")


minprop <- n <- p <- propcat <-  0

for(i in seq(along=alldatasets)) {

  load(paste0("./datasets/", alldatasets[i]))
  
  classes <- sapply(dataset, class)
  classes <- classes[names(classes)!="Ytarget"]
  
  propcat[i] <- mean(classes=="factor")
  
  minprop[i] <- min(table(dataset$Ytarget))/sum(table(dataset$Ytarget))
  n[i] <- nrow(dataset)
  p[i] <- ncol(dataset) - 1
  
  if (i %% 10 == 0) cat("i =", i, "\n")
  
}
  

  
 
# Make table with information of interest on the datasets: 
 
datatable <- data.frame(data.id=dataid, label=label, n=n, p=p, propcat=propcat, minprop=minprop, study=study)

rownames(datatable) <- NULL

datatable2 <- datatable
datatable2$propcat <- round(datatable2$propcat, 3)
datatable2$minprop <- round(datatable2$minprop, 3)

datatable2$propcat <- format(datatable2$propcat, nsmall=3)
datatable2$minprop <- format(datatable2$minprop, nsmall=3)






# Make LaTeX commands needed to present the tables that show the information
# on the datasets in the supplement:

tabletext <- ""

for(i in 1:nrow(datatable2)) {
  # Escape the "_":
  rowtext <- gsub("_", "\\\\_", datatable2[i,])
  tabletext[i] <- paste(paste(rowtext, collapse=" & "), " \\\\", sep="")
}
  

tabstart <- c("\\begin{table}[!htb]",
              "\\caption{Overview of datasets -- I. The following information is provided: `data.id': OpenML ID of the dataset, `label': dataset label, `n': sample size, `p': number of covariates, `prop. categ.': proportion of categorial covariates, `prop. min. class': proportion of observations in the smaller class of the target variable, `study': indicator whether the dataset was used in the preliminary analysis (`pre') or the comparison study (`main')}",
              "\\label{tab:data1}",
              "\\begin{tabular}{l | l | l | l | l | l | l}",
              "data.id & label & n & p & prop. categ. & prop. min. class & study \\\\",
              "\\hline")


tabend <- c("\\end{tabular}",
            "\\end{table}")



# Table S1: Overview of datasets – I
#####################################

counter <- 1

tabstarttemp <- gsub("tab:data1", paste0("tab:data", counter), tabstart)
tabstarttemp <- gsub("Overview of datasets -- I", paste0("Overview of datasets -- ", as.roman(counter)), tabstarttemp)

tabletexttemp <- tabletext[1:39]

tabtemp <- c(tabstarttemp, tabletexttemp, tabend)

# Table S1:

outfile <- paste0("../tables/TabS", counter, ".tex")
con <- file(outfile, open = "w", encoding = "UTF-8")
writeLines(tabtemp, con)
close(con)




# Table S2: Overview of datasets – II
#####################################

counter <- 2

tabstarttemp <- gsub("tab:data1", paste0("tab:data", counter), tabstart)
tabstarttemp <- gsub("Overview of datasets -- I", paste0("Overview of datasets -- ", as.roman(counter)), tabstarttemp)

tabletexttemp <- tabletext[39 + (1:45)]

tabtemp <- c(tabstarttemp, tabletexttemp, tabend)

# Table S2:

outfile <- paste0("../tables/TabS", counter, ".tex")
con <- file(outfile, open = "w", encoding = "UTF-8")
writeLines(tabtemp, con)
close(con)





# Table S3: Overview of datasets – III
######################################

counter <- 3

tabstarttemp <- gsub("tab:data1", paste0("tab:data", counter), tabstart)
tabstarttemp <- gsub("Overview of datasets -- I", paste0("Overview of datasets -- ", as.roman(counter)), tabstarttemp)

tabletexttemp <- tabletext[39 + 45 + (1:45)]

tabtemp <- c(tabstarttemp, tabletexttemp, tabend)

# Table S3:

outfile <- paste0("../tables/TabS", counter, ".tex")
con <- file(outfile, open = "w", encoding = "UTF-8")
writeLines(tabtemp, con)
close(con)




# Table S4: Overview of datasets – IV
#####################################

counter <- 4

tabstarttemp <- gsub("tab:data1", paste0("tab:data", counter), tabstart)
tabstarttemp <- gsub("Overview of datasets -- I", paste0("Overview of datasets -- ", as.roman(counter)), tabstarttemp)

tabletexttemp <- tabletext[39 + 2*45 + (1:45)]

tabtemp <- c(tabstarttemp, tabletexttemp, tabend)

# Table S4:

outfile <- paste0("../tables/TabS", counter, ".tex")
con <- file(outfile, open = "w", encoding = "UTF-8")
writeLines(tabtemp, con)
close(con)




# Table S5: Overview of datasets – V
#####################################

counter <- 5

tabstarttemp <- gsub("tab:data1", paste0("tab:data", counter), tabstart)
tabstarttemp <- gsub("Overview of datasets -- I", paste0("Overview of datasets -- ", as.roman(counter)), tabstarttemp)

tabletexttemp <- tabletext[(39 + 3*45 + 1):length(alldatasets)]

tabtemp <- c(tabstart, tabletexttemp, tabend)

# Table S5:

outfile <- paste0("../tables/TabS", counter, ".tex")
con <- file(outfile, open = "w", encoding = "UTF-8")
writeLines(tabtemp, con)
close(con)
