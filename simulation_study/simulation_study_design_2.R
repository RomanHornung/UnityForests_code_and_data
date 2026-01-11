####################################################################################

# NOTE:
# If the R working directory is not already set to
# '/UnityForests_code_and_data/simulation_study', it MUST be set to this directory
# before running this script (this is the directory in which this script is located).

# In that case, remove the '#' from the line below and replace 'here/is/my/path/'
# with the path to the directory '/UnityForests_code_and_data/simulation_study':

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



# Make table of settings (each row in the table contains the information for one iteration):

n <- c(100, 300, 500, 1000)
itind <- 1:1000

scenariogrid <- expand.grid(itind=itind, n=n, stringsAsFactors = FALSE)
scenariogrid <- scenariogrid[,ncol(scenariogrid):1, drop=FALSE]


# Add a specific seed to each row, such that the individual iterations are reproducible:
set.seed(1234)
seeds <- sample(1000:10000000, size=nrow(scenariogrid))

scenariogrid$seed <- seeds


# Randomly permute the rows of "scenariogrid" so that the computational burden
# is ensured to be distributed evenly across the parallel nodes:

set.seed(1234)
reorderind <- sample(1:nrow(scenariogrid))
scenariogrid <- scenariogrid[reorderind,,drop=FALSE]
rownames(scenariogrid) <- NULL



# Save scenariogrid, needed in evaluation of the results:

save(scenariogrid, file="./intermediate_results/scenariogrid_simulation_study_design_2.Rda")




# Source the functions that are used in performing the calculations 
# on the cluster:

source("./functions_simulation_study_design_2.R")




# Start the cluster:

ncores <- parallel::detectCores(logical = TRUE)
cl <- makeCluster(min(100, ncores-1), type = "PSOCK")




# Register the parallel backend:

registerDoParallel(cl)


current_dir <- getwd()  # Get the current working directory


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

save(results, file="./intermediate_results/results_simulation_study_design_2.Rda")  


# Stop the cluster:

stopCluster(cl)



# Delete the Rda files that contained the replication-specific results:

Sys.sleep(3)

allfiles <- grep("res_simulation_study_design_2_", list.files("./intermediate_results/"), value=TRUE)

for (i in seq(along=allfiles))
  file.remove(paste0("./intermediate_results/", allfiles[i]))
