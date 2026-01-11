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
###################################

load("./intermediate_results/scenariogrid_simulation_study_design_1.Rda")
load("./intermediate_results/results_simulation_study_design_1.Rda")

reorderind <- order(scenariogrid$n, scenariogrid$itind)
scenariogrid <- scenariogrid[reorderind, ]
results <- results[reorderind]

scenariogrid$seed <- NULL

resultsmethods <- scenariogrid[rep(1:nrow(scenariogrid), each = length(results[[1]])), ]
resultsmethods$method_all <- rep(names(results[[1]]), times = nrow(scenariogrid))

resultsmethods$n <- factor(
  paste0("n = ", resultsmethods$n),
  levels = paste0("n = ", sort(unique(resultsmethods$n)))
)

results <- unlist(results, recursive = FALSE)

resultsall <- resultsmethods[rep(1:nrow(resultsmethods), times = sapply(results, length)), ]
resultsall$rank <- unlist(lapply(results, function(x) rank(-x)))
resultsall$vim  <- unlist(results)
rownames(resultsall) <- NULL

# internal method codes for computation (keep as-is)
resultsall$method_all <- factor(resultsall$method_all, levels = c("perm", "gini_corr", "unity_vim"))

library("dplyr")
library("tidyr")
library("ggplot2")
library("stringr")
library("knitr")

resultsall <- resultsall %>%
  group_by(n, itind, method_all) %>%
  mutate(var_index = row_number()) %>%
  ungroup()




# Labels / ordering:


# Table labels (LaTeX strings)
label_order <- c(
  "$X_{mrg\\_s}$",
  "$X_{mrg\\_m}$",
  "$X_{mrg\\_w}$",
  "$X_{qn\\_s}$",
  "$X_{qn\\_m}$",
  "$X_{qn\\_w}$",
  "$X_{ql\\_s}$",
  "$X_{ql\\_m}$",
  "$X_{ql\\_w}$"
)

# Facet titles: plotmath strings (parsed)
label_order_parsed <- c(
  'X[mrg*"_s"]',
  'X[mrg*"_m"]',
  'X[mrg*"_w"]',
  'X[qn*"_s"]',
  'X[qn*"_m"]',
  'X[qn*"_w"]',
  'X[ql*"_s"]',
  'X[ql*"_m"]',
  'X[ql*"_w"]'
)

# Method order + pretty labels for plots and tables
method_levels_plot  <- c("unity_vim", "perm", "gini_corr")
method_labels_plot  <- c("Unity_vim", "Perm", "Gini_corr")
table_method_levels <- method_levels_plot

# dodge to avoid overlap at same sample size
pd <- position_dodge(width = 0.55)

# Helper: parse numeric n from "n = 100"
parse_n_num <- function(n_factor) as.numeric(str_extract(as.character(n_factor), "\\d+"))


# Indices:
noise_idx <- 1:50

# informative are 51:68 = 18 vars = 9 pairs
pair_idx_fun <- function(i) c(50 + 2*i - 1, 50 + 2*i)  # i = 1..9









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



# Per-iteration AUCs for the 9 TYPES (each type = 2 positives vs 50 noise negatives):

results_AUC_it <- resultsall %>%
  group_by(n, method_all, itind) %>%
  summarise(
    auc_1 = auroc(vim[c(noise_idx, pair_idx_fun(1))], c(rep(FALSE, 50), TRUE, TRUE)),
    auc_2 = auroc(vim[c(noise_idx, pair_idx_fun(2))], c(rep(FALSE, 50), TRUE, TRUE)),
    auc_3 = auroc(vim[c(noise_idx, pair_idx_fun(3))], c(rep(FALSE, 50), TRUE, TRUE)),
    auc_4 = auroc(vim[c(noise_idx, pair_idx_fun(4))], c(rep(FALSE, 50), TRUE, TRUE)),
    auc_5 = auroc(vim[c(noise_idx, pair_idx_fun(5))], c(rep(FALSE, 50), TRUE, TRUE)),
    auc_6 = auroc(vim[c(noise_idx, pair_idx_fun(6))], c(rep(FALSE, 50), TRUE, TRUE)),
    auc_7 = auroc(vim[c(noise_idx, pair_idx_fun(7))], c(rep(FALSE, 50), TRUE, TRUE)),
    auc_8 = auroc(vim[c(noise_idx, pair_idx_fun(8))], c(rep(FALSE, 50), TRUE, TRUE)),
    auc_9 = auroc(vim[c(noise_idx, pair_idx_fun(9))], c(rep(FALSE, 50), TRUE, TRUE)),
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

# Long numeric format for plotting: (n, method, cov_label, mean, lwr, upr):
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
    cov_label = factor(label_order_parsed[auc_index], levels = label_order_parsed),
    n_num     = parse_n_num(n),
    n_plot    = factor(paste0("n = ", n_num),
                       levels = paste0("n = ", sort(unique(n_num)))),
    method_plot = factor(as.character(method_all),
                         levels = method_levels_plot,
                         labels = method_labels_plot)
  )




