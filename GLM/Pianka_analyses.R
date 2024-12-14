rm(list=ls())

library(readxl)
library(dplyr)
library(corrplot) ## for correlation
library(MuMIn) ## for AICc
library(performance) ## collinearity check
library(effects) ## for partial effects plots
library(lattice) ## for model diagnosis
library(DHARMa) ## for model diagnosis
library(LMERConvenienceFunctions) ## for model diagnosis
library(psych) ## for table summary statistics


##### Data #####
setwd("/path/to/repository") #We put the path of the folder in which we are going to work
data <- read_excel("Analysis_table.xlsx")

# Variables to standardize
vars_to_standardize <- c("NDVI", "massdiff", "phyldist", "Avg_prec", "Stdev_prec", "Avg_elev", "Avg_t_min", "Avg_t_max", "Avg_carnivores")

# Standardize selected variables
standardized_data <- data %>%
  mutate(across(all_of(vars_to_standardize), scale))

#Before making the models we look at correlation
variables_interest <- standardized_data[, c("Pianka", "phyldist", "massdiff", "NDVI", "Avg_prec", "Avg_elev", "Avg_t_max", "Avg_t_min",
                                            "Avg_carnivores")]
# Calculate the correlation matrix
correlation_matrix <- cor(interest_variables)
print(correlation_matrix) #Correlation between NDVI and avg_prec. avg_t_min and avg_t_max. Max_carnivores and avg_carnivores
corplot(correlation_matrix, method = "color")


# Create a vector of names corresponding to biome values
biome_names <- c("Mediterranean", "Temperate Europe", "East Africa", "Kalahari", "Temperate Asia", "Tropical Asia", "Mediterranean north America", "Temperate north America", "Deserts", " South African grasslands")

# Assign names corresponding to biome values
standardized_data$biome_name <- biome_names[standardized_data$biome]

# Check the first records to make sure the new column was created correctly
head(standard_data)
#

##### MODELS ####
## we load contrast tables shared with those of other statistical programs (such as SPSS, STATISTICA)
options(contrasts=c(factor="contr.sum", ordered="contr.poly"))
control.lmer <- lmerControl(check.conv.grad=.makeCC(action ="ignore", tol=1e-6, relTol=NULL), optimizer="bobyqa", optCtrl=list(maxfun=100000))

#We transform the variable
standardized_data$Pianka <- log(standardized_data$Pianka / (1 - standardized_data$Pianka))

