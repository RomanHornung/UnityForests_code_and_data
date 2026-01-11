####################################################################################

# NOTE:
# If the R working directory is not already set to
# '/UnityForests_code_and_data/benchmark_study', it MUST be set to this directory
# before running this script (this is the directory in which this script is located).

# In that case, remove the '#' from the line below and replace 'here/is/my/path/'
# with the path to the directory '/UnityForests_code_and_data/benchmark_study':

# setwd("here/is/my/path/")

####################################################################################



# Load and pre-process the results:
#####################################

load("./intermediate_results/scenariogrid_benchmark_study.Rda")
load("./intermediate_results/results_benchmark_study.Rda")
load("../data/datainfo.Rda")

scenariogrid$order <- 1:nrow(scenariogrid)

scenariogrid <- merge(scenariogrid, datainfo[, c("dataset", "n", "p")], 
                      by = "dataset", all.x = TRUE)

scenariogrid <- scenariogrid[order(scenariogrid$order), ]
scenariogrid$order <- NULL

scenariogrid$acc <- sapply(results, function(x) mean(sapply(x, function(y) y$acctest)))
scenariogrid$auc <- sapply(results, function(x) mean(sapply(x, function(y) y$auctest)))
scenariogrid$brier <- sapply(results, function(x) mean(sapply(x, function(y) y$briertest)))

results_all <- scenariogrid[order(scenariogrid$dataset, scenariogrid$cvind, scenariogrid$method),]
results_all$seed <- NULL





# For comparing the performance of UFOs with that of RFs, we exclude the 30 datasets 
# used in the preliminary study in which we investigated the influence of the 
# hyperparameter values:

datasets_pre_study <- c("dataset55_rabe_266_id782.Rda", "dataset179_delta_ailerons_id803.Rda", 
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


results <- results_all[!(results_all$dataset %in% datasets_pre_study),]



# Average over the cross-validation repetitions for each dataset:

library("dplyr")

resultssum <- results %>%
  group_by(dataset, method) %>%
  summarise(
    n = first(n),
    p = first(p),
    acc = mean(acc, na.rm = TRUE),
    auc = mean(auc, na.rm = TRUE),
    brier = mean(brier, na.rm = TRUE)
  ) %>%
  ungroup()






# Table 1: Comparison of UFOs and conventional RFs across datasets.
###################################################################

library("tidyr")

# Reshape the data to compare uf and rf
comparison <- resultssum %>%
  filter(method %in% c("uf", "rf")) %>%
  pivot_wider(names_from = method, values_from = c(auc, brier, acc)) 

# Function to calculate counts and percentages with explicit rounding
compare_metrics <- function(uf, rf, better_criteria = "greater") {
  if (better_criteria == "greater") {
    better <- sum(uf > rf, na.rm = TRUE)
    equal <- sum(uf == rf, na.rm = TRUE)
    worse <- sum(uf < rf, na.rm = TRUE)
  } else if (better_criteria == "smaller") {
    better <- sum(uf < rf, na.rm = TRUE)
    equal <- sum(uf == rf, na.rm = TRUE)
    worse <- sum(uf > rf, na.rm = TRUE)
  }
  total <- better + equal + worse
  better_pct <- round(100 * better / total, 1)
  equal_pct <- round(100 * equal / total, 1)
  worse_pct <- round(100 * worse / total, 1)
  
  data.frame(
    Better = sprintf("%d (%.1f%%)", better, better_pct),
    Equal = sprintf("%d (%.1f%%)", equal, equal_pct),
    Worse = sprintf("%d (%.1f%%)", worse, worse_pct)
  )
}

# Apply the comparison function to each metric
auc_comparison <- compare_metrics(comparison$auc_uf, comparison$auc_rf, better_criteria = "greater")
brier_comparison <- compare_metrics(comparison$brier_uf, comparison$brier_rf, better_criteria = "smaller")
acc_comparison <- compare_metrics(comparison$acc_uf, comparison$acc_rf, better_criteria = "greater")

# Combine the results into one table
comparison_results <- bind_rows(
  data.frame(Metric = "Brier", brier_comparison),
  data.frame(Metric = "AUC", auc_comparison),
  data.frame(Metric = "ACC", acc_comparison)
)


# Load necessary package:
library("xtable")

# Change column names:
colnames(comparison_results) <- c("Metric", "UFO better", "UFO equal", "UFO worse")

# Generate LaTeX table:
tab <- xtable(
  comparison_results,
  caption = "Comparison of UFOs and conventional RFs across datasets. Each entry shows the number of datasets for which UFOs performed better, equal, or worse than RFs; percentages in parentheses indicate the corresponding proportions",
  label = "tab:benchmark_results",
  align = c("l", "l", "c", "c", "c")
)


# Table 1:

print(
  tab,
  file = "../tables/Tab1.tex",
  include.rownames = FALSE,
  booktabs = TRUE,
  caption.placement = "top"
)



# Use a binomial test to assess whether it can be explained by chance that UFO performed more frequently better
# than RF with respect to the AUC and ACC and more frequently worse than RF with
# respect to the Brier:

fu <- function(x) as.numeric(strsplit(x, split=" ")[[1]][1])

formatp <- function(x) ifelse(x < 0.001, "<0.001", round(x, 3))

# AUC
test_res <- binom.test(x =  fu(comparison_results[1,2]), n =  fu(comparison_results[1,2]) +  fu(comparison_results[1,4]), p = 0.5, alternative = "two.sided")
formatp(test_res$p.value)

# Brier
test_res <- binom.test(x =  fu(comparison_results[2,2]), n =  fu(comparison_results[2,2]) +  fu(comparison_results[2,4]), p = 0.5, alternative = "two.sided")
formatp(test_res$p.value)

# ACC
test_res <- binom.test(x = fu(comparison_results[3,2]), n =  fu(comparison_results[3,2]) +  fu(comparison_results[3,4]), p = 0.5, alternative = "two.sided")
formatp(test_res$p.value)







# Figure S2: Dataset-specific performance metric values: UFO versus conventional RF.
###################################################################################

library("sp")
which(bpy.colors()=="#FFC936FF")

# plot(1:length(bpy.colors()), col=bpy.colors(), pch=20)
bpy.colors()[80]

library("ggplot2")
library("scales")

# Calculate averages
resultssum_all <- results_all %>%
  group_by(dataset, method) %>%
  summarise(
    n = first(n),
    p = first(p),
    acc = mean(acc, na.rm = TRUE),
    auc = mean(auc, na.rm = TRUE),
    brier = mean(brier, na.rm = TRUE)
  ) %>%
  ungroup()

# Reshape the data to compare uf and rf
comparison <- resultssum_all %>%
  filter(method %in% c("uf", "rf")) %>%
  pivot_wider(names_from = method, values_from = c(auc, brier, acc))

comparison <- comparison %>%
  mutate(
    quality = case_when(
      auc_uf < 0.6 & auc_rf < 0.6 ~ "very weak signal",
      auc_uf > 0.99 & auc_rf > 0.99 ~ "very strong signal",
      TRUE ~ "normal signal"  # Default case
    )
  )


# "Transformed using negative complementary square root transformation"
custom_trans <- trans_new(
  name = "proportion",
  transform = function(x) -sqrt(1-x),
  inverse = function(x) 1 - x^2
)

p1 <- ggplot(comparison, aes(x = auc_rf, y = auc_uf)) + theme_bw() +
  geom_point(aes(color = quality, shape = quality), size = 1) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "black") +
  scale_x_continuous(trans = custom_trans, limits = c(NA, 1), breaks = c(0.4, 0.5, 0.8, 0.95, 0.99, 1)) +
  scale_y_continuous(trans = custom_trans, limits = c(NA, 1), breaks = c(0.4, 0.5, 0.8, 0.95, 0.99, 1)) +
  scale_shape_manual(values = c(19, 2, 0)) + 
  scale_color_manual(values = c("#000046FF", "#FFB24DFF", "#980BF4FF")) +
  labs(title = "AUC",
       x = "RF", 
       y = "UFO") + theme(legend.position = "none") 

