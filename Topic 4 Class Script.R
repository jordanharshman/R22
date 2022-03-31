# Libraries and Imports ---------------------------------------------------

library(tidyverse)

setwd("C:/Users/jth0083/Box/Teaching/CHEM 6450 Spring 2022/R22/Data") # set wd
copus <- read.csv("COPUS.csv") # read in copus data

# IV.1 Looping Simple ------------------------------------------------------------
#try base R:
1:10 + (1:10)^1:10 # didn't work; exponential can only take one element

# Going old school: brute force
1 + (1)^1
2 + (2)^2
3 + (3)^3
4 + (4)^4
5 + (5)^5
6 + (6)^6
7 + (7)^7
8 + (8)^8
9 + (9)^9
10 + (10)^10

# use a loop
for(i in 1:10){
  print(i + (i)^i)
}

# can call the index anything:
for(thisnumber in 1:10){
  print(thisnumber + (thisnumber)^thisnumber)
}

# can also use character vectors in loops:
for(beer in 99:1){
  cat(
    str_c(beer, " bottles of beer on the wall,\n",
          beer, " bottles of beer!\nTake one down, pass it around,\n",
          (beer - 1), " more bottles of beer on the wall.\n\n"
          )
  )
}


# IV.1 Looping COPUS -------------------------------------------------------

# 1. Code what you want for one full iteration
ggplot(copus, aes(x = Lec)) +
  geom_histogram() +
  ggtitle("Lec")

# 2. Code another iteration, identifying what needs to change from one 
# iteration to the next
ggplot(copus, aes(x = L)) +
  geom_histogram() +
  ggtitle("L")

# Need to change x aesthetic and the ggtitle each time
# 3. Set up your array
arr <- c(L, Lec) # error
arr <- c("L", "Lec")
for(var in arr){
  
}

# 4. Copy the one full iteration inside the loop and replace with generic index
for(var in arr){
  
}

# 5. Check your loop. 
# Uh-oh, nothing happened above. No errors, which is good, no plots, which is bad.
# Turns out, because of how ggplot works, you have to explicitly call a print()
# when inside of a loop or a function. That's just the way it is.

for(var in arr){
  print(
    ggplot(copus, aes(x = var)) + # replaced Lec with var
      geom_histogram() +
      ggtitle(var) # replaced "Lec" with var
  )
}

# To fix the error, you will have to tell aes() to use string information:
for(var in arr){
  print(
    ggplot(copus, aes_string(x = var)) + # replaced Lec with var
      geom_histogram() +
      ggtitle(var) # replaced "Lec" with var
  )
}

# 6. Run the full array
# Easily get all copus variable names into a character vector:
arr <- copus %>%
  select(L:T_O) %>%
  names()
for(var in arr){
  print(
    ggplot(copus, aes_string(x = var)) + # replaced Lec with var
      geom_histogram() +
      ggtitle(var) # replaced "Lec" with var
  )
}

# IV.1 Other Looping Ideas -------------------------------------------------
# For every Lec value, subtract the mean from it. 
# Seems like a for loop...
copus$Lec.c <- NA # set up a blank new variable
meanLec <- mean(copus$Lec) # calc mean
for(i in copus$Lec){
  copus$Lec.c[i] <- copus$Lec[i] - meanLec
}

# ...but it's not. This does the same thing.
copus %>%
  mutate(Lec.c = Lec - mean(Lec))

# Prove that loops are slow:
# Time to run loop:
start <- Sys.time()
copus$Lec.c <- NA # set up a blank new variable
meanLec <- mean(copus$Lec) # calc mean
for(i in copus$Lec){
  copus$Lec.c[i] <- copus$Lec[i] - meanLec
}
end <- Sys.time()
difftime(end, start)

start <- Sys.time()
copus <- copus %>%
  mutate(Lec.c = Lec - mean(Lec))
end <- Sys.time()
difftime(end, start)

# Now bring out the big guns for benchmarking:
library(rbenchmark)

benchmark(
  "forloop" = {
    copus$Lec.c <- NA # set up a blank new variable
    meanLec <- mean(copus$Lec) # calc mean
    for(i in copus$Lec){
      copus$Lec.c[i] <- copus$Lec[i] - meanLec
    }
  },
  "mutate" = {
    copus <- copus %>%
      mutate(Lec.c = Lec - mean(Lec))
  },
    replications = 1000
)

# IV.1 apply() and map() -------------------------------------------------------
# do our x + x^x loop again
for(i in 1:10){
  print(i + (i)^i)
}

