
#### This repository contains GLMM analyses testing the relationship between all relevant variables and the Pianka overlap coefficients.

*Analyses_table.xlsx*: expanded results.csv table with pairwise genetic and mass comparisons and abiotic variables. Categories included:

_spe1, spe2, specat1, specat2, row1, row2_: species, species category and rows from species compared per ecoregion.

_ecoregion_id, ecoregion_name, biome_: ecoregion and biome names and numbers as in Olson et al. 2001.

_phyldist_: mitochondrial DNA-based phylogenetic distances as calculated in phylogenetic_dist section.

_massdiff_: biomass difference between compared species.

_Pianka, Pianka_10_: Pianka's overlap coefficient and its values multiplied by 10.

_NDVI, NDVI_log_: real and log-based values of Normalized Difference Vegetation Index per ecoregion.

_Avg_prec, Avg_prec_log, Stdev_prec, Stdev_prec_log, Avg_elev, Avg_elev_log, Avg_t_min, Avg_t_max, Avg_t_max_log_: Values of average precipitation, standard deviation, average elevation, average minimum and maximum temperature and their log values per ecoregion. 

_Max_carnivores, Avg_carnivores_: Maximum and average carnivore richness per ecoregion.

**Pianka_analyses.R**: GLMM analyses testing the relationship between all relevant variables from Analyses_table.xlsx.
