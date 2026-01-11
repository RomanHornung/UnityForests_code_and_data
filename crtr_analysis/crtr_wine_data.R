####################################################################################

# NOTE:
# If the R working directory is not already set to
# '/UnityForests_code_and_data/crtr_analysis', it MUST be set to this directory
# before running this script (this is the directory in which this script is located).

# In that case, remove the '#' from the line below and replace 'here/is/my/path/'
# with the path to the directory '/UnityForests_code_and_data/crtr_analysis':

# setwd("here/is/my/path/")

####################################################################################



# Load and pre-process wine dataset:
####################################

load("../data/datasets/dataset122_wine_id973.Rda")

names(dataset)[names(dataset)=="OD280.OD315_of_diluted_wines"] <- "Wine_absorbance_index"
names(dataset)[names(dataset)=="Ytarget"] <- "Cultivar"

levels(dataset$Cultivar) <- c("G", "Other") # "Grignolino"

names(dataset)

names_short <- c("Alc", "Mal", "Ash", "AlcAsh", "Mg", 
                 "TP", "Fla", "NFP", "ProAn", "Col", 
                 "Hue", "WAI", "Prol", "C")

names(dataset) <- names_short





# Compute unity VIM and permutation VIM:
########################################

library("unityForest")

set.seed(10)
object <- unityfor(dependent.variable.name = "C", data = dataset, importance="unity", num.cand.trees = 500)

unityvim <- object$variable.importance


library("ranger")

set.seed(10)
permvim <- ranger(dependent.variable.name = "C", data=dataset, importance="permutation", 
                  num.trees=20000, replace = FALSE, sample.fraction = 0.7, probability=TRUE, 
                  min.node.size=5)$variable.importance




# Spearman correlation between the two VIMs:

cor(unityvim, permvim, method="spearman")






# Figure S24: Unity and permutation VIM values for wine dataset (n = 178)
#########################################################################

unityvim <- sort(unityvim, decreasing=TRUE)
permvim <- sort(permvim, decreasing=TRUE)

library("ggplot2")
library("dplyr")
library("tibble")
library("patchwork")

df1 <- enframe(unityvim, name = "variable", value = "importance") %>%
  mutate(sim = "sim1")

df2 <- enframe(permvim, name = "variable", value = "importance") %>%
  mutate(sim = "sim2")


# Plot function
make_barplot <- function(data, title) {
  ggplot(data, aes(x = reorder(variable, importance), y = importance)) +
    geom_col(fill = "steelblue") +
    coord_flip() +
    ggtitle(title) +
    theme_bw() +
    theme(axis.text = element_text(color="black", size = 10),
          axis.title = element_blank())
}
 
p1 <- make_barplot(df1, "Unity VIM")
p2 <- make_barplot(df2, "Permutation VIM")

p1 + p2

# Figure S24:

ggsave("../figures/FigS24.pdf", width=10, height=5)
ggsave("../figures/FigS24.eps", width=10, height=5)






# Figure 11: Visualization of the CRTRs for the three covariates with the highest unity
# VIM values in the wine dataset (n = 178).
#######################################################################################

source("./my_reprTrees_customized_for_plots_wine.R")

var_best <- names(sort(unityvim, decreasing=TRUE))[1:5]

repr_tree_obj <- my_reprTrees(object, vars=var_best, box_plots = FALSE, plotit=FALSE)
plots_temp <- repr_tree_obj$plots


p <- plots_temp[[1]]$tree_plot / plots_temp[[1]]$density_plot /
  plots_temp[[2]]$tree_plot / (plots_temp[[2]]$density_plot + plots_temp[[2]]$marginal_density_plot) /
  plots_temp[[3]]$tree_plot / plots_temp[[3]]$density_plot +
  patchwork::plot_layout(heights = c(2, 1,   # tree 1 : density 1
                                     2, 1,   # tree 2 : density 2
                                     2, 1))  # tree 3 : density 3

# Figure 11:

ggsave("../figures/Fig11.pdf", device=cairo_pdf, plot = p, width = 14, height = 16)
ggsave("../figures/Fig11.eps", device=cairo_pdf,plot = p, width = 14, height = 16)

  





# Figure 12: Visualization of the CRTRs for the fourth and fifth highest-ranked covariates
# according to the unity VIM in the wine dataset (n = 178). 
#########################################################################################

p <- plots_temp[[4]]$tree_plot / (plots_temp[[4]]$density_plot + plots_temp[[4]]$marginal_density_plot) /
  plots_temp[[5]]$tree_plot / (plots_temp[[5]]$density_plot + plots_temp[[5]]$marginal_density_plot) +
  patchwork::plot_layout(heights = c(2, 1,  
                                     2, 1)) 

# Figure 12:

ggsave("../figures/Fig12.pdf", device=cairo_pdf, plot = p, width = 14, height = 11)
ggsave("../figures/Fig12.eps", device=cairo_pdf,plot = p, width = 14, height = 11)
