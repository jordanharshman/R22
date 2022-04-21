#April Smith
#Assignment 1 Introduction to R


# 1 -----------------------------------------------------------------------

x <- sample (1:5, 5) #defining an object x that has 5 numberic elements, 1-5

### a more direct way would be simply 1:5; sampling would return them in any order
### and is not in the spirit of the vector (returning 1 through 5 should not
### be on the basis of randomness)

x.1 <- x + 1 #adding 1 to each of those elements

# 2 Cohen's D -------------------------------------------------------------

set.seed(42)
exp <- rnorm(100, 1.1, .1) # experimental
set.seed(42)
con <- rnorm(100, 1, .1) # control

mean(exp)
exp.m <-mean(exp) #calculation mean of experimental group
exp.c <-mean(con) #calculation mean of contro group
exp.sd <-sd(exp) #calculate SD of experimental group
con.sd <-sd(con) #calculate SD of control group

sd.pool <- sqrt((exp.sd*exp.sd) + (con.sd * con.sd)/2) # calculate pooled SD

### Order of operations issue. For sd.pool, you have:
### sqrt((exp.sd*exp.sd) + (con.sd * con.sd)/2)
### = 0.1275397

### That is really dividing con.sd^2 / 2 and then adding exp.sd^2
### sqrt((exp.sd*exp.sd) + ((con.sd * con.sd)/2))

### To avoid this, you need an extra set of parentheses:
### sqrt(((exp.sd*exp.sd) + (con.sd * con.sd))/2)
### = 0.1041357
### more efficient:
### sqrt(sum(exp.sd^2, con.sd^2)/2)
### -1

d <- (exp.m - exp.c)/sd.pool #calculate D

# 3 -----------------------------------------------------------------------

data <- seq(0,200, by = 0.5) #creating the data set as specified in assignment
set.seed(42)
dat.sample <-sample(data, 50, replace = FALSE) #taking random sample of 50 points w/o replacement
fivenum(dat.sample) #getting the 5-number summary stats

# #4 ----------------------------------------------------------------------

set.seed(42)
testscores <- rnorm(200, mean=80, sd=20) #creating normal distribution of test scores with mean = 80, SD = 20
test100 <- pmin(testscores, 100) #making sure no values are above 100

### I did not know about pmin()... nice! I just did:
### test100 <- testscores[testscores > 100] <- 100

testsort <- sort (test100, decreasing = TRUE) #sorting test scores in decreasing order
testtop33 <- testsort[1:66] #taking top thrid (probably a better way to do this with a percentile...)

### I encourage finding relative ways to reference the top third

mean(testtop33) #getting the mean of the top third
sd(testtop33) #getting the SD of the top third

testbin <-data.frame(testsort,bin=cut(testsort,c(0,60,70,80,90,100),include.lowest=TRUE)) #creating vector that bins

testbin #running this allows me to tally As, Bs, Cs, Ds, Fs...I'm sure there's a better way but I got tired :)

### cut() is on the right path:
### cut(testsort,c(0,60,70,80,90,100))
### This yields the proper cuts, but they aren't labeled to letters, just ranges
### Use the label argument to override:
### x <- cut(testsort,c(0,60,70,80,90,100), label = c("F", "D", "C", "B", "A"))
### table(x)
### -1
