# This function performs for the N_CAND_TREES analysis one repetition of 
# the five times repeated 5-fold stratified cross-validation on a specific dataset.
#
# It takes the whole number 'iter', which corresponds to the iter-th line 
# of 'scenariogrid', which contains the necessary information
# on the iter-th setting.

# Input:

# iter         - iter-th line of 'scenariogrid', which corresponds to the iter-th line 
#                of 'scenariogrid', which contains the necessary information
#                on the iter-th repetition.
# current_dir  - working directory. This needs to be the path to 
#                the directory "UnityForests_code_and_data/benchmark_study".

# Output:

# A list of length five, where each list element contains the accuracy, the
# AUC, and the Brier score for one of the cross-validation iterations

evaluatesetting_num_cand_trees <- function(iter, current_dir) {
  
  setwd(current_dir)
  
  # Obtain information for the iter-th setting:
  
  dataset <- scenariogrid$dataset[iter]
  num_cand_trees <- scenariogrid$num_cand_trees[iter]
  cvind <- scenariogrid$cvind[iter]
  seed <- scenariogrid$seed[iter]
  
  
  # Set seed:
  
  set.seed(seed)
  
  
  # Load dataset:
  
  load(paste0("../data/datasets/", dataset))
  
  
  # Make CV division:
  
  Kcv <- 5
  cvdiv <- makeCVdiv(data=dataset, yname="Ytarget", ncv=Kcv)
  
  
  # Perform cross-validation: 
  
  res <- list()
  
  for(i in 1:Kcv) {
    
    datatrain <- dataset[cvdiv!=i,]
    datatest <- dataset[cvdiv==i,]
      
    res[[i]] <- trainandpredict_unityfor_num_cand_trees(datatrain, datatest, dependent.variable.name="Ytarget", num.cand.trees=num_cand_trees)
    
  }
  
  # Save results:

  save(res, file=paste0("./intermediate_results/res_num_cand_trees_", iter, ".Rda"))
  
  
  # Return results:
  
  return(res)
  
}




# Wrapper function that fits a unity forest on a training
# dataset with a specific N_CAND_TREES value and performs 
# performance evaluation on a test dataset.

# Input:

# datatrain               - training dataset
# datatest                - test dataset
# dependent.variable.name - name of the outcome variable
# num.cand.trees          - N_CAND_TREES value

# Output:

# The values of the calculated performance metrics accuracy, AUC, and
# Brier score

trainandpredict_unityfor_num_cand_trees <- function(datatrain, datatest, dependent.variable.name, num.cand.trees) {
  
  require("unityForest")
  
  # Construct unity forest:
  model <- unityForest::unityfor(dependent.variable.name = dependent.variable.name, data = datatrain, importance="none", num.trees=2000, num.threads=1, num.cand.trees=num.cand.trees)
  
  # Predict conditional class probabilities for the observations in
  # the test dataset:
  probpreds <- predict(model, data=datatest)$predictions[,2]
  
  # Obtain class predictions:
  classpreds <- factor(ifelse(probpreds > 0.5, levels(datatest[,dependent.variable.name])[2], levels(datatest[,dependent.variable.name])[1]), levels=levels(datatest[,dependent.variable.name]))
  if(any(probpreds==0.5))
    classpreds[probpreds==0.5] <- sample(levels(datatest[,dependent.variable.name]), size=sum(probpreds==0.5), replace=TRUE)
  
  # Calculate AUC values:
  auctest <- measureAUC(probabilities=probpreds, truth=datatest$Ytarget, 
                        negative=levels(datatest$Ytarget)[1], positive=levels(datatest$Ytarget)[2])
  
  # Calculate ACC values:
  acctest <- measureACC(truth=datatest$Ytarget, response=classpreds)
  
  # Calculate Brier values:
  briertest <- measureBrier(probabilities=probpreds, truth=datatest$Ytarget, 
                            negative=levels(datatest$Ytarget)[1], positive=levels(datatest$Ytarget)[2])
  
  # Return results:
  return(list(acctest=acctest, auctest=auctest, briertest=briertest))
  
}





# This function performs for the PROP_VAR analysis one repetition of 
# the five times repeated 5-fold stratified cross-validation on a specific dataset.
#
# It takes the whole number 'iter', which corresponds to the iter-th line 
# of 'scenariogrid', which contains the necessary information
# on the iter-th setting.

# Input:

# iter         - iter-th line of 'scenariogrid', which corresponds to the iter-th line 
#                of 'scenariogrid', which contains the necessary information
#                on the iter-th repetition.
# current_dir  - working directory. This needs to be the path to 
#                the directory "UnityForests_code_and_data/benchmark_study".

# Output:

# A list of length five, where each list element contains the accuracy, the
# AUC, and the Brier score for one of the cross-validation iterations

