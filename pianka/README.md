#### This repository contains calculations of Pianka's niche overlap coefficients between the diets of various carnivore species. Files included:

**pianka-reduced.csv** - A table including data from all studies included in this review. 

_Paper:_ source publication.

_Ecoregion, BIOME:_ ecoregion and biome of the diet (according to Olson et al. 2001; doi: 10.1641/0006-3568(2001)051[0933:TEOTWA]2.0.CO;2)

_Type_of_Species:_ species category as specified in text (1: Medium-sized canids, 2: Small-sized felids, 3: Foxes of the Vulpini tribe, 4: Mustelids).

_Species:_ species name abbreviation as specified in text (AGW: African golden wolf; AWC: African wildcat; BBJ: Black-backed jackal; BC: Bobcat; BEF: Bat-eared fox; BF: Blanford fox; CF: Cape fox; EUGJ: Eurasian golden jackal; EuL: Eurasian lynx; GF: Gray fox; HB: honey badger; JC: Jungle cat; KF: Kit fox; LC: Leopard cat; Martes: European pine marten; RF: Red fox; SF: Silver fox; WC: Eurasian wildcat)

_Dietary categories_ (WU: Wild ungulates; MUWM: Medium-sized wild mammals (2-30 kg); CARN: other carnivores; DOM: domestic mammals; HARE: lagomorphs; SM: small mammals (rodents and <2kg); BIRD: birds (domestic and wild); REPT: reptiles; FISH: fish and marine/riverine molluscs and crustaceans; ARTHR: Arthropods; PLANTS: Plant material; OTHER: other unidentified organic material; WASTE: waste/inorganic material) and Percentage (total result sum)

**pianka-comp.py** - A python homemade script that takes an input table of values of dietary items and their frequency of occurrence (Fr) and calculates the Pianka overlap coefficient per pair of diets per ecoregion, comparing different types of species.

**results.csv** - The output table of pianka-comp.py, summarizing pairwise comparisons between rows in pianka-reduced.csv. Categories: rows (compared rows); type_of_species (species categories compared), pianka (Pianka's overlap coefficient between diets); species (species compared); Ecoregion, biome (as in Olson et al. 2001)