# to convert this to map or apply, need to define a function first:
# xpxx = x plus x to the x
xpxttx <- function(x){
  x + x^x
}

# use the apply() family (base R)
# lapply() returns a list
# sapply() returns a vector (unlists the list)
lapply(1:10, xpxttx)
sapply(1:10, xpxttx)

# us the map() family (dplyr)
# map() returns a list
# map_dbl() returns a numeric vector
map(1:10, xpxttx)
map_dbl(1:10, xpxttx)

# benchmark on something more computationally intense to see the savings
# running the same formula x + x^x but now with every value from 0 to 10
# by 0.0001 increments (100,000 iterations)

benchmark(
  "forloop" = {
    for(i in seq(0,10,.0001)){
      print(i + (i)^i)
    }
  },
  "sapply" = {
    print(sapply(seq(0,10,.0001), xpxttx))
  },
  "map_dbl" = {
    print(map_dbl(seq(0,10,.0001), xpxttx))
  },
  replications = 10
)


# IV.2 Writing custom functions -------------------------------------------

# simple function to compute:
# x + x^x
xpxttx <- function(x){
  x + x^x
}
xpxttx(5)

# store results as a list for ease of access later:
xpxttx <- function(x){
  solution <- x + x^x
  results <- list(value = solution)
  return(results)
}
xpxttx(5)

# x + y^x
xpyttx <- function(x, y){
  solution <- x + y^x
  results <- list(value = solution)
  return(results)
}
xpyttx(5, 1)

# x + y^x with default y = 3
xpyttx <- function(x, y = 3){       # set the default y value
  solution <- x + y^x
  results <- list(value = solution)
  return(results)
}
xpyttx(5)    # use default y value
xpyttx(5, 4) # override default y value

# x + y^x with default y = 3 & throw error if x is negative
xpyttx <- function(x, y = 3){
  if(x < 0){ # set up your condition
    stop("Error: x cannot be negative, stupid!") # if true, generate this error message
  } # end condition
  
  # If true, the stop() command halts all further execution. If it's false, stop() is never run
  
  solution <- x + y^x
  results <- list(value = solution)
  return(results)
}
xpyttx(-1)

# How about a warning instead of error?

# x + y^x with default y = 3 & throw error if x is negative
xpyttx <- function(x, y = 3){
  if(x < 0){ 
    warning("Warning: x is negative; are you sure you want to do that!?") 
  }
  
  # If true, the warning() command allows further execution. If it's false, warning() is never run
  
  solution <- x + y^x
  results <- list(value = solution)
  return(results)
}
xpyttx(-1)    # use default y value

# Examine what other functions do to make them more helpful:
mean("a") # warning message that input is not numerical
mean.default

# Warning is generated because mean.default has this code built into it:
# if (!is.numeric(x) && !is.complex(x) && !is.logical(x)) {
#   warning("argument is not numeric or logical: returning NA")
#   return(NA_real_)
# }

# IV.2 Functions for repetitive use ---------------------------------------

# hard code it first:
copus.f <- 
  copus %>%
  filter(Broader %in% c("Chemical", "Biological"))

# A. Compute means:
means <- copus.f %>%
  group_by(Broader) %>%
  summarize(Avg = mean(Lec))
means

# B. Boxplot:
ggplot(copus.f, aes(y = Lec, fill = Broader)) +
  geom_boxplot()

# C. Normality test:
copus.f1 <- copus.f %>%
  filter(Broader == "Chemical")
D1norm <- shapiro.test(copus.f1$Lec)
D1norm

copus.f2 <- copus.f %>%
  filter(Broader == "Biological")
D2norm <- shapiro.test(copus.f2$Lec)
D2norm

# D. t-test:
Ttest <- t.test(copus.f1$Lec, copus.f2$Lec)
Ttest

# Now, notice that the only thing that needs to change is any instance of
# "Chemical" and "Biological". Let's replace these with the arguments of a function
# and call them "D1" and "D2":

myfunction <- function(D1, D2){
  # going to copy everything in here
}

# Now copy it all in and replace all exact values:

myfunction <- function(D1, D2){
  copus.f <- 
    copus %>%
    filter(Broader %in% c(D1, D2))
  
  # A. Compute means:
  means <- copus.f %>%
    group_by(Broader) %>%
    summarize(Avg = mean(Lec))
  
  # B. Boxplot:
  print(
    ggplot(copus.f, aes(y = Lec, fill = Broader)) +
      geom_boxplot())
  
  # C. Normality test:
  copus.f1 <- copus.f %>%
    filter(Broader == D1)
  D1norm <- shapiro.test(copus.f1$Lec)
  
  copus.f2 <- copus.f %>%
    filter(Broader == D2)
  D2norm <- shapiro.test(copus.f2$Lec)
  
  # D. t-test:
  Ttest <- t.test(copus.f1$Lec, copus.f2$Lec)
  
  # make my results list:
  results <- list(averages = means,
                  normalitytest = list(D1norm, D2norm),
                  ttest = Ttest)
  
  # return the results
  return(results)
}

