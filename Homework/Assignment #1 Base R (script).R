# Key
# Assignment 1 Introduction to R


# #1 ----------------------------------------------------------------------
x <- 1:5
x + 1

# #2 ----------------------------------------------------------------------
set.seed(42)
exp <- rnorm(100, 1.1, .1) # experimental
set.seed(42)
con <- rnorm(100, 1, .1) # control

d <- (mean(exp) - mean(con)) / sqrt(((sd(exp))^2 + (sd(con))^2)/2)
d

# formatting will go a long way in helping this, so I might suggest:
d <- (mean(exp) - mean(con)) / 
  sqrt(
    ((sd(exp))^2 + (sd(con))^2) / 2
    )

# alternative stil, you might wish to define the pooled sd first:
sd.p <- sqrt(((sd(exp))^2 + (sd(con))^2)/2)
d <- (mean(exp) - mean(con)) / sd.p

# #3 ----------------------------------------------------------------------
data <- seq(from = 0, to = 200, by = .5)        # define the sequence
set.seed(42)                                    # set the seed
dat.sample <- sample(data, 50, replace = FALSE) # sample 50 obs
summary(dat.sample)                             # 5-number summary

# Alternative to summary():
min(dat.sample)           # minimum
quantile(dat.sample)      # print all quantiles
quantile(dat.sample, .25) # 1st quantile (25%)
median(dat.sample)        # 2nd quantile (50%, median)
quantile(dat.sample, .5)  # 2nd quantile (50%, median)
quantile(dat.sample, .75) # 3rd quantile (75%)
max(dat.sample)           # maximum

# #4 ----------------------------------------------------------------------
#a
set.seed(42)                  # set the seed
scores <- rnorm(200, 80, 20)  # sample the data
scores[scores > 100] <- 100   # replace scores over 100 with 100

#b
scores.s <- sort(scores, decreasing = TRUE)   # sort scores decreasing
top3 <- scores.s[1:round(length(scores.s)/3)] # select only top third observations
mean(top3) # compute avg
sd(top3)   # compute sd

#c
grades <- character(length(scores.s)) # blank character vector length of scores.s

# The next line is dangerous to do: I'm referencing indices in grades object based
# indices in scores.s object. If I'm not sure they are exactly aligned, this could be
# a silent error. Why take the risk when I could do:
#   grades[grades >= 90] <- "A" 

# The reason is because once I do this, it will turn grades from numeric to character
# vector, so I can't select numbers now. If that were the case, the next line would generate 
# an error:
#  grades[grades >= 80 & grades < 90]

grades[scores.s >= 90] <- "A"                 # generate A's
grades[scores.s >= 80 & scores.s < 90] <- "B" # generate B's
grades[scores.s >= 70 & scores.s < 80] <- "C" # generate C's
grades[scores.s >= 60 & scores.s < 70] <- "D" # generate D's
grades[scores.s < 60] <- "F"                  # generate F's

# Alternative: ifelse()
grades <- ifelse(scores.s >= 90, "A", # generate A's 
                 ifelse(scores.s >= 80 & scores.s < 90, "B", # generate B's
                        ifelse(scores.s >= 70 & scores.s < 80, "C", # generate C's
                               ifelse(scores.s >= 60 & scores.s < 70, "D", "F")))) # generate D's & F's

# Alternative: Logic your way. You can avoid the ranges by starting low: Define everyone
# as "F" and then replace them progressively:
grades <- rep("F", length(scores.s)) # everyone gets an F!!!
grades[scores.s >= 60] <- "D"        # everyone greater than 60 get's a D, replacing F's
grades[scores.s >= 70] <- "C"        # everyone greater than 70 get's a C, replacing D's
grades[scores.s >= 80] <- "B"        # everyone greater than 80 get's a B, replacing C's
grades[scores.s >= 90] <- "A"        # everyone greater than 90 get's a A, replacing B's

table(grades)