# Figure 3: Mean AUC values with 95% confidence intervals per considered sample size
# and method for DGP 1
#####################################################################################

p_auc <- ggplot(results_AUC_num,
                aes(x = n_plot, y = mean,
                    color = method_plot, linetype = method_plot, shape = method_plot,
                    group = method_plot)) +
  geom_errorbar(aes(ymin = lwr, ymax = upr),
                position = pd, width = 0.18, linewidth = 0.45, na.rm = TRUE) +
  geom_line(position = pd, na.rm = TRUE) +
  geom_point(position = pd, size = 2.2, na.rm = TRUE) +
  facet_wrap(~ cov_label, ncol = 3, labeller = label_parsed) +
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
    strip.text = element_text(size = 12),
    legend.title = element_text(size = 12),
    legend.text  = element_text(size = 11)
  )

# Figure 3:

ggsave("../figures/Fig3.pdf", p_auc, width = 9, height = 9)
ggsave("../figures/Fig3.eps", p_auc, width = 9, height = 9)





# Table S6: Mean AUC values with 95% confidence intervals per considered
# sample size and method for DGP 1
##################################################################################

results_AUC_table <- results_AUC_num %>%
  mutate(
    auc_string = sprintf("%.2f [%.2f, %.2f]", mean, lwr, upr),
    method_all = factor(as.character(method_all), levels = table_method_levels)
  ) %>%
  arrange(auc_index, method_all, n_num) %>%
  select(auc_index, method_all, n_plot, auc_string) %>%
  pivot_wider(names_from = n_plot, values_from = auc_string) %>%
  mutate(
    auc_label_tex = label_order[auc_index]
  ) %>%
  group_by(auc_index) %>%
  mutate(Covariate = if_else(row_number() == 1, auc_label_tex, "")) %>%
  ungroup() %>%
  rename(Method = method_all) %>%
  mutate(
    Method = recode(
      Method,
      "unity_vim" = "Unity\\_vim",
      "perm"      = "Perm",
      "gini_corr" = "Gini\\_corr"
    )
  ) %>%
  select(Covariate, Method, `n = 100`, `n = 300`, `n = 500`, `n = 1000`)

latex_auc_table <- kable(results_AUC_table, format = "latex",
                         booktabs = TRUE, linesep = "",
                         align = "llcccc", escape = FALSE)

# Table S6:

writeLines(latex_auc_table, "../tables/TabS6.tex")










# Ranks: Median ranks with 25%/75% quantiles:



# Build a long dataset with the pooled ranks:
# For each (n, method, itind) we take ranks of BOTH variables per type i

results_ranks_long <- bind_rows(lapply(1:9, function(i) {
  idx <- pair_idx_fun(i)  # two indices for type i
  resultsall %>%
    filter(var_index %in% idx) %>%
    transmute(
      n,
      method_all,
      itind,
      rank_index = i,
      rank_value = rank
    )
}))

# Summarize pooled ranks per (n, method, type)
results_ranks_sum <- results_ranks_long %>%
  group_by(n, method_all, rank_index) %>%
  summarise(
    med_rank = median(rank_value),
    q1_rank  = quantile(rank_value, 0.25),
    q3_rank  = quantile(rank_value, 0.75),
    .groups = "drop"
  ) %>%
  mutate(
    cov_label = factor(label_order_parsed[rank_index], levels = label_order_parsed),
    n_num     = parse_n_num(n),
    n_plot    = factor(paste0("n = ", n_num),
                       levels = paste0("n = ", sort(unique(n_num)))),
    method_plot = factor(as.character(method_all),
                         levels = method_levels_plot,
                         labels = method_labels_plot)
  )




# Figure 4: Median ranks with 25% and 75% quartiles per considered sample size and
# method for DGP 1
###################################################################################

p_rank <- ggplot(results_ranks_sum,
                 aes(x = n_plot, y = med_rank,
                     color = method_plot, linetype = method_plot, shape = method_plot,
                     group = method_plot)) +
  geom_errorbar(aes(ymin = q1_rank, ymax = q3_rank),
                position = pd, width = 0.18, linewidth = 0.45, na.rm = TRUE) +
  geom_line(position = pd, na.rm = TRUE) +
  geom_point(position = pd, size = 2.2, na.rm = TRUE) +
  facet_wrap(~ cov_label, ncol = 3, labeller = label_parsed) +
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
    strip.text = element_text(size = 12),
    legend.title = element_text(size = 12),
    legend.text  = element_text(size = 11)
  )


# Figure 4:

ggsave("../figures/Fig4.pdf", p_rank, width = 9, height = 9)
ggsave("../figures/Fig4.eps", p_rank, width = 9, height = 9)





# Table S7: Median ranks with 25% and 75% quartiles per considered sample size and 
# method for DGP 1
##################################################################################

