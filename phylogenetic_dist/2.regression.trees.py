# This python script extracts the data from table `table_comp.cytb.mito.csv`, from step `1.cytb_v_mito.Geffen_1995.Hassanin_2021.md`

import numpy as np
import pandas as pd
from sklearn.svm import SVR
from sklearn.tree import DecisionTreeRegressor
from sklearn.ensemble import RandomForestRegressor
from sklearn.ensemble import AdaBoostRegressor
from sklearn.gaussian_process import GaussianProcessRegressor
from sklearn.gaussian_process.kernels import RBF


# Read the file using pandas
data = pd.read_csv('table_comp.cytb.mito.csv', delimiter='\t', usecols=[2, 3])

# Convert the extracted columns to a NumPy array
data_array = data.to_numpy()
# Split the data into input (X) and output (y) variables
X = data_array[:, 0].reshape(-1, 1)  # Assuming the first column is the input variable
y = data_array[:, 1]  # Assuming the second column is the output variable

#############################################################################
# Create an SVR model
modelsvr = SVR(kernel='rbf')  # You can adjust the kernel and other parameters
# Fit the model to the data
modelsvr.fit(X, y)

# Create a Decision Tree Regression model
modeldtr = DecisionTreeRegressor()
# Fit the model to the data
modeldtr.fit(X, y)

# Create a Random Forest Regression model
modelrtr = RandomForestRegressor()
# Fit the model to the data
modelrtr.fit(X, y)

# Create a Random Forest Regression model
modelabr = AdaBoostRegressor()
# Fit the model to the data
modelabr.fit(X, y)

# Create a Gaussian Process Regression model with an RBF kernel
kernel = RBF()
modelgpr = GaussianProcessRegressor(kernel=kernel)
modelgpr.fit(X, y)

#############################################################################
# Obtain the R-squared (R2) score of the model
r2_score = modelsvr.score(X, y)
# Print the R2 score
print("SVR R2 Score:", r2_score)

# Obtain the R-squared (R2) score of the model
r2_score = modeldtr.score(X, y)
# Print the R2 score
print("Decision Tree Regressor R2 Score:", r2_score)

# Obtain the R-squared (R2) score of the model
r2_score = modelrtr.score(X, y)
# Print the R2 score
print("Random Forest Tree R2 Score:", r2_score)

# Obtain the R-squared (R2) score of the model
r2_score = modelabr.score(X, y)
# Print the R2 score
print("Ada Boost Regressor R2 Score:", r2_score)

# Obtain the R-squared (R2) score of the model
r2_score = modelgpr.score(X, y)
# Print the R2 score
print("Gaussian Process Regressor R2 Score:", r2_score)
