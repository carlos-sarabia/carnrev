### In this section I explain how we compared cytochrome-B and mitochondrial phylogenetic distances for Sarabia et al (2024) Trophic niche overlap decreases in related mesocarnivore species
#### Sources are: 
#### 1) Table 2 in Geffen et al. (1996) "Size, Life-History Traits, and Social Organization in the Canidae: A Reevaluation" 
#### 2) Supplementary tables in Hassanin et al. (2021) "Evolutionary history of Carnivora (Mammalia, Laurasiatheria) inferred from mitochondrial genomes"

We extracted Table 2 from Geffen et al (1996) and tables from the supplementary material of Hassanin et al. (2021) and have all carnivore species in the format `Genus_species` along with their genetic distances. 

```html
words=("Urocyon_cinereoargenteus" "Nyctereutes_procyonoides" "Otocyon_megalotis" "Vulpes_zerda" "Vulpes_vulpes" "Vulpes_lagopus" "Speothos_venaticus" "Chrysocyon_brachyurus" "Lycaon_pictus" "Canis_latrans" "Canis_aureus" "Lupulella_mesomelas" "Cuon_alpinus" "Lupulella_adusta")
for ((i=0; i<${#words[@]}; i++)); do
word1="${words[i]}"
grep $word1 1995_Geffen.comps.comp.txt
done
```




