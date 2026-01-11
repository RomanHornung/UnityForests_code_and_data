# This is a modified version of the reprTrees.R script from the unityForest R package, 
# adapted to visualize CRTRs for the wine dataset.
#######################################################################################


my_reprTrees <- function(object, vars=NULL, numvars=5, indvars=NULL, num.threads = NULL, plotit=TRUE,
                         highlight_relevant = TRUE, box_plots = TRUE, density_plots = TRUE, add_split_line = TRUE, verbose = TRUE) {
  
  predict.all <- FALSE
  num.trees <- object$num.trees
  type <- "response"					
  
  forest <- object$forest
  data <- object$data
  
  if (is.null(forest)) {
    stop("Error: No saved forest in unityfor object. Please set write.forest to TRUE when calling unityfor.")
  }
  
  var.imp <- object$variable.importance
  
  if (is.null(vars)) {
    
    if (is.null(var.imp)) {
      stop("If no variables are provided via 'vars', the fitted 'unityfor' object must contain unity VIM values ('$variable.importance'). Please refit using 'importance=\"unity\"'.'")
    }
    
    if (is.null(indvars)) {
      if (numvars > length(var.imp)) {
        numvars <- length(var.imp)
        warning(paste0("The value of 'numvars' was larger than the number of variables. --> numvars set to ", length(var.imp), "."))
      }
      repr.var.names <- names(sort(var.imp, decreasing=TRUE))[1:numvars]
    } else {
      if (any(!(indvars %in% 1:length(var.imp)))) {
        indvars_outofbound <- sort(indvars[any(!(indvars %in% 1:length(var.imp)))])
        if (length(setdiff(indvars, indvars_outofbound)) == 0) {
          stop("No elements of 'indvars' are within 1:length(variable.importance).")
        }
        warning(paste0("The following elements of 'indvars' were not within 1:length(variable.importance): ", paste(indvars_outofbound, collapse=", "), ". These are removed from 'indvars'."))
        indvars <- setdiff(indvars, indvars_outofbound)
      }
      repr.var.names <- names(sort(var.imp, decreasing=TRUE))[indvars]
    }
    
  } else {
    if (any(!(vars %in% forest$independent.variable.names))) {
      vars_notincluded <- vars[any(!(vars %in% forest$independent.variable.names))]
      if (length(setdiff(vars, vars_notincluded)) == 0) {
        stop("No elements of 'vars' are within the independent variables names of the unityfor object.")
      }
      warning(paste0("The following elements of 'vars' were not within the independent variables names of the unityfor object: ", paste(vars_notincluded, collapse=", "), ". These are removed from 'vars'."))
      vars <- setdiff(vars, vars_notincluded)
    }
    repr.var.names <- vars
  }
  
  
  
  se.method <- "infjack"
  seed <- NULL
  
  variable.names <- colnames(data)
  
  ## Check forest argument
  if (!inherits(object, "unityfor")) {
    stop("Error: Invalid class of input object.")
  }
  
  if (is.null(forest$dependent.varID) || is.null(forest$num.trees) ||
      is.null(forest$child.nodeIDs) || is.null(forest$split.varIDs) ||
      is.null(forest$split.values) || is.null(forest$independent.variable.names) ||
      is.null(forest$treetype)) {
    stop("Error: Invalid forest object.")
  }
  
  ## Convert to data matrix
  data.final <- data.matrix(data)
  
  ## Check missing values
  if (any(is.na(data.final))) {
    offending_columns <- colnames(data.final)[colSums(is.na(data.final)) > 0]
    stop("Missing data in columns: ",
         paste0(offending_columns, collapse = ", "), ".", call. = FALSE)
  }
  
  if (sum(!(forest$independent.variable.names %in% variable.names)) > 0) {
    stop("Error: One or more independent variables not found in data.")
  }
  
  ## Num threads
  ## Default 0 -> detect from system in C++.
  if (is.null(num.threads)) {
    num.threads = 0
  } else if (!is.numeric(num.threads) || num.threads < 0) {
    stop("Error: Invalid value for num.threads")
  }
  
  ## Seed
  if (is.null(seed)) {
    seed <- runif(1 , 0, .Machine$integer.max)
  }
  
  if (forest$treetype == "Classification") {
    treetype <- 1
  } else if (forest$treetype == "Regression") {
    treetype <- 3
  } else if (forest$treetype == "Probability estimation") {
    treetype <- 9
  } else {
    stop("Error: Unknown tree type.")
  }
  
  ## Defaults for variables not needed
  dependent.variable.name <- ""
  mtry <- 0
  importance <- 0
  min.node.size <- 0
  split.select.weights <- list(c(0, 0))
  use.split.select.weights <- FALSE
  always.split.variables <- c("0", "0")
  use.always.split.variables <- FALSE
  status.variable.name <- "status"
  prediction.mode <- TRUE
  write.forest <- FALSE
  replace <- TRUE
  probability <- FALSE
  unordered.factor.variables <- c("0", "0")
  use.unordered.factor.variables <- FALSE
  save.memory <- FALSE
  splitrule <- 1
  alpha <- 0
  minprop <- 0
  case.weights <- c(0, 0)
  use.case.weights <- FALSE
  class.weights <- c(0, 0)
  keep.inbag <- FALSE
  sample.fraction <- 1
  holdout <- FALSE
  num.random.splits <- 1
  order.snps <- FALSE
  oob.error <- FALSE
  max.depth <- 0
  inbag <- list(c(0,0))
  use.inbag <- FALSE
  nsplits <- 0 ## asdf
  proptry <- 0 ## asdf
  eim.mode <- 0
  prediction.type <- 1
  prop.best.splits <- object$prop.best.splits
  
  repr.tree.mode <- TRUE
  
  ## Use sparse matrix
  if ("dgCMatrix" %in% class(data.final)) {
    sparse.data <- data.final
    data.final <- matrix(c(0, 0))
    use.sparse.data <- TRUE
  } else {
    sparse.data <- Matrix(matrix(c(0, 0)))
    use.sparse.data <- FALSE
  }
  
  ## Call divfor
  result <- divforCpp(treetype, dependent.variable.name, data.final, variable.names, mtry,
                      num.trees, verbose, seed, num.threads, write.forest, importance,
                      min.node.size, min_node_size_root=0, split.select.weights, use.split.select.weights,
                      always.split.variables, use.always.split.variables,
                      status.variable.name, prediction.mode, forest, snp_data=as.matrix(0), replace, probability,
                      unordered.factor.variables, use.unordered.factor.variables, save.memory, splitrule,
                      case.weights, use.case.weights, class.weights, 
                      predict.all, keep.inbag, sample.fraction, alpha, minprop, holdout, 
                      prediction.type, num.random.splits, sparse.data, use.sparse.data,
                      order.snps, oob.error, max.depth, max_depth_root=3, num_cand_trees=1000, inbag, use.inbag, nsplits, npairs=0, proptry, prop_var_root=0, divfortype=4, 
                      promispairs=list(0,0), eim_mode=0, metricind=numeric(0), prop.best.splits,
                      repr.tree.mode, repr.var.names)
  
  
  result$forest$covariate.levels <- forest$covariate.levels
  
  if (length(result) == 0) {
    stop("User interrupt or internal error.")
  }
  
  
  plots_and_rules <- list()
  for(i in seq(along=repr.var.names)) {
    
    plots_and_rules[[i]] <- .my_plot_representative_tree(i, result$forest, data, names(data)[forest$dependent.varID+1], repr.var.names, forest$independent.variable.names, plotit, highlight_relevant, box_plots, density_plots, add_split_line)
    
    if(plotit) {
      for (j in seq(along=plots_and_rules[[i]]$ps)) {
        print(plots_and_rules[[i]]$ps[[j]])
        if(j < length(plots_and_rules[[i]]$ps)) {
          readline(prompt="Press [enter] for next plot.")
        }
      }
    }
    
    if(i < length(repr.var.names) & plotit)
      readline(prompt="Press [enter] for next plot.")
  }
  
  rules <- lapply(plots_and_rules, function(x) x$rules)
  plots <- lapply(plots_and_rules, function(x) x$ps)
  
  names(rules) <- names(plots) <- repr.var.names
  
  
  ## Prepare results
  
  result$rules <- rules
  result$plots <- plots
  result$num.samples <- nrow(data.final)
  result$var.names <- repr.var.names
  result$treetype <- forest$treetype
  result$var.names.all <- forest$independent.variable.names
  result$predictions <- result$num.trees <- NULL
  
  
  # Reorder the result list, so that they items in the list have a meaningful
  # ordering:
  
  res_names_all <- c("rules", "plots", "var.names",  "var.names.all", "num.independent.variables", "num.samples", "treetype", "forest")
  res_names <- names(result)
  
  ind_cl <- which(res_names %in% res_names_all)
  
  res_names_sub <- res_names[ind_cl]
  res_names_all_sub <- res_names_all[res_names_all %in% res_names]
  
  reorderind <- as.numeric(factor(res_names_all_sub, levels=res_names_sub))
  
  new_order <- 1:length(result)
  new_order[ind_cl] <- ind_cl[reorderind]
  
  result <- result[new_order]
  
  
  
  class(result) <- "unityfor.reprTrees"
  return(result)
  
}




