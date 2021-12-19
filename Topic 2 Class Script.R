# Libraries ---------------------------------------------------------------
library(tidyverse)

# II.2 Data.frames and tibbles --------------------------------------------
var1 <- 1:5  # single object
var2 <- 6:10 # single object

df <- data.frame(var1 = 1:5,  # create data.frame, first variable is var1
                 var2 = 6:10) # second variable var2
str(df) # get the structure of df (also seen in top left Environment)

# create a df with 6 variables, the second one is character vector
df <- data.frame(V1 = c(1,3,3,4,3,3,2,2,4,5),
                 V2 = letters[c(1,2,1,1,1,1,2,2,1,2)],
                 V3 = sample(1:10),
                 V4 = sample(1:10),
                 V5 = sample(1:10),
                 V6 = sample(1:10))

df[ , 1] # first variable by index
df$V1    # first variable by name

df[5 , 1]   # first variable by index, 5th row
df$V1[5]    # first variable by name, 5th element

df[5 , 1] <- 4  # rewrite first variable by index, 5th row
df$V1[5] <- 4   # rewrite first variable by name, 5th element

df.t <- as_tibble(df)
df
df.t

largedf <- data.frame(matrix(sample(1:10, 10000, replace = TRUE), nrow = 100))
largedf.t <- as_tibble(largedf)


# II.3 Importing data -----------------------------------------------------
setwd("C:/Users/Jordan/Desktop") # makes Desktop wd (windows)
setwd("/Jordan/Desktop") # makes Desktop wd (mac)

setwd("C:/Users/Jordan/Documents") # makes Documents wd (windows)
setwd("/Jordan/Documents") # makes Documents wd (mac)

# This is MY working directy and I HIGHLY DOUBT it will work for you, unless
# your user profile just happens to be "Jordan" or "jth0083" and you just 
# happen to have a folder called "R22" inside of a folder called "CHEM 6450
# Spring 2022" inside of a folder called "Teaching" inside of a folder called 
# "Box" in your user folder! If you do, you have problems...
setwd("C:/Users/Jordan/Box/Teaching/CHEM 6450 Spring 2022/R22") 

getwd() # verify working directory

# Note: my working directory is .../R22, but the COPUS.csv actually lives in
# .../R22/data, so I need to include the "data/" in order to navigate one more
# folder down. I do this because I want the primary directory to be .../R22 so
# I can easily access scripts stored in this parent directory.

# reading .csv files
copus.csv <- read.csv("data/COPUS.csv") # base R way
copus_csv <- read_csv("data/COPUS.csv") # tidy way

# reading .xlsx files
copus_excel <- read_excel("data/COPUS.xlsx") # error, can't find function
library(readxl) # load the package, need to install.package("readxl") first
copus_excel <- read_excel("data/COPUS.xlsx") # error, can't find function
# note the warnings: it saw numeric values and was expecting numerics, but got 
# character "NA" instead. 

rm(copus.csv, copus_csv, copus_excel) # remove clutter

copus <- read_csv("data/COPUS.csv") # tidy way

# Exporting data
write_csv(copus, "data/COPUSmod.csv") # exports as .csv file to your default directory
save.image("data/copus.RData") # exports all objects as .RData
rm(list = ls()) # remove all objects in your environment
load("data/copus.RData") # brings everything back in

# IMPORTANT: if you export an environment with a silent error, you will import 
# it back in with that error. It is usually better to not save.image and instead
# do a fresh import of raw data and manipulation each time unless the code takes
# too long to run. 

# II.4 Filter ----------------------------------------------------------
copus.m <- filter(copus, Year > 2013) # tidy
copus.m <- copus[copus$Year > 2013 , ] # base, but didn't get the same result

# Keep only obs from 2014 or 2015
copus.m <- filter(copus, Year == 2014 | Year == 2015) # tidy
copus.m <- filter(copus, Year %in% c(2014, 2015)) # tidy alternative
copus.m <- copus[copus$Year == 2014 | copus$Year == 2015, ] # base

