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
  dataset <- simDataset(N=n, mainstrength=c(3, 2, 1), quantstrength=c(3, 2, 1), qualstrength=c(3, 2, 1))
  
  
  
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

  save(res, file=paste0("./intermediate_results/res_simulation_study_design_1_", iter, ".Rda"))
  
  
  # Return results:
  
  return(res)
  
}










# Functions used for simulating the datasets:




# Function for simulating the variables with main effects only:

# Input:

# N        - sample size (assumed even; N/2 observations per class).
# strength - effect strength level (1 = weak, 2 = medium, 3 = strong).

# Output:

# Numeric vector of length N with class-dependent means.

simMainEff <- function(N, strength) {
  if(strength==1)
    d <- 0.5
  if(strength==2)
    d <- 0.75
  if(strength==3)
    d <- 1
  x <- c(rnorm(N/2, mean=0, sd=1), rnorm(N/2, mean=d, sd=1))
  return(x)
}





# Functions for simulating variable pairs with quantitative interactions:



# Function for drawing a point from class 1, if class 2 should concentrate in lower left corner:

# Input:

# dqual      - mean shift parameter controlling separation between components.
# propcorner - mixture weight for the designated "corner" component (class 2 only).

# Output:

# Numeric vector of length 2 containing one draw (x1, x2).

drawQuantInt1cl1 <- function(dqual, propcorner) {
  dind <- sample(1:3, size=1)
  if(dind==1) {
    return(rmvnorm(n=1, mean=c(0,dqual))[1,])
  }
  if(dind==2) {
    return(rmvnorm(n=1, mean=c(dqual,dqual))[1,])
  }
  if(dind==3) {
    return(rmvnorm(n=1, mean=c(dqual,0))[1,])
  }
}

# Function for drawing a point from class 2, if class 2 should concentrate in lower left corner:

# Input:

# dqual      - mean shift parameter controlling separation between components.
# propcorner - mixture weight for the designated "corner" component (class 2 only).

# Output:

# Numeric vector of length 2 containing one draw (x1, x2).

drawQuantInt1cl2 <- function(dqual, propcorner) {
  dind <- sample(1:4, size=1, prob=c((1-propcorner)/3, (1-propcorner)/3, propcorner, (1-propcorner)/3))
  if(dind==1) {
    return(rmvnorm(n=1, mean=c(0,dqual))[1,])
  }
  if(dind==2) {
    return(rmvnorm(n=1, mean=c(dqual,dqual))[1,])
  }
  if(dind==3) {
    return(rmvnorm(n=1, mean=c(0,0))[1,])
  }
  if(dind==4) {
    return(rmvnorm(n=1, mean=c(dqual,0))[1,])
  }
}


# Function for drawing a point from class 1, if class 2 should concentrate in lower right corner:

# Input:

# dqual      - mean shift parameter controlling separation between components.
# propcorner - mixture weight for the designated "corner" component (class 2 only).

# Output:

# Numeric vector of length 2 containing one draw (x1, x2).

drawQuantInt2cl1 <- function(dqual, propcorner) {
  dind <- sample(1:3, size=1)
  if(dind==1) {
    return(rmvnorm(n=1, mean=c(0,dqual))[1,])
  }
  if(dind==2) {
    return(rmvnorm(n=1, mean=c(dqual,dqual))[1,])
  }
  if(dind==3) {
    return(rmvnorm(n=1, mean=c(0,0))[1,])
  }
}

# Function for drawing a point from class 2, if class 2 should concentrate in lower right corner:

# Input:

# dqual      - mean shift parameter controlling separation between components.
# propcorner - mixture weight for the designated "corner" component (class 2 only).

# Output:

# Numeric vector of length 2 containing one draw (x1, x2).

