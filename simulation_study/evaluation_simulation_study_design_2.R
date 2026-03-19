####################################################################################

# NOTE:
# If the R working directory is not already set to
# '/UnityForests_code_and_data/simulation_study', it MUST be set to this directory
# before running this script (this is the directory in which this script is located).

# In that case, remove the '#' from the line below and replace 'here/is/my/path/'
# with the path to the directory '/UnityForests_code_and_data/simulation_study':

# setwd("here/is/my/path/")

####################################################################################



# Load and pre-process the results:
#####################################

load("./intermediate_results/scenariogrid_simulation_study_design_2.Rda")
load("./intermediate_results/results_simulation_study_design_2.Rda")

reorderind <- order(scenariogrid$n, scenariogrid$itind)
scenariogrid <- scenariogrid[reorderind,]
results <- results[reorderind]

scenariogrid$seed <- NULL

resultsmethods <- scenariogrid[rep(1:nrow(scenariogrid), each=length(results[[1]])),]
resultsmethods$method_all <- rep(names(results[[1]]), times=nrow(scenariogrid))

resultsmethods$n <- factor(
  paste0("n = ", resultsmethods$n),
  levels = paste0("n = ", sort(unique(resultsmethods$n)))
)

results <- unlist(results, recursive = FALSE)

resultsall <- resultsmethods[rep(1:nrow(resultsmethods), times=sapply(results, length)),]
resultsall$rank <- unlist(lapply(results, function(x) rank(-x)))
resultsall$vim <- unlist(results)
rownames(resultsall) <- 1:nrow(resultsall)

resultsall$method_all <- factor(resultsall$method_all, levels=c("perm", "gini_corr", "unity_vim"))

library("dplyr")
library("tidyr")
library("ggplot2")
library("scales")
library("stringr")
library("knitr")
library("ggh4x")

resultsall <- resultsall %>%
  group_by(n, itind, method_all) %>%
  mutate(var_index = row_number()) %>%
  ungroup()

resultsall$var_index <- as.factor(resultsall$var_index)




# Labels / ordering:


# Table labels (LaTeX strings) - keep for kable
label_order <- c(
  "$X_{mrg\\_s}$",
  "$X_{mrg\\_m}$",
  "$X_{mrg\\_w}$",
  "$X_{bne\\_ql}$",
  "$X_{ql\\_bne\\_s}$",
  "$X_{ql\\_bne\\_m}$",
  "$X_{ql\\_bne\\_w}$",
  "$X_{be\\_ql}$",
  "$X_{ql\\_be\\_s}$",
  "$X_{ql\\_be\\_m}$",
  "$X_{ql\\_be\\_w}$",
  "$X_{bne\\_qn}$",
  "$X_{qn\\_bne\\_s}$",
  "$X_{qn\\_bne\\_m}$",
  "$X_{qn\\_bne\\_w}$",
  "$X_{cne\\_ql}$",
  "$X_{ql\\_cne\\_s}$",
  "$X_{ql\\_cne\\_m}$",
  "$X_{ql\\_cne\\_w}$"
)

# For facet titles: plotmath strings (will be parsed by label_parsed)
# These correspond to variables 1:19.
label_order_parsed <- c(
  'X[mrg*"_s"]',
  'X[mrg*"_m"]',
  'X[mrg*"_w"]',
  'X[bne*"_ql"]',
  'X[ql*"_bne"*"_s"]',
  'X[ql*"_bne"*"_m"]',
  'X[ql*"_bne"*"_w"]',
  'X[be*"_ql"]',
  'X[ql*"_be"*"_s"]',
  'X[ql*"_be"*"_m"]',
  'X[ql*"_be"*"_w"]',
  'X[bne*"_qn"]',
  'X[qn*"_bne"*"_s"]',
  'X[qn*"_bne"*"_m"]',
  'X[qn*"_bne"*"_w"]',
  'X[cne*"_ql"]',
  'X[ql*"_cne"*"_s"]',
  'X[ql*"_cne"*"_m"]',
  'X[ql*"_cne"*"_w"]'
)



# Facet layout levels: 5 rows x 4 cols, with empty slot 4 in first row

design <- "
ABC#
DEFG
HIJK
LMNO
PQRS
"