model.null <- lmer(Pianka ~ 1+ (1|ecoregion_name), data = standardized_data, control=control.lmer, REML=FALSE)
model.1 <- lmer(Pianka ~ phyldist+massdiff+NDVI+ (1|ecoregion_name), data = standardized_data, control=control.lmer, REML=FALSE)
model.1.1 <- lmer(Pianka ~ phyldist + massdiff + NDVI + (1|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.2 <- lmer(Pianka ~ phyldist + massdiff + NDVI + (phyldist|ecoregion_name) +
 (massdiff|ecoregion_name) + (NDVI|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)
model.2.1 <- lmer(Pianka ~ phyldist + massdiff + NDVI + (phyldist|ecoregion_name) +
 (massdiff|ecoregion_name) + (NDVI|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.3 <- lmer(Pianka ~ phyldist + massdiff + NDVI + (phyldist + massdiff + NDVI|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)
summary(model.3)

model.4 <- lmer(Pianka ~ NDVI + (NDVI|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)
model.4.1 <- lmer(Pianka ~ NDVI + (1|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.5 <- lmer(Pianka ~ phyldist + (phyldist|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)
model.5.1 <- lmer(Pianka ~ phyldist + (1|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.6 <- lmer(Pianka ~ massdiff + (massdiff|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.6.1 <- lmer(Pianka ~ massdiff + (1|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.7 <- lmer(Pianka ~ phyldist + massdiff + (phyldist|ecoregion_name) + (massdiff|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.8 <- lmer(Pianka ~ phyldist + NDVI + (phyldist|ecoregion_name) + (NDVI|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.9 <- lmer(Pianka ~ massdiff + NDVI + (massdiff|ecoregion_name) + (NDVI|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.10 <- lmer(Pianka ~ massdiff + Avg_prec + (massdiff|ecoregion_name) + (Avg_prec|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.11 <- lmer(Pianka ~ massdiff + Avg_t_max + (massdiff|ecoregion_name) + (Avg_t_max|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.12 <- lmer(Pianka ~ massdiff + Avg_carnivores + (massdiff|ecoregion_name) + (Avg_carnivores|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.13 <- lmer(Pianka ~ phyldist + Avg_prec + (phyldist|ecoregion_name) + (Avg_prec|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.14 <- lmer(Pianka ~ phyldist + Avg_carnivores + (phyldist|ecoregion_name) + (Avg_carnivores|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.15 <- lmer(Pianka ~ phyldist + Avg_t_max + (phyldist|ecoregion_name) + (Avg_t_max|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.16 <- lmer(Pianka ~ phyldist + Avg_t_min + (phyldist|ecoregion_name) + (Avg_t_min|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.18 <- lmer(Pianka ~ NDVI + Avg_t_max + (NDVI|ecoregion_name) + (Avg_t_max|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.19 <- lmer(Pianka ~ NDVI + Avg_prec + (NDVI|ecoregion_name) + (Avg_prec|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.20 <- lmer(Pianka ~ NDVI + Avg_prec + (NDVI|ecoregion_name) + (Avg_prec|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.21 <- lmer(Pianka ~ phyldist + massdiff + NDVI + Avg_carnivores + (1|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.22 <- lmer(Pianka ~ phyldist + massdiff + NDVI + Avg_carnivores +
 (phyldist|ecoregion_name) + (massdiff|ecoregion_name) +
 (NDVI|ecoregion_name) + (Avg_carnivores|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.23 <- lmer(Pianka ~ phyldist + massdiff + Avg_t_max +
 (phyldist|ecoregion_name) + (massdiff|ecoregion_name) +
 (Avg_t_max|ecoregion_name), REML = FALSE,
 data = standardized_data, control = control.lmer)


model.24 <- lmer(Pianka ~ phyldist + massdiff + Avg_t_max +
 (phyldist|ecoregion_name) + (massdiff|ecoregion_name) +
 (Avg_t_max|ecoregion_name) + (1|ecoregion_name) , REML = FALSE,
 data = standardized_data, control = control.lmer)

model.25 <- lmer(Pianka ~ phyldist + Avg_t_min + (1|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)

model.26 <- lmer(Pianka ~ phyldist + massdiff + NDVI + Avg_t_max + (1|ecoregion_name),
 data = standardized_data, control = control.lmer, REML = FALSE)
 
#################################
AICc_values ​​<- na.omit(AICc(model.null, model.1, model.2, model.3, model.4, model.5, model.6, model.7,
 model.8, model.9, model.10, model.11, model.12, model.13, model.14, model.15,
 model.16, model.18, model.19, model.20, model.21, model.22, model.23,
 model.24, model.25, model.26, model.2.1, model.4.1, model.5.1, model.6.1))
AICc_values
Weights(AICc_values) #model.3

model <- model.3
#
###### Exploration of the chosen model ######
model <- update(model, REML=TRUE)

check_collinearity(model)
model@call; formula (model)
model@frame
hist(residuals(model), density=5, freq=FALSE, main="model residuals", ylim=c(0,0.3))
curve(dnorm(x, mean=mean(residuals(model)), sd=sd(residuals(model))), col="red", lwd=2, add=TRUE, yaxt="n")
qqnorm(residuals(model), main="model residuals")
qqline(residuals(model), col="red", lwd=2)
## Shapiro test of normality of residuals
shapiro.test(residuals(model)) ## lmer model
## for plots identifying values ​​with extreme residuals, we put in id the proportion of extreme residuals
qqmath(model, id=0.05) ## for lmer models
qqmath(residuals(model), id=0.05)
outliers.cook <- check_outliers(model, method="cook")
plot(outliers.cook)
## residual heteroscedasticity
## with lmer
plot(fitted(model), residuals(model), xlab="predicted values", ylab="residuals", main="IS THERE HETEROCEDASTICITY?")
abline(h=0, lty=2, lwd=2, col="red")
lines(smooth.spline(fitted(model), residuals(model), spar=0.95), col="blue")
##
## another more direct way
plot(model)
## another synthetic possibility for the revision of lmer models is:
mcp.fnc(model)
## with lmer models it is possible to carry out a diagnosis of the residues using DHARMa residues standardized at 0-1
## normality, heteroscedasticity of residuals and existence of outliers
testUniformity(model)
testQuantiles(model)
testOutliers(model)

## Synthetically ##
residuals.lmer <- simulateResiduals(model)
plot(residues.lmer)
testResiduals(residuals.lmer)
## we value the correspondence between classical residues and those of DHARMA
plot(residuals.lmer$scaledResiduals, residuals(model))
plot(rank(fitted(model))/dim(model@frame)[1], residuals.lmer$scaledResiduals,
 ylab="DHARMa residuals", xlab="range-transformed predictions", main="IS THERE HETEROCEDASTICITY?")
#

###### r2 model #####

## HOW MUCH DOES THE MODEL EXPLAIN?
## OBSERVED AND PREDICTED VALUES
## with lmer models
predicted <- fitted(model)
plot(model@frame[,1] ~ predicted, ylab="RESPONSE", xlab="PREDICTIONS")
abline(lm(model@frame[,1] ~ predicted), col="green", lwd=2)
r2_efron(model)
## approximation to pseudo-R2
pred_response_model <- predict(model, type="response")
plot(pred_response_model, get.response(model), ylab="ORIGINAL RESPONSE", xlab="PREDICTED RESPONSE")
pseudoR2_model <- cor(pred_response_model, get.response(model))^2
print(c("pseudo-R2 =", round(pseudoR2_model, 3)), quote=F)

##
## VARIANCE PARTITION
## R2m: marginal R2 (the proportion of variance explained by the fixed factor(s) alone)
## R2c: conditional R2 (the proportion of variance explained by both the fixed and random factors; i.e. the entire model)
## consult: https://jonlefcheck.net/2013/03/13/r2-for-linear-mixed-effects-models/comment-page-1/
## http://onlinelibrary.wiley.com/doi/10.1111/j.2041-210x.2012.00261.x/epdf
## http://onlinelibrary.wiley.com/doi/10.1111/2041-210X.12225/epdf
r.squaredGLMM(model) ## lmer model

## PARTITION OF THE VARIATION IN THE RESPONSE BETWEEN FIXED EFFECTS with lmer
## synthetic table of results with partitioning of response variability (and magnitudes of partial effects)
## using Kenward-Roger degrees of freedom estimation
## eta2 is the factor of one of the variation in the response explained exclusively by that fixed effect
SStotal <- sum((model@frame[,1]-mean(model@frame[,1]))^2) ## include here? manually the name of the response variable
SSerror <- SStotal*(1-as.numeric(r.squaredGLMM(model)[2]))
table.SS <- as.data.frame(anova(model, ddf="Kenward-Roger", type=3))
eta2 <- table.SS[,1]/SStotal
table.SS <- data.frame(eta2, table.SS)
names(table.SS)[7] <- "Pr.F"
print(table.SS, digits=4)
sharedvar <- (as.numeric(r.squaredGLMM(model)[1])-sum(table.SS$eta2))
print(c("proportion of variance attributable to fixed effects =", round(as.numeric(r.squaredGLMM(model)[1]), 4)), quote=FALSE)
print(c("proportion of variance shared by fixed effects =", round(sharedvar, 4)), quote=FALSE)
#

##### Model-based (Semi-)Parametric Bootstrap for Mixed Models; for lmer models #####
## type= can it be "parametric" ? "semiparametric"
## confidence intervals with finite-size corrections (important when the number of groups is <50)
##
mcmc.fixed <- bootMer(model, FUN=fixef, nsim=1000, type="parametric", seed=1)
coef.mcmc.fixed <- as.data.frame(mcmc.fixed$t)
## summary with coefficients of the model of interest (original), the average of the bootstrap coefficients (bootMed),
## your standard error (bootSE) and bias (bootBias)
summary(mcmc.fixed)
## results table with quantiles
table.mixedmodel.simulated <- describe(coef.mcmc.fixed, quant=c(0.025, 0.975, 0.005, 0.995))[,c(1:4, 14:17)]
colnames(table.mixedmodel.simulated)[4] <- "std_error"
table.mixedmodel.simulated$coefficient.model <- round(fixef(model), 5)
table.mixedmodel.simulated$std_error.model <- round(summary(model, ddf="Kenward-Roger")$coefficients[,2], 5)
table.mixedmodel.simulated$P.model <- round(summary(model, ddf="Kenward-Roger")$coefficients[,5], 5)
## compare the coefficients obtained by bootstrapping (in mean) with the original ones of the model (coefficient.model)
## if the kurtosis and bias values ​​are not close to zero, this is indicative of the existence of extreme values ​​(influential, missing, ...)
## we will use the confidence intervals derived from quantiles (95%: Q0.025 and Q0.975; 99%: Q0.005 and Q0.995)
## that do not include the value "zero"
print(table.mixedmodel.simulated, digits=3)
## Assessment of the degree of correlation between the model coefficients; the values ​​of r obtained should be close to "zero"
cor(coef.mcmc.fixed)








