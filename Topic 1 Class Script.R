# I.2 Workflow in R -------------------------------------------------------

# type whatever you want

# Input the the number 23 (technically, we are inputting a vector with length 1
# that is numeric with the first and only element being 23)

23 # print the number
"Hello World!" # print the characters
'Hello World'

# I.3 Mathematical Operations ---------------------------------------------
1+1   # addition
1 + 1 # extra spaces don't matter, sometimes visually helpful
3-2   # subtraction
3*2   # multiplication
3/2   # division
(4-2)^2 # exponents
4-2^2   # check order of operations
sqrt(4) # square-root, need to run a function
4^.5
4^(1/2)

# I.4 Object Definition ---------------------------------------------------
x

x <- 13 # defined as
x # print object contents
print(x) # same as above

# Jan 13

y <- 10 # define y
x-y     # call x, take it's contents and call y, subtract it's contents from x
x <- c(10, 13)
x
x <- 1:100
x
x
x <- 13

x+y     
x*y
x/y
(x/y)^4

# PREDICT: After you define z and then redefine y, will the value of z change?
y <- 11
z <- x-y
z
 

# I.5 Vectors -------------------------------------------------------------
x <- c(21,24,32,30,22,24,26,28,28,29,20) # define a numeric vector of length 11
x[6]      # print 6th element only
x[-6]     # print all but the 6th element
x[2:8]    # print elements 2 through 8
x[c(2,8)] # print elements 2 and 8 only
x[6] - y  # take 6th element of x and subject y from it

x <- c(21,24,32,30,22,24,26,28,28,29,20) # define x
x + x # add length 11 vector to itself and return length 11 vector

x - y
y <- c(10, 20)
x - y
x[12] <- 20
x - y

test.scores <- sample(50:100, 500, replace = TRUE)
test.scores <- test.scores - 75

sample(1:1000, 1)
set.seed(42)
sample(1:1000, 1)
sample(1:1000, 1)

x <- 1   # numeric
x <- "1" # character
x + 1
x <- factor("1") # factor
x <- as.logical(1)

# Jan 18

# Replacing elements based on index
x <- c(1,2,1,1,2,1,3,1,3,2)
x[6] <- 31      # redefine the 6th element as 31
x

# Replacing elements based on criteria
x == 1          # check if each element is equal to 1
x[x == 1]       # return element where each index was T
x[x == 1] <- 0  # replace each element where index was T
x

x <- c(1,2,1,1,2,1,3,1,3,2)
x == 1 | x == 2 # spell out each condition separately by "|" to mean "or"
x[x == 1 | x == 2] <- 0
x %in% c(1, 2)  # alternative: which elements IN x are equal to either 1 or 2

# I. 6 Basics of Functions -----------------------------------------------------
?mean # see documentation
??mean # searhc for function with "mean" in it
mean  # see what the function does
methods(mean) # see more on what the function does (if setup this way)
mean.default  # same as above
mean(x = x, trim = 0, na.rm = FALSE) # mean with all defaults
mean(x = test.scores, trim = 0, na.rm = FALSE) # change out what to compute
mean(x = x) # accept all defaults without writing them
mean(x)     # accept all defaults without even defining the first argument
mean(test.scores)

# PREDICT: How will the following lines change the resulting average calculation?
mean(x, trim = .1)
mean(x, .1)
mean(test.scores)
mean(test.scores, trim = 0.1)
mean(x, na.rm = TRUE)
x[2] <- NA # NA, not "NA"
mean(x)
mean(x, na.rm = TRUE)

data <- sample(x = 1:1000, size = 500, replace = TRUE) # randomly sample
set.seed(42) # when randomly sampling, can recover the random sample
data <- sample(x = 1:1000, size = 500, replace = TRUE) # randomly sample with a seed
mean(data) # no trim
mean(data, trim = 0.025) # trim outlying 0.025 percentile
mean(data, trim = 2.5)   # trim outlying 2.5 percentile

# Jan 20

# Task 1 ------------------------------------------------------------------



