#Junwei Wang
#Assignment 1 Introduction to R
##1
x<-(1:5) # define x from 1 to 5
x+1 #add 1 to each element
##2
set.seed(42)
exp <- rnorm(100, 1.1, .1)
set.seed(42)
con <- rnorm(100, 1, .1)
sd1<-sd(exp) #SD of experimental data
sd2<-sd(con) #SD of control data
sd.pooled<-sqrt(0.5*(sd1^2+sd2^2)) # calculate sd pooled
d<-((mean(exp)-mean(con))/sd.pooled) #calculate d

##3
data<-seq(0,200, by=0.5) #define "data" from 0 and to 200 in increments of 0.5 
set.seed(42)
dat.sample<- sample(data,50, replace=FALSE) #define dat.sample
min(dat.sample) # minimum
quantile(dat.sample,0.25) # first quantile
median(dat.sample) #median
quantile(dat.sample,0.75) # third quantile
max(dat.sample) #maximum

### check out ?summary()

##4
a. ### watch out for these; you can always make a comment to avoid errors
set.seed(42)
score<-rnorm(200,80,20)# Create a score dataset
score.replace<-replace(score,score>100,100) #replace any number over 100 with 100
b.
sort.score.replace<-sort(score.replace,decreasing = TRUE )# sort the score from highest to lowest
200/3 #number of people in the top third of the class
average.top.third<-mean(sort.score.replace[1:67]) #average of the top third
sd.top.third<-sd(sort.score.replace[1:67]) #sd of the top third

### I encourage a relative way to code these

### Last part with replacing the letters?
### -1