# Keep only obs from Biological discipline and Large classes
copus.m <- filter(copus, Broader == "Biological", Size == "Large") # tidy
copus.m <- copus[copus$Broader == "Biological" | copus$Size == "Large", ] # base

#Keep only those for whom we know the Year, Semester, and Broader discipline (no NA’s)
copus.m <- filter(copus, !is.na(Year) & !is.na(Semester) & !is.na(Broader)) # tidy
copus.m <- copus[!is.na(copus$Year) & !is.na(copus$Semester) & !is.na(copus$Broader), ] # base

# Task 1 ------------------------------------------------------------------


# II.4 Arrange ------------------------------------------------------------
# Arrange the data according from increasing to decreasing lecture (Lec)
arrange(copus, Lec) # tidy, but you did not change the object!
copus.m <- arrange(copus, Lec) #tidy
copus.m <- copus[order(copus$Lec), ] # base

# Arrange in decreasing order according to lecture (Lec)
copus.m <- arrange(copus, desc(Lec)) #tidy
copus.m <- copus[rev(order(copus$Lec)), ] # base

# Arrange in increasing order base first on Year, then on Semester, then on discipline (Broader)
copus.m <- arrange(copus, Year, Semester, Broader) #tidy
copus.m <- copus[order(copus$Year, copus$Semester, copus$Broader), ] # base
copus.m <- copus[with(copus, order(Year, Semester, Broader)), ] # base alternative

# Task 2 ------------------------------------------------------------------


# II.4 Select -------------------------------------------------------------
# Select only the class size (Size) and lecture amount (Lec) variables.
copus.m <- select(copus, Size, Lec) # tidy
copus.m <- copus[ , names(copus) %in% c("Size", "Lec")] # base

# Select only the demographic variables (Instructor ID through Layout)
# There is some wonkiness here to address first. The first and second variables
# (Instructor ID and Course ID) have a space in their name, which is not great:
copus$Instructor ID # error; cannot have spaces in names
copus$`Instructor ID` # no error; how to handle spaces in names, but still sucks

copus.m <- select(copus, 'Instructor ID':Layout) # tidy
copus.m <- copus[names(copus)[1:8]] # base, but we had to reference by index
 
# Select everything except the demographic variables (Instructor ID through Layout)
copus.m <- select(copus, -'Instructor ID':-Layout) # tidy
copus.m <- copus[names(copus)[-1:-8]] # base, but we had to reference by index

# Select anything that starts with an “L”
copus.m <- select(copus, starts_with("L")) # tidy, no clear base alternative

# Select anything that contains “cluster”
copus.m <- select(copus, contains("cluster")) # tidy, no clear base alternative

# Reorder the variables so that Lec is first followed by everything else
copus.m <- select(copus, 'Instructor ID':Layout, Cluster, Bcluster, L:T_O) # tidy, no clear base alternative
copus.m <- select(copus, 'Instructor ID':Layout, Cluster, Bcluster, everything()) # tidy alternative

# (different dataset) Select variables that end in a 1:4
df <- as_tibble(matrix(rep(1, 1000), nrow = 10))
df.m <- select(df, num_range("V", 1:4))


# Task 3 ------------------------------------------------------------------



# II.4 Mutate -------------------------------------------------------------
# Create a variable that converts Lec to proportion instead of percent.
copus.m <- mutate(copus, Lec.p = Lec / 100) # tidy
copus.m <- copus # base
copus.m$Lec.p <- copus.m$Lec / 100 # base

#Write over the existing Lec variable as a proportion and then write it back as percent.
copus.m <- mutate(copus, Lec = Lec / 100) # tidy, replace
copus.m <- mutate(copus, Lec = Lec * 100) # tidy, return
copus.m <- copus # base
copus.m$Lec <- copus.m$Lec / 100 # base, replace
copus.m$Lec <- copus.m$Lec * 100 # base, return