# Helper: parse numeric n from "n = 100"
parse_n_num <- function(n_factor) as.numeric(str_extract(as.character(n_factor), "\\d+"))

# Method order + pretty labels for plots
method_levels_plot <- c("unity_vim", "perm", "gini_corr")
method_labels_plot <- c("Unity_vim", "Perm", "Gini")

# dodge to avoid overlap at same sample size
pd <- position_dodge(width = 0.55)









# AUCs: Mean AUC values with 95% confidence intervals:



# Functions for calculating the AUC with 95% confidence interval:

auroc <- function(score, bool) {
  n1 <- sum(!bool)
  n2 <- sum(bool)
  U  <- sum(rank(score)[!bool]) - n1 * (n1 + 1) / 2
  return(1 - U / n1 / n2)
}

calculate_mean_ci_l <- function(x) {
  m <- mean(x); s <- sd(x); n <- length(x)
  m - qnorm(0.975) * (s / sqrt(n))
}
calculate_mean_ci_u <- function(x) {
  m <- mean(x); s <- sd(x); n <- length(x)
  m + qnorm(0.975) * (s / sqrt(n))
}


# Per-iteration AUCs:

results_AUC_it <- resultsall %>%
  group_by(n, method_all, itind) %>%
  summarise(
    auc_1  = auroc(vim[c(20:69, 1 )], c(rep(FALSE, 50), TRUE)),
    auc_2  = auroc(vim[c(20:69, 2 )], c(rep(FALSE, 50), TRUE)),
    auc_3  = auroc(vim[c(20:69, 3 )], c(rep(FALSE, 50), TRUE)),
    auc_4  = auroc(vim[c(20:69, 4 )], c(rep(FALSE, 50), TRUE)),
    auc_5  = auroc(vim[c(20:69, 5 )], c(rep(FALSE, 50), TRUE)),
    auc_6  = auroc(vim[c(20:69, 6 )], c(rep(FALSE, 50), TRUE)),
    auc_7  = auroc(vim[c(20:69, 7 )], c(rep(FALSE, 50), TRUE)),
    auc_8  = auroc(vim[c(20:69, 8 )], c(rep(FALSE, 50), TRUE)),
    auc_9  = auroc(vim[c(20:69, 9 )], c(rep(FALSE, 50), TRUE)),
    auc_10 = auroc(vim[c(20:69, 10)], c(rep(FALSE, 50), TRUE)),
    auc_11 = auroc(vim[c(20:69, 11)], c(rep(FALSE, 50), TRUE)),
    auc_12 = auroc(vim[c(20:69, 12)], c(rep(FALSE, 50), TRUE)),
    auc_13 = auroc(vim[c(20:69, 13)], c(rep(FALSE, 50), TRUE)),
    auc_14 = auroc(vim[c(20:69, 14)], c(rep(FALSE, 50), TRUE)),
    auc_15 = auroc(vim[c(20:69, 15)], c(rep(FALSE, 50), TRUE)),
    auc_16 = auroc(vim[c(20:69, 16)], c(rep(FALSE, 50), TRUE)),
    auc_17 = auroc(vim[c(20:69, 17)], c(rep(FALSE, 50), TRUE)),
    auc_18 = auroc(vim[c(20:69, 18)], c(rep(FALSE, 50), TRUE)),
    auc_19 = auroc(vim[c(20:69, 19)], c(rep(FALSE, 50), TRUE)),
    .groups = "drop"
  )

# Aggregate mean + CI per (n, method):

results_AUC_num_wide <- results_AUC_it %>%
  group_by(n, method_all) %>%
  summarise(
    across(starts_with("auc_"),
           list(mean = mean, l = calculate_mean_ci_l, u = calculate_mean_ci_u),
           .names = "{.col}_{.fn}"),
    .groups = "drop"
  )

