####################################################################################

# NOTE:
# If the R working directory is not already set to
# '/UnityForests_code_and_data/data', it MUST be set to this directory
# before running this script (this is the directory in which this script is located).

# In that case, remove the '#' from the line below and replace 'here/is/my/path/'
# with the path to the directory '/UnityForests_code_and_data/data':

# setwd("here/is/my/path/")

####################################################################################



# We excluded a larger number of datasets used by Couronné et al., in most cases 
# because there were groups of versions of the same datasets in which cases we 
# selected only one of them in order to avoid dependencies between the datasets used.
######################################################################################

# The datasets "dataset9_monks-problems-1_id333.Rda", "dataset10_monks-problems-2_id334.Rda", and "dataset11_monks-problems-3_id335.Rda"
# are versions of the same dataset.
# --> Delete "dataset10_monks-problems-2_id334.Rda" and "dataset11_monks-problems-3_id335.Rda".


file.remove("./datasets/dataset10_monks-problems-2_id334.Rda")
file.remove("./datasets/dataset11_monks-problems-3_id335.Rda")



# The datasets "dataset12_SPECT_id336.Rda" and "dataset13_SPECTF_id337.Rda" are versions of the same dataset:
# --> Remove "dataset12_SPECT_id336.Rda" because it has fewer observations.

file.remove("./datasets/dataset12_SPECT_id336.Rda")



# The datasets "dataset15_analcatdata_boxing2_id444.Rda" and "dataset17_analcatdata_boxing1_id448.Rda" are versions of the
# same dataset:
# --> Remove "dataset17_analcatdata_boxing1_id448.Rda" because it has fewer observations.

file.remove("./datasets/dataset17_analcatdata_boxing1_id448.Rda")



# "dataset26_vineyard_id713.Rda" and "dataset31_analcatdata_vineyard_id724.Rda" are likely similar,
# with "dataset26_vineyard_id713.Rda" probably being a subset of "dataset31_analcatdata_vineyard_id724.Rda".
# --> Remove "dataset26_vineyard_id713.Rda" because it has much fewer observations.

file.remove("./datasets/dataset26_vineyard_id713.Rda")



# "dataset76_boston_id853.Rda" and "dataset80_boston_id872.Rda" are versions of the
# same dataset.
# --> Remove the second one, i.e. "dataset80_boston_id872.Rda":

file.remove("./datasets/dataset80_boston_id872.Rda")


# "dataset93_chscase_census6_id900.Rda", "dataset96_chscase_census5_id906.Rda",
# "dataset97_chscase_census4_id907.Rda", "dataset98_chscase_census3_id908.Rda", and
# "dataset99_chscase_census2_id909.Rda" are very likely versions of the same dataset
# because they contain the same numbers of observations, and with the exception
# of "dataset93_chscase_census6_id900.Rda" which contains 6 covariates, all contain
# 7 variables.
# --> Delete all these datasets with the exception of "dataset96_chscase_census5_id906.Rda":

file.remove("./datasets/dataset93_chscase_census6_id900.Rda")
file.remove("./datasets/dataset97_chscase_census4_id907.Rda")
file.remove("./datasets/dataset98_chscase_census3_id908.Rda")
file.remove("./datasets/dataset99_chscase_census2_id909.Rda")



# "dataset107_rabe_97_id928.Rda" and "dataset108_rabe_176_id929.Rda" are likely
# versions of the same dataset.
# --> Delete "dataset107_rabe_97_id928.Rda" because it has fewer observations:

file.remove("./datasets/dataset107_rabe_97_id928.Rda")


# Consider the datasets:
# "dataset113_arsenic-male-bladder_id947.Rda",
# "dataset114_arsenic-female-bladder_id949.Rda",
# "dataset115_arsenic-female-lung_id950.Rda", and
# "dataset116_arsenic-male-lung_id951.Rda".
# Given that these all contain the same numbers of
# observations and variables. The datasets "dataset113_arsenic-male-bladder_id947.Rda"
# and "dataset116_arsenic-male-lung_id951.Rda" as well
# as "dataset114_arsenic-female-bladder_id949.Rda" and
# "dataset115_arsenic-female-lung_id950.Rda" most likely
# contain the same subjects.
# --> Delete the datasets "dataset113_arsenic-male-bladder_id947.Rda"
# and "dataset115_arsenic-female-lung_id950.Rda":

file.remove("./datasets/dataset113_arsenic-male-bladder_id947.Rda")
file.remove("./datasets/dataset115_arsenic-female-lung_id950.Rda")



# The datasets "dataset194_kc1_id1067.Rda" and "dataset138_kc1-top5_id1045.Rda"
# are versions of the same dataset:
# "dataset138_kc1-top5_id1045.Rda" is a transformed version of "dataset194_kc1_id1067.Rda"
# with a different target variable definition (Top 5% in defect count ranking).
# --> Delete "dataset138_kc1-top5_id1045.Rda" to retain only one version.

file.remove("./datasets/dataset138_kc1-top5_id1045.Rda")


# The datasets "dataset194_kc1_id1067.Rda", "dataset146_kc2_id1063.Rda", and "dataset148_kc3_id1065.Rda"
# are versions of the same software system (KC - Knowledge Center) but from different modules.
# They share similar attributes and metrics, and were developed using the same coding standards and processes.
# --> Retain only "dataset194_kc1_id1067.Rda" and delete the others for independence.

file.remove("./datasets/dataset146_kc2_id1063.Rda")
file.remove("./datasets/dataset148_kc3_id1065.Rda")