evaluatesetting_prop_var_root <- function(iter, current_dir) {
  
  setwd(current_dir)
  
  # Obtain information for the iter-th setting:
  
  dataset <- scenariogrid$dataset[iter]
  prop_var_root_mult <- scenariogrid$prop_var_root_mult[iter]
  cvind <- scenariogrid$cvind[iter]
  seed <- scenariogrid$seed[iter]
  
  
  # Set seed:
  
  set.seed(seed)
  
  
  # Load dataset:
  
  load(paste0("../data/datasets/", dataset))
  
  
  # Make CV division:
  
  Kcv <- 5
  cvdiv <- makeCVdiv(data=dataset, yname="Ytarget", ncv=Kcv)
  
  
  # Perform cross-validation: 
  
  res <- list()
  
  for(i in 1:Kcv) {
    
    datatrain <- dataset[cvdiv!=i,]
    datatest <- dataset[cvdiv==i,]
      
    res[[i]] <- trainandpredict_unityfor_prop_var_root(datatrain, datatest, dependent.variable.name="Ytarget", prop_var_root_mult=prop_var_root_mult)
    
  }
  
  # Save results:

  save(res, file=paste0("./intermediate_results/res_prop_var_root_", iter, ".Rda"))
  
  
  # Return results:
  
  return(res)
  
}




# Wrapper function that fits a unity forest on a training
# dataset with a specific PROP_VAR value and performs 
# performance evaluation on a test dataset.

# Input:

# datatrain               - training dataset
# datatest                - test dataset
# dependent.variable.name - name of the outcome variable
# prop_var_root_mult     -  multiplicator of sqrt(ncol(datatrain)-1)/(ncol(datatrain)-1)); if prop_var_root_mult=99, prop.var.root=1 is used.

# Output:

# The values of the calculated performance metrics accuracy, AUC, and
# Brier score

trainandpredict_unityfor_prop_var_root <- function(datatrain, datatest, dependent.variable.name, prop_var_root_mult) {
  
  require("unityForest")
  
  # Determine the prop.var.root value:
  if (prop_var_root_mult==99) {
     prop.var.root <- 1
  }
  else {
     prop.var.root <- min(c(1, prop_var_root_mult*sqrt(ncol(datatrain)-1)/(ncol(datatrain)-1)))
  }
  
  # Construct unity forest:
  model <- unityForest::unityfor(dependent.variable.name = dependent.variable.name, data = datatrain, importance="none", prop.var.root=prop.var.root, num.trees=2000, num.threads=1, num.cand.trees=500)
  
  # Predict conditional class probabilities for the observations in
  # the test dataset:
  probpreds <- predict(model, data=datatest)$predictions[,2]
  
  # Obtain class predictions:
  classpreds <- factor(ifelse(probpreds > 0.5, levels(datatest[,dependent.variable.name])[2], levels(datatest[,dependent.variable.name])[1]), levels=levels(datatest[,dependent.variable.name]))
  if(any(probpreds==0.5))
    classpreds[probpreds==0.5] <- sample(levels(datatest[,dependent.variable.name]), size=sum(probpreds==0.5), replace=TRUE)
  
  # Calculate AUC values:
  auctest <- measureAUC(probabilities=probpreds, truth=datatest$Ytarget, 
                        negative=levels(datatest$Ytarget)[1], positive=levels(datatest$Ytarget)[2])
  
  # Calculate ACC values:
  acctest <- measureACC(truth=datatest$Ytarget, response=classpreds)
  
  # Calculate Brier values:
  briertest <- measureBrier(probabilities=probpreds, truth=datatest$Ytarget, 
                            negative=levels(datatest$Ytarget)[1], positive=levels(datatest$Ytarget)[2])
  
  # Return results:
  return(list(acctest=acctest, auctest=auctest, briertest=briertest))
  
}







# This function performs for the MAX_DEPTH_ROOT analysis one repetition of 
# the five times repeated 5-fold stratified cross-validation on a specific dataset.
#
# It takes the whole number 'iter', which corresponds to the iter-th line 
# of 'scenariogrid', which contains the necessary information
# on the iter-th setting.

# Input:

# iter         - iter-th line of 'scenariogrid', which corresponds to the iter-th line 
#                of 'scenariogrid', which contains the necessary information
#                on the iter-th repetition.
# current_dir  - working directory. This needs to be the path to 
#                the directory "UnityForests_code_and_data/benchmark_study".

# Output:

# A list of length five, where each list element contains the accuracy, the
# AUC, and the Brier score for one of the cross-validation iterations

