library(dplyr)
library(data.table)
library(ggplot2)


setwd("~/nbamodel/AdvGLS/MEM")
# TRAIN
NBA_train <- read.csv("MEM2016GL.csv")
str(NBA_train)
summary(NBA_train)
data.table(NBA_train)
NBA_train <- NBA_train %>%
  mutate(Wins = as.factor(Wins),
         Opp = as.factor(Opp)) %>%
  select(Wins, Opp,Pace, eFGP, TOVP ,	ORBP ,	FT_FGA , OppFT_FGA)
head(NBA_train)
table(NBA_train$Wins)
table(NBA_train$Opp)


# GLM
fit <- glm(Wins ~ ., family = binomial(link="logit"), data= NBA_train)


#Rpart
library(rpart)
rparty<-rpart(Wins ~ ., data = NBA_train,method="class")
print(rparty)
library(partykit)
plot(as.party(rparty))


#Evaluate
library(caret)
confusionMatrix(NBA_train$Wins,predict(rparty,NBA_train,type = "class"))




## TEST
NBA_test <- read.csv("MEM2017GL.csv")

NBA_test <- NBA_test %>%
  mutate(Wins = as.factor(Wins),
         Opp = as.factor(Opp)) %>%
  select(Wins, Opp,Pace,eFGP, TOVP ,	ORBP ,	FT_FGA ,OppFT_FGA)

confusionMatrix(NBA_test$Wins,predict(rparty,NBA_test,type = "class"))
# Confusion Matrix and Statistics Output
# 
# Reference
# Prediction  0  1
# 0 17 22
# 1 12 31
# 
# Accuracy : 0.5854          
# 95% CI : (0.4712, 0.6932)
# No Information Rate : 0.6463          
# P-Value [Acc > NIR] : 0.8970          
# 
# Kappa : 0.1587          
# Mcnemar's Test P-Value : 0.1227          
# 
# Sensitivity : 0.5862          
# Specificity : 0.5849          
# Pos Pred Value : 0.4359          
# Neg Pred Value : 0.7209          
# Prevalence : 0.3537          
# Detection Rate : 0.2073          
# Detection Prevalence : 0.4756          
# Balanced Accuracy : 0.5856          
# 
# 'Positive' Class : 0    