# The datasets "dataset195_pc1_id1068.Rda", "dataset232_pc2_id1069.Rda", 
# "dataset193_pc3_id1050.Rda", and "dataset192_pc4_id1049.Rda"
# are different versions of the same flight software system (PC - Programmed Control) 
# for earth orbiting satellites. They share similar attributes and were extracted 
# using the same metrics tools, making them statistically dependent.
# --> Retain only "dataset192_pc4_id1049.Rda" (least imbalanced) and delete the others for independence.

file.remove("./datasets/dataset195_pc1_id1068.Rda")
file.remove("./datasets/dataset232_pc2_id1069.Rda")
file.remove("./datasets/dataset193_pc3_id1050.Rda")



# The datasets "dataset231_mc1_id1056.Rda" and "dataset140_mc2_id1054.Rda"
# are different components or releases of the same software system (MC - Maintenance Control).
# They share a similar structure, attributes, and were developed using the same coding practices.
# --> Retain only "dataset140_mc2_id1054.Rda" and delete "dataset231_mc1_id1056.Rda" for independence
# ("dataset231_mc1_id1056.Rda" is extremely imbalanced)

file.remove("./datasets/dataset231_mc1_id1056.Rda")



# The dataset "dataset141_cm1_req_id1055.Rda" is related to the same NASA project as "dataset231_mc1_id1056.Rda",
# sharing the same source, metrics extraction methods, and likely similar modules.
# To maintain independence, only one representative dataset is kept.
# --> Delete "dataset141_cm1_req_id1055.Rda".

file.remove("./datasets/dataset141_cm1_req_id1055.Rda")



# The datasets "dataset142_ar1_id1059.Rda", "dataset143_ar3_id1060.Rda", "dataset144_ar4_id1061.Rda",
# "dataset145_ar5_id1062.Rda", and "dataset147_ar6_id1064.Rda" are from the same source,
# a Turkish white-goods manufacturer, collected using the same tools (Prest Metrics Extraction Tool).
# They represent different versions or modules of the same embedded software system.
# --> Retain only "dataset144_ar4_id1061.Rda" as the representative dataset because it is the least imbalanced
# dataset and delete the others for independence.

file.remove("./datasets/dataset142_ar1_id1059.Rda")
file.remove("./datasets/dataset143_ar3_id1060.Rda")
file.remove("./datasets/dataset145_ar5_id1062.Rda")
file.remove("./datasets/dataset147_ar6_id1064.Rda")



# The dataset "dataset149_kc1-binary_id1066.Rda" is a transformed version of the "KC1" dataset,
# with a binary target variable. It is therefore not statistically independent of "dataset194_kc1_id1067.Rda".
# --> Delete "dataset149_kc1-binary_id1066.Rda" and retain "dataset194_kc1_id1067.Rda".

file.remove("./datasets/dataset149_kc1-binary_id1066.Rda")



# The dataset "dataset150_mw1_id1071.Rda" is part of the NASA Metrics Data Program and shares
# the same McCabe and Halstead metrics as other PROMISE datasets. It is derived from similar
# development environments and practices.
# --> To ensure independence, retain only one representative dataset from the same metrics pool.
# --> Delete "dataset150_mw1_id1071.Rda".

file.remove("./datasets/dataset150_mw1_id1071.Rda")


# The dataset "dataset152_datatrieve_id1075.Rda" is related to the same NASA Metrics Data Program,
# but for a different product version (DATATRIEVE transition from version 6.0 to 6.1).
# It shares similar metrics extraction methods and coding practices as other PROMISE datasets.
# --> To maintain independence, delete "dataset152_datatrieve_id1075.Rda".

file.remove("./datasets/dataset152_datatrieve_id1075.Rda")



# The datasets "dataset196_PizzaCutter1_id1443.Rda" and "dataset197_PizzaCutter3_id1444.Rda" are most likely
# versions of the same dataset (same number of features).
# --> Remove the smaller dataset "dataset196_PizzaCutter1_id1443.Rda".

file.remove("./datasets/dataset196_PizzaCutter1_id1443.Rda")



# The datasets "dataset198_PieChart1_id1451.Rda", "dataset199_PieChart2_id1452.Rda", "dataset200_PieChart3_id1453.Rda", and 
# "dataset201_PieChart4_id1454.Rda" are most likely observations from the same dataset.
# --> Retain only "dataset201_PieChart4_id1454.Rda" because it is the largest dat set:

file.remove("./datasets/dataset198_PieChart1_id1451.Rda")
file.remove("./datasets/dataset199_PieChart2_id1452.Rda")
file.remove("./datasets/dataset200_PieChart3_id1453.Rda")



# The dataset "dataset208_electricity_id151.Rda" is a time-series dataset.
# However, we are only interested in i.i.d. date.
# --> Delete the dataset:

file.remove("./datasets/dataset208_electricity_id151.Rda")



# "dataset213_cpu_small_id735.Rda" and "dataset214_cpu_act_id761.Rda" are most
# likely versions of the same dataset as they have the same numbers of observations.
# --> Delete "dataset213_cpu_small_id735.Rda" because it has fewer variables:

file.remove("./datasets/dataset213_cpu_small_id735.Rda")



# Check whether the datasets "dataset215_house_16H_id821.Rda", "dataset216_houses_id823.Rda",
# and "dataset217_house_8L_id843.Rda" are different:

load("./datasets/dataset215_house_16H_id821.Rda")

dataset1 <- dataset
rm(dataset); gc()

load("./datasets/dataset216_houses_id823.Rda")

dataset2 <- dataset
rm(dataset); gc()

load("./datasets/dataset217_house_8L_id843.Rda")

dim(dataset1)
dim(dataset2)
dim(dataset)