# Long numeric format for plotting: 
results_AUC_num <- results_AUC_num_wide %>%
  pivot_longer(
    cols = -c(n, method_all),
    names_to = "name",
    values_to = "value"
  ) %>%
  mutate(
    auc_id = str_extract(name, "^auc_\\d+"),
    stat   = str_extract(name, "(?<=_)mean$|(?<=_)l$|(?<=_)u$"),
    stat   = recode(stat, "l"="lwr", "u"="upr", "mean"="mean")
  ) %>%
  select(n, method_all, auc_id, stat, value) %>%
  pivot_wider(names_from = stat, values_from = value) %>%
  mutate(
    auc_index = as.integer(str_extract(auc_id, "\\d+")),
    cov_label = label_order_parsed[auc_index],
    # IMPORTANT: facet levels must match the design order (A,B,C,#,D,...,S)
    cov_label = factor(cov_label, levels = label_order_parsed),
    n_num     = parse_n_num(n),
    n_plot    = factor(paste0("n = ", n_num),
                       levels = paste0("n = ", sort(unique(n_num)))),
    method_plot = factor(as.character(method_all),
                         levels = method_levels_plot,
                         labels = method_labels_plot)
  )





# Figure S7: Mean AUC values with 95% confidence intervals per considered sample size
# and method for DGP 2
#####################################################################################

p_auc <- ggplot(results_AUC_num,
                aes(x = n_plot, y = mean,
                    color = method_plot, linetype = method_plot, shape = method_plot,
                    group = method_plot)) +
  geom_errorbar(aes(ymin = lwr, ymax = upr),
                position = pd, width = 0.18, linewidth = 0.45, na.rm = TRUE) +
  geom_line(position = pd, na.rm = TRUE) +
  geom_point(position = pd, size = 2.2, na.rm = TRUE) +
  ggh4x::facet_manual(~cov_label, design = design, #drop = FALSE,
                      labeller = ggplot2::label_parsed) +
  labs(x = "Sample size", y = "Mean AUC",
       color = "Method", linetype = "Method", shape = "Method") +
  theme_bw() +
  theme(
    legend.position = "bottom",
    axis.text = element_text(size = 10, color = "black"),
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.title.x = element_blank(),
    axis.title.y = element_text(size = 12),
    panel.grid.minor = element_blank(),
    strip.text = element_text(size = 14),
    legend.title = element_text(size = 12),
    legend.text  = element_text(size = 11)
  )

# Figure S7:

ggsave("../figures/FigS7.pdf", p_auc, width = 10, height = 12)
ggsave("../figures/FigS7.eps", p_auc, width = 10, height = 12)






# Tables S8 and S9: Mean AUC values with 95% confidence intervals per 
# considered sample size and method for DGP 2 
#######################################################################

# IMPORTANT: enforce same method order as plots
table_method_levels <- c("unity_vim", "perm", "gini_corr")

results_AUC_table <- results_AUC_num_wide %>%
  mutate(
    method_all = factor(as.character(method_all), levels = table_method_levels)
  ) %>%
  arrange(n, method_all) %>%
  mutate(across(.cols = matches("^auc_\\d+_mean$"), .fns = ~ .x, .names = "{.col}"))

for (k in 1:19) {
  mcol <- paste0("auc_", k, "_mean")
  lcol <- paste0("auc_", k, "_l")
  ucol <- paste0("auc_", k, "_u")
  scol <- paste0("auc_", k)
  results_AUC_table[[scol]] <- sprintf("%.2f [%.2f, %.2f]",
                                       results_AUC_table[[mcol]],
                                       results_AUC_table[[lcol]],
                                       results_AUC_table[[ucol]])
}

results_AUC_table <- results_AUC_table %>%
  select(n, method_all, all_of(paste0("auc_", 1:19)))

auc_order <- paste0("auc_", 1:19)
label_map_auc <- setNames(label_order, auc_order)

results_prepped <- results_AUC_table %>%
  pivot_longer(cols = starts_with("auc_"),
               names_to = "auc_var",
               values_to = "auc_value") %>%
  mutate(
    auc_label = recode(auc_var, !!!label_map_auc),
    auc_label = factor(auc_label, levels = label_order),
    n = as.character(n),
    method_all = factor(as.character(method_all), levels = table_method_levels)
  ) %>%
  arrange(auc_label, method_all, n)

results_wide <- results_prepped %>%
  pivot_wider(names_from = n, values_from = auc_value)

