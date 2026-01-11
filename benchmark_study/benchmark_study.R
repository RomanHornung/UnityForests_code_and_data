####################################################################################

# NOTE:
# If the R working directory is not already set to
# '/UnityForests_code_and_data/benchmark_study', it MUST be set to this directory
# before running this script (this is the directory in which this script is located).

# In that case, remove the '#' from the line below and replace 'here/is/my/path/'
# with the path to the directory '/UnityForests_code_and_data/benchmark_study':

# setwd("here/is/my/path/")

####################################################################################



# Limit internal BLAS/OpenMP threading to avoid oversubscription
# when running many parallel R workers (set only if not defined):

set_if_unset <- function(var, value) {
  if (Sys.getenv(var, unset = "") == "") {
    do.call(Sys.setenv, setNames(list(value), var))
  }
}

set_if_unset("OMP_NUM_THREADS", "1")
set_if_unset("OPENBLAS_NUM_THREADS", "1")



# Load libraries for parallelization:

library("parallel")
library("doParallel")




# Available datasets:

datasets <- list.files("../data/datasets")



# Make table of settings:

cvind <- 1:5
method <- c("uf", "rf")

scenariogrid <- expand.grid(method=method, cvind=cvind, dataset=datasets, stringsAsFactors = TRUE)
scenariogrid <- scenariogrid[,ncol(scenariogrid):1, drop=FALSE]

set.seed(1234)
seeds <- sample(1000:10000000, size=length(datasets)*length(cvind))

scenariogrid$seed <- rep(seeds, each=length(method))

set.seed(1234)
reorderind <- sample(1:nrow(scenariogrid))
scenariogrid <- scenariogrid[reorderind,,drop=FALSE]
rownames(scenariogrid) <- NULL




# Save scenariogrid, needed in evaluation of the results:

save(scenariogrid, file="./intermediate_results/scenariogrid_benchmark_study.Rda")



# Source the functions that are used in performing the calculations 
# on the cluster:

source("./functions_benchmark_study.R")




# Start the cluster:

ncores <- parallel::detectCores(logical = TRUE)
cl <- makeCluster(min(100, ncores-1), type = "PSOCK")



# Register the parallel backend:

registerDoParallel(cl)



# Get the current working directory:

current_dir <- getwd()



# Export the objects in the workspace to the
# parallel jobs:

clusterExport(cl, varlist = ls())



# Perform the calculations:

results <- parLapply(cl, 1:nrow(scenariogrid), function(z) {
  try({
    evaluatesetting(z, current_dir)
  })
})




# Save the results:  

save(results, file="./intermediate_results/results_benchmark_study.Rda")  



# Stop the cluster:

stopCluster(cl)



# Delete the Rda files that contained the replication-specific results:

Sys.sleep(3)

allfiles <- grep("res_benchmark_study_", list.files("./intermediate_results/"), value=TRUE)

for (i in seq(along=allfiles))
  file.remove(paste0("./intermediate_results/", allfiles[i]))