par(mfrow=c(3,1))
boxplot(scale(dataset1[,names(dataset1)!="Ytarget"]))
boxplot(scale(dataset2[,names(dataset2)!="Ytarget"]))
boxplot(scale(dataset[,names(dataset)!="Ytarget"]))
par(mfrow=c(1,1))

# --> The dataset "dataset217_house_8L_id843.Rda" seems to be a subset of the dataset 
# "dataset215_house_16H_id821.Rda".
# --> Delete "dataset217_house_8L_id843.Rda" because it has fewer variabes:

file.remove("./datasets/dataset217_house_8L_id843.Rda")



# "dataset47_analcatdata_apnea1_id767.Rda", "dataset46_analcatdata_apnea2_id765.Rda", and 
# "dataset45_analcatdata_apnea3_id764.Rda" are most likely versions of the same datasets.
# --> Only retain "dataset47_analcatdata_apnea1_id767.Rda":

file.remove("./datasets/dataset46_analcatdata_apnea2_id765.Rda")
file.remove("./datasets/dataset45_analcatdata_apnea3_id764.Rda")




# "dataset109_disclosure_z_id931.Rda", "dataset51_disclosure_x_bias_id774.Rda", 
# "dataset61_disclosure_x_tampered_id795.Rda", and "dataset72_disclosure_x_noise_id827.Rda"
# are likely versions of the same datasets.
# There is not information on them.
# --> Keep only the one with the smallest ID, i.e. "dataset51_disclosure_x_bias_id774.Rda":

file.remove("./datasets/dataset61_disclosure_x_tampered_id795.Rda")
file.remove("./datasets/dataset72_disclosure_x_noise_id827.Rda")
file.remove("./datasets/dataset109_disclosure_z_id931.Rda")



# "dataset229_gina_prior_id1042.Rda" and "dataset241_gina_agnostic_id1038.Rda"
# are versions of the same underlying dataset, originating from the MNIST dataset
# and involving the same classification task of separating odd from even digits.
# The "prior" version uses the original pixel map representation with 784 features,
# while the "agnostic" version anonymizes and preprocesses the features, resulting in
# 970 features, many of which are distractors.
# Since our study focuses on general model performance without considering feature
# interpretability, we retain the agnostic version, which is more challenging due to
# the inclusion of distractor features, and remove the prior version.
# --> Remove "dataset229_gina_prior_id1042.Rda":

file.remove("./datasets/dataset229_gina_prior_id1042.Rda")



# "dataset228_sylva_prior_id1040.Rda" and "dataset240_sylva_agnostic_id1036.Rda"
# are versions of the same underlying dataset, derived from the Covertype dataset,
# and involve the same classification task of distinguishing Ponderosa pine from other
# forest cover types.
# The "prior" version uses 108 features with the identity of the features revealed,
# whereas the "agnostic" version uses 216 features with half of them being distractors,
# making the task more challenging.
# Since our study focuses on general model performance without considering feature
# interpretability, we retain the agnostic version, which is more challenging due to
# the inclusion of distractor features, and remove the prior version.
# --> Remove "dataset228_sylva_prior_id1040.Rda":

file.remove("./datasets/dataset228_sylva_prior_id1040.Rda")







# Some datasets featured factor variables which were not cast as R factors.
# Therefore, we went through all datasets that likely contained factors and cast
# numeric variables which were actually factors as R factors.
# In this process, a further dataset was deleted, which was very similar to another
# dataset.
###################################################################################


# Determine all datasets which contained variables with at most 50 different unique variables
# because these may be factors:

may_contain_factor <- FALSE

for(i in seq(along=datasets_to_check)) {
  
  load(paste0("./datasets/", datasets_to_check[i]))
  
  may_contain_factor[[i]] <- any(sapply(dataset[,names(dataset)!="Ytarget"], function(x) length(unique(x))) <= 50)
  
  if(i %% 10 == 0)
    cat(paste("Iteration:", i), "\n")
  
}

table(may_contain_factor)
datasets_with_factors <- datasets_to_check[may_contain_factor]


j <- 1

load(paste0("./datasets/", datasets_with_factors[j]))

dim(dataset)
if (ncol(dataset) <= 30) {
  print(head(dataset))
}
datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50]
sapply(datatemp, table)




j <- 2

load(paste0("./datasets/", datasets_with_factors[j]))

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}





j <- 3

load(paste0("./datasets/", datasets_with_factors[j]))

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}





j <- 4

load(paste0("./datasets/", datasets_with_factors[j]))

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 5

load(paste0("./datasets/", datasets_with_factors[j]))

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}





j <- 6

load(paste0("./datasets/", datasets_with_factors[j]))

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}

dataset$subj <- NULL

save(dataset, file=paste0("./datasets/", datasets_with_factors[j]))







j <- 7

load(paste0("./datasets/", datasets_with_factors[j]))

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 8

load(paste0("./datasets/", datasets_with_factors[j]))

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}

dataset$patient <- NULL

save(dataset, file=paste0("./datasets/", datasets_with_factors[j]))






j <- 9
  
  load(paste0("./datasets/", datasets_with_factors[j]))

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 10
  
load(paste0("./datasets/", datasets_with_factors[j]))

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 11
  
  load(paste0("./datasets/", datasets_with_factors[j]))

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 12

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}

dataset$Course_instructor <- factor(dataset$Course_instructor)
dataset$Course <- factor(dataset$Course)

save(dataset, file=paste0("./datasets/", datasets_with_factors[j]))







j <- 13
  
  load(paste0("./datasets/", datasets_with_factors[j]))

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 14
  
  load(paste0("./datasets/", datasets_with_factors[j]))

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 25) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}