# Function for plotting one of the representative trees:
.my_plot_representative_tree <- function(treeind, forest, data, dep.var.name, var.names, var.names.all, plotit=TRUE, highlight_relevant=TRUE, box_plots=TRUE, density_plots=TRUE, add_split_line=TRUE) {
  
  # Subset the data to only contain the in-bag observations of the tree:
  inbag_ind <- which(forest$inbag.counts[[treeind]]!=0)
  data <- data[inbag_ind,]
  data[-ncol(data)] <- lapply(data[-ncol(data)], as.numeric)
  
  # Extract the information from the forest for the treeind-th tree:
  scoreval <- forest$score.values[[treeind]]
  nodeID_in_root <- forest$nodeID.in.root[[treeind]]
  child_left <- forest$child.nodeIDs[[treeind]][[1]] + 1
  child_right <- forest$child.nodeIDs[[treeind]][[2]] + 1
  split_varIDs <- forest$split.varIDs[[treeind]] + 1
  split_values <- forest$split.values[[treeind]]
  is_in_best <- forest$is.in.best[[treeind]]
  is_cat <- child_left != 1 & nodeID_in_root[child_left] != 0 & split_varIDs %in% which(sapply(forest$covariate.levels, length) > 0)
  
  # Determine the depth of the tree because this informs, how broad the first splits
  # will be plotted:
  
  depth_count <- 1
  curr_child_nodes <- c()
  curr_depths <- rep(99, length(nodeID_in_root))
  
  for(i in seq(along=nodeID_in_root)) {
    
    nodeID_in_root_temp <- nodeID_in_root[i]
    
    if ((i == 1) || (child_left[i] != 1 && nodeID_in_root[child_left[i]] != 0))
    {
      
      if (nodeID_in_root_temp %in% curr_child_nodes) {
        depth_count <- depth_count + 1
        curr_child_nodes <- c()
      }
      
      curr_child_nodes <- c(curr_child_nodes, nodeID_in_root[child_left[i]], nodeID_in_root[child_right[i]])
      
      curr_depths[i] <- depth_count
      
    }
    
  }
  
  depth_tree <- depth_count
  
  # Width of the first split:
  max_width <- 2^(depth_tree-1)
  
  # Names of categorical variables:
  cat_indicator <- sapply(forest$covariate.levels, length)>0
  var.names.cat <- var.names.all[cat_indicator]
  var.cat.levels <- forest$covariate.levels[cat_indicator]
  
  # This will contain the labels showing the class distributions at the nodes:
  y_label <- rep("", length(nodeID_in_root))
  
  # This will contain the vectors of indices of observations at each node:
  indices_nodes <- vector("list", length = length(nodeID_in_root))
  indices_nodes[[1]] <- 1:nrow(data)
  
  # First class distribution label:
  nums_raw <- table(data[indices_nodes[[1]], dep.var.name])
  freqs_raw <- nums_raw/sum(nums_raw)
  
  ytab <- round(freqs_raw, 2) # CHANGED: 3)
  y_label[1] <- paste0("P(\"G\") = ", ytab[1]) # CHANGED: paste(paste0(names(ytab), ": ", ytab), collapse=", ")
  
  
  # First line of the data.frame that will contain the horizontal lines showing
  # the splits in the plot:
  left_label <- my_format_split_label(split_var=var.names.all[split_varIDs[1]], split_val=split_values[1], 
                                   var.names.cat=var.names.cat, cov_levels=var.cat.levels, data=data, 
                                   ind_curr=indices_nodes[[1]], direction="left")
  right_label <- my_format_split_label(split_var=var.names.all[split_varIDs[1]], split_val=split_values[1], 
                                    var.names.cat=var.names.cat, cov_levels=var.cat.levels, data=data, 
                                    ind_curr=indices_nodes[[1]], direction="right")
  xlines_df <- data.frame(x = -max_width/2, xend = max_width/2, y = 0, yend = 0, left_label = left_label, 
                          right_label=right_label, 
                          scoreval=scoreval[1], is_in_best=is_in_best[1], ind_in_full_tree=1, highlight=1,
                          stringsAsFactors = FALSE)
  
  # First line of the data.frame that will contain the class distribution labels:
  y_label_df <- data.frame(x = 0, y = 0.9, y_label=y_label[1], ind_in_full_tree=1, highlight=1, stringsAsFactors = FALSE)
  
  
  # This will contain the class distributions in numerical format, will be
  # returned by the function:
  rules_dist <- vector("list", length = length(nodeID_in_root))
  
  rules_dist_new <- rbind(freqs_raw, nums_raw)
  rownames(rules_dist_new) <- c("frequencies", "numbers")
  
  rules_dist[[1]] <- rules_dist_new
  
  # This will contain the rules corresponding to the nodes in the forest:
  rules <- rep("root node", length(nodeID_in_root))
  
  
  # This loop cycles through the nodes in the tree and adds the the plot
  # information, namely the coordinates of the horizontal and vertical lines,
  # as well as the labels shown in the plot, and further visualization information:
  for(i in 2:length(nodeID_in_root)) {
    
    nodeID_in_root_temp <- nodeID_in_root[i]
    
    # Only the tree roots are plotted:
    if (nodeID_in_root[i] != 0)
    {
      
      parent_left <- which(child_left==i)
      ind_parent <- c(parent_left, which(child_right==i))
      
      if(length(parent_left) > 0) {
        indices_nodes[[i]] <- indices_nodes[[ind_parent]][data[indices_nodes[[ind_parent]],var.names.all[split_varIDs[ind_parent]]] <= split_values[ind_parent]]
      } else {
        indices_nodes[[i]] <- indices_nodes[[ind_parent]][data[indices_nodes[[ind_parent]],var.names.all[split_varIDs[ind_parent]]] > split_values[ind_parent]]
      }
      
      nums_raw <- table(data[indices_nodes[[i]], dep.var.name])
      freqs_raw <- nums_raw/sum(nums_raw)
      ytab <- round(freqs_raw, 2) # CHANGED: 3)
      y_label[i] <- paste0("P(\"G\") = ", ytab[1]) # CHANGED: paste(paste0(names(ytab), ": ", ytab), collapse=", ")

      rules_dist_new <- rbind(freqs_raw, nums_raw)
      rownames(rules_dist_new) <- c("frequencies", "numbers")
      
      rules_dist[[i]] <- rules_dist_new
      
      parent_line <- xlines_df[xlines_df$ind_in_full_tree==ind_parent,]    
      
      rules[i] <- paste0(rules[ind_parent], ", ", ifelse(length(parent_left) > 0, parent_line$left_label, parent_line$right_label))
      
      # If the node has child nodes in the tree root, add horizontal line (and class distribution information):
      if (child_left[i] != 1 && nodeID_in_root[child_left[i]] != 0)
      {
        
        if(length(parent_left) > 0) {
          x_new <- parent_line$x - max_width/(2*curr_depths[i])
          xend_new <- parent_line$x + max_width/(2*curr_depths[i])
        } else {
          x_new <- parent_line$xend - max_width/(2*curr_depths[i])
          xend_new <- parent_line$xend + max_width/(2*curr_depths[i])
        }
        
        left_label <- my_format_split_label(split_var=var.names.all[split_varIDs[i]], split_val=split_values[i], 
                                         var.names.cat=var.names.cat, cov_levels=var.cat.levels, data=data, 
                                         ind_curr=indices_nodes[[i]], direction="left")
        right_label <- my_format_split_label(split_var=var.names.all[split_varIDs[i]], split_val=split_values[i], 
                                          var.names.cat=var.names.cat, cov_levels=var.cat.levels, data=data, 
                                          ind_curr=indices_nodes[[i]], direction="right")
        
        new_row <- data.frame(x = x_new, xend = xend_new, y = -curr_depths[i]+1, yend = -curr_depths[i]+1, 
                              left_label = left_label, right_label=right_label, 
                              scoreval=scoreval[i], is_in_best=is_in_best[i], ind_in_full_tree=i, highlight=0, 
                              stringsAsFactors = FALSE) ## wenn das is_in_best==1 ist ---> highlight = 1
        
        # if (i == 5) browser() 
        
        if (is_in_best[i] == 1 & var.names.all[split_varIDs[i]]==var.names[treeind]) {
          
          # Den index in xlines_df bei highlight = 1 setzen
          xlines_df$highlight[which(xlines_df$ind_in_full_tree == ind_parent)] <- 1
          y_label_df$highlight[which(y_label_df$ind_in_full_tree == ind_parent)] <- 1
          
          parent_temp <- ind_parent
          
          while (parent_temp != 1) {
            parent_left <- which(child_left==parent_temp)
            ind_parent <- c(parent_left, which(child_right==parent_temp))
            # Den index in xlines_df bei highlight = 1 setzen
            xlines_df$highlight[which(xlines_df$ind_in_full_tree == ind_parent)] <- 1
            y_label_df$highlight[which(y_label_df$ind_in_full_tree == ind_parent)] <- 1
            parent_temp <- ind_parent
          }
          
          new_row$highlight <- 1
          
        }
        
        xlines_df <- rbind(xlines_df, new_row)
        
        y_label_df <- rbind(y_label_df, data.frame(x = (new_row$x + new_row$xend)/2, y = new_row$y + 0.85, y_label=y_label[i], ind_in_full_tree=i, highlight=new_row$highlight))
        
      }
      else {
        
        # If the node does not have nodes in the tree root, just add class distribution information:
        if(length(parent_left) > 0) {
          x_new <- parent_line$x
        } else {
          x_new <- parent_line$xend
        }
        
        y_label_df <- rbind(y_label_df, data.frame(x = x_new, y = parent_line$y - 0.15, y_label=y_label[i], ind_in_full_tree=i, highlight=0))
      }
      
    }
    
  }
  
  
  # In the above loop, not all labels of the class distributions were marked as
  # highlighted, only the direct ancestors, for example only the right nodes,
  # but not the left ones, or the other way round.
  # Highlight the rest:
  
  highlight_inds <- which(y_label_df$highlight==1)[-1]
  
  for (i in seq(along=highlight_inds)) {
    temp_id <- y_label_df$ind_in_full_tree[highlight_inds[i]]
    if (length(which(child_right==temp_id)) > 0) {
      y_label_df$highlight[which(y_label_df$ind_in_full_tree==child_left[which(child_right==temp_id)])] <- 1
    } else {
      y_label_df$highlight[which(y_label_df$ind_in_full_tree==child_right[which(child_left==temp_id)])] <- 1
    }
  }
  
  # Add the name of the variable used for spltting:
  xlines_df$split_var <- var.names.all[split_varIDs[xlines_df$ind_in_full_tree]]
  
  # Mark the labels of the class distributions for the best splits:
  best_inds <- which(xlines_df$is_in_best & xlines_df$split_var==var.names[treeind]) #  xlines_df$ind_in_full_tree)#xlines_df$highlight==1)
  for(i in seq(along=best_inds)) {
    temp_id <- xlines_df$ind_in_full_tree[best_inds[i]]
    y_label_df$highlight[which(y_label_df$ind_in_full_tree==child_left[temp_id])] <- 1
    y_label_df$highlight[which(y_label_df$ind_in_full_tree==child_right[temp_id])] <- 1
  }
  
  # The widths of the horizontal lines are determined by scores that express whether
  # the corresponding variables are used more often in the best trees associated with
  # the variables than in the complete forest - however, for the variable for which
  # the representative tree was obtained this does not make sense because this variable
  # is obviously in all best trees that use this variable.
  # Therefore for the variable for which the representative tree was obtained we
  # use as width the mean score value from the score values of the splits in the
  # other variables:
  xlines_df$scoreval[xlines_df$split_var==var.names[treeind]] <- mean(xlines_df$scoreval[xlines_df$split_var!=var.names[treeind]])
  
  
  
  # Make the vertical lines using the information on the horizontal lines:
  ylines_df <- data.frame(x = 0, xend = 0, y = 0, yend = 0.8, highlight = 1)
  for(i in 2:nrow(xlines_df)) {
    x_new <- (xlines_df$x[i] + xlines_df$xend[i])/2
    ylines_df <- rbind(ylines_df, data.frame(x=x_new, xend=x_new, y=xlines_df$y[i], yend=xlines_df$y[i]+0.8, highlight = xlines_df$highlight[i]))
  }
  
  
  # Subset the rules vectors so that they only contain nodes from the tree roots:
  incl_ind <- which(sapply(rules_dist, length)!=0)
  
  rules <- rules[incl_ind]
  rules_dist <- rules_dist[incl_ind]
  
  rules <- gsub("root node, ", "", rules)
  
  names(rules_dist) <- rules
  
  
  ps <- list()
  
  # Make th plot:
  
  library("ggplot2")
  library("ggrepel")
  
  if (highlight_relevant) {
    
    y_label_df$color <- 2
    y_label_df$color[y_label_df$highlight==0] <- 4
    
    y_label_df$color <- factor(y_label_df$color)
    
    
    ylines_df$color <- 2
    ylines_df$color[ylines_df$highlight==0] <- 4
    
    ylines_df$color <- factor(ylines_df$color)
    
    
    incl_bool <- y_label_df$x %in% c(min(y_label_df$x), max(y_label_df$x))
    y_label_df_extr <- y_label_df[incl_bool,]
    y_label_df_nonextr <- y_label_df[!incl_bool,]
    
    xlines_df$color <- 1
    xlines_df$color[xlines_df$split_var==var.names[treeind]] <- 2
    xlines_df$color[xlines_df$highlight==0] <- 5
    xlines_df$color[xlines_df$split_var==var.names[treeind] & xlines_df$highlight==0] <- 4
    xlines_df$color[xlines_df$is_in_best==TRUE & xlines_df$split_var==var.names[treeind]] <- 3
    
    xlines_df$color <- factor(xlines_df$color)
    
    xlines_df_labels <- xlines_df
    xlines_df_labels$color <- 2
    xlines_df_labels$color[xlines_df_labels$highlight==0] <- 4
    
    xlines_df_labels$color <- factor(xlines_df_labels$color)
    
    p <- ggplot() + geom_segment(data=ylines_df, aes(x=x, xend=xend, y=y, yend=yend, color=color), linewidth=2) +
      geom_segment(data=xlines_df, aes(x=x, xend=xend, y=y, yend=yend, linewidth=scoreval, color=color, linetype=factor(as.numeric(color==3)))) +
      scale_color_manual(values = c("1" = "grey50", "2" = "black", "3" = "green3", "4" = "grey65", "5" = "grey90")) +
      scale_linetype_manual(values = c("0" = "solid", "1" = "twodash")) +
      geom_text(data = xlines_df_labels, aes(x = x + 0.2*(xend - x), y = y + 0.2, label = left_label, color=color), size = 4) +
      geom_text(data = xlines_df_labels, aes(x = x + 0.8*(xend - x), y = y + 0.2, label = right_label, color=color), size = 4) +
      geom_text(data = y_label_df_nonextr, aes(x = x, y = y, label = y_label, color=color), size = 4) +
      geom_text_repel(data = y_label_df_extr, aes(x = x, y = y, label = y_label, color=color), size = 4, direction = "x") + #, box.padding = .3, force = 1)
      ggtitle(var.names[treeind]) +
      theme_void() +
      theme(legend.position = "none",
            plot.title = element_text(size = 18, hjust = 0.5, margin = margin(t = 10, b = 10), face="bold") )
    
  } else {
    
    incl_bool <- y_label_df$x %in% c(min(y_label_df$x), max(y_label_df$x))
    y_label_df_extr <- y_label_df[incl_bool,]
    y_label_df_nonextr <- y_label_df[!incl_bool,]
    
    xlines_df$color <- 1
    xlines_df$color[xlines_df$split_var==var.names[treeind]] <- 2
    xlines_df$color[xlines_df$is_in_best==TRUE & xlines_df$split_var==var.names[treeind]] <- 3
    xlines_df$color <- factor(xlines_df$color)
    
    # if (var.names[treeind] == "X58") browser()
    
    p <- ggplot() + geom_segment(data=ylines_df, aes(x=x, xend=xend, y=y, yend=yend), linewidth=2) +
      geom_segment(data=xlines_df, aes(x=x, xend=xend, y=y, yend=yend, linewidth=scoreval, color=color, linetype=factor(as.numeric(color==3)))) +
      scale_color_manual(values = c("1" = "grey50", "2" = "black", "3" = "green3", "4" = "grey65", "5" = "grey90")) +
      scale_linetype_manual(values = c("0" = "solid", "1" = "twodash")) +
      geom_text(data = xlines_df, aes(x = x + 0.2*(xend - x), y = y + 0.2, label = left_label), size = 4) +
      geom_text(data = xlines_df, aes(x = x + 0.8*(xend - x), y = y + 0.2, label = right_label), size = 4) +
      geom_text(data = y_label_df_nonextr, aes(x = x, y = y, label = y_label), size = 4) +
      geom_text_repel(data = y_label_df_extr, aes(x = x, y = y, label = y_label), size = 4, direction = "x") + #, box.padding = .3, force = 1)
      ggtitle(var.names[treeind]) +
      theme_void() +
      theme(legend.position = "none",
            plot.title = element_text(size = 18, hjust = 0.5, margin = margin(t = 10, b = 10), face="bold") )
    
  }
  
  ps[[length(ps) + 1]] <- p
  names(ps)[length(ps)] <- "tree_plot"
  
  
  indices_best_splits <- xlines_df$ind_in_full_tree[xlines_df$is_in_best==1 & xlines_df$split_var==var.names[treeind]]
  
  
  if (box_plots | density_plots) {
    
    counts <- make_count_labels(data, dep.var.name, var.names[treeind])
    
    plot_title <- paste0("Marginal influence of ", var.names[treeind])
    
    xtemp <- data[,var.names[treeind]]
    ytemp <- data[,dep.var.name]
    
    if (var.names[treeind] %in% var.names.cat) {
      levelstemp <- var.cat.levels[[which(var.names.cat==var.names[treeind])]]
      xtemp <- factor(levelstemp[xtemp], levels=levelstemp)
    }
    
    p <- plotVarDensityUFO(x=xtemp, y=ytemp, counts=counts, split_value=1, x_label=var.names[treeind], y_label="", legend_title=dep.var.name, plot_title=plot_title, add_split_line=FALSE)
    ps[[length(ps) + 1]] <- p
    names(ps)[length(ps)] <- "marginal_density_plot"
    
    for (i in seq(along=indices_best_splits)) {
      
      index_temp <- indices_best_splits[i]
      
      data_best_split <- data[indices_nodes[[index_temp]],]
      split_var <- var.names.all[split_varIDs[index_temp]]
      split_value <- split_values[index_temp]
      split_label <- names(rules_dist)[which(y_label_df$ind_in_full_tree == index_temp)]
      
      counts <- make_count_labels(data_best_split, dep.var.name, split_var)
      
      if (split_label=="root node")
        plot_title <- paste0("Marginal influence of ", split_var)
      else
        plot_title <- paste0("Influence of ", split_var, " for subgroup '", split_label, "'")
      
      xtemp <- data_best_split[,split_var]
      ytemp <- data_best_split[,dep.var.name]
      
      if (split_var %in% var.names.cat) {
        levelstemp <- var.cat.levels[[which(var.names.cat==split_var)]]
        xtemp <- factor(levelstemp[xtemp], levels=levelstemp)
      }
      
      if (class(xtemp) != "factor" & length(unique(xtemp)) > 2) { # if (class(xtemp) != "factor") {
        if (box_plots) {
          p <- plotVarBoxplotUFO(x=xtemp, y=ytemp, counts=counts, split_value=split_value, x_label=dep.var.name, y_label=split_var, plot_title=plot_title, add_split_line=add_split_line)
          ps[[length(ps) + 1]] <- p
          names(ps)[length(ps)] <- ifelse(length(indices_best_splits) > 1, paste0("box_plot_", i), "box_plot")
        }
        
        if (density_plots) {
          p <- plotVarDensityUFO(x=xtemp, y=ytemp, counts=counts, split_value=split_value, x_label=split_var, y_label="", legend_title=dep.var.name, plot_title=plot_title, add_split_line=add_split_line)
          ps[[length(ps) + 1]] <- p
          names(ps)[length(ps)] <- ifelse(length(indices_best_splits) > 1, paste0("density_plot_", i), "density_plot")
        }
      } else {
        p <- plotVarBarplotUFO(x=xtemp, y=ytemp, split_value=split_value, x_label=split_var, legend_title=dep.var.name, plot_title=plot_title, add_split_line=add_split_line)
        ps[[length(ps) + 1]] <- p
        names(ps)[length(ps)] <- ifelse(length(indices_best_splits) > 1, paste0("bar_plot_", i), "bar_plot")
      }
      
    }
    
  }
  
  return(list(rules=rules_dist, ps=ps))
}



