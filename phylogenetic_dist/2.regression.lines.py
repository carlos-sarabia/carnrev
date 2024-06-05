# This python script extracts the data from table `table_comp.cytb.mito.csv`, from step `1.cytb_v_mito.Geffen_1995.Hassanin_2021.md`

import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.linear_model import Ridge
from sklearn.linear_model import Lasso
from sklearn.linear_model import ElasticNet
from sklearn.preprocessing import PolynomialFeatures
import pandas as pd

# Read the file using pandas
data = pd.read_csv('table_comp.cytb.mito.txt', delimiter='\t', usecols=[2, 3])

# Convert the extracted columns to a NumPy array
data_array = data.to_numpy()
# Split the data into input (X) and output (y) variables
X = data_array[:, 0].reshape(-1, 1)  # Assuming the first column is the input variable
y = data_array[:, 1]  # Assuming the second column is the output variable

# Create polynomial features
degree = 2  # Set the degree of the polynomial
poly_features2 = PolynomialFeatures(degree=degree)
X_poly2 = poly_features2.fit_transform(X)

degree = 3  # Set the degree of the polynomial
poly_features3 = PolynomialFeatures(degree=degree)
X_poly3 = poly_features3.fit_transform(X)

degree = 4  # Set the degree of the polynomial
poly_features4 = PolynomialFeatures(degree=degree)
X_poly4 = poly_features4.fit_transform(X)

#############################################################################
# Create a linear regression model
modelreg = LinearRegression()
# Fit the model to the data
modelreg.fit(X, y)

# Create a Ridge regression model
modelrid = Ridge(alpha=1.0)  # You can adjust the alpha parameter for regularization
# Fit the model to the data
modelrid.fit(X, y)

# Create a Lasso regression model
modellas = Lasso(alpha=1.0)  # You can adjust the alpha parameter for regularization
# Fit the model to the data
modellas.fit(X, y)

# Create an ElasticNet regression model
modelela = ElasticNet(alpha=1.0, l1_ratio=0.5)  # You can adjust the alpha and l1_ratio parameters
# Fit the model to the data
modelela.fit(X, y)

# Create a linear regression model
model2 = LinearRegression()
# Fit the model to the polynomial features
model2.fit(X_poly2, y)

# Create a linear regression model
model3 = LinearRegression()
# Fit the model to the polynomial features
model3.fit(X_poly3, y)

# Create a linear regression model
model4 = LinearRegression()
# Fit the model to the polynomial features
model4.fit(X_poly4, y)

# Apply logarithmic transformation to the output variable
y_log = np.log(y)
# Create a linear regression model
modellog = LinearRegression()
# Fit the model to the transformed data
modellog.fit(X, y_log)

# Apply exponential transformation to the output variable
y_exp = np.log(y)
# Create a linear regression model
modelexp = LinearRegression()
# Fit the model to the transformed data
modelexp.fit(X, y_exp)

# Apply power transformation to the input and output variables
X_power = np.log(X)
y_power = np.log(y)
# Create a linear regression model
modelpow = LinearRegression()
# Fit the model to the transformed data
modelpow.fit(X_power, y_power)

#############################################################################

# Obtain the coefficients and intercept of the linear regression model
coefficients = modelreg.coef_
intercept = modelreg.intercept_
# Obtain the R-squared (R2) score of the model
r2_score = modelreg.score(X, y)
# Print the equation and R2 score
print("Linear Equation: y = {} * x + {}".format(coefficients[0], intercept))
print("R2 Score:", r2_score)

# Obtain the coefficients and intercept of the Ridge regression model
coefficients = modelrid.coef_
intercept = modelrid.intercept_
# Obtain the R-squared (R2) score of the model
r2_score = modelrid.score(X, y)
# Print the equation and R2 score
print("Ridge Equation: y = {} * x + {}".format(coefficients[0], intercept))
print("R2 Score:", r2_score)

# Obtain the coefficients and intercept of the Lasso regression model
coefficients = modellas.coef_
intercept = modellas.intercept_
# Obtain the R-squared (R2) score of the model
r2_score = modellas.score(X, y)
# Print the equation and R2 score
print("Lasso Equation: y = {} * x + {}".format(coefficients[0], intercept))
print("R2 Score:", r2_score)

# Obtain the coefficients and intercept of the ElasticNet regression model
coefficients = modelela.coef_
intercept = modelela.intercept_
# Obtain the R-squared (R2) score of the model
r2_score = modelela.score(X, y)
# Print the equation and R2 score
print("ElasticNet Equation: y = {} * x + {}".format(coefficients[0], intercept))
print("R2 Score:", r2_score)

# Obtain the coefficients and intercept of the polynomial regression model
coefficients = model2.coef_
intercept = model2.intercept_
# Obtain the R-squared (R2) score of the model
r2_score = model2.score(X_poly2, y)
# Print the equation and R2 score
print("Polynomial 2 Equation: y = {} * x^2 + {} * x + {}".format(coefficients[2], coefficients[1], intercept))
print("R2 Score:", r2_score)

# Obtain the coefficients and intercept of the polynomial regression model
coefficients = model3.coef_
intercept = model3.intercept_
# Obtain the R-squared (R2) score of the model
r2_score = model3.score(X_poly3, y)
# Print the equation and R2 score
equation = "y = {} * x^3 + {} * x^2 + {} * x + {}".format(coefficients[3], coefficients[2], coefficients[1], intercept)
print("Polynomial 3 Equation:", equation)
print("R2 Score:", r2_score)

# Obtain the coefficients and intercept of the polynomial regression model
coefficients = model4.coef_
intercept = model4.intercept_
# Obtain the R-squared (R2) score of the model
r2_score = model4.score(X_poly4, y)
# Print the equation and R2 score
equation = "y = {} * x^4 + {} * x^3 + {} * x^2 + {} * x + {}".format(coefficients[4], coefficients[3], coefficients[2], coefficients[1], intercept)
print("Polynomial 4 Equation:", equation)
print("R2 Score:", r2_score)

# Obtain the coefficient and intercept of the logarithmic regression model
coefficient = modellog.coef_[0]
intercept = modellog.intercept_
# Obtain the R-squared (R2) score of the model
r2_score = modellog.score(X, y_log)
# Print the equation of the logarithmic regression model
print("Logarithmic Equation: y = {} * ln(x) + {}".format(coefficient, intercept))
print("R2 Score:", r2_score)

# Obtain the coefficient and intercept of the logarithmic regression model
coefficient = modelexp.coef_[0]
intercept = modelexp.intercept_
# Obtain the R-squared (R2) score of the model
r2_score = modelexp.score(X, y_exp)
# Print the equation of the logarithmic regression model
print("Exponential Equation: y = {} * ln(x) + {}".format(coefficient, intercept))
print("R2 Score:", r2_score)

# Obtain the coefficient and intercept of the power regression model
coefficient = modelpow.coef_[0]
intercept = modelpow.intercept_
# Obtain the R-squared (R2) score of the model
r2_score = modelpow.score(X_power, y_power)
# Print the equation of the power regression model
print("Power Regression Equation: y = exp({} + {} * log(x))".format(intercept, coefficient))
print("R2 Score:", r2_score)
# 