unique(dataset$Air.Perm)
dataset$Air.Perm <- NULL

save(dataset, file=paste0("./datasets/", datasets_with_factors[j]))







j <- 15
  
  load(paste0("./datasets/", datasets_with_factors[j]))

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 16
  
  load(paste0("./datasets/", datasets_with_factors[j]))

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}





j <- 17
  
  load(paste0("./datasets/", datasets_with_factors[j]))

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}









j <- 18
  
  load(paste0("./datasets/", datasets_with_factors[j]))

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}

dataset$hobby <- factor(dataset$hobby)
dataset$educational_level <- factor(dataset$educational_level)
dataset$marital_status <- factor(dataset$marital_status)


save(dataset, file=paste0("./datasets/", datasets_with_factors[j]))








j <- 19
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 20

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 20

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}









j <- 21
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 22
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}










j <- 23

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}










j <- 24

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 25
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}









j <- 26

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}









j <- 27

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 28

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}





j <- 29

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}





j <- 30

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 31

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}









j <- 32

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 33

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 34

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 35

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}









j <- 36

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}











j <- 37

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 38

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}










j <- 39

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}


dataset$ID <- NULL

save(dataset, file=paste0("./datasets/", datasets_with_factors[j]))








j <- 40
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}









j <- 41
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 42
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 43
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}

# --> This is very similar to the previous dataset. --> Delete the previous one because it
# is smaller:

file.remove("./datasets/dataset156_CostaMadre1_id1446.Rda")







j <- 44
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 45
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 46
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 47
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}





j <- 48
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 49
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}









j <- 50
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 51
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 52
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 53
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 54
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}





j <- 55
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 56
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 57
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}





j <- 58
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 59
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}









j <- 60
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 61
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 62
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}









j <- 63
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 64
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 65
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}


table(dataset$Scale_Factor)

dataset$Scale_Factor <- NULL
 
save(dataset, file=paste0("./datasets/", datasets_with_factors[j]))








j <- 66
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 67
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 68

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 69

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}

dataset$event <- factor(dataset$event)

dataset$id <- NULL

save(dataset, file=paste0("./datasets/", datasets_with_factors[j]))








j <- 70
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 71
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 72
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 73

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}









j <- 74

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}









j <- 75

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 76

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 77

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}

for(i in 1:(ncol(dataset)-1))
  dataset[,i] <- factor(dataset[,i])

save(dataset, file=paste0("./datasets/", datasets_with_factors[j]))






j <- 78
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 79
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 80
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}





j <- 81

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 82

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 83

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 84

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 85

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}










j <- 86

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 87

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 88

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 89

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 90

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}





j <- 91
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 92

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 93

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}





j <- 94

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 95

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 96

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 97

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 98

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 99

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}

tail(names(dataset))

for(i in 1:(ncol(dataset)-1)) {
  dataset[,i] <- factor(dataset[,i])
}








j <- 100

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 101
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 102

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 103

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 104

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}

dataset$Patients_year_of_operation <- as.numeric(as.character(dataset$Patients_year_of_operation))

save(dataset, file=paste0("./datasets/", datasets_with_factors[j]))







j <- 105
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 106

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}

dataset$Year <- as.numeric(as.character(dataset$Year))

save(dataset, file=paste0("./datasets/", datasets_with_factors[j]))







j <- 107
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 108
  
load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 109

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 110

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 111

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 112

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}





j <- 113

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 114

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 115

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}





j <- 116

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 117

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 118

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 119

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 120

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 121

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 122

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 123

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}

dataset$Time_index <- NULL

save(dataset, file=paste0("./datasets/", datasets_with_factors[j]))







j <- 124
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}

dataset$sex <- factor(dataset$sex)
dataset$chest <- factor(dataset$chest)
dataset$resting_electrocardiographic_results <- factor(dataset$resting_electrocardiographic_results)
dataset$exercise_induced_angina <- factor(dataset$exercise_induced_angina)
dataset$thal <- factor(dataset$thal)

save(dataset, file=paste0("./datasets/", datasets_with_factors[j]))







j <- 125
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 126
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 127

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 128

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 129

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 130

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 131

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 132

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}

dataset$month <- factor(dataset$month)

save(dataset, file=paste0("./datasets/", datasets_with_factors[j]))








j <- 133
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}

dataset$a02 <- NULL

save(dataset, file=paste0("./datasets/", datasets_with_factors[j]))







j <- 134
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 135

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 136

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 137

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 138

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 139

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 140

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 141

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 142

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 143

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 144

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 145

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}

dataset$Age <- factor(dataset$Age, 
                      levels = c("0-2", "3-5", "6-8", "9-11", "12-13", "14-15"), 
                      ordered = TRUE)

save(dataset, file=paste0("./datasets/", datasets_with_factors[j]))







j <- 146
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 147
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}









j <- 148

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 149

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 150

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 151

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 152

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 153

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}

dataset$Age <- factor(dataset$Age, 
                      levels = c("10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-54", "55-64", "65+"), 
                      ordered = TRUE)

save(dataset, file=paste0("./datasets/", datasets_with_factors[j]))







j <- 154
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}

dataset$LABEL <- NULL

save(dataset, file=paste0("./datasets/", datasets_with_factors[j]))






j <- 155
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 156

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}

dataset$obs <- NULL

save(dataset, file=paste0("./datasets/", datasets_with_factors[j]))







j <- 157
  
  load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 158

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}





j <- 159

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 160

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 161

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}







j <- 162

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}






j <- 163

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 164

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}








j <- 165

load(paste0("./datasets/", datasets_with_factors[j]))
datasets_with_factors[j]

dim(dataset)