results_final <- results_wide %>%
  arrange(auc_label, method_all) %>%
  group_by(auc_label) %>%
  mutate(Covariate = if_else(row_number() == 1, auc_label, "")) %>%
  ungroup() %>%
  rename(Method = method_all) %>%
  mutate(
    Method = recode(
      Method,
      "unity_vim" = "Unity\\_vim",
      "perm"      = "Perm",
      "gini_corr" = "Gini"
    )
  ) %>%
  select(Covariate, Method, `n = 100`, `n = 300`, `n = 500`, `n = 1000`)

latex_table <- kable(results_final, format = "latex",
                     booktabs = TRUE, linesep = "",
                     align = "llcccc", escape = FALSE)

# Tables S8 and S9:

writeLines(latex_table, "../tables/TabS8S9.tex")










# Ranks: Median ranks with 25%/75% quantiles:



# Compute ranks summary (informative variables 1..19):
results_ranks <- resultsall %>%
  filter(as.numeric(var_index) >= 1 & as.numeric(var_index) <= 19) %>%
  mutate(
    var_index = as.numeric(var_index),
    var_id = paste0("rank_", var_index),
    method_all = factor(as.character(method_all), levels = table_method_levels)
  ) %>%
  group_by(n, method_all, var_id) %>%
  summarise(
    med_rank = median(rank),
    q1_rank  = quantile(rank, 0.25),
    q3_rank  = quantile(rank, 0.75),
    .groups = "drop"
  ) %>%
  mutate(
    rank_string = sprintf("%.0f [%.0f, %.0f]", med_rank, q1_rank, q3_rank)
  )

# Plot data:
results_ranks_plot <- results_ranks %>%
  mutate(
    rank_index = as.integer(str_extract(var_id, "\\d+")),
    cov_label  = label_order_parsed[rank_index],
    cov_label  = factor(cov_label, levels = label_order_parsed),
    n_num      = parse_n_num(n),
    n_plot     = factor(paste0("n = ", n_num),
                        levels = paste0("n = ", sort(unique(n_num)))),
    method_plot = factor(as.character(method_all),
                         levels = method_levels_plot,   # unity_vim, perm, gini_corr
                         labels = method_labels_plot)   # Unity_vim, Perm, Gini
  )




# Figure S8: Median ranks with 25% and 75% quartiles per considered sample size and
# method for DGP 2
###################################################################################

p_rank <- ggplot(results_ranks_plot,
                 aes(x = n_plot, y = med_rank,
                     color = method_plot, linetype = method_plot, shape = method_plot,
                     group = method_plot)) +
  geom_errorbar(aes(ymin = q1_rank, ymax = q3_rank),
                position = pd, width = 0.18, linewidth = 0.45, na.rm = TRUE) +
  geom_line(position = pd, na.rm = TRUE) +
  geom_point(position = pd, size = 2.2, na.rm = TRUE) +
  ggh4x::facet_manual(~cov_label, design = design,
                      labeller = ggplot2::label_parsed) +
  labs(x = "Sample size", y = "Median rank",
       color = "Method", linetype = "Method", shape = "Method") +
  theme_bw() +
  theme(
    legend.position = "bottom",
    axis.text = element_text(size = 10, color = "black"),
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.title.x = element_blank(),
    axis.title.y = element_text(size = 12),
    panel.grid.minor = element_blank(),
    strip.text = element_text(size = 14),
    legend.title = element_text(size = 12),
    legend.text  = element_text(size = 11)
  )
  
# Figure S8:

ggsave("../figures/FigS8.pdf", p_rank, width = 10, height = 12)
ggsave("../figures/FigS8.eps", p_rank, width = 10, height = 12)





# Table S10: Median ranks with 25% and 75% quartiles per considered sample size 
# and method for DGP 2
###############################################################################

rank_order <- paste0("rank_", 1:19)
rank_label_map <- setNames(label_order, rank_order)

results_ranks_prepped <- results_ranks %>%
  mutate(
    rank_label = recode(var_id, !!!rank_label_map),
    rank_label = factor(rank_label, levels = label_order),
    n = as.character(n),
    method_all = factor(as.character(method_all), levels = table_method_levels)
  ) %>%
  arrange(rank_label, method_all, n)

