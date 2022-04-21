#Adelia Grabowsky
#Assignment 1 Introduction to R
##1 

# Here's my code #1 (I.2)with adequate commenting ------------------------------
x<-1:5 #defines an object x which contains 5 numeric elements of 1 through 5
print(x+1) #adds 1 to each element of x and then prints the resulting elements

### don't actually need the print() function

# Here's my code #2 (I.3) with adequate commenting ------------------------------

set.seed(42) #enables you to generate random numbers that will be the same as others who have set seed (42) 
exp <- rnorm(100, 1.1, .1) #experimental, generates 100 values with a normal distribution, a mean of 1.1 and sd of .1
set.seed(42)
con <- rnorm (100, 1, .1) # control, generates 100 values with a normal distribution, a mean of 1 and sd of .1
SDe2 <-sd(exp)^2 #calculates the squared sd of the experimental values
SDc2 <- sd(con)^2 #calculates the squared sd of the control values
SDp <- sqrt((SDe2 + SDc2)/2) #calculates the sample pooled sd by adding the squared sds of the exp and control groups, dividing that number by 2, and taking the square root
d <-(mean(exp)-mean(con))/SDp #calculates Cohen's d by adding the means of the exp and con and then dividing by the sample sd pooled
print(d) #prints Cohen's d

### can also just type d (no need to print())

# Here's my code #3 (I.5) with adequate commenting ------------------------------

data <- seq(from = 0, to = 200, by = 0.5) #creates an object that goes from 0 to 200 in increments of 0.5
set.seed(42) # same as in code #2
dat.sample <- sample(data, 50) #takes a random sample of 50 from the object data without replacement because the default is no replacement
fivenum(dat.sample) #calculates the minimum, 1st quantile, median, 3rd quantile, and max score


# Here's my code #4 (I.8) with adequate commenting ------------------------------

set.seed(42) #same as code #2
scores <- rnorm(200, 80, 20) #creates a random sample of 200 scores with a normal distribution, an average of 80 and a sd of 20
scores <- replace(scores, scores > 100, 100) #replaces all scores that are greater than 100 with 100

### good use of the replace function!

top3 <- scores[scores >= quantile(scores, 0.67)] #defines an object composed of the scores in the top third (33%) of the class
mean(top3) #calculates the mean of the scores in the top third of the class
sd(top3) #calculates the standard deviation of the scores in the top third of the class

### Did you do the replace with letter grades?
### -1