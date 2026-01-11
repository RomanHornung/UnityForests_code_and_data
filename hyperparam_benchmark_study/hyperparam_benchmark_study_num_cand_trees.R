####################################################################################

# NOTE:
# If the R working directory is not already set to
# '/UnityForests_code_and_data/hyperparam_benchmark_study', it MUST be set to this directory
# before running this script (this is the directory in which this script is located).

# In that case, remove the '#' from the line below and replace 'here/is/my/path/'
# with the path to the directory '/UnityForests_code_and_data/hyperparam_benchmark_study':

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



# Randomly draw 30 datasets from the datasets for which the outcome variables
# were created by dichotomizing a continuous variable:

# All available datasets with dichotomized outcome:

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

# Randomly sample 30 datasets:
set.seed(1234)
datasets <- sample(dichotomized_datasets, size=30)

cat(paste(datasets, collapse="\", \""), "\n")

# These are the sampled datasets:
datasets <- c("dataset55_rabe_266_id782.Rda", "dataset179_delta_ailerons_id803.Rda", 
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





# Make table of settings:

cvind <- 1:5
num_cand_trees <- c(2, 5, 10, 50, 100, 200, 500, 1000, 2000)

scenariogrid <- expand.grid(num_cand_trees=num_cand_trees, cvind=cvind, dataset=datasets, stringsAsFactors = TRUE)
scenariogrid <- scenariogrid[,ncol(scenariogrid):1, drop=FALSE]

set.seed(1234)
seeds <- sample(1000:10000000, size=length(datasets)*length(cvind))

scenariogrid$seed <- rep(seeds, each=length(num_cand_trees))

set.seed(1234)
reorderind <- sample(1:nrow(scenariogrid))
scenariogrid <- scenariogrid[reorderind,,drop=FALSE]
rownames(scenariogrid) <- NULL

nrow(scenariogrid)



# Save scenariogrid, needed in evaluation of the results:

save(scenariogrid, file="./intermediate_results/scenariogrid_num_cand_trees.Rda")




# Source the functions that are used in performing the calculations 
# on the cluster:

source("./functions_hyperparam_benchmark_study.R")




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
    evaluatesetting_num_cand_trees(z, current_dir)
  })
})




# Save the results:  

save(results, file="./intermediate_results/results_num_cand_trees.Rda")  



# Stop the cluster:

stopCluster(cl)



# Delete the Rda files that contained the replication-specific results:

Sys.sleep(3)

allfiles <- grep("res_num_cand_trees_", list.files("./intermediate_results/"), value=TRUE)

for (i in seq(along=allfiles))
  file.remove(paste0("./intermediate_results/", allfiles[i]))
