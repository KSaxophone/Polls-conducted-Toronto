## SIMULATE DATA ##
# The purpose of this script is to simulate testing data for the model
# The conclusion of this simulation indicates that testing is consistent with 
# the training in the main report

# Divide data into training and testing
set.seed(653)

n <- nrow(polls_clean)

# Choose 70% as training
training_data <- sample(1:n, size=round(0.7*n))
polls_clean <- polls_clean %>% rowid_to_column()

train <- polls_clean %>% filter(rowid %in% training_data)

# Choose 30% as testing
test <- polls_clean %>% filter(!(rowid %in% training_data))
```

# Start model (testing)
model_start <- lm(PASS_RATE ~ BALLOTS_IN_FAVOUR+BALLOTS_NEEDED_TO_PROCEED+BALLOTS_OPPOSED+BALLOTS_RECEIVED_BY_VOTERS+BALLOTS_SPOILED+FINAL_VOTER_COUNT+MISSING, data=test)
## No ballots blank, potential voter, poll result, returned to sender(high correlation), application type (large differences)
# Multicollinearity
vif(model_start)
```


# Selection
summary(model_start)
## Auto
model_auto_reduced <- step(model_start, direction="both")
## Manual
model_manual_reduced <- lm(PASS_RATE ~ BALLOTS_NEEDED_TO_PROCEED + BALLOTS_RECEIVED_BY_VOTERS + FINAL_VOTER_COUNT + MISSING, data=test)
```


# ANOVA Partial F-test
anova(model_auto_reduced, model_start)
anova(model_manual_reduced, model_start)
```


# Adj R^2
summary(model_start)$adj.r.squared
summary(model_auto_reduced)$adj.r.squared
summary(model_manual_reduced)$adj.r.squared
```


# AIC
AIC(model_auto_reduced)
AIC(model_manual_reduced)
AIC(model_start)
```

`fig.cap="Goodness of Model"
# assumption checking graphs
par(mfrow = c(2,2))
plot(model_auto_reduced)
```
