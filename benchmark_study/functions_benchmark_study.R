# This function performs one repetition of the five times repeated 
# 5-fold stratified cross-validation on a specific dataset using
# one of the two compared methods.

# Input:

# iter         - iter-th line of 'scenariogrid', which corresponds to the iter-th line 
#                of 'scenariogrid', which contains the necessary information
#                on the iter-th repetition.
# current_dir  - working directory. This needs to be the path to 
#                the directory "UnityForests_code_and_data/benchmark_study".

# Output:

# A list of length five, where each list element contains the accuracy, the
# AUC, and the Brier score for one of the cross-validation iterations

evaluatesetting <- function(iter, current_dir) {
  
  setwd(current_dir)
  
  # Obtain information for the iter-th setting:
  
  dataset <- scenariogrid$dataset[iter]
  method <- scenariogrid$method[iter]
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
	
    res[[i]] <- trainandpredict(datatrain, datatest, dependent.variable.name="Ytarget", method)
    
  }
  
  # Save results:

  save(res, file=paste0("./intermediate_results/res_benchmark_study_", iter, ".Rda"))
  
  
  # Return results:
  
  return(res)
  
}




# Wrapper function that fits a prediction rule on a training
# dataset and performs performance evaluation on a test
# dataset.

# Input:

# datatrain               - training dataset
# datatest                - test dataset
# dependent.variable.name - name of the outcome variable
# method                  - "uf" (unity forest) or "rf" (random forest)

# Output:

# The values of the calculated performance metrics accuracy, AUC, and
# Brier score

trainandpredict <- function(datatrain, datatest, dependent.variable.name, method) {
  
  if (method=="uf") {
  
  require("unityForest")
  
  # Construct unity forest:
  model <- unityForest::unityfor(dependent.variable.name = dependent.variable.name, data = datatrain, importance="none", num.trees=20000, num.threads=100, num.cand.trees=500)
  
  # Predict conditional class probabilities for the observations in
  # the test dataset:
  probpreds <- predict(model, data=datatest)$predictions[,2]
  
  # Obtain class predictions:
  classpreds <- factor(ifelse(probpreds > 0.5, levels(datatest[,dependent.variable.name])[2], levels(datatest[,dependent.variable.name])[1]), levels=levels(datatest[,dependent.variable.name]))
  if(any(probpreds==0.5))
    classpreds[probpreds==0.5] <- sample(levels(datatest[,dependent.variable.name]), size=sum(probpreds==0.5), replace=TRUE)
  
  }
  
  if (method=="rf") {

  require("ranger")
  
  # Construct random forest (where the used configuration is adjusted to the default configuration of the unity forest):
  model <- ranger::ranger(dependent.variable.name = dependent.variable.name, data = datatrain, importance="none", replace=FALSE, sample.fraction=0.7, num.tree=20000, probability=TRUE, 
    min.node.size = 5, respect.unordered.factors="order", num.threads=100)
  
  # Predict conditional class probabilities for the observations in
  # the test dataset:
  probpreds <- predict(model, data=datatest)$predictions[,2]
  
  # Obtain class predictions:
  classpreds <- factor(ifelse(probpreds > 0.5, levels(datatest[,dependent.variable.name])[2], levels(datatest[,dependent.variable.name])[1]), levels=levels(datatest[,dependent.variable.name]))
  if(any(probpreds==0.5))
    classpreds[probpreds==0.5] <- sample(levels(datatest[,dependent.variable.name]), size=sum(probpreds==0.5), replace=TRUE)
  
  }
  
  # Calculate AUC value:
  auctest <- measureAUC(probabilities=probpreds, truth=datatest$Ytarget, 
                        negative=levels(datatest$Ytarget)[1], positive=levels(datatest$Ytarget)[2])
  
  # Calculate ACC value:
  acctest <- measureACC(truth=datatest$Ytarget, response=classpreds)
  
  # Calculate Brier value:
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
