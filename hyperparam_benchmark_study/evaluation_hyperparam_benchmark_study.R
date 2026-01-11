####################################################################################

# NOTE:
# If the R working directory is not already set to
# '/UnityForests_code_and_data/hyperparam_benchmark_study', it MUST be set to this directory
# before running this script (this is the directory in which this script is located).

# In that case, remove the '#' from the line below and replace 'here/is/my/path/'
# with the path to the directory '/UnityForests_code_and_data/hyperparam_benchmark_study':

# setwd("here/is/my/path/")

####################################################################################



# Figure S1: Preliminary study: Dataset-specific performance metric values depending 
# on the considered values of N_CAND_TREES, MAX_DEPTH_ROOT, and PROP_VAR
#####################################################################################


# Global plot parameters:

y_label_size <- 16
x_label_size <- 16
x_y_tex_size <- 13



# Plot for the N_CAND_TREES analysis:


load("./intermediate_results/scenariogrid_num_cand_trees.Rda")
load("./intermediate_results/results_num_cand_trees.Rda")
load("../data/datainfo.Rda")


# Save orginal ordering
scenariogrid$order <- 1:nrow(scenariogrid)

# Conduct merge
scenariogrid <- merge(scenariogrid, datainfo[, c("dataset", "n", "p")], 
                      by = "dataset", all.x = TRUE)

# Sort by original order and remove helper column
scenariogrid <- scenariogrid[order(scenariogrid$order), ]
scenariogrid$order <- NULL


scenariogrid$acc <- sapply(results, function(x) mean(sapply(x, function(y) y$acctest)))
scenariogrid$auc <- sapply(results, function(x) mean(sapply(x, function(y) y$auctest)))
scenariogrid$brier <- sapply(results, function(x) mean(sapply(x, function(y) y$briertest)))

results <- scenariogrid[order(scenariogrid$dataset, scenariogrid$cvind, scenariogrid$num_cand_trees),]
results$seed <- NULL


library("dplyr")

# Calculate averages
resultssum <- results %>%
  group_by(dataset, num_cand_trees) %>%
  summarise(
    n = first(n),
    p = first(p),
    acc = mean(acc, na.rm = TRUE),
    auc = mean(auc, na.rm = TRUE),
    brier = mean(brier, na.rm = TRUE)
  ) %>%
  ungroup()


library("ggplot2")

# Extract unique values for x-axis breaks
unique_trees <- sort(unique(resultssum$num_cand_trees))

# Plot for Brier
p_brier_num_cand_trees <- ggplot(data = resultssum, aes(x = num_cand_trees, y = brier, group = dataset)) + 
  theme_bw() + 
  geom_point() + 
  geom_line() +
  scale_x_log10(breaks = unique_trees, labels = unique_trees) + 
  labs(x = "N_CAND_TREES", y = "Brier") + 
  theme(axis.text = element_text(color="black"), axis.text.x = element_text(size = x_y_tex_size, angle = 45, hjust = 1), axis.text.y = element_text(size = x_y_tex_size), axis.title.x = element_text(size = x_label_size), axis.title.y = element_text(size = y_label_size))

# Plot for AUC
p_auc_num_cand_trees <- ggplot(data = resultssum, aes(x = num_cand_trees, y = auc, group = dataset)) + 
  theme_bw() + 
  geom_point() + 
  geom_line() +
  scale_x_log10(breaks = unique_trees, labels = unique_trees) + 
  labs(x = "N_CAND_TREES", y = "AUC") + 
  theme(axis.text = element_text(color="black"), axis.text.x = element_text(size = x_y_tex_size, angle = 45, hjust = 1), axis.text.y = element_text(size = x_y_tex_size), axis.title.x = element_text(size = x_label_size), axis.title.y = element_text(size = y_label_size))

# Plot for Accuracy (Acc)
p_acc_num_cand_trees <- ggplot(data = resultssum, aes(x = num_cand_trees, y = acc, group = dataset)) + 
  theme_bw() + 
  geom_point() + 
  geom_line() +
  scale_x_log10(breaks = unique_trees, labels = unique_trees) + 
  labs(x = "N_CAND_TREES", y = "Accuracy") + 
  theme(axis.text = element_text(color="black"), axis.text.x = element_text(size = x_y_tex_size, angle = 45, hjust = 1), axis.text.y = element_text(size = x_y_tex_size), axis.title.x = element_text(size = x_label_size), axis.title.y = element_text(size = y_label_size))

# Combine the plots side by side
library("patchwork")
combined_plot_num_cand_trees <- p_brier_num_cand_trees + p_auc_num_cand_trees + p_acc_num_cand_trees + 
  plot_layout(ncol = 3)  # Arrange in one row with 3 columns