results_ranks_wide <- results_ranks_prepped %>%
  select(rank_label, method_all, n, rank_string) %>%
  pivot_wider(names_from = n, values_from = rank_string)

results_ranks_final <- results_ranks_wide %>%
  arrange(rank_label, method_all) %>%
  group_by(rank_label) %>%
  mutate(Covariate = if_else(row_number() == 1, rank_label, "")) %>%
  ungroup() %>%
  rename(Method = method_all) %>%
  mutate(
    Method = recode(
      Method,
      "unity_vim" = "Unity\\_vim",
      "perm"      = "Perm",
      "gini_corr" = "Gini"
    )
  ) %>%
  select(Covariate, Method, `n = 100`, `n = 300`, `n = 500`, `n = 1000`)

latex_rank_table <- kable(results_ranks_final, format = "latex",
                          booktabs = TRUE, linesep = "",
                          align = "llcccc", escape = FALSE)

# Tables S10 and S11:

writeLines(latex_rank_table, "../tables/TabS10S11.tex")










# Figure S4: Empirical effects of the interacting covariates in a simulated dataset 
# generated from DGP 2 (n = 500)
####################################################################################


source("./functions_simulation_study_design_2.R")

set.seed(12345)
dataset <- simDataset(N=500)



library("ggpattern")

# Common scales:
pat_scale  <- scale_pattern_manual(values = c("1" = "none", "2" = "stripe"))

fill_cols <- scale_fill_manual(values = c("1" = "#8A01FEFF", "2" = "#FFB24DFF"))

x_lab_size <- y_lab_size <- 14
x_text_size <- 12

library("scales")  

p1 <- ggplot(dataset, aes(x = factor(X4), fill = y, pattern = y)) + theme_bw() +
  geom_bar_pattern(position = "fill", pattern_colour = "black", pattern_size = 0.2, pattern_fill   = "black", pattern_spacing = 0.03, pattern_density = 0.45, pattern_key_scale_factor = 0.6) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  fill_cols + pat_scale +
  theme(legend.position = "none",
        axis.text = element_text(color="black"),
        axis.title.x = element_text(size = x_lab_size, vjust = 15)) +
  labs(x = expression(X[bne*"_ql"]), y = "Proportion")



dataset2 <- dataset %>%
  mutate(
    X4 = as.integer(X4),
    y  = as.integer(y),
    grp = factor(
      paste0("X4=", X4, ", y=", y),
      levels = c("X4=0, y=1", "X4=0, y=2", "X4=1, y=1", "X4=1, y=2")
    )
  )
  


p2 <- ggplot(dataset2, aes(x = grp, y = X5, fill = factor(y), pattern = factor(y))) +
  geom_boxplot_pattern(width = 0.7, outlier.shape = 16, outlier.size = 1.5, pattern_size = 0.2, pattern_colour = "black", pattern_fill   = "black", pattern_spacing = 0.03, pattern_density = 0.45, pattern_key_scale_factor = 0.6) +
    stat_summary(fun = median, geom = "crossbar",
               width = 0.7, colour = "white", linewidth = 1.2) +
  stat_summary(fun = median, geom = "crossbar",
               width = 0.7, colour = "black", linewidth = 0.5) +
  geom_vline(xintercept = 2.5, color = "#505050", lty = 2) +
  scale_x_discrete(labels = c(
    "X4=0, y=1" = expression(X[bne*"_ql"]==0 * ", y=1"),
    "X4=0, y=2" = expression(X[bne*"_ql"]==0 * ", y=2"),
    "X4=1, y=1" = expression(X[bne*"_ql"]==1 * ", y=1"),
    "X4=1, y=2" = expression(X[bne*"_ql"]==1 * ", y=2")
  )) +
  fill_cols + pat_scale +
  labs(y = expression(X[ql * "_" * bne * "_" * s]), fill = "y") +
  theme_bw() +
  theme(axis.text = element_text(color = "black"),
        axis.text.x = element_text(size = x_text_size, angle = 45, hjust = 1, vjust = 1),
        legend.position = "none",
        axis.title.x = element_blank(),
        axis.title.y = element_text(size = y_lab_size))