# “Broader” was a dumb name – make new variable called “Discipline”
copus.m <- mutate(copus, Discipline = Broader) # tidy
copus.m <- copus # base
copus.m$Discipline <- copus.m$Broader # base

# Make a All Group Work (AGW) variable that takes the average of CG, WG, and OG
copus.m <- mutate(copus, AGW = mean(CG, WG, OG)) # didn't work...
copus.m <- mutate(copus, AGW = mean(c(CG, WG, OG))) # silent error
copus.m <- rowwise(copus) # tell R to conduct operations row-wise
copus.m <- mutate(copus.m, AGW = mean(c(CG, WG, OG))) # perfection
copus.m <- mutate(copus, AGW = rowMeans(select(copus, CG, WG, OG))) # alternative
copus.m <- copus # base
copus.m$AGW <- rowMeans(copus[ , names(copus) %in% c("CG", "WG", "OG")]) # base

# Make a variable call “ChemBio” that is the discipline except chemistry and 
# biology are combined into chembio and everyone else is the same
copus.m <- mutate(copus, ChemBio = if_else(
                  Broader == "Biological" | Broader == "Chemical", # if bio or chem
                  "ChemBio", # change to ChemBio if true
                  Broader)) # leave it alone if false, tidy
table(copus.m$Broader, copus.m$ChemBio) # check if it worked as intended
copus.m <- copus
copus.m$ChemBio <- ifelse(copus$Broader == "Biological" | copus$Broader == "Chemical", # if bio or chem
                           "ChemBio", # change to ChemBio if true
                           copus$Broader) # leave it alone if false, base
table(copus.m$Broader, copus.m$ChemBio) # check if it worked as intended

# Task 4 ------------------------------------------------------------------


# II.4 Summarize ----------------------------------------------------------
# or summarise for our British friends, both work :)

# Compute the average Lec for each Broader discipline.
copus <- group_by(copus, Broader) # tidy
summarize(copus, Avg = mean(Lec)) # tidy
aggregate(copus$Lec, by = list(lecture = copus$Broader), mean) # base

# Compute percent of sample in each discipline (Broader)
copus <- group_by(copus, Broader) # already grouped, but good to get in the habbit
summarize(copus, Count = n()) # gives count, not percent
summarize(copus, Count = n()/n()) # that didn't work, silent error
summarize(copus, Count = n()/sum(n())) # nope, still working only by grouping variable
disciplines <- summarize(copus, Count = n()) # store to object (still grouped)
mutate(disciplines, Percent = Count / sum(Count) * 100) #... okay, I guess
table(copus$Broader) / nrow(copus) * 100 # base, returns named vector instead of tibble

# When data are grouped, summarize will only operate within those groups, so if 
# there are 8 groups, summarize will always return a vector of length 8 and any
# function applied will be applied to each of those 8 separately. Mutate, works
# on the whole data regardless of groups, so asking for the sum of counts is valid.

# Compute the min, max, and average of Lec by class Size
copus <- group_by(copus, Size) # group by size
summarize(copus,               # tidy
          Min = min(Lec),      # min
          Max = max(Lec),      # max
          Avg = mean(Lec))     # mean
aggregate(copus$Lec, by = list(Size = copus$Size), min)  # base
aggregate(copus$Lec, by = list(Size = copus$Size), max)  # base
aggregate(copus$Lec, by = list(Size = copus$Size), mean) # base

copus <- group_by(copus, Semester, Year) # group by semester & year
summarize(copus, Avg = median(Lec))
aggregate(copus$Lec, by = list(Semester = copus$Semester, Year = copus$Year), mean)  # base