if (ncol(dataset) <= 30) {
  print(head(dataset))
  cat("\n")
  cat("\n")
}

datatemp <- dataset[,names(dataset)!="Ytarget" & sapply(dataset, function(x) length(unique(x))) <= 50, drop=FALSE]
if (ncol(datatemp) <= 20) {
  print(sapply(datatemp, table))
  cat("\n")
  cat("\n")
  print(sapply(datatemp, class))
}









# Remove variables which are clearly IDs and constant variables:
##################################################################

datasets_to_check <- list.files("./datasets/")

for (i in seq(along=datasets_to_check)) {
  load(paste0("./datasets/", datasets_to_check[i]))
  
  first_is_id <- is.numeric(dataset[,names(dataset)!="Ytarget"][,1]) && all(dataset[,names(dataset)!="Ytarget"][,1]==(1:nrow(dataset)))
  if (first_is_id) {
    dataset <- dataset[,-which(names(dataset)==names(dataset[,names(dataset)!="Ytarget"])[1])]
  }
  
  contains_constants <- any(apply(dataset, 2, function(x) length(unique(x)))==1)
  if (contains_constants) {
    dataset <- dataset[,-which(apply(dataset, 2, function(x) length(unique(x)))==1)]
  }  
  
  if (first_is_id || contains_constants) {
    save(dataset, file=paste0("./datasets/", datasets_to_check[i]))
    cat(i, "\n")
  }
}







# Identify pairs of dataset that have the same numbers of observations and variables
# because for these it is likely that they are the same
######################################################################################

# Get numbers of observations and variables: 

datasets_to_check <- list.files("./datasets/")

datasets_n <- datasets_p <- 0

for (i in seq(along=datasets_to_check)) {
  
  load(paste0("./datasets/", datasets_to_check[i]))
  
  datasets_n[i] <- nrow(dataset)
  datasets_p[i] <- ncol(dataset)
  
  if(i %% 10 == 0)
    cat(paste("Iteration:", i), "\n")
  
}


# Create a data frame with the number of observations and variables
datasets_info <- data.frame(
  dataset = datasets_to_check,  # Index for each dataset
  n = datasets_n,
  p = datasets_p
)

# Find duplicated rows (same n and p)
duplicated_rows <- datasets_info[duplicated(datasets_info[, c("n", "p")]) | duplicated(datasets_info[, c("n", "p")], fromLast = TRUE), ]

# Get pairs of datasets with the same n and p
pairs <- split(duplicated_rows$dataset, interaction(duplicated_rows$n, duplicated_rows$p))

# Filter out groups with less than 2 elements (i.e., no pair)
pairs <- lapply(pairs, function(x) if(length(x) > 1) x else NULL)
pairs <- pairs[!sapply(pairs, is.null)]

# Add numbers of observations and variables to the output
pairs_with_details <- lapply(pairs, function(x) {
  data.frame(
    dataset = x,
    n = datasets_n[datasets_to_check==x[1]],
    p = datasets_p[datasets_to_check==x[1]]
  )
})

# Print the pairs with details
print(pairs_with_details)



# Inspect the identified pairs:


load("./datasets/dataset103_analcatdata_seropositive_id921.Rda")
dataset1 <- dataset
rm(dataset); gc()

load("./datasets/dataset15_analcatdata_boxing2_id444.Rda")
dataset2 <- dataset
rm(dataset); gc()

dim(dataset1)
dim(dataset2)

head(dataset1)
head(dataset2)

# --> Different datasets.





load("./datasets/dataset114_arsenic-female-bladder_id949.Rda")
dataset1 <- dataset
rm(dataset); gc()

load("./datasets/dataset116_arsenic-male-lung_id951.Rda")
dataset2 <- dataset
rm(dataset); gc()

dim(dataset1)
dim(dataset2)

head(dataset1)
head(dataset2)

all(dataset1$conc==dataset2$conc)
all(dataset1$age==dataset2$age)
all(dataset1$at.risk==dataset2$at.risk)

library("ranger")
ranger(dependent.variable.name = "Ytarget", data=dataset1, num.trees=5000)$prediction.error
ranger(dependent.variable.name = "Ytarget", data=dataset2, num.trees=5000)$prediction.error

table(dataset1$Ytarget)
table(dataset2$Ytarget)

head(dataset1)
head(dataset2)

sapply(dataset1, class)
sapply(dataset2, class)

par(mfrow=c(2,2))
boxplot(conc ~ Ytarget, data=dataset1)
boxplot(age ~ Ytarget, data=dataset1)
boxplot(log(at.risk) ~ Ytarget, data=dataset1)
par(mfrow=c(1,1))

par(mfrow=c(2,2))
boxplot(conc ~ Ytarget, data=dataset2)
boxplot(age ~ Ytarget, data=dataset2)
boxplot(log(at.risk) ~ Ytarget, data=dataset2)
par(mfrow=c(1,1))

# --> The variables "conc" and "age" have exactly the same values in the 
# two datasets, which is why these two datasets most likely have the same observations.
# For the dataset "dataset116_arsenic-male-lung_id951.Rda" the signal is unfortunately
# much too strong.
# --> Delete this dataset:

file.remove("./datasets/dataset116_arsenic-male-lung_id951.Rda")





load("./datasets/dataset14_aids_id346.Rda")
dataset1 <- dataset
rm(dataset); gc()

load("./datasets/dataset57_witmer_census_1980_id787.Rda")
dataset2 <- dataset
rm(dataset); gc()

load("./datasets/dataset81_rabe_131_id874.Rda")
dataset3 <- dataset
rm(dataset); gc()