# Function that formats the split values so that they can be better visualized
# in the plot:
my_format_number <- function(x) {
  abs_x <- abs(x)
  
  formatC(x, format = "f", digits = 2)
  
  # if (abs_x >= 1000) {
  #   return(formatC(x, format = "f", digits = 0))
  # } else if (abs_x >= 10) {
  #   return(formatC(x, format = "f", digits = 1))
  # } else if (abs_x >= 1) {
  #   return(formatC(x, format = "f", digits = 2))
  # } else if (abs_x >= 0.1) {
  #   return(formatC(x, format = "f", digits = 3))
  # } else if (abs_x >= 0.01) {
  #   return(formatC(x, format = "f", digits = 4))
  # } else if (abs_x >= 0.001) {
  #   return(formatC(x, format = "f", digits = 5))
  # } else if (abs_x >= 1e-4) {
  #   return(formatC(x, format = "f", digits = 6))
  # } else {
  #   return(formatC(x, format = "e", digits = 2))
  # }
}


# Function used for labeling the splits:
my_format_split_label <- function(split_var, split_val, var.names.cat, cov_levels, data, ind_curr, direction=c("left", "right")) {
  if (!(split_var %in% var.names.cat)) {
    op_temp <- ifelse(direction=="left", " ≤ ", " > ")
    return(paste0(split_var, op_temp, my_format_number(split_val)))
  } else {
    inds_temp <- sort(unique(data[ind_curr, split_var]))
    if (direction == "left") {
      inds_node <- inds_temp[inds_temp <= split_val]
    } else {
      inds_node <- inds_temp[inds_temp > split_val]
    }
    categ_node <- cov_levels[[which(var.names.cat==split_var)]][inds_node]
    return(paste0(split_var, ":  ", paste(categ_node, collapse=", ")))
  }
}