# I.7 Coding Principles ---------------------------------------------------

# Errors

mean(x, trim = "A") # trim needs to be numeric
mean(x, trim = A)   # object A does not exist
mean(a)             # object a does not exist
mean(x, trim = ".1") # trim needs to be numeric

# PREDICT: What caused the errors in each of the following lines?
mean(X, trim = .1)
mean("x", trim = ".1")
mean("x", trim = .1)

# Silent Error
# Want: sample 1:100 WITH replacement:
sample(1:100, 100) # worked, no errors, but was not what we intended
sample(1:100, 100, replace = TRUE)

# Alternatives
# PREDICTION: All of the following are ways to calculate the average of the data vector 
# we made previously. What are the advantages/disadvantages of each method?
mean(data)
sum(data) / 500
sum(data) / length(data) 
set.seed(42)                                         
mean(sample(x = 1:1000, size = 500, replace = TRUE)) 
mean(
  c(
    561, 997, 321, 153, 74, 228, 146, 634, 49, 128, 303, 24, 839, 356, 601, 165, 
    622, 532, 410, 882, 879, 899, 297, 601, 283, 932, 997, 991, 621, 517, 212, 
    930, 860, 872, 259, 314, 481, 298, 24, 158, 299, 911, 406, 314, 648, 292, 
    836, 982, 146, 621, 348, 197, 516, 226, 504, 946, 355, 984, 727, 945, 245, 
    922, 626, 262, 390, 130, 372, 3, 374, 405, 770, 870, 698, 650, 40, 517, 33, 
    945, 103, 228, 109, 329, 669, 76, 980, 777, 491, 547, 733, 16, 357, 732, 248, 
    325, 988, 630, 642, 82, 920, 881, 914, 325, 622, 360, 951, 296, 149, 996, 569, 
    100, 999, 298, 402, 91, 781, 181, 54, 851, 288, 720, 758, 60, 285, 849, 620, 
    969, 377, 853, 638, 427, 442, 112, 584, 285, 951, 934, 513, 141, 718, 901, 
    969, 311, 912, 474, 811, 554, 42, 760, 865, 251, 441, 669, 25, 883, 703, 544,
    849, 238, 526, 623, 262, 504, 943, 299, 446, 933, 720, 369, 512, 758, 369, 
    754, 799, 930, 862, 224, 774, 214, 294, 607, 518, 852, 764, 783, 546, 426, 
    471, 188, 254, 268, 640, 410, 41, 193, 578, 824, 664, 98, 537, 348, 107, 317,
    958, 14, 162, 636, 706, 607, 544, 923, 906, 697, 796, 630, 37, 138, 369, 773, 
    547, 78, 526, 668, 890, 97, 741, 483, 182, 474, 127, 799, 493, 555, 692, 506, 
    992, 337, 955, 539, 542, 180, 868, 212, 587, 977, 201, 401, 62, 269, 991, 382,
    124, 63, 561, 573, 628, 769, 913, 929, 540, 2, 671, 648, 127, 208, 771, 741, 
    269, 12, 705, 670, 563, 444, 863, 677, 559, 824, 198, 912, 10, 967, 255, 201,
    745, 921, 515, 850, 181, 751, 284, 764, 463, 605, 313, 84, 985, 464, 886, 984, 
    225, 573, 102, 171, 489, 662, 922, 694, 822, 980, 567, 566, 826, 685, 421, 
    555, 207, 85, 930, 153, 870, 961, 910, 240, 49, 139, 156, 274, 567, 226, 762,
    170, 292, 148, 719, 189, 839, 113, 27, 606, 645, 86, 916, 626, 250, 169, 907, 
    732, 550, 362, 457, 895, 919, 858, 115, 873, 779, 915, 732, 213, 292, 426, 214, 
    985, 438, 827, 625, 542, 699, 469, 876, 917, 966, 559, 105, 202, 88, 370, 951,
    391, 398, 268, 693, 819, 522, 121, 601, 37, 706, 163, 418, 795, 46, 287, 859, 
    464, 868, 376, 821, 280, 934, 756, 981, 404, 715, 225, 379, 206, 348, 801, 605, 
    804, 301, 864, 358, 918, 684, 960, 765, 647, 876, 773, 159, 928, 978, 935, 653, 
    378, 542, 54, 514, 540, 387, 929, 623, 989, 212, 747, 265, 822, 138, 711, 627,
    988, 594, 409, 620, 202, 73, 659, 335, 46, 247, 131, 150, 61, 20, 682, 354, 983,
    529, 82, 211, 174, 273, 94, 330, 933, 429, 690, 179, 74, 304, 930, 954, 836,
    473, 346, 829, 231, 929, 366, 116, 726, 108, 659, 326, 748, 601, 542, 618, 103,
    755, 345, 258, 934, 393, 184, 843, 390, 799, 197
  )
)

