####################################################################################

# NOTE:
# If the R working directory is not already set to
# '/UnityForests_code_and_data/crtr_analysis', it MUST be set to this directory
# before running this script (this is the directory in which this script is located).

# In that case, remove the '#' from the line below and replace 'here/is/my/path/'
# with the path to the directory '/UnityForests_code_and_data/crtr_analysis':

# setwd("here/is/my/path/")

####################################################################################



# Generate a dataset from DGP 1 and change the names of the variables:
########################################################################

source("../simulation_study/functions_simulation_study_design_1.R")

set.seed(3)
dataset <- simDataset(N=500, mainstrength=c(3, 2, 1), quantstrength=c(3, 2, 1), qualstrength=c(3, 2, 1))

names(dataset)[1:50] <- paste0("no_", 1:50)
names(dataset)[51] <- "mrg_s_1"
names(dataset)[52] <- "mrg_s_2"
names(dataset)[53] <- "mrg_m_1"
names(dataset)[54] <- "mrg_m_2"
names(dataset)[55] <- "mrg_w_1"
names(dataset)[56] <- "mrg_w_2"
names(dataset)[57] <- "qn_s_1"
names(dataset)[58] <- "qn_s_2"
names(dataset)[59] <- "qn_m_1"
names(dataset)[60] <- "qn_m_2"
names(dataset)[61] <- "qn_w_1"
names(dataset)[62] <- "qn_w_2"
names(dataset)[63] <- "ql_s_1"
names(dataset)[64] <- "ql_s_2"
names(dataset)[65] <- "ql_m_1"
names(dataset)[66] <- "ql_m_2"
names(dataset)[67] <- "ql_w_1"
names(dataset)[68] <- "ql_w_2"





# Compute unity VIM and permutation VIM:
########################################

library("unityForest")

set.seed(3)
object <- unityfor(dependent.variable.name = "y", data = dataset, importance="unity", num.cand.trees = 500)

unityvim_dgp1 <- object$variable.importance


set.seed(3)
permvim_dgp1 <- ranger::ranger(dependent.variable.name = "y", data=dataset, importance = "permutation", num.trees = 20000, replace=FALSE, sample.fraction = 0.7, probability = TRUE, min.node.size=5)$variable.importance





# Figure 4: Visualization of the CRTRs for the three covariates with the highest unity
# VIM values in a dataset generated from DGP 1 (n = 500).
#######################################################################################

source("./my_reprTrees_customized_for_plots_sim.R")

names(sort(object$variable.importance, decreasing=TRUE))[1:10]
var_best <- c("mrg_s_1", "qn_s_1", "ql_s_1", "mrg_m_1", "ql_m_2")

repr_tree_obj <- my_reprTrees(object, vars=var_best, box_plots = FALSE, plotit=FALSE)
plots_temp <- repr_tree_obj$plots


library("patchwork")

p <- plots_temp[[1]]$tree_plot / plots_temp[[1]]$density_plot /
  plots_temp[[2]]$tree_plot / plots_temp[[2]]$density_plot /
  plots_temp[[3]]$tree_plot / plots_temp[[3]]$density_plot +
  patchwork::plot_layout(heights = c(2, 1,   # tree 1 : density 1
                                     2, 1,   # tree 2 : density 2
                                     2, 1))  # tree 3 : density 3

# Figure 4:

ggsave("../figures/Fig4.pdf", device=cairo_pdf, plot = p, width = 14, height = 16)
ggsave("../figures/Fig4.eps", device=cairo_pdf,plot = p, width = 14, height = 16)





# Figure 5: Visualization of the CRTRs for the fourth and fifth highest-ranked covariates
# according to the unity VIM in a dataset generated from DGP 1 (n = 500). 
#########################################################################################

p <- plots_temp[[4]]$tree_plot / plots_temp[[4]]$density_plot /
  plots_temp[[5]]$tree_plot / plots_temp[[5]]$density_plot +
  patchwork::plot_layout(heights = c(2, 1,  
                                     2, 1)) 

# Figure 5:

ggsave("../figures/Fig5.pdf", device=cairo_pdf, plot = p, width = 14, height = 11)
ggsave("../figures/Fig5.eps", device=cairo_pdf, plot = p, width = 14, height = 11)





# Figures S10-S18: Visualization of the CRTRs for all covariates in a dataset generated
# from DGP 1 (n = 500).
#########################################################################################

var_all <- names(unityvim_dgp1)[-(1:50)]

repr_tree_obj <- my_reprTrees(object, vars=var_all, box_plots = FALSE, plotit=FALSE)
plots_temp <- repr_tree_obj$plots