p3 <- ggplot(dataset, aes(x = factor(X8), fill = y, pattern = y)) + theme_bw() +
  geom_bar_pattern(position = "fill", pattern_size = 0.2, pattern_colour = "black", pattern_fill   = "black", pattern_spacing = 0.03, pattern_density = 0.45, pattern_key_scale_factor = 0.6) +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  fill_cols + pat_scale +
  theme(legend.position = "none", axis.text = element_text(color="black"), axis.title.x = element_text(size = x_lab_size, vjust = 15)) +
  labs(x = expression(X[be*"_ql"]), y = "Proportion")
  



dataset2 <- dataset %>%
  mutate(
    X8 = as.integer(X8),
    y  = as.integer(y),
    grp = factor(
      paste0("X8=", X8, ", y=", y),
      levels = c("X8=0, y=1", "X8=0, y=2", "X8=1, y=1", "X8=1, y=2")
    )
  )

p4 <- ggplot(dataset2, aes(x = grp, y = X9, fill = factor(y), pattern = factor(y))) +
  geom_boxplot_pattern(width = 0.7, outlier.shape = 16, outlier.size = 1.5, pattern_size = 0.2, pattern_colour = "black", pattern_fill   = "black", pattern_spacing = 0.03, pattern_density = 0.45, pattern_key_scale_factor = 0.6) +
    stat_summary(fun = median, geom = "crossbar",
               width = 0.7, colour = "white", linewidth = 1.2) +
  stat_summary(fun = median, geom = "crossbar",
               width = 0.7, colour = "black", linewidth = 0.5) +
  geom_vline(xintercept = 2.5, color = "#505050", lty = 2) +
  scale_x_discrete(labels = c(
    "X8=0, y=1" = expression(X[be*"_ql"]==0 * ", y=1"),
    "X8=0, y=2" = expression(X[be*"_ql"]==0 * ", y=2"),
    "X8=1, y=1" = expression(X[be*"_ql"]==1 * ", y=1"),
    "X8=1, y=2" = expression(X[be*"_ql"]==1 * ", y=2")
  )) +
  fill_cols + pat_scale +
  labs(
    y   = expression(X[ql * "_" * be * "_" * s]),  
    fill = "y"
  ) +
  theme_bw() +
  theme(
    axis.text = element_text(color = "black"),
    axis.text.x = element_text(size = x_text_size, angle = 45, hjust = 1, vjust = 1),
    legend.position = "none",
    axis.title.x = element_blank(),
    axis.title.y = element_text(size = y_lab_size)
  )




p5 <- ggplot(dataset, aes(x = factor(X12), fill = y, pattern = y)) + theme_bw() +
  geom_bar_pattern(position = "fill", pattern_size = 0.2, pattern_colour = "black", pattern_fill   = "black", pattern_spacing = 0.03, pattern_density = 0.45, pattern_key_scale_factor = 0.6) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  fill_cols + pat_scale +
  theme(legend.position = "none", axis.text = element_text(color="black"), axis.title.x = element_text(size = x_lab_size, vjust = 15)) +
  labs(x = expression(X[bne*"_qn"]), y = "Proportion")




dataset2 <- dataset %>%
  mutate(
    X12 = as.integer(X12),
    y  = as.integer(y),
    grp = factor(
      paste0("X12=", X12, ", y=", y),
      levels = c("X12=0, y=1", "X12=0, y=2", "X12=1, y=1", "X12=1, y=2")
    )
  )

p6 <- ggplot(dataset2, aes(x = grp, y = X13, fill = factor(y), pattern = factor(y))) +
  geom_boxplot_pattern(width = 0.7, outlier.shape = 16, outlier.size = 1.5, pattern_size = 0.2, pattern_colour = "black", pattern_fill   = "black", pattern_spacing = 0.03, pattern_density = 0.45, pattern_key_scale_factor = 0.6) +
    stat_summary(fun = median, geom = "crossbar",
               width = 0.7, colour = "white", linewidth = 1.2) +
  stat_summary(fun = median, geom = "crossbar",
               width = 0.7, colour = "black", linewidth = 0.5) +
  geom_vline(xintercept = 2.5, color = "#505050", lty = 2) +
  scale_x_discrete(labels = c(
    "X12=0, y=1" = expression(X[bne*"_qn"]==0 * ", y=1"),
    "X12=0, y=2" = expression(X[bne*"_qn"]==0 * ", y=2"),
    "X12=1, y=1" = expression(X[bne*"_qn"]==1 * ", y=1"),
    "X12=1, y=2" = expression(X[bne*"_qn"]==1 * ", y=2")
  )) +
  fill_cols + pat_scale +
  labs(
    y   = expression(X[qn * "_" * bne * "_" * s]),  
    fill = "y"
  ) +
  theme_bw() +
  theme(
    axis.text = element_text(color = "black"),
    axis.text.x = element_text(size = x_text_size, angle = 45, hjust = 1, vjust = 1),
    legend.position = "none",
    axis.title.x = element_blank(),
    axis.title.y = element_text(size = y_lab_size)
  )