# Plot for the MAX_DEPTH_ROOT analysis:


load("./intermediate_results/scenariogrid_max_depth_root.Rda")
load("./intermediate_results/results_max_depth_root.Rda")
load("../data/datainfo.Rda")

# Save orginal ordering
scenariogrid$order <- 1:nrow(scenariogrid)

# Conduct merge
scenariogrid <- merge(scenariogrid, datainfo[, c("dataset", "n", "p")], 
                      by = "dataset", all.x = TRUE)

# Sort by original order and remove helper column
scenariogrid <- scenariogrid[order(scenariogrid$order), ]
scenariogrid$order <- NULL


scenariogrid$acc <- sapply(results, function(x) mean(sapply(x, function(y) y$acctest)))
scenariogrid$auc <- sapply(results, function(x) mean(sapply(x, function(y) y$auctest)))
scenariogrid$brier <- sapply(results, function(x) mean(sapply(x, function(y) y$briertest)))

results <- scenariogrid[order(scenariogrid$dataset, scenariogrid$cvind, scenariogrid$max_depth_root),]
results$seed <- NULL


# Calculate averages
resultssum <- results %>%
  group_by(dataset, max_depth_root) %>%
  summarise(
    n = first(n),
    p = first(p),
    acc = mean(acc, na.rm = TRUE),
    auc = mean(auc, na.rm = TRUE),
    brier = mean(brier, na.rm = TRUE)
  ) %>%
  ungroup()

# View the first few rows of the result
head(resultssum)



p_brier_max_depth_root <- ggplot(data = resultssum, aes(x = max_depth_root, y = brier, group = dataset)) + 
  theme_bw() + 
  geom_point() + 
  geom_line() +
  labs(x = "MAX_DEPTH_ROOT", y = "Brier") + 
  theme(axis.text = element_text(size = x_y_tex_size, color="black"), axis.title.x = element_text(size = x_label_size), axis.title.y = element_text(size = y_label_size))

p_auc_max_depth_root <- ggplot(data = resultssum, aes(x = max_depth_root, y = auc, group = dataset)) + 
  theme_bw() + 
  geom_point() + 
  geom_line() +
  labs(x = "MAX_DEPTH_ROOT", y = "AUC") + 
  theme(axis.text = element_text(size = x_y_tex_size, color="black"), axis.title.x = element_text(size = x_label_size), axis.title.y = element_text(size = y_label_size))

p_acc_max_depth_root <- ggplot(data = resultssum, aes(x = max_depth_root, y = acc, group = dataset)) + 
  theme_bw() + 
  geom_point() + 
  geom_line() +
  labs(x = "MAX_DEPTH_ROOT", y = "Accuracy") + 
  theme(axis.text = element_text(size = x_y_tex_size, color="black"), axis.title.x = element_text(size = x_label_size), axis.title.y = element_text(size = y_label_size))


# Combine the plots side by side

combined_plot_max_depth_root <- p_brier_max_depth_root + p_auc_max_depth_root + p_acc_max_depth_root + 
  plot_layout(ncol = 3)  # Arrange in one row with 3 columns





# Informal analysis indicating that datasets exhibiting stronger deterioration for larger depths
# tended to be small:


p <- ggplot(data = resultssum, aes(x = max_depth_root, y = brier, group = dataset)) + 
  theme_bw() + 
  geom_point() + 
  geom_line() +
  labs(x = "max_depth_root", y = "Brier") + 
  theme(axis.text = element_text(color="black"))
p

# --> For most datasets max_depth_root does not seem to have a strong
# influence on the results.
# However, there are a number of datasets for which larger values of max_depth_root
# lead to worse results.


# --> Investigate the datasets for which larger values of max_depth_root
# lead to worse results:

library("tidyr")

# Create a data frame with the desired structure and order by brier_diff
ordered_datasets <- resultssum %>%
  filter(max_depth_root %in% c(2, 3, 5)) %>% 
  pivot_wider(names_from = max_depth_root, 
              values_from = c(acc, auc, brier), 
              names_prefix = "max_depth_root_") %>%
  mutate(brier_diff = brier_max_depth_root_2 - brier_max_depth_root_5) %>%
  arrange(brier_diff)

# Print the result
print(ordered_datasets, n = Inf)

plot(ordered_datasets$brier_diff)
abline(v=6.5, lty=2)

# --> For six datasets, the difference is stronger than for the other datasets.


# Compare the sample size and the number of variables of these datasets with those
# of the remaining datasets:

par(mfrow=c(1,3))
boxplot(ordered_datasets$n[1:6], ordered_datasets$n[-(1:6)])
boxplot(log(ordered_datasets$n[1:6]), log(ordered_datasets$n[-(1:6)]))
wilcox.test(ordered_datasets$n[1:6], ordered_datasets$n[-(1:6)])

