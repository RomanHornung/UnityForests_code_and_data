# R Code and Data to the Article: Unity Forests: Improving Interaction Modelling and Interpretability in Random Forests

Authors: Roman Hornung<sup>1,2,*</sup> and Alexander Hapfelmeier<sup>3,4</sup>

1. Institute for Medical Information Processing, Biometry and Epidemiology, Faculty of Medicine, Ludwig Maximilian University of Munich (LMU), Munich, Germany, ORCID: 0000-0002-6036-1495.
2. Munich Center for Machine Learning (MCML), Munich, Germany.
3. Institute of AI and Informatics in Medicine, Department Clinical Medicine, TUM School of Medicine and Health, Technical University of Munich (TUM), Munich, Germany, ORCID: 0000-0001-6765-6352.
4. Institute of General Practice and Health Services Research, Department Clinical Medicine, TUM School of Medicine and Health, Technical University of Munich (TUM), Munich, Germany

\* For questions, please contact: hornung@ibe.med.uni-muenchen.de

---

## Program and Platform

- **Program**: R, versions 4.5.0 and 4.5.2.
- The intermediate (or "raw") results of the computationally intensive analyses, that is, the simulation study and the large-scale real data evaluation (preliminary study and comparison study) were obtained on a Linux cluster, and the evaluation of the intermediate results to produce the final results (i.e., the figures and tables) as well as the CRTR analyses and the preparation of the datasets for the large-scale real data evaluation were performed on Windows 11.
- Below is the output of the R command `sessionInfo()` on the Linux machine and on the Windows machine. The output specifies which systems, R packages and versions of those packages were used.

### sessionInfo() on the Linux Cluster

```R
> sessionInfo()
R version 4.5.0 (2025-04-11)
Platform: x86_64-pc-linux-gnu
Running under: Debian GNU/Linux 13 (trixie)

Matrix products: default
BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3 
LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.29.so;  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=de_DE.UTF-8       LC_NUMERIC=C              
 [3] LC_TIME=de_DE.UTF-8        LC_COLLATE=de_DE.UTF-8    
 [5] LC_MONETARY=de_DE.UTF-8    LC_MESSAGES=de_DE.UTF-8   
 [7] LC_PAPER=de_DE.UTF-8       LC_NAME=C                 
 [9] LC_ADDRESS=C               LC_TELEPHONE=C            
[11] LC_MEASUREMENT=de_DE.UTF-8 LC_IDENTIFICATION=C       

time zone: Europe/Berlin
tzcode source: system (glibc)

attached base packages:
[1] parallel  stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] mvtnorm_1.3-3     ranger_0.17.0     unityForest_0.1.0 doParallel_1.0.17
[5] iterators_1.0.14  foreach_1.5.2    

loaded via a namespace (and not attached):
 [1] Matrix_1.7-3      gtable_0.3.6      dplyr_1.1.4       compiler_4.5.0   
 [5] ggsignif_0.6.4    tidyselect_1.2.1  Rcpp_1.0.14       tidyr_1.3.1      
 [9] scales_1.3.0      lattice_0.22-7    ggplot2_3.5.1     R6_2.6.1         
[13] ggpubr_0.6.0      generics_0.1.3    Formula_1.2-5     backports_1.5.0  
[17] tibble_3.2.1      car_3.1-3         munsell_0.5.1     pillar_1.10.1    
[21] rlang_1.1.5       broom_1.0.7       cli_3.6.4         magrittr_2.0.3   
[25] grid_4.5.0        rstudioapi_0.17.1 lifecycle_1.0.4   vctrs_0.6.5      
[29] rstatix_0.7.2     glue_1.8.0        codetools_0.2-20  abind_1.4-8      
[33] carData_3.0-5     colorspace_2.1-1  purrr_1.0.4       tools_4.5.0      
[37] pkgconfig_2.0.3  
```

### sessionInfo() on the Windows Machine

```R
> sessionInfo()
R version 4.5.2 (2025-10-31 ucrt)
Platform: x86_64-w64-mingw32/x64
Running under: Windows 11 x64 (build 26100)

Matrix products: default
  LAPACK version 3.12.1

locale:
[1] LC_COLLATE=German_Germany.utf8  LC_CTYPE=German_Germany.utf8   
[3] LC_MONETARY=German_Germany.utf8 LC_NUMERIC=C                   
[5] LC_TIME=German_Germany.utf8    

time zone: Europe/Berlin
tzcode source: internal

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] mvtnorm_1.3-3     xtable_1.8-4      unityForest_0.1.0 tidyr_1.3.1      
 [5] tibble_3.3.0      stringr_1.6.0     sp_2.2-0          scales_1.4.0     
 [9] ranger_0.17.0     patchwork_1.3.2   knitr_1.50        jsonlite_2.0.0   
[13] httr_1.4.7        ggrepel_0.9.6     ggpattern_1.2.1   ggh4x_0.3.1      
[17] ggplot2_4.0.1     dplyr_1.1.4      

loaded via a namespace (and not attached):
 [1] generics_0.1.4     rstatix_0.7.3      stringi_1.8.7      lattice_0.22-7    
 [5] magrittr_2.0.4     evaluate_1.0.5     grid_4.5.2         RColorBrewer_1.1-3
 [9] Matrix_1.7-4       backports_1.5.0    Formula_1.2-5      purrr_1.2.0       
[13] abind_1.4-8        cli_3.6.5          rlang_1.1.6        withr_3.0.2       
[17] tools_4.5.2        ggsignif_0.6.4     ggpubr_0.6.2       broom_1.0.11      
[21] vctrs_0.6.5        R6_2.6.1           lifecycle_1.0.4    car_3.1-3         
[25] pkgconfig_2.0.3    pillar_1.11.1      gtable_0.3.6       glue_1.8.0        
[29] Rcpp_1.1.0         xfun_0.54          tidyselect_1.2.1   rstudioapi_0.17.1 
[33] farver_2.1.2       carData_3.0-5      compiler_4.5.2     S7_0.2.1  
```

