#####################################################################################################
## This program takes an input table of values of dietary items and their frequency of occurrence (Fr)
## and calculates the Pianka overlap coefficient per pair of diets per ecoregion, comparing different 
## types of species (1: medium-sized canids, 2: small-sized felids, 3: foxes of the Vulpini tribe, 4:
## mustelids and herpestids). 

## Input file: https://github.com/cdomsar/Pianka/blob/main/pianka-reduced.csv
## Output file: https://github.com/cdomsar/Pianka/blob/main/results.csv
#####################################################################################################

import math
import pandas as pd

# Float numeric cols <s
COEF_COLS = ['WU', 'MUWM', 'CARN', 'DOM', 'HARE', 'SM', 'BIRD', 'REPT', 'FISH', 'ARTHR', 'PLANTS', 'OTHER', 'WASTE']


def process():
    # read file
    df = pd.read_csv('files/pianka-210811-reduced.csv', sep='|', encoding='utf-8')
    cleaned(df)
    compute(df)


def cleaned(df):
    # Replace nan with 0 in Ecoregion field and transform to integer values 
    df.Ecoregion = df.Ecoregion.fillna(0)
    df.Ecoregion = df.Ecoregion.astype(int)
    # Replace in BIOME col Sahel by its numeric value and transform to integer
    df.BIOME = df.BIOME.str.replace('Sahel', '11')
    df.BIOME = df.BIOME.astype(int)
    df.fillna(0)
    # In each col in COEF_COLS replace comma by dot and convert to float
    for col in COEF_COLS:
        df[col] = df[col].str.replace(',', '.')
        df[col] = df[col].astype(float)
        df[col] = df[col].fillna(0)


def compute(df):
    res = pd.DataFrame()
    # Split the dataframe into groups. Each group shares the same ecoregion.We will iterate over all groups, called by name (for instance 11, 2, ...) 
    for name, group in df.groupby(by=['Ecoregion']):
        combination_indexes = [] # stores valid row combinations 
        results = {'rows': [], 'type_of_species': [], 'pianka': [], 'species': []}    
        indexes = [ix for ix, _ in group.iterrows()] # we store all the indexes (row number of the original dataframe)
        if len(indexes) > 1: # inly for rows with more than a row (inside each group)
            for i in range(len(indexes)):
                for j in range(i+1, len(indexes)):
                    # potencial combination index 
                    ix_i = indexes[i] 
                    ix_j = indexes[j]
                    if group.loc[ix_i]['Type_of_Species'] != group.loc[ix_j]['Type_of_Species']: # the condition to create a right combination
                        # Compute formula
                        ab = sum((group.loc[ix_i][COEF_COLS]/100.) * group.loc[ix_j][COEF_COLS]/100.) 
                        sqa = sum((group.loc[ix_i][COEF_COLS]/100.)**2)
                        sqb = sum((group.loc[ix_j][COEF_COLS]/100.)**2)
                        pianka = ab / math.sqrt(sqa*sqb)
                        # store the results
                        results['rows'].append((ix_i, ix_j))
                        results['type_of_species'].append((group.loc[ix_i]['Type_of_Species'], group.loc[ix_j]['Type_of_Species']))
                        results['pianka'].append(pianka)
                        results['species'].append((group.loc[ix_i]['Species'], group.loc[ix_j]['Species']))
                        # results['biome'].append(group['BIOME'])
            # Transform resulsts dictionary in a pandas dataframe
            df_res = pd.DataFrame(results)
            df_res['Ecoregion'] = name
            df_res['biome'] = group['BIOME'].unique()[0]
            # concat each group in a final dataframe 
            res = pd.concat([res, df_res], ignore_index=True)
    res = res.sort_values(by=['biome'])
    print(res)
    res.to_csv('results.csv', index=False, sep='|')   
    

if __name__ == '__main__':
    process()