levels(dataset$X16) <- 1:3

p7 <- ggplot(dataset, aes(x = X16, fill = y, pattern = y)) + theme_bw() +
  geom_bar_pattern(position = "fill", pattern_size = 0.2, pattern_colour = "black", pattern_fill   = "black", pattern_spacing = 0.03, pattern_density = 0.45, pattern_key_scale_factor = 0.6) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  fill_cols + pat_scale +
  theme(legend.position = "none", axis.text = element_text(color="black"), axis.title.x = element_text(size = x_lab_size, vjust = 15)) +
  labs(x = expression(X[cne*"_ql"]), y = "Proportion")




dataset2 <- dataset %>%
  mutate(
    X16 = as.integer(X16),
    y  = as.integer(y),
    grp = factor(
      paste0("X16=", X16, ", y=", y),
      levels = c("X16=1, y=1", "X16=1, y=2", "X16=2, y=1", "X16=2, y=2", "X16=3, y=1", "X16=3, y=2")
    )
  )

p8 <- ggplot(dataset2, aes(x = grp, y = X17, fill = factor(y), pattern = factor(y))) +
  geom_boxplot_pattern(width = 0.7, outlier.shape = 16, outlier.size = 1.5, pattern_size = 0.2, pattern_colour = "black", pattern_fill   = "black", pattern_spacing = 0.03, pattern_density = 0.45, pattern_key_scale_factor = 0.6) +
    stat_summary(fun = median, geom = "crossbar",
               width = 0.7, colour = "white", linewidth = 1.2) +
  stat_summary(fun = median, geom = "crossbar",
               width = 0.7, colour = "black", linewidth = 0.5) +
  geom_vline(xintercept = c(2.5, 4.5), color = "#505050", lty = 2) +
  scale_x_discrete(labels = c(
    "X16=1, y=1" = expression(X[cne*"_ql"]==1 * ", y=1"),
    "X16=1, y=2" = expression(X[cne*"_ql"]==1 * ", y=2"),
    "X16=2, y=1" = expression(X[cne*"_ql"]==2 * ", y=1"),
    "X16=2, y=2" = expression(X[cne*"_ql"]==2 * ", y=2"),
    "X16=3, y=1" = expression(X[cne*"_ql"]==3 * ", y=1"),
    "X16=3, y=2" = expression(X[cne*"_ql"]==3 * ", y=2")
  )) +
  fill_cols + pat_scale +
  labs(
    y   = expression(X[ql * "_" * cne * "_" * s]),  
    fill = "y"
  ) +
  theme_bw() +
  theme(
    axis.text = element_text(color = "black"),
    axis.text.x = element_text(size = x_text_size, angle = 45, hjust = 1, vjust = 1),
    legend.position = "none",
    axis.title.x = element_blank(),
    axis.title.y = element_text(size = y_lab_size)
  )



library("patchwork")
ps <- (p1 | p2) / (p3 | p4) / (p5 | p6) / (p7 | p8)
ps


# Figure 2:

ggsave("../figures/Fig2.pdf", width=12*0.8, height=15*0.8)
ggsave("../figures/Fig2.eps", width=12*0.8, height=15*0.8)


# Figure S4 (same as Figure 2):

ggsave("../figures/FigS4.pdf", width=12*0.8, height=15*0.8)
ggsave("../figures/FigS4.eps", width=12*0.8, height=15*0.8)