drawQuantInt2cl2 <- function(dqual, propcorner) {
  dind <- sample(1:4, size=1, prob=c((1-propcorner)/3, (1-propcorner)/3, (1-propcorner)/3, propcorner))
  if(dind==1) {
    return(rmvnorm(n=1, mean=c(0,dqual))[1,])
  }
  if(dind==2) {
    return(rmvnorm(n=1, mean=c(dqual,dqual))[1,])
  }
  if(dind==3) {
    return(rmvnorm(n=1, mean=c(0,0))[1,])
  }
  if(dind==4) {
    return(rmvnorm(n=1, mean=c(dqual,0))[1,])
  }
}



# Function for drawing a point from class 1, if class 2 should concentrate in upper right corner:

# Input:

# dqual      - mean shift parameter controlling separation between components.
# propcorner - mixture weight for the designated "corner" component (class 2 only).

# Output:

# Numeric vector of length 2 containing one draw (x1, x2).

drawQuantInt3cl1 <- function(dqual, propcorner) {
  dind <- sample(1:3, size=1)
  if(dind==1) {
    return(rmvnorm(n=1, mean=c(0,dqual))[1,])
  }
  if(dind==2) {
    return(rmvnorm(n=1, mean=c(0,0))[1,])
  }
  if(dind==3) {
    return(rmvnorm(n=1, mean=c(dqual,0))[1,])
  }
}

# Function for drawing a point from class 2, if class 2 should concentrate in upper right corner:

# Input:

# dqual      - mean shift parameter controlling separation between components.
# propcorner - mixture weight for the designated "corner" component (class 2 only).

# Output:

# Numeric vector of length 2 containing one draw (x1, x2).

drawQuantInt3cl2 <- function(dqual, propcorner) {
  dind <- sample(1:4, size=1, prob=c((1-propcorner)/3, propcorner, (1-propcorner)/3, (1-propcorner)/3))
  if(dind==1) {
    return(rmvnorm(n=1, mean=c(0,dqual))[1,])
  }
  if(dind==2) {
    return(rmvnorm(n=1, mean=c(dqual,dqual))[1,])
  }
  if(dind==3) {
    return(rmvnorm(n=1, mean=c(0,0))[1,])
  }
  if(dind==4) {
    return(rmvnorm(n=1, mean=c(dqual,0))[1,])
  }
}



# Function for drawing a point from class 1, if class 2 should concentrate in upper left corner:

# Input:

# dqual      - mean shift parameter controlling separation between components.
# propcorner - mixture weight for the designated "corner" component (class 2 only).

# Output:

# Numeric vector of length 2 containing one draw (x1, x2).

drawQuantInt4cl1 <- function(dqual, propcorner) {
  dind <- sample(1:3, size=1)
  if(dind==1) {
    return(rmvnorm(n=1, mean=c(dqual,dqual))[1,])
  }
  if(dind==2) {
    return(rmvnorm(n=1, mean=c(0,0))[1,])
  }
  if(dind==3) {
    return(rmvnorm(n=1, mean=c(dqual,0))[1,])
  }
}

# Function for drawing a point from class 2, if class 2 should concentrate in upper left corner:

# Input:

# dqual      - mean shift parameter controlling separation between components.
# propcorner - mixture weight for the designated "corner" component (class 2 only).

# Output:

# Numeric vector of length 2 containing one draw (x1, x2).

drawQuantInt4cl2 <- function(dqual, propcorner) {
  dind <- sample(1:4, size=1, prob=c(propcorner, (1-propcorner)/3, (1-propcorner)/3, (1-propcorner)/3))
  if(dind==1) {
    return(rmvnorm(n=1, mean=c(0,dqual))[1,])
  }
  if(dind==2) {
    return(rmvnorm(n=1, mean=c(dqual,dqual))[1,])
  }
  if(dind==3) {
    return(rmvnorm(n=1, mean=c(0,0))[1,])
  }
  if(dind==4) {
    return(rmvnorm(n=1, mean=c(dqual,0))[1,])
  }
}




# Function for simulating a pair of variables with quantitative interaction:

# Input:

# N        - sample size (assumed even; N/2 per class).
# corner   - interaction pattern (1..4), specifying where class 2 concentrates in the x1-x2 plane.
# strength - effect strength level (1 = weak, 2 = medium, 3 = strong).

# Output:

# Numeric matrix of size N x 2 with columns (x1, x2).

simQuantInt <- function(N, corner, strength) {
  
  # Set parameters for specified effect strength level:  
  if(strength==1) {
    dqual <- 1.225
    propcorner <- 0.485
  }
  if(strength==2) {
    dqual <- 1.51
    propcorner <- 0.574
  }
  if(strength==3) {
    dqual <- 1.772
    propcorner <- 0.649
  }
  
  x1 <- x2 <- rep(0, N)
  
  # If class 2 in lower left corner:
  if(corner == 1) {
    draws1 <- replicate(N/2, drawQuantInt1cl1(dqual=dqual, propcorner=propcorner))
    draws2 <- replicate(N/2, drawQuantInt1cl2(dqual=dqual, propcorner=propcorner))
  }
  
  # If class 2 in lower right corner:
  if(corner == 2) {
    draws1 <- replicate(N/2, drawQuantInt2cl1(dqual=dqual, propcorner=propcorner))
    draws2 <- replicate(N/2, drawQuantInt2cl2(dqual=dqual, propcorner=propcorner))
  }
  
  # If class 2 in upper right corner:
  if(corner == 3) {
    draws1 <- replicate(N/2, drawQuantInt3cl1(dqual=dqual, propcorner=propcorner))
    draws2 <- replicate(N/2, drawQuantInt3cl2(dqual=dqual, propcorner=propcorner))
  }
  
  # If class 2 in upper left corner:
  if(corner == 4) {
    draws1 <- replicate(N/2, drawQuantInt4cl1(dqual=dqual, propcorner=propcorner))
    draws2 <- replicate(N/2, drawQuantInt4cl2(dqual=dqual, propcorner=propcorner))
  }
  
  # Assign drawn values to the variables:
  x1[1:(N/2)] <- draws1[1,]
  x2[1:(N/2)] <- draws1[2,]
  x1[((N/2)+1):N] <- draws2[1,]
  x2[((N/2)+1):N] <- draws2[2,]
  
  # Return variables:
  return(cbind(x1, x2))
}









# Functions for simulating variable pairs with qualitative interactions:



# Function for drawing a value in upper right or lower left corner:

# Input:

# dqual - mean shift parameter controlling separation between corners.

# Output:

# Numeric vector of length 2 containing one draw (x1, x2).

drawQualInt1 <- function(dqual) {
  dind <- sample(1:2, size=1)
  if(dind==1) {
    x2_1 <- rnorm(1, mean=dqual, sd=1)
    x2_2 <- rnorm(1, mean=dqual, sd=1)
  }
  else {
    x2_1 <- rnorm(1, mean=0, sd=1)
    x2_2 <- rnorm(1, mean=0, sd=1)
  }
  return(c(x2_1, x2_2))
}


# Function for drawing a value in upper left or lower right corner:

# Input:

# dqual - mean shift parameter controlling separation between corners.

# Output:

# Numeric vector of length 2 containing one draw (x1, x2).

drawQualInt2 <- function(dqual) {
  dind <- sample(1:2, size=1)
  if(dind==1) {
    x2_1 <- rnorm(1, mean=0, sd=1)
    x2_2 <- rnorm(1, mean=dqual, sd=1)
  }
  else {
    x2_1 <- rnorm(1, mean=dqual, sd=1)
    x2_2 <- rnorm(1, mean=0, sd=1)
  }
  return(c(x2_1, x2_2))
}




# Function for simulating a pair of variables with qualitative interaction:

# Input:

# N        - sample size (assumed even; N/2 per class).
# corner   - interaction pattern (1 or 2), selecting which diagonal corners correspond to class 2.
# strength - effect strength level (1 = weak, 2 = medium, 3 = strong).

