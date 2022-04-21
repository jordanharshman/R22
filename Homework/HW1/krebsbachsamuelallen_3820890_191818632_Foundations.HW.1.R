# SAM KREBSBACH
# Assignment 1 Introduction to R

# I.2 ---------------------------------------------------------------------
x <- c(1,2,3,4,5) #defines x as vector 1-5
### 1:5 is quicker, fyi
x+1 #adds 1 to each element of vector

# I.3 ---------------------------------------------------------------------
set.seed(42) #sets the seed for same number
exp <- rnorm(100, 1.1, .1) # creates normalized experimental data
set.seed(42) #sets seed again
con <- rnorm(100, 1, .1) # creates normalized control data
m.exp <- mean(exp) #finds mean of experimental data
m.con <- mean(con) #finds mean of control data
sd.exp <- sd(exp) #finds standard deviation of experimental data
sd.con <- sd(con) #finds standard deviation of experimental data
sd.pool<- sqrt((((sd.exp)^2) + ((sd.con)^2))/2) #pooled standard dev equation

d <- (m.exp-m.con)/(sd.pool) #Cohen equation

# I.5 ---------------------------------------------------------------------

data <- seq(from = 0, to = 200 , by= 0.5) # creates object from 0-200 by 0.5
set.seed(42) #setting seed for same data
dat.sample <- sample(data, 50, replace = FALSE) #samples 50 random numbers without repeating
summary(dat.sample) #displays quartiles, min, median, and mac of data

# I.8 ---------------------------------------------------------------------
set.seed(42) #setting seed for same data
scores <- rnorm(n = 200, mean = .80, sd = .2) #creates dataset of 200 tests with mean of 80% and standard deviation of 20
scores #diplays scores
scores > 1          # check all scores over 1
scores[scores > 1]       # return scores over 1
scores[scores > 1] <- 1  # replace each score over 1 with 1

mean(scores[scores>=quantile(scores, 0.667)])*100 #fines mean of top 33% of students
sd(scores[scores>=quantile(scores, 0.667)])*100 #finds sd of top 33 %


#this is all just me trying and failing the last question
install.packages("dplyr")
library(dplyr)

#perform binning with custom breaks
df %>% mutate(new_bin = cut(variable_name, breaks=c(0, 10, 20, 30)))

grades<- scores %>% mutate(breaks=c(0.6, 0.7, 0.8, 0.9))

?mutate

### the following is pretty close:

A <- scores[scores>=0.9]
### scores[scores >= 0.9] <- "A"
B <- scores[scores>=0.8]
B <- B[B %in% 0.9]

ifelse(scores>=90, A, )

binning <- scores %>% 0.9

### -1

# #2 ---------------- (new section: CTRL + SHIFT + R)