dim(dataset1)
dim(dataset2)
dim(dataset3)

head(dataset1)
head(dataset2)
head(dataset3)

# --> Different datasets.






load("./datasets/dataset20_analcatdata_japansolvent_id467.Rda")
dataset1 <- dataset
rm(dataset); gc()

load("./datasets/dataset67_chscase_vine1_id815.Rda")
dataset2 <- dataset
rm(dataset); gc()

dim(dataset1)
dim(dataset2)

head(dataset1)
head(dataset2)

sapply(dataset1, class)

sapply(dataset2, class)

par(mfrow=c(1,2))
boxplot(dataset1[,names(dataset1)!="Ytarget"])
boxplot(dataset2[,names(dataset2)!="Ytarget"])
par(mfrow=c(1,1))

# --> Different datasets.





load("./datasets/dataset176_bank8FM_id725.Rda")
dataset1 <- dataset
rm(dataset); gc()

load("./datasets/dataset180_kin8nm_id807.Rda")
dataset2 <- dataset
rm(dataset); gc()

load("./datasets/dataset181_puma8NH_id816.Rda")
dataset3 <- dataset
rm(dataset); gc()

dim(dataset1)
dim(dataset2)
dim(dataset3)

head(dataset1)
head(dataset2)
head(dataset3)

par(mfrow=c(2,2))
boxplot(dataset1[,names(dataset1)!="Ytarget"])
boxplot(dataset2[,names(dataset2)!="Ytarget"])
boxplot(dataset3[,names(dataset3)!="Ytarget"])
par(mfrow=c(1,1))

# --> "dataset176_bank8FM_id725.Rda" clearly different from the other two.

par(mfrow=c(2,4))
datatemp <- dataset2[,names(dataset2)!="Ytarget"]
for(i in 1:ncol(datatemp))
  boxplot(datatemp[,i] ~ dataset2$Ytarget)
par(mfrow=c(1,1))

x11()

par(mfrow=c(2,4))
datatemp <- dataset3[,names(dataset3)!="Ytarget"]
for(i in 1:ncol(datatemp))
  boxplot(datatemp[,i] ~ dataset3$Ytarget)
par(mfrow=c(1,1))

# --> Also "dataset180_kin8nm_id807.Rda" and "dataset181_puma8NH_id816.Rda" are different.





load("./datasets/dataset172_credit-g_id31.Rda")
dataset1 <- dataset
rm(dataset); gc()

load("./datasets/dataset205_autoUniv-au1-1000_id1547.Rda")
dataset2 <- dataset
rm(dataset); gc()

dim(dataset1)
dim(dataset2)

head(dataset1)
head(dataset2)

# --> Different datasets.





load("./datasets/dataset192_pc4_id1049.Rda")
dataset1 <- dataset
rm(dataset); gc()

load("./datasets/dataset201_PieChart4_id1454.Rda")
dataset2 <- dataset
rm(dataset); gc()

dim(dataset1)
dim(dataset2)

head(dataset1)
head(dataset2)

are_equal <- FALSE
for(i in 1:(ncol(dataset1)-1))
  are_equal[i] <- all(dataset1[,i]==dataset2[,i])

are_equal

# --> These datasets are the same.
# --> Delete "dataset192_pc4_id1049.Rda":

file.remove("./datasets/dataset192_pc4_id1049.Rda")








# Extract the descriptions of all datasets and save them in a txt file.
########################################################################

all_datasets <- list.files("./datasets/")

# Extract the IDs using regular expression
extract_ids <- function(datasets) {
  ids <- gsub(".*_id(\\d+)\\.Rda", "\\1", datasets)
  return(as.numeric(ids))
}

reorderind <- order(extract_ids(all_datasets))

all_datasets <- all_datasets[reorderind]


# Apply the function
all_datasets_ids <- extract_ids(all_datasets)


# Load two packages
library("httr")
library("jsonlite")

# Function to get descriptions using the OpenML REST API
get_descriptions_api <- function(ids) {
  descriptions <- lapply(ids, function(id) {
    url <- paste0("https://www.openml.org/api/v1/json/data/", id)
    response <- GET(url)
    
    # Check if the request was successful
    if (status_code(response) == 200) {
      data <- content(response, as = "text")
      data_json <- fromJSON(data)
      
      # Extract relevant information
      name <- data_json$data_set_description$name
      description <- data_json$data_set_description$description
      return(list(id = id, name = name, description = description))
    } else {
      return(list(id = id, name = NA, description = "Error fetching description"))
    }
  })
  return(descriptions)
}

# Fetch descriptions
descriptions <- get_descriptions_api(all_datasets_ids)

no_description <- which(sapply(descriptions, function(x) length(nchar(x$description)))==0)

if (length(no_description) > 0) {
  for(i in seq(along=no_description)) {
    descriptions[[no_description[i]]]$description <- ""
  }
}

# Convert to data frame for better display
descriptions_df <- do.call(rbind, lapply(descriptions, as.data.frame))



long_string <- ""

for (i in 1:nrow(descriptions_df)) {
  
  long_string <- c(long_string, c(paste0("Name: ", descriptions_df$name[i], ", Id: ", descriptions_df$id[i]),
                                  paste0("\"", all_datasets[i], "\""),
                                  rep("", 2),
                                  descriptions_df$description[i],
                                  rep("", 15)))
  
}

writeLines(long_string, con = "./data_set_descriptions.txt")










# The dataset descriptions revealed that, in many cases, the outcome variables 
# were created by dichotomizing a continuous variable, most often using the mean 
# as the cutoff point.
##################################################################################

# This the case for the following datasets:

