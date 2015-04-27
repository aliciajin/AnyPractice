## Test from DataRobot
## By Yiqian Jin
## yj2342@columbia.edu
## Apr.26
## Topic:Breast Cancer Prediction 


###### input data and seperate into training and testing data
setwd("~/Documents/JOB/test_DataRobot")
rm(list=ls())
Breast<-read.csv('BreastCancer.csv')
Breast<-na.omit(Breast)
test.size=round(0.1*nrow(Breast))
set.seed(12)
test.ind<-sample(seq(1:nrow(Breast)), size=test.size)
testset<-Breast[test.ind, ]
trainset<-Breast[-test.ind, ]

write.table(trainset, "Train.csv", sep=",", row.names = F, col.names=F)
write.table(testset, "Test.csv", sep=",", row.names = F, col.names=F)

###### build API model
library(rjson)
library(bitops)
library(RCurl)
library(googlepredictionapi)

my.model <- PredictionApiTrain(data="gs://breastcan/Train.csv")
summary(my.model)

##### perform prediction

pred_list=c()
for(i in 1:nrow(testset)){
  tmp=predict(my.model, paste(testset[i,-1], collapse = ",")))
  pred_list=c(pred_list, tmp)
}
table(pred_list, testset$Result)


######### Thanks for your consideration #####