# Compute counts and dynamic label positions:
get_counts_with_y <- function(df, yvar) {
  require("dplyr")
  df %>%
    group_by(y) %>%
    summarise(
      n = n(),
      y = max(.data[[yvar]], na.rm = TRUE) + 0.05 * diff(range(.data[[yvar]], na.rm = TRUE)),
      .groups = "drop"
    )
}

make_count_labels <- function(dataset, dep.var.name, split_var) {
  dep <- dataset[[dep.var.name]]
  y   <- dataset[[split_var]]
  
  res <- by(y, dep, function(vals) {
    n    <- length(vals)
    rng  <- range(vals, na.rm = TRUE)
    ymax <- max(vals, na.rm = TRUE)
    ypos <- ymax + 0.05 * diff(rng)
    data.frame(n = n, y = ypos)
  })
  
  counts <- do.call(rbind, res)
  counts$category <- factor(rownames(counts), levels = levels(dep))
  counts$label <- paste0("n = ", counts$n)
  rownames(counts) <- NULL
  counts
}


plotVarBoxplotUFO <- function(x, y, counts, split_value, x_label="", y_label="", plot_title="", add_split_line=TRUE) {

  # Create a boxplot for a numeric covariate:
  
  if (inherits(x, "numeric")) {
    
    plotdata <- data.frame(x=x, y=y)
    
    p <- ggplot(plotdata, aes(x =.data$y, y=.data$x)) +
      geom_text(data = counts, aes(x = category, y = y, label = label), inherit.aes = FALSE, color = "grey40", size = 5) +
      geom_boxplot() +
      theme_bw() +
      theme(
        axis.text.x = element_text(color = "black", size = 15),
        axis.text.y = element_text(color = "black", size = 11),
        axis.title = element_text(size = 15),
        plot.title = element_text(size = 15)
      )
    
    if (add_split_line) 
      p <- p + geom_hline(yintercept = split_value, linetype = "dashed", color = "green3", linewidth = 1)
    
  }
  
  # Create a density plot for a factor covariate:
  
  if (inherits(x, "ordered") || inherits(x, "factor")) {
    
    if (inherits(x, "factor"))
      warning("The plot is likely not meaningful because the variable is an unordered factor.")
    
    x_levels <- levels(x)[levels(x) %in% unique(x)]
    
    # For plotting, the factor variable is transformed to a continuous variable:
    x <- as.numeric(x)
    
    plotdata <- data.frame(x=x, y=y)
    
    x_unique_sorted <- sort(unique(x))
    
    # Boxplot:

    p <- ggplot(plotdata, aes(x =.data$y, y=.data$x)) +
      geom_text(data = counts, aes(x = category, y = y, label = label), inherit.aes = FALSE, color = "grey40", size = 5) +
      geom_boxplot() +
      scale_y_continuous(breaks=x_unique_sorted, labels=x_levels) +
      theme_bw() +
      theme(
        axis.text.x = element_text(color = "black", size = 15),
        axis.text.y = element_text(color = "black", size = 11),
        axis.title = element_text(size = 15),
        plot.title = element_text(size = 15)
      )
    
    
    if (add_split_line) 
      p <- p + geom_hline(yintercept = split_value, linetype = "dashed", color = "green3", linewidth = 1)
    
  }
  
  # Add labels to the plot if provided:
  
  if (x_label=="")
    p <- p + theme(axis.title.x=element_blank())
  else
    p <- p + ylab(x_label)
  
  if (y_label=="")
    p <- p + xlab("class")
  else
    p <- p + xlab(y_label)
  
  if (plot_title!="")
    p <- p + ggtitle(plot_title)
  
  p
  
}