# Output:

# Numeric matrix of size N x 2 with columns (x1, x2).

simQualInt <- function(N, corner, strength) {
  
  # Set parameters for specified effect strength level:  
  if(strength==1)
    dqual <- 1.225
  if(strength==2)
    dqual <- 1.51
  if(strength==3)
    dqual <- 1.772
  
  x1 <- x2 <- rep(0, N)
  
  # If class 2 in upper left and lower right corner:
  if(corner == 1) {
    
    draws <- replicate(N/2, drawQualInt1(dqual=dqual))
    x1[1:(N/2)] <- draws[1,]
    x2[1:(N/2)] <- draws[2,]
    
    draws <- replicate(N/2, drawQualInt2(dqual=dqual))
    x1[((N/2)+1):N] <- draws[1,]
    x2[((N/2)+1):N] <- draws[2,]
  }
  
  # If class 2 in upper right and lower left corner:
  if(corner == 2) {
    
    draws <- replicate(N/2, drawQualInt2(dqual=dqual))
    x1[1:(N/2)] <- draws[1,]
    x2[1:(N/2)] <- draws[2,]
    
    draws <- replicate(N/2, drawQualInt1(dqual=dqual))
    x1[((N/2)+1):N] <- draws[1,]
    x2[((N/2)+1):N] <- draws[2,]
  }
  
  # Return variables:
  return(cbind(x1, x2))
}






# Function for simulating a dataset:

# Input:

# N            - sample size (assumed even; balanced classes).
# mainstrength - numeric vector of length 3 with effect strength levels for main effects.
# quantstrength- numeric vector of length 3 with effect strength levels for quantitative interactions.
# qualstrength - numeric vector of length 3 with effect strength levels for qualitative interactions.

# Output:

# Data frame with N rows containing the outcome 'y' and 68 predictors.

simDataset <- function(N, mainstrength, quantstrength, qualstrength) {
  
  require("mvtnorm")
  
  # Empty data frame:
  simdata <- data.frame(matrix(nrow=N, ncol=68))
  
  # Add outcome variable:
  simdata$y <- factor(rep(1:2, each=N/2), levels=1:2)
  
  # Add variables without effect:
  count <- 1
  for(i in 1:50) {
    simdata[,count] <- rnorm(N, mean=0, sd=1)
    count <- count + 1
  }
  
  # Add variables with main effects only:
  simdata[,count] <- simMainEff(N, strength=mainstrength[1])
  count <- count + 1
  simdata[,count] <- simMainEff(N, strength=mainstrength[1])
  count <- count + 1
  
  simdata[,count] <- simMainEff(N, strength=mainstrength[2])
  count <- count + 1
  simdata[,count] <- simMainEff(N, strength=mainstrength[2])
  count <- count + 1
  
  simdata[,count] <- simMainEff(N, strength=mainstrength[3])
  count <- count + 1
  simdata[,count] <- simMainEff(N, strength=mainstrength[3])
  count <- count + 1
  
  
  # Add variables with quantitative interactions:
  simdata[,count + c(0,1)] <- simQuantInt(N, corner=2, strength=quantstrength[1])
  count <- count + 2
  
  simdata[,count + c(0,1)] <- simQuantInt(N, corner=3, strength=quantstrength[2])
  count <- count + 2
  
  simdata[,count + c(0,1)] <- simQuantInt(N, corner=4, strength=quantstrength[3])
  count <- count + 2
  
  
  # Add variables with qualitative interactions:  
  simdata[,count + c(0,1)] <- simQualInt(N, corner=2, strength=qualstrength[1])
  count <- count + 2
  
  simdata[,count + c(0,1)] <- simQualInt(N, corner=1, strength=qualstrength[2])
  count <- count + 2
  
  simdata[,count + c(0,1)] <- simQualInt(N, corner=2, strength=qualstrength[3])
  count <- count + 2
  
  
  # Return dataset:
  return(simdata)
  
}