p1

# "Transformed using Square Root Scale"
prop_trans <- trans_new(
  name = "proportion",
  transform = function(x) sqrt(x),
  inverse = function(x) x^2
)



p2 <- ggplot(comparison, aes(x = brier_rf, y = brier_uf)) + theme_bw() +
  geom_point(aes(color = quality, shape = quality), size = 1) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "black") +
  scale_x_continuous(trans = prop_trans, breaks = c(0.01, 0.05, 0.15, 0.25)) +
  scale_y_continuous(trans = prop_trans, breaks = c(0.01, 0.05, 0.15, 0.25)) +
  scale_shape_manual(values = c(19, 2, 0)) + 
  scale_color_manual(values = c("#000046FF", "#FFB24DFF", "#980BF4FF")) +
  labs(title = "Brier",
       x = "RF", 
       y = "UFO") + theme(legend.position = "none")


p3 <- ggplot(comparison, aes(x = acc_rf, y = acc_uf)) + theme_bw() +
  geom_point(aes(color = quality, shape = quality), size = 1) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "black") +
  scale_x_continuous(trans = custom_trans, limits = c(NA, 1), breaks = c(0.2, 0.5, 0.8, 0.95, 0.99, 1)) +
  scale_y_continuous(trans = custom_trans, limits = c(NA, 1), breaks = c(0.2, 0.5, 0.8, 0.95, 0.99, 1)) +
  scale_shape_manual(values = c(19, 2, 0)) + 
  scale_color_manual(values = c("#000046FF", "#FFB24DFF", "#980BF4FF")) +
  labs(title = "ACC",
       x = "RF", 
       y = "UFO") + theme(legend.position = "none")

library("patchwork")
ps <- p1 | p2 | p3
ps

# Figure S2:

ggsave("../figures/FigS2.pdf", width=15*0.8, height=5*0.8)
ggsave("../figures/FigS2.eps", width=15*0.8, height=5*0.8)