boxplot(ordered_datasets$p[1:6], ordered_datasets$p[-(1:6)])
par(mfrow=c(1,1))

# --> These 6 datasets tend to be rather small; but their numbers of variables are
# not systematically different compared to those of the remaining datasets.












# Plot for the PROP_VAR analysis:


load("./intermediate_results/scenariogrid_prop_var_root.Rda")
load("./intermediate_results/results_prop_var_root.Rda")
load("../data/datainfo.Rda")

# Save orginal ordering
scenariogrid$order <- 1:nrow(scenariogrid)

# Conduct merge
scenariogrid <- merge(scenariogrid, datainfo[, c("dataset", "n", "p")], 
                      by = "dataset", all.x = TRUE)

# Sort by original order and remove helper column
scenariogrid <- scenariogrid[order(scenariogrid$order), ]
scenariogrid$order <- NULL


scenariogrid$acc <- sapply(results, function(x) mean(sapply(x, function(y) y$acctest)))
scenariogrid$auc <- sapply(results, function(x) mean(sapply(x, function(y) y$auctest)))
scenariogrid$brier <- sapply(results, function(x) mean(sapply(x, function(y) y$briertest)))

results <- scenariogrid[order(scenariogrid$dataset, scenariogrid$cvind, scenariogrid$prop_var_root_mult ),]
results$seed <- NULL
results$prop_var_root_mult[results$prop_var_root_mult==99] <- 5



# Calculate averages
resultssum <- results %>%
  group_by(dataset, prop_var_root_mult) %>%
  summarise(
    n = first(n),
    p = first(p),
    acc = mean(acc, na.rm = TRUE),
    auc = mean(auc, na.rm = TRUE),
    brier = mean(brier, na.rm = TRUE)
  ) %>%
  ungroup()


# Make x a factor and define math-formatted labels ----
# Ensure prop_var_root_mult is treated as discrete and in the intended order.

resultssum$prop_var_root_mult <- factor(
  resultssum$prop_var_root_mult,
  levels = c(0.5, 1, 2, 3, 4, 5)
)

prop_var_labels <- c(
  expression(0.5 * sqrt(p) / p),
  expression(sqrt(p) / p),
  expression(2 * sqrt(p) / p),
  expression(3 * sqrt(p) / p),
  expression(4 * sqrt(p) / p),
  expression(1)
)

# Plot with custom breaks/labels
p_brier_prop_var_root <- ggplot(
  data = resultssum,
  aes(x = prop_var_root_mult, y = brier, group = dataset)
) +
  theme_bw() +
  geom_point() +
  geom_line() +
  scale_x_discrete(labels = prop_var_labels) +
  labs(x = "PROP_VAR", y = "Brier") +
  theme(
    axis.text = element_text(size = x_y_tex_size, color = "black"),
    axis.title.x = element_text(size = x_label_size),
    axis.title.y = element_text(size = y_label_size)
  )

p_auc_prop_var_root <- ggplot(
  data = resultssum,
  aes(x = prop_var_root_mult, y = auc, group = dataset)
) +
  theme_bw() +
  geom_point() +
  geom_line() +
  scale_x_discrete(labels = prop_var_labels) +
  labs(x = "PROP_VAR", y = "AUC") +
  theme(
    axis.text = element_text(size = x_y_tex_size, color = "black"),
    axis.title.x = element_text(size = x_label_size),
    axis.title.y = element_text(size = y_label_size)
  )

p_acc_prop_var_root <- ggplot(
  data = resultssum,
  aes(x = prop_var_root_mult, y = acc, group = dataset)
) +
  theme_bw() +
  geom_point() +
  geom_line() +
  scale_x_discrete(labels = prop_var_labels) +
  labs(x = "PROP_VAR", y = "Accuracy") +
  theme(
    axis.text = element_text(size = x_y_tex_size, color = "black"),
    axis.title.x = element_text(size = x_label_size),
    axis.title.y = element_text(size = y_label_size)
  )

# Combine the plots side by side

combined_plot_prop_var_root <- p_brier_prop_var_root + p_auc_prop_var_root + p_acc_prop_var_root + 
  plot_layout(ncol = 3)  # Arrange in one row with 3 columns




# Combine the plots for all three investigated hyperparameters beneath each other:

combined_plot <- combined_plot_num_cand_trees / combined_plot_max_depth_root / combined_plot_prop_var_root +
  plot_layout(ncol = 1)  # Arrange in one row with 3 columns

# Display the combined plot:

combined_plot



# Figure S1:

ggsave("../figures/FigS1.eps", combined_plot, width=15, height=14)
ggsave("../figures/FigS1.pdf", combined_plot, width=15, height=14)