for (i in 1:9) {
  
  ind_temp <- 1 + (i-1)*2
  
  if (length(plots_temp[[ind_temp]]$density_plot) > 0) {
    plot1 <- plots_temp[[ind_temp]]$density_plot
  }
  else {
    plot1 <- plots_temp[[ind_temp]]$bar_plot
  }
  
  if (length(plots_temp[[ind_temp+1]]$density_plot) > 0) {
    plot2 <- plots_temp[[ind_temp+1]]$density_plot
  }
  else {
    plot2 <- plots_temp[[ind_temp+1]]$bar_plot
  }
  
  p <- plots_temp[[ind_temp]]$tree_plot / plot1 /
    plots_temp[[ind_temp+1]]$tree_plot / plot2 +
    patchwork::plot_layout(heights = c(2, 1,  
                                       2, 1)) 
  
  ggsave(paste0("../figures/FigS", i+9, ".eps"), device=cairo_pdf,plot = p, width = 14, height = 16)
  ggsave(paste0("../figures/FigS", i+9, ".pdf"), device=cairo_pdf,plot = p, width = 14, height = 16)
  
}








# Generate a dataset from DGP 2 and change the names of the variables:
########################################################################

source("../simulation_study/functions_simulation_study_design_2.R")

set.seed(10)
dataset <- simDataset(N=500)


names(dataset)[1] <- "mrg_s"
names(dataset)[2] <- "mrg_m"
names(dataset)[3] <- "mrg_w"
names(dataset)[4] <- "bne_ql"
names(dataset)[5] <- "ql_bne_s"
names(dataset)[6] <- "ql_bne_m"
names(dataset)[7] <- "ql_bne_w"
names(dataset)[8] <- "be_ql"
names(dataset)[9] <- "ql_be_s"
names(dataset)[10] <- "ql_be_m"
names(dataset)[11] <- "ql_be_w"
names(dataset)[12] <- "bne_qn"
names(dataset)[13] <- "qn_bne_s"
names(dataset)[14] <- "qn_bne_m"
names(dataset)[15] <- "qn_bne_w"
names(dataset)[16] <- "cne_ql"
names(dataset)[17] <- "ql_cne_s"
names(dataset)[18] <- "ql_cne_m"
names(dataset)[19] <- "ql_cne_w"
names(dataset)[20:69] <- paste0("no_", 1:50)

dataset$bne_ql <- factor(dataset$bne_ql)
dataset$be_ql <- factor(dataset$be_ql)
dataset$bne_qn <- factor(dataset$bne_qn)





# Compute unity VIM and permutation VIM:
########################################

set.seed(10)
object <- unityfor(dependent.variable.name = "y", data = dataset, importance="unity", num.cand.trees = 500)

unityvim_dgp2 <- object$variable.importance


set.seed(10)
permvim_dgp2 <- ranger::ranger(dependent.variable.name = "y", data=dataset, importance = "permutation", num.trees = 20000, replace=FALSE, sample.fraction = 0.7, probability = TRUE, min.node.size=5)$variable.importance





# Figure S19: Visualization of the CRTRs for the three covariates with the highest unity
# VIM values in a dataset generated from DGP 2 (n = 500).
#######################################################################################

source("./my_reprTrees_customized_for_plots_sim.R")


var_best <- names(sort(object$variable.importance, decreasing=TRUE))[1:5]


repr_tree_obj <- my_reprTrees(object, vars=var_best, box_plots = FALSE, plotit=FALSE)
plots_temp <- repr_tree_obj$plots


p <- plots_temp[[1]]$tree_plot / plots_temp[[1]]$density_plot /
  plots_temp[[2]]$tree_plot / plots_temp[[2]]$density_plot /
  plots_temp[[3]]$tree_plot / plots_temp[[3]]$density_plot +
  patchwork::plot_layout(heights = c(2, 1,   # tree 1 : density 1
                                     2, 1,   # tree 2 : density 2
                                     2, 1))  # tree 3 : density 3

# Figure S19:

ggsave("../figures/FigS19.pdf", device=cairo_pdf, plot = p, width = 14, height = 16)
ggsave("../figures/FigS19.eps", device=cairo_pdf,plot = p, width = 14, height = 16)





# Figure S20: Visualization of the CRTRs for the fourth and fifth highest-ranked covariates
# according to the unity VIM in a dataset generated from DGP 2 (n = 500). 
###########################################################################################

p <- plots_temp[[4]]$tree_plot / plots_temp[[4]]$bar_plot /
  plots_temp[[5]]$tree_plot / plots_temp[[5]]$bar_plot +
  patchwork::plot_layout(heights = c(2, 1,  
                                     2, 1)) 

# Figure S20:

ggsave("../figures/FigS20.pdf", device=cairo_pdf, plot = p, width = 14, height = 11)
ggsave("../figures/FigS20.eps", device=cairo_pdf,plot = p, width = 14, height = 11)




# Figures S21-S29: Visualization of the CRTRs for all covariates in a dataset generated
# from DGP 2 (n = 500).
#########################################################################################

var_all <- names(unityvim_dgp2)[1:19]

repr_tree_obj <- my_reprTrees(object, vars=var_all, box_plots = FALSE, plotit=FALSE)
plots_temp <- repr_tree_obj$plots


