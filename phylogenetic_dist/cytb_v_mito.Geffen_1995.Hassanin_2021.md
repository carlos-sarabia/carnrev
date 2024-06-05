### In this section I explain how we compared cytochrome-B and mitochondrial phylogenetic distances for Sarabia et al (2024) "Trophic niche overlap decreases in related mesocarnivore species"
#### Sources are: 
#### 1) Table 2 in Geffen et al. (1996) "Size, Life-History Traits, and Social Organization in the Canidae: A Reevaluation" 
#### 2) Supplementary tables in Hassanin et al. (2021) "Evolutionary history of Carnivora (Mammalia, Laurasiatheria) inferred from mitochondrial genomes"

We extracted Table 2 from Geffen et al (1996) and tables from the supplementary material of Hassanin et al. (2021) and have all carnivore species in the format `Genus_species` along with their genetic distances. For example:

 ```
head cytb_mito/1996_Geffen.comps.comp.txt
Urocyon_cinereoargenteus	Nyctereutes_procyonoides	0.179
Urocyon_cinereoargenteus	Otocyon_megalotis	0.181
Urocyon_cinereoargenteus	Vulpes_lagopus	0.214
Urocyon_cinereoargenteus	Vulpes_zerda	0.196
Urocyon_cinereoargenteus	Vulpes_vulpes	0.159
```

We extract carnivore species from this study from each table with a custom-made script:

```
words=("Urocyon_cinereoargenteus" "Nyctereutes_procyonoides" "Otocyon_megalotis" "Vulpes_zerda" "Vulpes_vulpes" "Vulpes_lagopus" "Speothos_venaticus" "Chrysocyon_brachyurus" "Lycaon_pictus" "Canis_latrans" "Canis_aureus" "Lupulella_mesomelas" "Cuon_alpinus" "Lupulella_adusta")
for ((i=0; i<${#words[@]}; i++)); do
word1="${words[i]}"
grep $word1 1996_Geffen.comps.txt > 1996_Geffen.comps.red.txt
grep $word1 2021_Hassanin.comps.txt > grep $word1 2021_Hassanin.comps.red.txt
done

echo -e "carn1\tcarn2\tcytb\tmitogenome" > header

cut -f3 2021_Hassanin.comps.red.txt | paste 1995_Geffen.comps.comp.txt - | cat header - > table_comp.cytb.mito.csv
```
The result:

```
head -5 table_comp.cytb.mito.csv 
carn1	carn2	cytb	mitogenome
Urocyon_cinereoargenteus	Nyctereutes_procyonoides	0.179	0.14569448
Urocyon_cinereoargenteus	Otocyon_megalotis	0.181	0.14570458
Urocyon_cinereoargenteus	Vulpes_lagopus	0.214	0.1440113
Urocyon_cinereoargenteus	Vulpes_zerda	0.196	0.14838754
Urocyon_cinereoargenteus	Vulpes_vulpes	0.159	0.14454992
```