plotVarDensityUFO <- function(x, y, counts, split_value, x_label="", y_label="", legend_title="", plot_title="", add_split_line=TRUE) {
  
  # x <- data_best_split[,split_var]
  # y <- data_best_split[,dep.var.name]
  
  classtab <- table(y)
  
  # The densities are plotted only for classes with at least two observations:
  levels_to_keep <- names(classtab[classtab >= 2])
  
  filterbool <- y %in% levels_to_keep
  
  x <- x[filterbool]
  y <- y[filterbool]
  
  if (length(unique(x)) < length(unique(y)))
    stop("The number of unique covariate values must be at least as large as the number of classes.")
  
  allclasses <- levels(y)[levels(y) %in% unique(y)]
  
  classtab <- classtab[classtab >= 2]
  classprob <- classtab/sum(classtab)
  
  # The maximum number of different colors used. If the number of classes is larger
  # than this, the different classes are differentiated visually using both
  # colors and line types:
  nmax <- min(c(length(allclasses), 7))
  
  colors <- scales::hue_pal()(nmax)
  
  # if (length(allclasses) == nmax) {
  #   colorsvec <- colors
  #   linetypesvec <- rep("solid", length=length(colorsvec))
  # } else {
  #   colorsvec <- rep(colors, length=length(allclasses))
  #   
  #   linetypesvec <- rep(c("solid", "longdash", "dotdash"), each=nmax)[1:length(colorsvec)]
  #   linetypesvec <- c(linetypesvec, rep("dotdash", times=length(colorsvec) - length(linetypesvec)))
  # }
  linetypesvec <- c("solid", "dashed")
  colorsvec <- c("#F8766D", "#00BFC4")
  
  
  # Create a density plot for a numeric covariate:
  
  if (inherits(x, "numeric")) {
    
    denstemps <- list()
    
    for(i in seq(along=allclasses)) {
      xtemp <- x[y==allclasses[i]]
      
      denstemp <- density(xtemp)
      denstemp <- data.frame(x=denstemp$x, y=denstemp$y)
      # The density values are scaled by the class sizes:
      denstemp$y <- denstemp$y*classprob[i]
      denstemps[[i]] <- denstemp
    }
    
    plotdata <- do.call("rbind", denstemps)
    plotdata$class <- factor(rep(allclasses, times=sapply(denstemps, nrow)), levels=allclasses)
    
    pointdata <- data.frame(x=x, class=y)
    pointdata$class <- droplevels(pointdata$class)
    
    # If there are more than 1000 observations, the rug plot on the lower margin
    # only shows a random subset of 1000 observations:
    if (nrow(pointdata) > 1000) {
      pointdata <- pointdata[sample(1:nrow(pointdata), size=1000),]
    }
    
    
    coords <- sapply(denstemps, function(x) c(x$x[which.max(x$y)], x$y[which.max(x$y)]))
    coords[2,] <- coords[2,] + mean(coords[2,])*0.05
    
    counts$x1 <- coords[1,]
    counts$x2 <- coords[2,]
    
    p <- ggplot(plotdata, aes(x=.data$x, color=.data$class, linetype=.data$class)) + theme_bw() + geom_line(aes(y=.data$y)) +
      geom_text(data = counts, aes(x = x1, y = x2, label = paste0("n = ", n)), color = "grey40", size = 5, inherit.aes = FALSE) +
      scale_color_manual(values=colorsvec) + scale_linetype_manual(values = linetypesvec) +
      ylab("(scaled) density") + geom_rug(data=pointdata, sides="b") +
      theme(
        axis.text = element_text(color = "black", size = 11),
        axis.title = element_text(size = 15),
        plot.title = element_text(size = 15),
        legend.title = element_text(size = 15),
        legend.text = element_text(size = 15)
      ) + labs(color = legend_title, linetype=legend_title)
    
    if (add_split_line) 
      p <- p + geom_vline(xintercept = split_value, linetype = "dashed", color = "green3", linewidth = 1)
    
  }
  
  # Create a density plot for a factor covariate:
  
  if (inherits(x, "ordered") || inherits(x, "factor")) {
    
    if (inherits(x, "factor"))
      warning("The plot is likely not meaningful because the variable is an unordered factor..")
    
    x_levels <- levels(x)[levels(x) %in% unique(x)]
    
    # For plotting, the factor variable is transformed to a continuous variable:
    x <- as.numeric(x)
    
    denstemps <- list()
    
    for(i in seq(along=allclasses)) {
      xtemp <- x[y==allclasses[i]]
      
      denstemp <- density(xtemp)
      denstemp <- data.frame(x=denstemp$x, y=denstemp$y)
      denstemp$y <- denstemp$y*classprob[i]
      denstemps[[i]] <- denstemp
    }
    
    plotdata <- do.call("rbind", denstemps)
    plotdata$class <- factor(rep(allclasses, times=sapply(denstemps, nrow)), levels=allclasses)
    
    if (x_label=="")
      xlabadd <- theme(axis.title.x=element_blank())
    else
      xlabadd <- xlab(x_label)
    
    x_unique_sorted <- sort(unique(x))
    
    coords <- sapply(denstemps, function(x) c(x$x[which.max(x$y)], x$y[which.max(x$y)]))
    coords[2,] <- coords[2,] + mean(coords[2,])*0.05
    
    counts$x1 <- coords[1,]
    counts$x2 <- coords[2,]
    
    p <- ggplot(plotdata, aes(x=.data$x, y=.data$y, color=.data$class, linetype=.data$class)) + theme_bw() + geom_line() + 
      geom_text(data = counts, aes(x = x1, y = x2, label = paste0("n = ", n)), color = "grey40", size = 5, inherit.aes = FALSE) +
      scale_color_manual(values=colorsvec) + scale_linetype_manual(values = linetypesvec) +
      # The labels of the categories of the covariate are added to the x-axis:
      scale_x_continuous(breaks=x_unique_sorted, labels=x_levels) +
      ylab("density") +
      theme(axis.text.x = element_text(color = "black", size = 13, angle = 90, vjust = 0.5, hjust = 1),
            axis.text.y = element_text(color = "black", size = 11),
            axis.title = element_text(size = 15),
            plot.title = element_text(size = 15),
            legend.title = element_text(size = 15),
            legend.text = element_text(size = 15)
      ) + labs(color = legend_title, linetype=legend_title)
    
    if (add_split_line) 
      p <- p + geom_vline(xintercept = split_value, linetype = "dashed", color = "green3", linewidth = 1)
    
  }
  
  
  # Add labels to the plot if provided:
  
  if (x_label=="")
    p <- p + theme(axis.title.x=element_blank())
  else
    p <- p + xlab(x_label)
  
  if (y_label!="")
    p <- p + labs(colour=y_label, linetype=y_label)
  
  if (plot_title!="")
    p <- p + ggtitle(plot_title)
  
  return(p)
  
}

