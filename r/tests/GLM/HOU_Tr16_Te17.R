library(dyplyr)
library(data.table)
library(lattice)
library(ggplot2)


#set working directory
setwd("~/nbamodel/NBA_Model_GitR/tests/GLM/AdvGls/HOU")

# fast read training data
NBA_train <- read.csv("HOU1617GL.csv")
str(NBA_train)
summary(NBA_train)
data.table(NBA_train)
NBA_train <- NBA_train %>%
  mutate(Wins = as.factor(Wins),
         Opp = as.factor(Opp))%>%
  select(Wins, Opp, Home, Pace, eFGP, TOVP,	ORBP,	FT_FGA, OppFT_FGA)
  head(NBA_train)
  table(NBA_train$Wins)
  table(NBA_train$Opp)

# GLM fit
library(arm)

#fit <- bayesglm(Wins ~ ., data = NBA_train , family = binomial(link="logit"))
#display(fit)
fit <- glm(Wins ~ ., family = binomial(link="logit") ,data = NBA_train )


library(rpart)
rparty<-rpart(Wins ~ ., data = NBA_train,method="class")
print(rparty)
library(partykit)
plot(as.party(rparty))


#Evaluate
library(caret)
confusionMatrix(NBA_train$Wins,predict(rparty,NBA_train, type = "class"))
# Confusion Matrix and Statistics Results
# 
# Reference
# Prediction  0  1
# 0 60  8
# 1 14 82
# 
# Accuracy : 0.8659        
# 95% CI : (0.804, 0.914)
# No Information Rate : 0.5488        
# P-Value [Acc > NIR] : <2e-16        
# 
# Kappa : 0.7272        
# Mcnemar's Test P-Value : 0.2864        
# 
# Sensitivity : 0.8108        
# Specificity : 0.9111        
# Pos Pred Value : 0.8824        
# Neg Pred Value : 0.8542        
# Prevalence : 0.4512        
# Detection Rate : 0.3659        
# Detection Prevalence : 0.4146        
# Balanced Accuracy : 0.8610        
# 
# 'Positive' Class : 0         
require(caret)



## TEST
NBA_test <- read.csv("HOU2017GL.csv")

NBA_test <- NBA_test %>%
mutate(Wins = as.factor(Wins),
Opp = as.factor(Opp)) %>%
select(Wins, Opp, Home, Pace,eFGP, TOVP ,	ORBP ,	FT_FGA , OppFT_FGA)

predict<-predict(rparty,NBA_test,type = "class")
confusionMatrix(NBA_test$Wins,predict(rparty,NBA_test,type = "class"))


testUpc <- testUpc %>%
  mutate(Wins = as.factor(Wins),
         Opp = as.factor(Opp))%>%
  select(Opp, OppFT_FGA)

predict<-predict(fit,testUpc,type = "class")
summary(predict)