# Commenting

# Anything that follows a # sign will be ignored by R; type whatever you want

# Line-by-line commenting:
x <- 13 # define x
y <- 10 # define y
x - y   # subtract y from x

x <- c(21,24,32,30,22,24,26,28,28,29,20) # redefine x
mean(x)                                  # compute mean of x (add space to make it look nicer)

set.seed(42) # set a seed
data <- sample(x = 1:1000, size = 500, replace = TRUE) # generate random data
mean(data)   # compute the mean of random data

# Segment-by-segment commenting

# subtract y from x after defining them
x <- 13 
y <- 10 
x - y 

# define x and compute the mean
x <- c(21,24,32,30,22,24,26,28,28,29,20)
mean(x)

# randomly generate data according to seed and compute mean
set.seed(42) 
data <- sample(x = 1:1000, size = 500, replace = TRUE) 
mean(data)

# Absolute/Relative Coding

x <- sample(1:10, 239, replace = TRUE)
# calculate proportion of obs that equal “2”
sum(x==2)/239       # absolute
sum(x==2)/length(x) # relative

# add another obs (3), bringing total to 240
x <- c(x, 3)
sum(x==2)/239       # silent error, BAD!!!
sum(x==2)/length(x) # all good b/c of relative coding!

# I.8 Chaining commands -------------------------------------------------------
x <- c(1,2,1,1,2,1,3,1,3,2) # define x

# Alternative 1
x.rm2 <- x[x != 2]     # get rid of 2's in new object
x.rm2.s <- sort(x.rm2) # sort the new x
len.x.rm2.s <- length(x.rm2.s) # compute number of elements in new x
x.rm2.s.l2 <- x.rm2.s[(len.x.rm2.s - 1):len.x.rm2.s] # select only last two elements
sum(x.rm2.s.l2) # calculate the sum

# Alternative 2
sum(sort(x[x != 2])[(length(x[x != 2]) - 1):length(x[x != 2])]) # do it all in one line

# Alternative 2.1 (same as #2, just formatted)
sum(
  sort(
    x[x != 2])[
      (length(x[x != 2]) - 1):length(x[x != 2])
    ]
)

# Alternative 3 (middle ground)
x2 <- sort(x[x != 2])  # remove 2's and sort
len <- length(x2)      # compute new length
sum(x2[(len - 1):len]) # compute sum of last 2

# Alternative 4 (find better way to select last two elements that avoids computing length)
x2 <- sort(x[x != 2])  # remove 2's and sort
sum(tail(x2, 2))       # comput sum of tail 2 elements

# Alternative 5 (avoid [] notation)
x2 <- sort(
  subset(x, x != 2))   # made it longer, but a little clearer, maybe?
sum(tail(x2, 2))       # comput sum of tail 2 elements

# Alternative 6 (build your own function, ADVANCED!)
myfunction <- function(y){
  y2 <- sort(
    subset(y, y != 2))   
  return(sum(tail(y2, 2)))  
}
myfunction(x)


# I.9 Packages ----------------------------------------------------------------

# to work with other packages, first download the package using:
#      install.package("tidyverse"). 
# I'm keeping it commented out because we don't have to run this each time we run 
# this particular script.

library(tidyverse) # have to run this every time with a new session

