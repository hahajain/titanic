Mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

train <- read.csv("/Users/harshitjain/train.csv",header = TRUE, na.strings=c("",".","NA"))
train$Embarked[is.na(train$Embarked)]<-Mode(train$Embarked)
#train$Sex <- as.integer(train$Sex)
View(train)
#train$Embarked <- as.integer(train$Embarked)
test <- read.csv("/Users/harshitjain/test.csv",header = TRUE, na.strings=c("",".","NA"))
#test$Sex <- as.integer(test$Sex)
#test$Embarked <- as.integer(test$Embarked)

train_w_age <- subset(train, !(is.na(train$Age)))
train_wo_age <- subset(train, is.na(train$Age))

#scatterplot3d(train$Pclass,train$Survived,train$Age)
#abline(fit)
#aggregate( train$Survived~ train$Pclass, train, sum)

#table(train$Pclass,train$Survived, mean(train$Age))
fit<-lm(Age~Pclass+Survived+SibSp,data= train)
summary(fit)

train_wo_age$Age <- round(predict(fit,train_wo_age))
updated_age<-merge(train_w_age,train_wo_age,all=TRUE)
View(updated_age)

drops <- c("Name", "Ticket", "Cabin", "Passenger Id")
Cleansed_data<- updated_age[,!(names(updated_age) %in% drops)]

Cleansed<-dummy.data.frame(Cleansed_data,sep="_")

View(Cleansed)