# Compute the distribution of classroom Layout for each of the three cluster categories (Bcluster)
copus <- group_by(copus, Layout, Bcluster) # group by layout and cluster
summarize(copus, n()) # tidy
tally(copus) # tidy shortcut, tally() just means the function is always n() to count
table(copus$Layout, copus$Bcluster) # base, returns table in wide form

# Task 5 ------------------------------------------------------------------


# II.4 The Pipe -----------------------------------------------------------

# Task: Filter copus to keep only large classes; then center the Lec variable 
# (take each Lec minus the average of Lec); then compute the average centered  
# Lec by Discipline.

# without the pipe:
copus.large <- filter(copus, Size == "Large")   # filter only large classes
copus.large <- mutate(copus.large, Lec.c = Lec - mean(Lec)) # create centered variable
copus.large <- group_by(copus.large, Broader)   # group by discipline
summarize(copus.large, AvgCenLec = mean(Lec.c)) # compute averages by group

# with the pipe:
copus %>%
  filter(Size == "Large") %>% # filter only large classes, then...
  mutate(Lec.c = Lec - mean(Lec)) %>% # create centered variable, then...
  group_by(Broader) %>% # group by discipline, then...
  summarize(AvgCenLec = mean(Lec.c)) # compute averages by group
  

# Task 6 ------------------------------------------------------------------

#s
# Strings -----------------------------------------------------------------


string1 <- "This is a string"
string2 <- 'If I want to include a "quote" inside a string, I use single quotes'
# demonstrate: 
# string3 <- "Oh no, I'm stuck

x <- "\"" # this is how you quote a quotation mark
x         # printing x will show you the contents
writeLines(x) # writeLines will render the contents and display the result

x <- "I want a\nnew line"
x
writeLines(x)

x <- c("Celebrate", "good", "times", "come", "on!", NA)
w1 <- "Celebrate"
w2 <- "good"
w3 <- "times"
w4 <- "come"
w5 <- "on!"
w6 <- NA

str_length(x)    # compute string lengths for all indices
str_length(x)[1] # compute string lengths for just first index
str_length(w1)   # alternative

paste(w1, w2, w3, w4, w5, w6) # combine multiple strings into 1
str_c(w1, w2, w3, w4, w5, w6) # alternative, except for how it handles NA
str_c(w1, w2, w3, w4, w5, sep = "/") # combine multiple strings into 1 with custom separator

paste(x, collapse = " ") # combine 1 vector of strings into 1 string
str_c(x, collapse = " ") #alternative, except how it handles NA

# PREDICT: Strings are still vectorized. What will this do?
str_c("Hey!", x)

x <- x[!is.na(x)] # get rid of all NA's (! means "is not")

str_sub(x, 1, 3)   # subset first three letters of each index
str_sub(x, -3, -1) # subset last three letters of each index

str_to_lower(x) # all lowercase
str_to_upper(x) # all uppercase

str_sort(x) # alphabetize
str_sort(x, locale = "Haw") # alphebetize to the Hawaiian alphebet

# Matching characters in a string

str_detect(x, "me") # find which strings have "me" anywhere
str_detect(x, ".o.") # find any strings that have an "o" sandwhiched between any characters
str_detect(x, "o.") # find any strings that have an "o" with any character that follows
str_detect(x, ".") # this is clearly not doing what we think it's doing
str_detect(x, "\\.") # find any strings that have an "o" with any character that follows
str_detect(x, "^t") # find any strings that start with "t"
str_detect(x, "[aeiou]$") # find any strings that end in a vowel
str_detect(x, "[aei]") # find any strings that have a, e, or i anywhere
!str_detect(x, "[aei]") # find any strings that DO NOT have a, e, or i anywhere

# Splitting
x <- str_c(x, collapse = " ") # collapse the vector of strings into 1 string
str_split(x, " ") # split each into an index in one vector, returns as a list
str_split(x, " ", simplify = TRUE) # alternative, no list, but as matrix
unlist(str_split(x, " ")) # alternative, no list, but as vector