dichotomized_datasets <- c("dataset3_haberman_id43.Rda",
                           "dataset27_fruitfly_id714.Rda",
                           "dataset28_rmftsa_ladata_id717.Rda",
                           "dataset29_veteran_id719.Rda",
                           "dataset30_pwLinear_id721.Rda",
                           "dataset31_analcatdata_vineyard_id724.Rda",
                           "dataset32_visualizing_slope_id729.Rda",
                           "dataset33_baskball_id731.Rda",
                           "dataset34_machine_cpu_id733.Rda",
                           "dataset35_visualizing_environmental_id736.Rda",
                           "dataset36_rmftsa_sleepdata_id741.Rda",
                           "dataset37_auto_price_id745.Rda",
                           "dataset38_servo_id747.Rda",
                           "dataset39_analcatdata_wildcat_id748.Rda",
                           "dataset40_pm10_id750.Rda",
                           "dataset41_wisconsin_id753.Rda",
                           "dataset42_sleuth_ex1605_id755.Rda",
                           "dataset43_analcatdata_election2000_id758.Rda",
                           "dataset44_analcatdata_olympic2000_id759.Rda",
                           "dataset47_analcatdata_apnea1_id767.Rda",
                           "dataset48_strikes_id770.Rda",
                           "dataset49_analcatdata_michiganacc_id771.Rda",
                           "dataset50_quake_id772.Rda",
                           "dataset51_disclosure_x_bias_id774.Rda",
                           "dataset52_sleuth_ex1714_id777.Rda",
                           "dataset53_bodyfat_id778.Rda",
                           "dataset54_rabe_265_id780.Rda",
                           "dataset55_rabe_266_id782.Rda",
                           "dataset56_newton_hema_id784.Rda",
                           "dataset57_witmer_census_1980_id787.Rda",
                           "dataset58_triazines_id788.Rda",
                           "dataset59_elusage_id790.Rda",
                           "dataset60_diabetes_numeric_id791.Rda",
                           "dataset62_pyrim_id800.Rda",
                           "dataset63_chscase_funds_id801.Rda",
                           "dataset64_hutsof99_logis_id804.Rda",
                           "dataset65_rmftsa_ctoarrivals_id811.Rda",
                           "dataset66_chscase_vine2_id814.Rda",
                           "dataset67_chscase_vine1_id815.Rda",
                           "dataset68_diggle_table_a1_id817.Rda",
                           "dataset69_diggle_table_a2_id818.Rda",
                           "dataset70_chatfield_4_id820.Rda",
                           "dataset71_sensory_id826.Rda",
                           "dataset73_analcatdata_vehicle_id835.Rda",
                           "dataset74_stock_id841.Rda",
                           "dataset75_schlvote_id848.Rda",
                           "dataset76_boston_id853.Rda",
                           "dataset77_bolts_id857.Rda",
                           "dataset78_analcatdata_gviolence_id859.Rda",
                           "dataset79_vinnie_id860.Rda",
                           "dataset81_rabe_131_id874.Rda",
                           "dataset82_analcatdata_chlamydia_id875.Rda",
                           "dataset83_mu284_id880.Rda",
                           "dataset84_pollution_id882.Rda",
                           "dataset85_transplant_id885.Rda",
                           "dataset86_no2_id886.Rda",
                           "dataset87_mbagrade_id887.Rda",
                           "dataset88_cloud_id890.Rda",
                           "dataset89_sleuth_case1201_id892.Rda",
                           "dataset90_visualizing_hamster_id893.Rda",
                           "dataset91_rabe_148_id894.Rda",
                           "dataset92_chscase_geyser1_id895.Rda",
                           "dataset96_chscase_census5_id906.Rda",
                           "dataset100_balloon_id914.Rda",
                           "dataset101_plasma_retinol_id915.Rda",
                           "dataset102_rabe_166_id919.Rda",
                           "dataset103_analcatdata_seropositive_id921.Rda",
                           "dataset104_humandevel_id924.Rda",
                           "dataset105_visualizing_galaxy_id925.Rda",
                           "dataset106_hutsof99_child_witness_id927.Rda",
                           "dataset108_rabe_176_id929.Rda",
                           "dataset110_socmob_id934.Rda",
                           "dataset111_kidney_id945.Rda",
                           "dataset112_visualizing_ethanol_id946.Rda",
                           "dataset114_arsenic-female-bladder_id949.Rda",
                           "dataset175_abalone_id720.Rda",
                           "dataset176_bank8FM_id725.Rda",
                           "dataset177_analcatdata_supreme_id728.Rda",
                           "dataset178_space_ga_id737.Rda",
                           "dataset179_delta_ailerons_id803.Rda",
                           "dataset180_kin8nm_id807.Rda",
                           "dataset181_puma8NH_id816.Rda",
                           "dataset182_delta_elevators_id819.Rda",
                           "dataset183_wind_id847.Rda",
                           "dataset184_tecator_id851.Rda",
                           "dataset185_visualizing_soil_id923.Rda",
                           "dataset211_pol_id722.Rda",
                           "dataset212_ailerons_id734.Rda",
                           "dataset214_cpu_act_id761.Rda",
                           "dataset215_house_16H_id821.Rda",
                           "dataset216_houses_id823.Rda",
                           "dataset218_elevators_id846.Rda")

length(all_datasets)
length(dichotomized_datasets)

all(dichotomized_datasets %in% all_datasets)





#  Make a table with the number of observations and number of variables
########################################################################

all_datasets <- list.files("./datasets/")

# Extract the IDs using regular expression
extract_ids <- function(datasets) {
  ids <- gsub(".*_id(\\d+)\\.Rda", "\\1", datasets)
  return(as.numeric(ids))
}