results_rank_table <- results_ranks_sum %>%
  mutate(
    rank_string = sprintf("%.0f [%.0f, %.0f]", med_rank, q1_rank, q3_rank),
    method_all  = factor(as.character(method_all), levels = table_method_levels),
    rank_label_tex = label_order[rank_index]
  ) %>%
  arrange(rank_index, method_all, n_num) %>%
  select(rank_index, method_all, n_plot, rank_string, rank_label_tex) %>%
  pivot_wider(names_from = n_plot, values_from = rank_string) %>%
  group_by(rank_index) %>%
  mutate(Covariate = if_else(row_number() == 1, rank_label_tex, "")) %>%
  ungroup() %>%
  rename(Method = method_all) %>%
  mutate(
    Method = recode(
      Method,
      "unity_vim" = "Unity\\_vim",
      "perm"      = "Perm",
      "gini_corr" = "Gini\\_corr"
    )
  ) %>%
  select(Covariate, Method, `n = 100`, `n = 300`, `n = 500`, `n = 1000`)

latex_rank_table <- kable(results_rank_table, format = "latex",
                          booktabs = TRUE, linesep = "",
                          align = "llcccc", escape = FALSE)

# Table S7:

writeLines(latex_rank_table, "../tables/TabS7.tex")










# Figures 1 and S3: Example pairs of variables with strong effects in a simulated
# dataset generated from DGP 1 (n = 500)
#################################################################################

source("./functions_simulation_study_design_1.R")

set.seed(12345)
dataset <- simDataset(N=500, mainstrength=c(3, 2, 1), quantstrength=c(3, 2, 1), qualstrength=c(3, 2, 1))

library("ggplot2")

titlesize <- 15
axistitlesize <- 20
axistextsize <- 17

tri <- data.frame(
  x = c(1-max(dataset$X52), max(dataset$X51), max(dataset$X51)),
  y = c(max(dataset$X52), max(dataset$X52), 1-max(dataset$X51))
)

p1 <- ggplot(data=dataset, aes(x=X51, y=X52, col=y, shape=y, size=y)) + theme_bw() + 
  annotate("polygon",
           x = tri$x, y = tri$y,
           fill = "grey95", color = NA) +
  geom_point() + 
  theme(legend.position = "none", title=element_text(size=titlesize),
        axis.text=element_text(size=axistextsize),
        axis.title=element_text(size=axistitlesize)) + 
  scale_size_manual(values = c("1" = 1.2, "2"=1.5, 1)) +
  scale_color_manual(
    values = c("1" = "#8A01FEFF", "2" = "#FFB24DFF")
  ) +
  labs(x=expression(X[mrg * "_" * s * ",1"]), y=expression(X[mrg * "_" * s * ",2"]))

p2 <- ggplot(data=dataset, aes(x=X57, y=X58, col=y, shape=y, size=y)) + theme_bw() + 
  annotate("rect",
           xmin = 1.772/2, xmax = max(dataset$X57),
           ymin = min(dataset$X58), ymax = 1.772/2,
           fill = "grey95", color = NA) +
  geom_point() + 
  theme(legend.position = "none", title=element_text(size=titlesize),
        axis.text=element_text(size=axistextsize),
        axis.title=element_text(size=axistitlesize)) + 
  scale_size_manual(values = c("1" = 1.2, "2"=1.5, 1)) +
  scale_color_manual(
    values = c("1" = "#8A01FEFF", "2" = "#FFB24DFF")
  ) +
  labs(x=expression(X[qn * "_" * s * ",1"]), y=expression(X[qn * "_" * s * ",2"]))

p3 <- ggplot(data=dataset, aes(x=X63, y=X64, col=y, shape=y, size=y)) + theme_bw() + 
  annotate("rect",
           xmin = min(dataset$X63), xmax = 1.772/2,
           ymin = min(dataset$X64), ymax = 1.772/2,
           fill = "grey95", color = NA) +
  annotate("rect",
           xmin = 1.772/2, xmax = max(dataset$X63),
           ymin = 1.772/2, ymax = max(dataset$X64),
           fill = "grey95", color = NA) +
  geom_point() + 
  theme(legend.position = "none", title=element_text(size=titlesize),
        axis.text=element_text(size=axistextsize),
        axis.title=element_text(size=axistitlesize)) + 
  scale_size_manual(values = c("1" = 1.2, "2"=1.5, 1)) +
  scale_color_manual(
    values = c("1" = "#8A01FEFF", "2" = "#FFB24DFF")
  ) +
  labs(x=expression(X[ql * "_" * s * ",1"]), y=expression(X[ql * "_" * s * ",2"]))

library("patchwork")
ps <- p1 + p2 + p3

ps


# Figure 1:

ggsave("../figures/Fig1.pdf", width=12, height=4)
ggsave("../figures/Fig1.eps", width=12, height=4)


# Figure S3 (same as Figure 1):

ggsave("../figures/FigS3.pdf", width=12, height=4)
ggsave("../figures/FigS3.eps", width=12, height=4)