plotVarBarplotUFO <- function(x, y, split_value, x_label="", legend_title="", plot_title="", add_split_line=TRUE) {

  library("dplyr")
  
  # Prepare counts and relative frequencies
  
  # Build a temporary data frame
  df <- data.frame(x = x, y = y)
  
  # Compute counts and relative frequencies
  counts <- df %>%
    count(x, y, .drop = FALSE) %>%           # optional .drop=FALSE, um 0-Zellen zu behalten
    group_by(x) %>%
    mutate(
      prop  = n / sum(n),
      label = paste0("n = ", n)
    ) %>%
    ungroup()
  
  # Plot
  p <- ggplot(counts, aes(x = x, y = prop, fill = y)) +
    geom_col() +
    geom_text(
      aes(label = label),
      position = position_stack(vjust = 0.5),
      size = 5
    ) +
    scale_y_continuous(labels = scales::percent_format()) +
    labs(x = x_label, y = "Relative frequency", fill = legend_title) +
    ggtitle(plot_title) +
    theme_bw() + 
    theme(
      axis.text.x = element_text(color = "black", size = 15),
      axis.text.y = element_text(color = "black", size = 11),
      axis.title = element_text(size = 15),
      plot.title = element_text(size = 15),
      legend.title = element_text(size = 15),
      legend.text = element_text(size = 15)
    )
  
  if (add_split_line) 
    p <- p + geom_vline(xintercept = split_value, linetype = "dashed", color = "green3", linewidth = 1)
  
  return(p)
}


environment(my_reprTrees) <- environment(reprTrees)
environment(.my_plot_representative_tree) <- environment(reprTrees)
