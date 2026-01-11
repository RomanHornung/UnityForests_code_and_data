# This function performs one replication of the simulation. It simulates
# one dataset and estimates the three different variable importance measures
# for this dataset.

# Input:

# iter         - iter-th line of 'scenariogrid', which corresponds to the iter-th line 
#                of 'scenariogrid', which contains the necessary information
#                on the iter-th replication.
# current_dir  - working directory. This needs to be the path to 
#                the directory "UnityForests_code_and_data/simulation_study".

# Output:

# A list of length three, where each element contains the variable importance values
# for a specific variable importance measure

evaluatesetting <- function(iter, current_dir) {
  
  setwd(current_dir)
    
  # Obtain information for the iter-th setting:
  
  n <- scenariogrid$n[iter]
  itind <- scenariogrid$itind[iter]
  seed <- scenariogrid$seed[iter]
  
  
  # Simulate dataset:
  
  set.seed(seed)
  dataset <- simDataset(N=n)
  
  
  
  # Apply the methods:
  
  set.seed(seed)
  perm <- ranger::ranger(dependent.variable.name = "y", data=dataset, importance="permutation", 
                         num.trees=20000, replace = FALSE, sample.fraction = 0.7, probability=TRUE, 
                         min.node.size=5, num.threads=1)$variable.importance
  
  set.seed(seed)
  gini_corr <- ranger::ranger(dependent.variable.name = "y", data=dataset, importance="impurity_corrected",
                              num.trees=20000, replace = FALSE, sample.fraction = 0.7,
                              probability=TRUE, min.node.size=5, num.threads=1)$variable.importance
  
  set.seed(seed)
  unity_vim <- unityForest::unityfor(dependent.variable.name = "y", data=dataset, importance="unity", 
                                 num.trees=20000, num.cand.trees = 500, num.threads=1)$variable.importance
  
  
  # Save the results in a list:
  
  res <- list(perm=perm,
              gini_corr=gini_corr,
              unity_vim=unity_vim)
  
  # Save results:

  save(res, file=paste0("./intermediate_results/res_simulation_study_design_2_", iter, ".Rda"))
  
  # Return results:
  
  return(res)
  
}






# Function for simulating a dataset:

# Input:

# N  - sample size (assumed even; balanced classes).

# Output:

# Data frame with N rows containing the outcome 'y' and 69 predictors.

simDataset <- function(N) {
  
  y <- rep(c(1,2), each=N/2)
  
  
  # Covariates with only marginal effects:
  
  X1 <- rnorm(N)
  X1[y==2] <- X1[y==2] + 1
  
  X2 <- rnorm(N)
  X2[y==2] <- X2[y==2] + 0.75
  
  X3 <- rnorm(N)
  X3[y==2] <- X3[y==2] + 0.5
  
  
  
  # Qualitative interaction between binary and continuous covariate,
  # where the binary covariate does not have an effect:
  
  X4 <- sample(c(0,1), size=N, replace=TRUE)
  
  X5 <- rnorm(N)
  X5[y==1 & X4==1] <- X5[y==1 & X4==1] + 1
  X5[y==2 & X4==0] <- X5[y==2 & X4==0] + 1
  
  X6 <- rnorm(N)
  X6[y==1 & X4==1] <- X6[y==1 & X4==1] + 0.75
  X6[y==2 & X4==0] <- X6[y==2 & X4==0] + 0.75  
  
  X7 <- rnorm(N)
  X7[y==1 & X4==1] <- X7[y==1 & X4==1] + 0.5
  X7[y==2 & X4==0] <- X7[y==2 & X4==0] + 0.5 
  
  
    
  # Qualitative interaction between binary and continuous covariate,
  # where the binary covariate does have an effect:
  
  X8 <- rep(1, N)
  X8[y==1] <- sample(c(0,1), size=sum(y==1), prob=c(0.4, 0.6), replace=TRUE)
  X8[y==2] <- sample(c(0,1), size=sum(y==2), prob=c(0.6, 0.4), replace=TRUE)
  
  X9 <- rnorm(N)
  X9[y==1 & X8==1] <- X9[y==1 & X8==1] + 1
  X9[y==2 & X8==0] <- X9[y==2 & X8==0] + 1
  
  X10 <- rnorm(N)
  X10[y==1 & X8==1] <- X10[y==1 & X8==1] + 0.75
  X10[y==2 & X8==0] <- X10[y==2 & X8==0] + 0.75 
  
  X11 <- rnorm(N)
  X11[y==1 & X8==1] <- X11[y==1 & X8==1] + 0.5
  X11[y==2 & X8==0] <- X11[y==2 & X8==0] + 0.5
  
  
  
  # Quantitative interaction between binary and continuous covariate,
  # where the binary covariate does not have an effect and the 
  # continuous covariate only has an effect if the binary covariate 
  # takes the value 1:
  
  X12 <- sample(c(0,1), size=N, replace=TRUE)
  
  X13 <- rnorm(N)
  X13[y==2 & X12==1] <- X13[y==2 & X12==1] + 1
  
  X14 <- rnorm(N)
  X14[y==2 & X12==1] <- X14[y==2 & X12==1] + 0.75
  
  X15 <- rnorm(N)
  X15[y==2 & X12==1] <- X15[y==2 & X12==1] + 0.5
  
  
  
  # Qualitative interaction between categorical covariate with three categories "A", "B", and "C"
  # and continuous covariate, where the categorical covariate does not have an effect
  # and the continuous covariate does not have an effect if the categorical covariate has the
  # category "B":
  
  X16 <- factor(sample(c("A", "B", "C"), size=N, replace=TRUE))
  
  X17 <- rnorm(N)
  X17[y==1 & X16=="C"] <- X17[y==1 & X16=="C"] + 1
  X17[y==2 & X16=="A"] <- X17[y==2 & X16=="A"] + 1
  
  X18 <- rnorm(N)
  X18[y==1 & X16=="C"] <- X18[y==1 & X16=="C"] + 0.75
  X18[y==2 & X16=="A"] <- X18[y==2 & X16=="A"] + 0.75
  
  X19 <- rnorm(N)
  X19[y==1 & X16=="C"] <- X19[y==1 & X16=="C"] + 0.5
  X19[y==2 & X16=="A"] <- X19[y==2 & X16=="A"] + 0.5
  
  
  Xnoise <- matrix(nrow=N, ncol=50, data=rnorm(N*50))
  
  dataset <- data.frame(X1, X2, X3, X4, X5, X6, X7, X8, X9, X10, X11, X12, X13, X14, X15, X16, X17, X18, X19, Xnoise)
  dataset$y <- factor(y)
  
  
  return(dataset)
  
}
