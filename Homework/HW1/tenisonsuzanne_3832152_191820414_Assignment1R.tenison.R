#suzannetenison
#Assignment 1 Introduction to R


#1---------------------------

x<- c(1,2,3,4,5)
x
x<- (x+1)
x

#2------------------------------
  
set.seed(42)
exp <- rnorm(100, 1.1, .1) #experimental
set.seed(42)
con <- rnorm(100, 1, .1) #control
m.exp <- mean(exp) #mean of experimental
m.con <- mean(con) #mean of control
sd.exp <- sd(exp) #sd of experimental
sd.con <- sd(con) #sd of control
sd.pooled <- sqrt (((sd.exp^2) + (sd.con^2))/2) #cohnes d formula
sd.pooled
d <- (m.exp - m.con)/ sd.pooled #cohens d formula
d

#3---------------------------------

set.seed(42)
data <- seq(0,200,0.5) #0 to 200, sequened by .5

dat.sample <- sample(data, 50, replace = FALSE) #created dat.sample, w/ 50 random samples 
summary(dat.sample) #calculates a 5-number summary


#4A-------------------------------

data<- rnorm(200, mean= 80, sd = 20) #200 students, normally distributed, 80% average w/ sd of 20%
set.seed(42)
data[data > 100] <- 100 #get rid of all the numbers larger than 100, change to 100
data
#B---------------------------------

### something going on here becuase they give you the same numbers...
### quantiles spit out 5 quantiles (default) of a set of data, whereas 
### you supplied one single number.
### -1

quantile(mean (data))
quantile(sd (data))

#C----------------------------------
library(dplyr)
df %>% data(points_bin = ntile(points, n=100))
# Installed release version from CRAN
install.packages("rbin")
bins <- rbin_manual(A=90, B=80:<90, C=70:<80, D=60:<70, F=60) #attempted to create vector that bins scores
table(df$bins) #didn't work, I tried!

### sorry, I'm not sure about this function and how it works, I'd have to look into it
### seems that cut() would work just fine
### -1