# run the newly created function:
myfunction(D1 = "Chemical", D2 = "Biological")
myfunction("Chemical", "Biological") # without the args defined
myfunction("Computer", "Physical") # compare comp and phys
myfunction("Biological", "Physical") # compare bio and phys

# Can we make it work for any dataset? Yes:

myfunction <- function(data, group, dv, D1, D2){
  df <- data %>%
    rename(Group = group,
           DV = dv) 
  
  df.f <- 
    df %>%
    filter(Group %in% c(D1, D2))
  
  # A. Compute means:
  means <- df.f %>%
    group_by(Group) %>%
    summarize(Avg = mean(DV))
  
  # B. Boxplot:
  print(
    ggplot(df.f, aes(y = DV, fill = Group)) +
      geom_boxplot())
  
  # C. Normality test:
  df.f1 <- df.f %>%
    filter(Group == D1)
  D1norm <- shapiro.test(df.f1$DV)
  
  df.f2 <- df.f %>%
    filter(Group == D2)
  D2norm <- shapiro.test(df.f2$DV)
  
  # D. t-test:
  Ttest <- t.test(df.f1$DV, df.f2$DV)
  
  # make my results list:
  results <- list(averages = means,
                  normalitytest = list(D1norm, D2norm),
                  ttest = Ttest)
  
  # return the results
  return(results)
}

# compare Setosa vs Virginica Sepal.Length
myfunction(iris, "Species", "Sepal.Length", "setosa", "virginica")
# Is there a cost increase of a diamond with cut of "Very Good" from "Good"?
myfunction(diamonds, "cut", "price", "Ideal", "Good")
# Guess we won't find out until we debug :(
# Ha! Shapiro function can't handle grater than 5,000 samples. If we were serious
# about releasing this function to others, we should figure out how to deal with it:
#   A. We could let the error generate and let the user deal with it
#   B. We could at least program a more specific error message (i.e. "Cannot have data with > 5000 observations;
#      reduce number of observations first")
#   C. Automatically detect if this is an issue and then auto sample 5,000 points, 
#      print a warning saying we did this...
#   D. Swap out Shapiro test for Anderson Darling
#   E. Modify the base shapiro.test to remove the 5,000 maximum threshold
#   F. Others?

myfunction <- function(data, group, dv, D1, D2){
  df <- data %>%
    rename(Group = group,
           DV = dv) 
  
  df.f <- 
    df %>%
    filter(Group %in% c(D1, D2))
  
  # A. Compute means:
  means <- df.f %>%
    group_by(Group) %>%
    summarize(Avg = mean(DV))
  
  # B. Boxplot:
  print(
    ggplot(df.f, aes(y = DV, fill = Group)) +
      geom_boxplot())
  
  if(nrow(df.f) > 5000){
    df.f <- sample_n(df.f, 5000)
    warning("Shapiro-Wilks test in base R can only handle 5,000 observations. I know that this is incredibly stupid
            and outdated (like, why? srsly, why?) but it just is what it is. I decided the best way to deal with this
            is for this function to automatically sample 5,000 of your data points at random, so I'm just letting you
            know that the function did this. You should really think about that and may consider sampling the points
            yourself prior to entering it into the function. This means if you run the function once and then run it
            again, you might not get exactly the same results because of which points it sampled. Again, I'm so sorry 
            for this stupidity and that I didn't have the time to modify the shapiro test or swap it out. Sorry. For 
            real, sorry.")
  }
  
  # C. Normality test:
  df.f1 <- df.f %>%
    filter(Group == D1)
  D1norm <- shapiro.test(df.f1$DV)
  
  df.f2 <- df.f %>%
    filter(Group == D2)
  D2norm <- shapiro.test(df.f2$DV)
  
  # D. t-test:
  Ttest <- t.test(df.f1$DV, df.f2$DV)
  
  # make my results list:
  results <- list(averages = means,
                  normalitytest = list(D1norm, D2norm),
                  ttest = Ttest)
  
  # return the results
  return(results)
}

myfunction(diamonds, "cut", "price", "Ideal", "Good")
# It's gonna cost you another $520 on average, just sayin



# IV.3 RMarkdown ----------------------------------------------------------