---

## General Information and Contents of this Electronic Appendix

### Preliminary Remark
Readers who are not interested in the detailed contents of this electronic appendix, but only in the production of the figures and tables (by evaluating the intermediate results) or the full reproduction of the computationally intensive analyses, may skip to the sections "Production of the Final Results (Based on Intermediate Results)" or "Full Reproduction of the Computationally Intensive Analyses", respectively.

### Contents
- **benchmark_study**: This subfolder contains the R scripts `benchmark_study.R`,
    `functions_benchmark_study.R`, `functions_benchmark_study.R`, and `evaluation_benchmark_study.R`, as well
    as the subfolder `intermediate_results`.
    
    The R script `benchmark_study.R` can be used to run the large-scale real data comparison study between unity forests and random forests
    using parallel computing on the Linux cluster, producing the 
    intermediate results (see the section "Full Reproduction of the Computationally Intensive Analyses" 
    below for details).

    The R script `functions_benchmark_study.R` is sourced by `benchmark_study.R` 
    and contains all functions required for the comparison study.

    The R script `evaluation_benchmark_study.R` evaluates the intermediate results of 
    the comparison study to produce the figures and tables associated with 
    the comparison study.

    The subfolder `intermediate_results` contains the intermediate results 
    of the comparison study.
- **crtr_analysis**: This subfolder contains the R scripts `crtr_simulated_data.R`,
    `crtr_wine_data.R`, `my_reprTrees_customized_for_plots_sim.R`, and `my_reprTrees_customized_for_plots_wine.R`.
    
    The R scripts `crtr_simulated_data.R` and `crtr_wine_data.R` perform the CRTR analysis for the simulated datasets and for the wine dataset.

    The R scripts `my_reprTrees_customized_for_plots_sim.R` and `my_reprTrees_customized_for_plots_wine.R` are sourced by `crtr_simulated_data.R` and `crtr_wine_data.R`, respectively, and contain modified versions of the `reprTrees.R` script from the `unityForest` R package, adapted to visualize CRTRs for the simulated datasets and the wine dataset, respectively.
- **data**: This subfolder contains the files `preprocess_data_sets.R`, `make_data_table.R`, `datainfo.Rda`, and `data_set_descriptions.txt`, as well as the subfolders `datasets` and `datasets_large`.
    
    The R script `preprocess_data_sets.R` documents in detail the pre-processing of the datasets used in the large-scale real data evaluation, including the reasons for the exclusion of datasets from the original pool of available datasets.
    
    The R script `make_data_table.R` produces the supplmentary tables (Tables S1-S5) that provide an overview of the characteristics of the included datasets.
    
    The file `datainfo.Rda` was produced by `preprocess_data_sets.R` and contains a `data.frame` that provided for each included dataset, the numbers of observations and variables. This is required in the evaluation of the large-scale real data study (preliminary and comparison study).
    
    The file `data_set_descriptions.txt` was produced by `preprocess_data_sets.R` and contains for all included datasets (and a few more), the descriptions of these datasets from their OpenML pages. This is just for information and not required for reproduction.
    
    The subfolder `datasets` contains the pre-processed versions of all 198 datasets included in the large-scale real data study.
    
    The subfolders `datasets_large` contains the non-subset versions of the "large" datasets - as described in the paper, datasets with more than 1000 observations or variables were randomly subset to contain only 1000 observations or variables. This subfolder contains the non-subset, pre-processed versions of these datasets.
