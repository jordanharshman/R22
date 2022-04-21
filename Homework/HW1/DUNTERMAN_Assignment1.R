#Rebecca Dunterman
#Assignment 1 Introduction to R



# 1 ---------------------------------------------------------------------

x <- 1:5 #create an object named x that contains the elements 1 through 5
x + 1 #add 1 to each element of x and print



# 2 -----------------------------------------------------------------------

set.seed(42) 
exp <- rnorm(100, 1.1, .1) # experimental
set.seed(42)
con <- rnorm(100, 1, .1) # control

sd_samp_con <-sd(con) # calculate the standard devation of control group
sd_samp_exp <-sd(exp) #calculate the standard devation of experiemtal group

n_con <- length(con)# find length or sample size
n_exp <- length(exp) #find length/sample size


pooled_sd <- sqrt(((n_con-1)*sd_samp_con^2 + (n_exp-1)*sd_samp_exp^2) / (n_con + n_exp -2))
#calculate the pooled sd of contol and expeiemental groups
pooled_sd #print the pooled sd 

mean(exp) #find mean of experimental group
mean(con) #find mean of control group

d = ((mean(exp)- mean(con))/pooled_sd) # using the formula d = (Me -Mc) /Sample sd pooled, calculate Cohen's D
d #print d 


# 3 -----------------------------------------------------------------------

data <- seq (0, 200, by=0.5) #create a sequence 0 through 200 in increments of 0.5
data # print data

set.seed(42)

dat.sample <- sample(data,50,replace=FALSE) # produce a random sample of 50 without replacement

min(dat.sample) #find minimum value of the sample
quantile(dat.sample) #find quartiles
median(dat.sample)#find median of the sample
max(dat.sample) #find maximum of the sample

### ln 49 and 50 already shown in qunatiles()

# 4 -----------------------------------------------------------------------


set.seed(42) 
test_scores <- rnorm(200, mean =80, sd =20) #create a simulated dataset with 200 students with a mean of 80% and a sd of 20%
 
test_scores[test_scores>100]<-100 # replace any test score over 100 with 100
sort(test_scores,decreasing =FALSE)# order test scores from lowest to highest
200/3 #find how many students are in top third, 66.66666, round up to 67
top_third <-tail(sort(test_scores),67) #create a vector of the top 3rd by isolating the last 67 hightest scores

### I would encourage you to find relative ways of coding ln 63

top_third
mean(top_third) #find mean of the top 3rd
sd(top_third) #find Standard deviation of the top 3rd

#I have very much confused myself

A <- test_scores[test_scores >90]# find scores earning an A and create a vector called A
length(A) #count number of "A"s earned
200-57 #number of students who got less than an a =143
below_A <-tail(sort(test_scores),143) #create vector for the students less than a by sorting and taking off the 57 "a"s
length(below_A) #check
B <- below_A[below_A <80]#find how many students scored a b
length(B)#check 95 students earned a b, so remove them from pool of 143 to get 48
143-95
B

### I think you went off in the following line. You defined it
### solely off of below_A, which only contains the A observations.
### Why not:
### below_B <- tail(sort(test_scores, decreasing = T), ##)
### , where you will need to rethink the number
### -1

below_B <-tail(sort(below_A),48) 
length(below_B)
C <- below_B[below_B <70]
length(C)
below_c <-tail(sort(below_b),0)
length(below_c)
D <-below_C <-tail(sort(below_c),0)
length(D)                  
      
#F <- test_scores[test_scores <60]#find scores earning an F and create a vector called F
length(F) #count number of "F" earned

length(A)
length(B)
length(c)
length(D)
length(F)


