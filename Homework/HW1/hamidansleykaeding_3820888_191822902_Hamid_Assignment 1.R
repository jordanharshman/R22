# Ansley Hamid
# Assignment 1 Introduction to R

### I would advice using the <- instead of =
### https://pics.me.me/thumb_equals-sign-assignment-operator-imgflip-com-going-through-data-structures-and-47188178.png

# #1 --------------------------------------------------------------------

x = 1:5 #creates a numeric vector with 5 elements numbered 1 through 5
x+1 #adds 1 to each element of vector x and prints the result


# #2 ----------------------------------------------------------------------

set.seed(42)
exp = rnorm(100, 1.1, .1) #experimental
set.seed(42)
con = rnorm(100, 1, .1) #control

sd_exp = sd(exp)
sd_con = sd(con)
sd_pooled = sqrt((sd(exp)^2 + sd(con)^2)/2)

d = (mean(exp) - mean(con)) / sd_pooled
d


# #3 ----------------------------------------------------------------------

data = seq(from = 0, to = 200,  by = 0.5)
set.seed(42)
dat.sample = sample(data, 50, replace = FALSE)
summary(dat.sample)


# #4a ---------------------------------------------------------------------

set.seed(42)
data = rnorm(200, mean = 80, sd=20) #Create vector with 200 elements with mean 80 and st dev 20
data #View all elements
data[data > 100] = 100 #Replace values over 100 with 100
data #Check data to make sure replacement was successful


# #4b ---------------------------------------------------------------------

mean(data[data>=quantile(data, 0.6667)]) #mean of top 33% of data
sd(data[data>=quantile(data, 0.6667)])#stdev of top 33% of data


# #4c ---------------------------------------------------------------------

A = data[data>=90] #Create a new vector called "A" that contains all grades greater than or equal to 90
A #Check to make sure vector A contains intended elements
B = data[data>=80 & data<90] #Create a new vector called "B" that contains all grades greater than or equal to 80 and less than 90
B #Check to make sure vector B contains intended elements
C = data[data>= 70 & data<80] #same idea as vector B but greater than or equal to 70 and less than 80
C
D = data[data>=60 & data<70]
D
F = data[data<60]
F 

length(A) #count total amount of grade A given
length(B) #Count total amount of grade B given
length(C)
length(D)
length(F)