evaluatesetting_max_depth_root <- function(iter, current_dir) {
  
  setwd(current_dir)
  
  # Obtain information for the iter-th setting:
  
  dataset <- scenariogrid$dataset[iter]
  max_depth_root <- scenariogrid$max_depth_root[iter]
  cvind <- scenariogrid$cvind[iter]
  seed <- scenariogrid$seed[iter]
  
  
  # Set seed:
  
  set.seed(seed)
  
  
  # Load dataset:
  
  load(paste0("../data/datasets/", dataset))
  
  
  # Make CV division:
  
  Kcv <- 5
  cvdiv <- makeCVdiv(data=dataset, yname="Ytarget", ncv=Kcv)
  
  
  # Perform cross-validation: 
  
  res <- list()
  
  for(i in 1:Kcv) {
    
    datatrain <- dataset[cvdiv!=i,]
    datatest <- dataset[cvdiv==i,]
      
    res[[i]] <- trainandpredict_unityfor_max_depth_root(datatrain, datatest, dependent.variable.name="Ytarget", max_depth_root=max_depth_root)
    
  }
  
  # Save results:

  save(res, file=paste0("./intermediate_results/res_max_depth_root_", iter, ".Rda"))
  
  
  # Return results:
  
  return(res)
  
}




# Wrapper function that fits a unity forest on a training
# dataset with a specific MAX_DEPTH_ROOT value and performs 
# performance evaluation on a test dataset.

# Input:

# datatrain               - training dataset
# datatest                - test dataset
# dependent.variable.name - name of the outcome variable
# max_depth_root          - MAX_DEPTH_ROOT value

# Output:

# The values of the calculated performance metrics accuracy, AUC, and
# Brier score

trainandpredict_unityfor_max_depth_root <- function(datatrain, datatest, dependent.variable.name, max_depth_root) {
  
  require("unityForest")
  
  # Construct unity forest:
  model <- unityForest::unityfor(dependent.variable.name = dependent.variable.name, data = datatrain, importance="none", max.depth.root=max_depth_root, num.trees=2000, num.threads=1, num.cand.trees=500)
  
  # Predict conditional class probabilities for the observations in
  # the test dataset:
  probpreds <- predict(model, data=datatest)$predictions[,2]
  
  # Obtain class predictions:
  classpreds <- factor(ifelse(probpreds > 0.5, levels(datatest[,dependent.variable.name])[2], levels(datatest[,dependent.variable.name])[1]), levels=levels(datatest[,dependent.variable.name]))
  if(any(probpreds==0.5))
    classpreds[probpreds==0.5] <- sample(levels(datatest[,dependent.variable.name]), size=sum(probpreds==0.5), replace=TRUE)
  
  # Calculate AUC values:
  auctest <- measureAUC(probabilities=probpreds, truth=datatest$Ytarget, 
                        negative=levels(datatest$Ytarget)[1], positive=levels(datatest$Ytarget)[2])
  
  # Calculate ACC values:
  acctest <- measureACC(truth=datatest$Ytarget, response=classpreds)
  
  # Calculate Brier values:
  briertest <- measureBrier(probabilities=probpreds, truth=datatest$Ytarget, 
                            negative=levels(datatest$Ytarget)[1], positive=levels(datatest$Ytarget)[2])
  
  # Return results:
  return(list(acctest=acctest, auctest=auctest, briertest=briertest))
  
}









# Function that generates the splittings for stratified cross-validation:

# Input:

# data   - dataset
# yname  - label of the outcome variable
# ncv    - number of folds to use

# Output:

# A vector of length nrow(data), where the ith element contains the index
# of the fold in the K-fold cross-validation to which the ith observation is assigned.

makeCVdiv <- function(data, yname="y", ncv=5) {
  
  cvid <- rep(NA, length = nrow(data))
  for(i in levels(data[, yname])) cvid[data[, yname] == i] <- 
      sample(rep(1:ncv, length = sum(data[, yname] == i)))
  
  cvid
  
}





# Function calculating AUC values (taken from "mlr" R package):

measureAUC <- function (probabilities, truth, negative, positive) 
{
  if (is.factor(truth)) {
    i = as.integer(truth) == which(levels(truth) == positive)
  }
  else {
    i = truth == positive
  }
  if (length(unique(i)) < 2L) {
    stop("truth vector must have at least two classes")
  }
  if (length(i) > 5000L) {
    r = frankv(probabilities)
  }
  else {
    r = rank(probabilities)
  }
  n.pos = as.numeric(sum(i))
  n.neg = length(i) - n.pos
  (sum(r[i]) - n.pos * (n.pos + 1)/2)/(n.pos * n.neg)
}




# Function calculating ACC values (taken from "mlr" R package):

measureACC <- function (truth, response) 
{
  mean(response == truth)
}



# Function calculating Brier values (taken from "mlr" R package):

measureBrier <- function (probabilities, truth, negative, positive) 
{
  y = as.numeric(truth == positive)
  mean((y - probabilities)^2)
}