- **figures**: This subfolder contains all figures shown in the main paper and in the supplementary material as eps and pdf files.
- **hyperparam_benchmark_study**: This subfolder contains the R scripts `hyperparam_benchmark_study_max_depth_root.R`, `hyperparam_benchmark_study_num_cand_trees.R`, `hyperparam_benchmark_study_prop_var_root.R`, `functions_hyperparam_benchmark_study.R`, and `evaluation_hyperparam_benchmark_study.R`, as well as the subfolder `intermediate_results`.
    
    The R scripts `hyperparam_benchmark_study_max_depth_root.R`, `hyperparam_benchmark_study_num_cand_trees.R`, and `hyperparam_benchmark_study_prop_var_root.R` can be used to run the preliminary study for MAX_DEPTH_ROOT, N_CAND_TREES, and PROP_VAR using parallel computing on the Linux cluster, producing the intermediate results.

    The R script `functions_hyperparam_benchmark_study.R` is sourced by `hyperparam_benchmark_study_max_depth_root.R`, `hyperparam_benchmark_study_num_cand_trees.R`, and `hyperparam_benchmark_study_prop_var_root.R` 
    and contains all functions required for the preliminary study.

    The R script `evaluation_hyperparam_benchmark_study.R` evaluates the intermediate results of 
    the preliminary study to produce the figure associated with 
    the preliminary study.

    The subfolder `intermediate_results` contains the intermediate results 
    of the preliminary study.
    
- **simulation**: This subfolder contains the R scripts `simulation_study_design_1.R`,
`simulation_study_design_2.R`, `functions_simulation_study_design_1.R`, `functions_simulation_study_design_2.R`, `evaluation_simulation_study_design_1.R`, and `evaluation_simulation_study_design_2.R`, as well as the subfolder `intermediate_results`.
    
    The R scripts `simulation_study_design_1.R`,
`simulation_study_design_2.R` can be used to run the simulation study for DGP 1 and DGP 2, respectively, using parallel computing on the Linux cluster, producing the intermediate results.

    The R scripts `functions_simulation_study_design_1.R`, `functions_simulation_study_design_2.R` are sourced by `simulation_study_design_1.R`,
`simulation_study_design_2.R`, respectively, and contain all functions required for the simulation study.

    The R scripts `evaluation_simulation_study_design_1.R` and `evaluation_simulation_study_design_2.R` evaluate the intermediate results of 
    the simulation study for DGP 1 and DGP 2, respectively, to produce all figures and tables associated with the simulation study.

    The subfolder `intermediate_results` contains the intermediate results of the simulation study.
- **tables**: This subfolder contains all tables shown in the main paper and in the supplementary material as tex files.

---

## Production of the Final Results (Based on Intermediate Results)

The R scripts `evaluation_benchmark_study.R`, `evaluation_hyperparam_benchmark_study.R`, `evaluation_simulation_study_design_1.R`, `evaluation_simulation_study_design_2.R`, `crtr_simulated_data.R`, `crtr_wine_data.R`, and `make_data_table.R` produce the final results (i.e., the figures and tables). With the exception of `crtr_simulated_data.R`, `crtr_wine_data.R`, and `make_data_table.R`, these do not perform the corresponding analyses from scratch, but load Rda files that contain the intermediate results (for reproducing the intermediate results, see section "Full Reproduction of the Computationally Intensive Analyses" below).

The following provides an overview on which R scripts produce which results:

- `benchmark_study/evaluation_benchmark_study.R`: FigS2, Tab1
- `hyperparam_benchmark_study/evaluation_hyperparam_benchmark_study.R`: FigS1
- `simulation_study/evaluation_simulation_study_design_1.R`: Fig1, Fig3, FigS3, FigS5, FigS6, TabS6, TabS7
- `simulation_study/evaluation_simulation_study_design_2.R`: Fig2, FigS4, FigS7, FigS8, TabS8, TabS9, TabS10, TabS11
- `crtr_analysis/crtr_simulated_data.R`: Fig4, Fig5, FigS9, FigS10, FigS11, FigS12, FigS13, FigS14, FigS15, FigS16, FigS17, FigS18, FigS19, FigS20, FigS21, FigS22, FigS23, FigS24, FigS25, FigS26, FigS27, FigS28, FigS29
- `crtr_analysis/crtr_wine_data.R`: Fig6, Fig7, FigS30
- `data/make_data_table.R`: TabS1, TabS2, TabS3, TabS4, TabS5

---

## Full Reproduction of the Computationally Intensive Analyses
- An MPI environment is required.
- The R scripts `benchmark_study/benchmark_study.R`, `hyperparam_benchmark_study/hyperparam_benchmark_study_max_depth_root.R`, `hyperparam_benchmark_study/hyperparam_benchmark_study_num_cand_trees.R`, `hyperparam_benchmark_study/hyperparam_benchmark_study_prop_var_root.R`,
`simulation_study/simulation_study_design_1.R`, and `simulation_study/simulation_study_design_2.R` perform the computationally intensive analyses using parallel computing, producing the respective intermediate results.

  These R scripts use the R packages `parallel` and `doParallel` for parallelization. However, it is also possible to use other parallelization techniques or even sequential computation to reproduce the intermediate results. This is because we use a different seed  for each line in the `scenariogrid` data frames created by the above-mentioned R scripts. Each line in these data frames corresponds to one replication in the respective analysis (see the corresponding scripts for details). Using a different seed for each replication makes reproduction possible independent of the specific type of parallelization. To use a different type of parallelization or to use sequential computation, the respective R scripts need to be changed accordingly.
