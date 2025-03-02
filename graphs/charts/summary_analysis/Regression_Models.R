### exploration and models for 2017 data.

source("~/Lab2/Trade_Union_Global_Analysis/summary_analysis/Enviroment_Setup.R")
# Calculate the correlation between National Compliance with Labour Rights and Collective Bargaining Coverage for 2017 data, excluding missing values
joined_data2017 %>%
  select(National_Compliance_wth_Labour_Rights, `Collective Bargaining Coverage`) %>%
  cor(use = "complete.obs")

# Create a scatter plot for 2017 data showing the relationship between National Compliance with Labour Rights and Collective Bargaining Coverage
ggplot(joined_data2017, aes(x = National_Compliance_wth_Labour_Rights, y = `Collective Bargaining Coverage`)) +
  geom_point() +
  theme_minimal() +
  labs(x = "National_Compliance_wth_Labour_Rights", y = "Collective Bargaining Coverage", title = "Scatter Plot between National_Compliance_wth_Labour_Rights and Collective Bargaining Coverage")

# Linear regression model for 2017 data to predict Collective Bargaining Coverage based on National Compliance with Labour Rights
model <- lm(`Collective Bargaining Coverage` ~ National_Compliance_wth_Labour_Rights, data = joined_data2017)
summary(model)




### Full data set exploration and Models

# Calculate the correlation between National Compliance with Labour Rights and Collective Bargaining Coverage for the full data set, excluding missing values
joined_full_data_set %>%
  select(National_Compliance_wth_Labour_Rights, `Collective Bargaining Coverage`) %>%
  cor(use = "complete.obs")

# Create a scatter plot for the full data set showing the relationship between National Compliance with Labour Rights and Collective Bargaining Coverage
ggplot(joined_full_data_set, aes(x = National_Compliance_wth_Labour_Rights, y = `Collective Bargaining Coverage`)) +
  geom_point() +
  theme_minimal() +
  labs(x = "National_Compliance_wth_Labour_Rights", y = "Collective Bargaining Coverage", title = "Scatter Plot between National_Compliance_wth_Labour_Rights and Collective Bargaining Coverage")

# Linear regression model for the full data set to predict Collective Bargaining Coverage based on National Compliance with Labour Rights
model2 <- lm(`Collective Bargaining Coverage` ~ National_Compliance_wth_Labour_Rights, data = joined_full_data_set)
summary(model2)

# Calculate the correlation among National Compliance with Labour Rights, Collective Bargaining Coverage, and Union Density for the full data set
joined_full_data_set %>%
  select(National_Compliance_wth_Labour_Rights, `Collective Bargaining Coverage`, `Union Density`) %>%
  cor(use = "complete.obs")

# Multiple linear regression model for the full data set to predict Collective Bargaining Coverage based on National Compliance with Labour Rights and Union Density
model3 <- lm(`Collective Bargaining Coverage` ~ National_Compliance_wth_Labour_Rights + `Union Density`, data = joined_full_data_set)
summary(model3)

# Generate a pairs plot (ggpairs) for the full data set to visualize the pairwise relationships and distributions of National Compliance with Labour Rights, Collective Bargaining Coverage, and Union Density
ggpairs(joined_full_data_set,
  columns = c("National_Compliance_wth_Labour_Rights", "Collective Bargaining Coverage", "Union Density"),
  diag = list(continuous = "densityDiag")
)

# Multiple linear regression model with National Compliance with Labour Rights as the dependent variable, predicting it based on Collective Bargaining Coverage and Union Density in the full data set
model_National_Compliance_wth_Labour_Rights <- lm(National_Compliance_wth_Labour_Rights ~ `Collective Bargaining Coverage` + `Union Density`, data = joined_full_data_set)

# Summary of the regression model for National Compliance with Labour Rights
summary(model_National_Compliance_wth_Labour_Rights)




# Residuals vs Fitted Plot for Model2
plot(model2, which = 1)

# Residuals vs Fitted Plot for Model3
plot(model3, which = 1)

# Residuals vs Fitted Plot for model_National_Compliance_wth_Labour_Rights
plot(model_National_Compliance_wth_Labour_Rights, which = 1)




# Histogram of Residuals
hist(residuals(model2), main = "Histogram of Residuals for Model2")
hist(residuals(model3), main = "Histogram of Residuals for Model3")
hist(residuals(model_National_Compliance_wth_Labour_Rights), main = "Histogram of Residuals for model_National_Compliance_wth_Labour_Rights")

# QQ Plot
qqnorm(residuals(model2))
qqline(residuals(model2))
qqnorm(residuals(model3))
qqline(residuals(model3))
qqnorm(residuals(model_National_Compliance_wth_Labour_Rights))
qqline(residuals(model_National_Compliance_wth_Labour_Rights))





# Residuals vs Leverage Plot to check for homoscedasticity
plot(model2, which = 5)
plot(model3, which = 5)
plot(model_National_Compliance_wth_Labour_Rights, which = 5)



# Install and load the car package for VIF calculation
install.packages("car")
library(car)

# Calculate VIF
vif(model3)
vif(model_National_Compliance_wth_Labour_Rights)






# Diagnostic Plots for each model
par(mfrow = c(2, 2)) # Arrange plots in a 2x2 grid
plot(model2) # Plots for Model2
plot(model3) # Plots for Model3
plot(model_National_Compliance_wth_Labour_Rights) # Plots for model_National_Compliance_wth_Labour_Rights
