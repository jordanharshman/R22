# Emily Driessen
# Assignment 1 Introduction to R

#1 ----------------------------------------------------------------------
##I.2 Suppose I wrote 2 lines of code and then said the following: 
##“Here, I defined an object x as a numeric vector that contains 5 numeric elements, the numbers 1 through 5. 
##Then I told R to add 1 to each element and print the result.” What are the two lines of code? 
x<-c(1,2,3,4,5) ##creates vector with a length of 5, with the numbers 1 through 5.

### did you actually add 1 to this?
### -.5

# #2 ----------------------------------------------------------------------
##I.3 Cohen’s d is a metric that computes the effect size in a comparisons test (if you don’t know what I’m talking about, it’s okay). 
##Calculate Cohen’s d in R comparing the two simulated groups below. 
##I would recommend using mean() and sd() to compute means and standard deviations (as opposed to doing them “by hand”). 
##Note: there are functions in other packages that compute Cohen’s d for you, but do not use one of these functions here.

set.seed(42) ##sets the seed at 42, so others can reproduce this "random" dataset
exp <- rnorm(100, 1.1, .1) # experimental, generates dataset
s1<-sd(exp) #calculates sd for experiemntal dataset

set.seed(42) ##sets the seed at 42, so others can reproduce this "random" dataset
con <- rnorm(100, 1, .1) # control, generates dataset
s2<-sd(con)#calculates sd for control dataset

n1 <- length(exp) #finds length of experimental dataset, the number fof elements in this vector
n2 <- length(con) #finds length of control dataset, the number fof elements in this vector

pooled <- sqrt(((n1-1)*s1^2 + (n2-1)*s2^2) / (n1+n1-2)) ##calculates pooled sd
cohend<-(mean(exp)-mean(con))/pooled ##calculates cohen's d
cohend ##prints the value for our cohen's d; 0.96

# #3 ----------------------------------------------------------------------
##Create an object called data and define it as a numeric sequence that starts at 0 and goes to 200 in increments of 0.5 (i.e. 0, 0.5, 1, 1.5... ...199, 199.5, 200). 
##Then, take a random sample of 50 points without replacement (cannot sample the same set of points more than once) and assign it to an object called dat.sample. 
##Set the seed to 42 prior to sampling so we get the same result. 
##Calculate a 5-number summary of dat.sample (minimum, 1st quartile, median, 3rd quartile, and maximum). 
data<-seq(0, 200, by =0.5) ##creates an object called data and define it as a numeric sequence that starts at 0 and goes to 200 in increments of 0.5 (i.e. 0, 0.5, 1, 1.5... ...199, 199.5, 200). 
data ##prints the object
set.seed(42) ##sets the seed at 42, so others can reproduce this "random" dataset
dat.sample<-sample(data, size = 50, replace = FALSE) ##a random sample of 50 points without replacement
dat.sample ##prints the object
fivenum(dat.sample) ##generates the 5-number summary (minimum, 1st quartile, median, 3rd quartile, and maximum); 1.0  63.5 125.5 173.5 200.0

### summary() works too

# #4 ----------------------------------------------------------------------
##Binning numbers is a pretty common task in research that entails taking a numeric vector and binning them into categories. 

?rnorm ## learn about rnorm function
set.seed(42) ##sets the seed at 42, so others can reproduce this "random" dataset
studentscores<- rnorm(200,80,20) ##200 is number of datapoints, 80 average, and 20 is is standard deviation)
studentscores  

studentscores[studentscores>100] <- 100 ##Replace any number over 100 with 100. 
studentscores ##check replacement worked. It did

##What is the average and standard deviation of just the students in the top third of the class? 
studentscoressorted<-sort(studentscores) ##creates a sorted dataset
studentscoressorted
topthird<-studentscoressorted[133:200] ##creates a dataset with the top third of student scores in the class

### I'd encourage you to find a way to use relative coding to figure out the correct numbers

topthird  ##check dataset created
mean(topthird) ##gives mean of top third, it is 96.05
sd(topthird) ##gives sd of topthird, it is 4.22
