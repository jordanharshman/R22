# #1 ------------
x <- c(1,2,3,4,5) #Defined an object x as a numeric vector containing 5 elements 1-5
x + 1 #Add 1 to each element and print the results

# #2 ----------------------------------------------------------------------
set.seed(42)
exp <- rnorm(100, 1.1, .1) # experimental
set.seed(42)
con <- rnorm(100, 1, .1) # control
mean.exp <- mean(exp) #calculate the mean of our experimental group
mean.con <- mean(con) #calculate the mean of our control group
sd.exp <- sd(exp) #calculate the sd of our experimental group
sd.con <- sd(con) #calculate the sd of our control group
sdpool <- sqrt((sd.exp^2 + sd.con^2)/2) #calculate the pooled sd
Cohensd <- ((mean.exp-mean.con/sdpool)) #calculate Cohen's d

### You have an order of operations issue here that leads to a different result:
### ((mean.exp-mean.con/sdpool)) will do:
### mean.exp - (mean.con/sdpool)
### you needed:
### (mean.exp - mean.con) / sdpool
### -1

# #3a ----------------------------------------------------------------------
data <- seq(0, 200, by =0.5) #creates our sequence from 0-200
set.seed(42) #setting the seed as instructed
dat.sample <- sample(data, 50, replace = FALSE) #taking our sample from the var data without replacement
fivenum(dat.sample) # calculating our 5 number summary

# #3b ----------------------------------------------------------------------
set.seed(42) # setting the seed as instructed
dataset <- rnorm(200, mean = 80, sd = 20) # creating our initial sample with mean 80 and sd 20
dataset[dataset > 100] <- 100 # replacing all values greater than 100 with 100
sorteddataset <- sort(dataset) #sorting data from highest to lowest
a <- length(dataset) - (length(dataset)/3) 
top3rd <- sorteddataset[a:length(dataset)] #creating top 1/3rd of data set
mean(top3rd) #mean of top 1/3
sd(top3rd) #sd of top 1/3

# #3c ----------------------------------------------------------------------
A<-dataset[dataset>=90]
length(A) #How many students scored above 90%
B.1<-dataset[dataset>=80] # all values greater that or equal to 80
B<-B.1[B.1<90] #adds all values less than 90
length(B) #how many students got a B
C.1<-dataset[dataset>=70] # all values greater than or equal to 70
C<-C.1[C.1<80] #adds all values less than 80
length(C) # how many students got a C
D.1<-dataset[dataset>=60] #adds all values greater than or equal to 60
D<-D.1[D.1<70] #adds all values less than 70
length(D) #how many students got a D
F.1<-dataset[dataset>=0] #adds all values greater than 0
F<-F.1[F.1<60] #adds all values less than 60
length(F) #how many students got an F
length(A)+length(B)+length(C)+length(D)+length(F) # Check to ensure our 200 scores are all present

### good checks!