p <- plots_temp[[1]]$tree_plot / plots_temp[[1]]$density_plot /
  plots_temp[[2]]$tree_plot / plots_temp[[2]]$density_plot /
  plots_temp[[3]]$tree_plot / plots_temp[[3]]$density_plot +
  patchwork::plot_layout(heights = c(2, 1,   # tree 1 : density 1
                                     2, 1,   # tree 2 : density 2
                                     2, 1))  # tree 3 : density 3


ggsave("../figures/FigS21.eps", device=cairo_pdf,plot = p, width = 14, height = 16)
ggsave("../figures/FigS21.pdf", device=cairo_pdf,plot = p, width = 14, height = 16)


for (i in setdiff(1:8, 2)) {
  
  ind_temp <- 4 + (i-1)*2
  
  if (length(plots_temp[[ind_temp]]$density_plot) > 0) {
    plot1 <- plots_temp[[ind_temp]]$density_plot
  }
  else {
    plot1 <- plots_temp[[ind_temp]]$bar_plot
  }
  
  if (length(plots_temp[[ind_temp+1]]$density_plot) > 0) {
    plot2 <- plots_temp[[ind_temp+1]]$density_plot
  }
  else {
    plot2 <- plots_temp[[ind_temp+1]]$bar_plot
  }
  
  p <- plots_temp[[ind_temp]]$tree_plot / plot1 /
    plots_temp[[ind_temp+1]]$tree_plot / plot2 +
    patchwork::plot_layout(heights = c(2, 1,  
                                       2, 1)) 
  
  ggsave(paste0("../figures/FigS", i+21, ".eps"), device=cairo_pdf, plot = p, width = 14, height = 16)
  ggsave(paste0("../figures/FigS", i+21, ".pdf"), device=cairo_pdf, plot = p, width = 14, height = 16)
  
}


i <- 2

ind_temp <- 4 + (i-1)*2

p <- plots_temp[[ind_temp]]$tree_plot / plots_temp[[ind_temp]]$density_plot /
  plots_temp[[ind_temp+1]]$tree_plot / (plots_temp[[ind_temp+1]]$density_plot_1 + plots_temp[[ind_temp+1]]$density_plot_2) +
  patchwork::plot_layout(heights = c(2, 1,  
                                     2, 1)) 

ggsave("../figures/FigS23.eps", device=cairo_pdf,plot = p, width = 14, height = 16)
ggsave("../figures/FigS23.pdf", device=cairo_pdf,plot = p, width = 14, height = 16)






# Figure S9: Top 20 unity and permutation VIM values for one dataset each generated from DGP 1
# and DGP 2 (n = 500).
###############################################################################################

unityvim_rel_dgp1 <- sort(unityvim_dgp1, decreasing=TRUE)[1:20]
unityvim_rel_dgp2 <- sort(unityvim_dgp2, decreasing=TRUE)[1:20]


library("ggplot2")
library("dplyr")
library("tibble")

df1 <- enframe(unityvim_rel_dgp1, name = "variable", value = "importance") %>%
  mutate(sim = "dgp1")

df2 <- enframe(unityvim_rel_dgp2, name = "variable", value = "importance") %>%
  mutate(sim = "dgp2")


# Plot function
make_barplot <- function(data, title) {
  ggplot(data, aes(x = reorder(variable, importance), y = importance)) +
    geom_col(fill = "steelblue") +
    coord_flip() +
    labs(x = NULL, y = "Unity VIM", title = title) +
    theme_bw() +
    theme(axis.text = element_text(color="black", size = 10),
          axis.title = element_text(size = 13),
          plot.title = element_text(size = 16))
}

p1 <- make_barplot(df1, "DGP 1")
p2 <- make_barplot(df2, "DGP 2")



permvim_rel_dgp1 <- sort(permvim_dgp1, decreasing=TRUE)[1:20]
permvim_rel_dgp2 <- sort(permvim_dgp2, decreasing=TRUE)[1:20]


df1 <- enframe(permvim_rel_dgp1, name = "variable", value = "importance") %>%
  mutate(sim = "dgp1")

df2 <- enframe(permvim_rel_dgp2, name = "variable", value = "importance") %>%
  mutate(sim = "dgp2")


# Plot function
make_barplot <- function(data, title) {
  ggplot(data, aes(x = reorder(variable, importance), y = importance)) +
    geom_col(fill = "steelblue") +
    coord_flip() +
    labs(x = NULL, y = "Permutation VIM", title = title) +
    theme_bw() +
    theme(axis.text = element_text(color="black", size = 10),
          axis.title = element_text(size = 13),
          plot.title = element_text(size = 16))
}

p3 <- make_barplot(df1, "DGP 1")
p4 <- make_barplot(df2, "DGP 2")

# p1 + p2

(p1 + p3) / (p2 + p4)

ggsave("../figures/FigS9.pdf", width=10, height=10)
ggsave("../figures/FigS9.eps", width=10, height=10)
