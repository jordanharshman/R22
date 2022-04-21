# Yousif Muten
# Assignment 1 Introduction to R

# Question (1) 1.2 --------------------------------------------------------------


x<-c(1:5)+1 # creat a vector contain elements and add 1 to each element

### do not need c() in this case; 1:5 works just fine

print(x) # print the vector's values resulting from the previous command

# Question (2) 1.3 ------------------------------------------------------------


set.seed(42) #set the starting number  to get the same data
exp<-rnorm(100, 1.1, .1) # stimulate group that follow normal distribution 
set.seed(42) # set the starting number to get the same data
con<-rnorm(100, 1, .1) ## stimulate group that follow normal distribution 
mean(exp)# calculate the mean of exp
sd(exp) # calculate the sd of exp
mean(con) # calculate the mean of con
sd(con) # calculate the sd of con
SDpooled <- sqrt((sd(exp)^2+sd(con)^2)/2) # manually calculating the SDpooled
print(SDpooled) # print
d<-((mean(exp)-mean(con))/SDpooled) # manually calculating the cohen's d

# Question (3) 1.5 --------------------------------------------------------


data<-c(seq(0,200, by=0.5)) # create an object 0:200 in increments of .5
set.seed(42) # set the starting number
dat.sample<-sample(data, 50) # take and assign a random number of 50 points without replacement to an object called dat.sample
summary(dat.sample) # to compute summary statistics of the data from the object


# Question (4) 1.8 --------------------------------------------------------


set.seed(42) #set the starting number to get the same data
dataset<-rnorm(200, 80, 20) # sti,ulate a dataset contains 200 students with a mean of 80, and sd of 20
dataset<-replace(dataset, dataset>100, 100) # replace any value over 100 with 100
table(dataset>100) # to confirm than there are no data larger than  100
quantile(dataset, probs = seq(0, 1 , 1/3)) # to find the third top 

mean(dataset[dataset>=quantile(dataset, 0.6666667, na.rm = T)], na.rm=T) # to calculate the mean using the third top quantile from 0.6666667-1 which correspond to the top third
sd(dataset[dataset>=quantile(dataset, 0.6666667, na.rm = T)], na.rm=T) # to calclate the sd using the third top quantile from 0.6666667-1 which correspond to the top third

### I would look for cleaner way to run things, but if it works it works

dataset_scores<-c(dataset)# create new vector as a second version of the previous vector but different name 
dataset_grade<-c(case_when(dataset_scores >= 90 ~ 'A', dataset_scores >=80 ~ 'B', dataset_scores >=70 ~ 'C', dataset_scores >= 60 ~ 'D',  dataset_scores <60 ~ 'F'))# use case_when()on the vector and use multiple cases using the following value

### you are using a function from dplyr, but did not library it in your script.
### Make sure that you have the library in your script or you will not be able to reproduce.

df<-data.frame(dataset_scores, dataset_grade)# create dataframe to bin scores to grade (cut function was not easy to use and do not have grade packages
table(dataset_grade) # count each grade in the vector