reorderind <- order(extract_ids(all_datasets))

all_datasets <- all_datasets[reorderind]


datasets_n <- datasets_p <- 0

for (i in seq(along=all_datasets)) {
  
  load(paste0("./datasets/", all_datasets[i]))
  
  datasets_n[i] <- nrow(dataset)
  datasets_p[i] <- ncol(dataset)-1
  
  if(i %% 10 == 0)
    cat(paste("Iteration:", i), "\n")
  
}


# Create a data frame with the number of observations and variables
datainfo <- data.frame(
  dataset = all_datasets,  # Index for each dataset
  n = datasets_n,
  p = datasets_p
)




# Subset the datasets to have a maximum of 10000 observations and 1000 variables:
##################################################################################

all_datasets <- list.files("./datasets/")

datasets_large_n <- datainfo$dataset[datainfo$n > 10000]
datasets_large_p <- datainfo$dataset[datainfo$p > 1000]

intersect(datasets_large_n, datasets_large_p)
# --> There are no datasets which both have more than 10000 obervations
# and more than 1000 variables.

datasets_large_n
datasets_large_p

cat(paste0(datasets_large_n, collapse="\", \""), "\n")
datasets_large_n <- c("dataset173_mammography_id310.Rda", "dataset238_webdata_wXa_id350.Rda", 
                      "dataset239_vehicle_sensIT_id357.Rda", "dataset211_pol_id722.Rda", 
                      "dataset212_ailerons_id734.Rda", "dataset215_house_16H_id821.Rda", 
                      "dataset216_houses_id823.Rda", "dataset218_elevators_id846.Rda", 
                      "dataset219_nursery_id959.Rda", "dataset222_letter_id977.Rda", 
                      "dataset225_pendigits_id1019.Rda", "dataset240_sylva_agnostic_id1036.Rda", 
                      "dataset191_mozilla4_id1046.Rda", "dataset233_bank-marketing_id1461.Rda", 
                      "dataset234_eeg-eye-state_id1471.Rda", "dataset237_skin-segmentation_id1502.Rda")

cat(paste0(datasets_large_p, collapse="\", \""), "\n")
datasets_large_p <- c("dataset242_hiva_agnostic_id1039.Rda", 
                      "dataset243_Internet-Advertisements_id1176.Rda")

all_large_datasets <- c(datasets_large_n, datasets_large_p)



# Save the not subsetted datasets in a new subdirectory "./datasets_large/",
# so that these datasets can be used in comparison studies from others:

# Define source and destination directories
source_dir <- "./datasets/"
dest_dir <- "./datasets_large/"

# Create the destination directory if it doesn't exist
if (!dir.exists(dest_dir)) {
  dir.create(dest_dir)
}

# Construct full paths for source and destination
source_files <- file.path(source_dir, all_large_datasets)
dest_files <- file.path(dest_dir, all_large_datasets)

# Copy files
file.copy(from = source_files, to = dest_files, overwrite = TRUE)



# Subset datasets with more than 10000 observations to have only 10000 observations:

for(i in seq(along=datasets_large_n)) {
  
  load(paste0("./datasets/", datasets_large_n[i]))
  
  set.seed(1234)
  ranind <- sort(sample(1:nrow(dataset), size=10000))
  dataset <- dataset[ranind,]
  
  save(dataset, file=paste0("./datasets/", datasets_large_n[i]))
  
}



# Check whether the subsetting has induced constant variables for any of the datasets:

has_constants <- FALSE

for(i in seq(along=datasets_large_n)) {
  
  load(paste0("./datasets/", datasets_large_n[i]))
  
  has_constants[i] <- any(sapply(dataset, function(x) length(unique(x))==1))
   
}

has_constants

# --> The subbsetting has induced constant variables for the dataset
# "dataset238_webdata_wXa_id350.Rda".
# --> Exclude the constant variables:

load("./datasets/dataset238_webdata_wXa_id350.Rda")

constant_ind <- which(sapply(dataset, function(x) length(unique(x))==1))
dataset <- dataset[,-constant_ind]

save(dataset, file="./datasets/dataset238_webdata_wXa_id350.Rda")





# Subset datasets with more than 1000 variables to have only 1000 variables:

for(i in seq(along=datasets_large_p)) {
  
  load(paste0("./datasets/", datasets_large_p[i]))
  
  set.seed(1234)
  ranind <- sort(c(sample(which(names(dataset)!="Ytarget"), size=1000), which(names(dataset)=="Ytarget")))
  dataset <- dataset[,ranind]
  
  save(dataset, file=paste0("./datasets/", datasets_large_p[i]))
  
}






#  Make a new table with the number of observations and number of variables
#  after the above subsetting:
###########################################################################

all_datasets <- list.files("./datasets/")

# Extract the IDs using regular expression
extract_ids <- function(datasets) {
  ids <- gsub(".*_id(\\d+)\\.Rda", "\\1", datasets)
  return(as.numeric(ids))
}

reorderind <- order(extract_ids(all_datasets))

all_datasets <- all_datasets[reorderind]


datasets_n <- datasets_p <- 0

for (i in seq(along=all_datasets)) {
  
  load(paste0("./datasets/", all_datasets[i]))
  
  datasets_n[i] <- nrow(dataset)
  datasets_p[i] <- ncol(dataset)-1
  
  if(i %% 10 == 0)
    cat(paste("Iteration:", i), "\n")
  
}


# Create a data frame with the number of observations and variables
datainfo <- data.frame(
  dataset = all_datasets,  # Index for each dataset
  n = datasets_n,
  p = datasets_p
)

save(datainfo, file="./datainfo.Rda")
