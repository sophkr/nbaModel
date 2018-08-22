library(dplyr)
library(data.table)
library(lattice)
library(ggplot2)


#set working directory
setwd("~/nbamodel/NBA_Model_GitR/data/AdvGls/HOU")

# fast read training data
NBA_train <- read.csv("HOU1516GL.csv")
str(NBA_train)
summary(NBA_train)
data.table(NBA_train)
NBA_train <- NBA_train %>%
  mutate(Wins = as.factor(Wins),
         Opp = as.factor(Opp))%>%
  select(Wins, Opp, Pace, eFGP, TOVP,	ORBP,	FT_FGA, OppFT_FGA)
  head(NBA_train)
  table(NBA_train$Wins)
  table(NBA_train$Opp)

# GLM fit
library(arm)

#fit <- bayesglm(Wins ~ ., data = NBA_train , family = binomial(link="logit"))
#display(fit)
fit <- glm(Wins ~ ., family = binomial(link="logit") ,data = NBA_train )
summary(fit)


library(rpart)
rparty<-rpart(Wins ~ ., data = NBA_train,method="class")
print(rparty)
library(partykit)
plot(as.party(rparty))
summary(rparty)


#Evaluate
library(caret)
confusionMatrix(NBA_train$Wins,predict(rparty,NBA_train, type = "class"))
              

require(caret)

## TEST
NBA_test <- read.csv("HOU2017GL.csv")
library(dplyr)
data.table(NBA_test)
NBA_test <- NBA_test %>%
  mutate(Wins = as.factor(Wins),
        Opp = as.factor(Opp)) %>%
  select(Wins, Opp, Pace, eFGP, TOVP,	ORBP,	FT_FGA, OppFT_FGA)
predict<-predict(rparty,NBA_test,type = "class")
confusionMatrix(NBA_test$Wins,predict(rparty,NBA_test,type = "class"))


prob=predict(fit,type=c("response"))    
install.packages("ROCR")
library("ROCR")    
pred <- prediction(prob, NBA_test$Wins)    
perf <- performance(pred, measure = "tpr", x.measure = "fpr")     
plot(perf, col=rainbow(7), main="ROC curve Admissions", xlab="Specificity", 
     ylab="Sensitivity")    
abline(0, 1)
