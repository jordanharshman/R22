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

#Jan 27

df.t <- as_tibble(df)
df
df.t

largedf <- data.frame(matrix(sample(1:10, 10000, replace = TRUE), nrow = 100))
largedf.t <- as_tibble(largedf)

# II.3 Importing data -----------------------------------------------------
setwd("C:/Users/jth0083/Desktop") # makes Desktop wd (windows)
# setwd("/jth0083/Desktop") # makes Desktop wd (mac)

setwd("C:/Users/jth0083/Documents") # makes Documents wd (windows)
# setwd("/jth0083/Documents") # makes Documents wd (mac)

# This is MY working directy and I HIGHLY DOUBT it will work for you, unless
# your user profile just happens to be "jth0083" or "jth0083" and you just 
# happen to have a folder called "R22" inside of a folder called "CHEM 6450
# Spring 2022" inside of a folder called "Teaching" inside of a folder called 
# "Box" in your user folder! If you do, you have problems...
setwd("C:/Users/jth0083/Box/Teaching/CHEM 6450 Spring 2022/R22") 

getwd() # verify working directory

# Note: my working directory is .../R22, but the COPUS.csv actually lives in
# .../R22/data, so I need to include the "data/" in order to navigate one more
# folder down. I do this because I want the primary directory to be .../R22 so
# I can easily access scripts stored in this parent directory.

# reading .csv files
copus.csv <- read.csv("COPUS.csv") # base R way
copus_csv <- read_csv("COPUS.csv") # tidy way

# reading .xlsx files
copus_excel <- read_excel("data/COPUS.xlsx") # error, can't find function
library(readxl) # load the package, need to install.package("readxl") first
copus_excel <- read_excel("data/COPUS.xlsx") # error, can't find function
# note the warnings: it saw numeric values and was expecting numerics, but got 
# character "NA" instead. 

# can also pull data straight from online, although not always practical for your own data
copus <- read_csv("https://github.com/jordanharshman/R22/blob/main/data/COPUS.csv") # wrong URL
copus <- read_csv("https://raw.githubusercontent.com/jordanharshman/R22/main/data/COPUS.csv") # raw

copus.csv <- read.csv("~/COPUS.csv")
New.Raw.Final <- read.csv("C:/Users/jth0083/Box/Publications/Grad Elements/Data/New Raw Final.csv", header=FALSE, comment.char="#")
setwd("C:/Users/jth0083/Box/Publications/Grad Elements/Data")
New.Raw.Final <- read.csv("New Raw Final.csv")
Old.Raw.Final <- read.csv("Old Raw.csv")

copus_csv <- read_csv("~/COPUS.csv")
copus_xlsx <- read_excel("~/COPUS.xlsx")

rm(copus.csv, copus_csv, copus_excel) # remove clutter

copus <- read_csv("~/COPUS.csv") # tidy way

# Exporting data
write_csv(copus, "COPUSmod.csv") # exports as .csv file to your default directory
save.image("copus.RData") # exports all objects as .RData
rm(list = ls()) # remove all objects in your environment
load("copus.RData") # brings everything back in

# IMPORTANT: if you export an environment with a silent error, you will import 
# it back in with that error. It is usually better to not save.image and instead
# do a fresh import of raw data and manipulation each time unless the code takes
# too long to run. 

rm(list = ls())
copus <- read_csv("C:/Users/jth0083/Box/Teaching/CHEM 6450 Spring 2022/R22/data/COPUS.csv")

# II.4 Filter ----------------------------------------------------------
copus.m <- filter(copus, Year > 2013) # tidy
copus.m <- copus[copus$Year > 2013 , ] # base, but didn't get the same result

# Feb 1

# Keep only obs from 2014 or 2015
copus.m <- filter(copus, Year == 2014 | Year == 2015) # tidy
copus.m <- filter(copus, Year %in% c(2014, 2015)) # tidy alternative
copus.m <- copus[copus$Year == 2014 | copus$Year == 2015, ] # base

# Keep only obs from Biological discipline and Large classes
copus.m <- filter(copus, Broader == "Biological", Size == "Large") # tidy
copus.m <- copus[copus$Broader == "Biological" | copus$Size == "Large", ] # base

# Keep only those for whom we know the Year, Semester, and Broader discipline (no NA's)
copus.m <- filter(copus, !is.na(Year) & !is.na(Semester) & !is.na(Broader)) # tidy
copus.m <- copus[!is.na(copus$Year) & !is.na(copus$Semester) & !is.na(copus$Broader), ] # base

# Keep only those with Lec between 50% and 75%
copus.m <- filter(copus, between(Lec, 50, 75)) # tidy
copus.m <- filter(copus, Lec >= 50, Lec <= 75)
copus.m <- copus[copus$Lec >= 50 & copus$Lec <= 75, ] # base

# Task 1 ------------------------------------------------------------------

# 1
copus.chem <- filter(copus, Broader == "Chemical")
mean(copus.chem$Lec, na.rm = T)
length(unique(copus.chem$Instructor.ID))
nrow(copus.chem)

# 2
copus.chem.l <- filter(copus.chem, Size == "Large")
mean(copus.chem.l$Lec, na.rm = TRUE)
copus.chem.s <- filter(copus.chem, Size == "Small")
mean(copus.chem.s$Lec, na.rm = TRUE)

# 3
copus.bio <- filter(copus, Broader == "Biological")
table(copus.bio$Bcluster) / nrow(copus.bio) * 100

# Feb 3

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

nrow(copus) / 4
copus.L <- arrange(copus, Lec)
copus.L$Lec[502 * 1:3]

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

#1
select(copus, Lec, Lec)

#2
select(copus, Lec, L)
select(copus, "Lec", "L")
select(copus, c("Lec", "L"))
vars <- c("Lec", "L")
select(copus, vars) # use all_of() here

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
copus.m <- ungroup(copus.m)

# Feb 8

# Make a variable call “ChemBio” that is the discipline except chemistry and 
# biology are combined into chembio and everyone else is the same
copus.m <- mutate(copus, ChemBio = if_else(
                  Broader == "Biological" | Broader == "Chemical", # if bio or chem
                  "ChemBio", # change to ChemBio if true
                  Broader)) # leave it alone if false, tidy
table(copus.m$Broader, copus.m$ChemBio) # check if it worked as intended
copus.m <- copus # base R
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

copus <- copus %>%
  ungroup() # end this section by ungrouping as it could affect code later on

# Task 6 ------------------------------------------------------------------





# II.5 Pivoting data ------------------------------------------------------
copus %>% # take copus, then...
  select(Broader, Lec:T_O) %>%     # select only the variables that need to be pivoted
  pivot_longer(-Broader, "InsBeh") # pivot, noting that Broader is a "key" variable, name new variable "InsBeh"

# summarize way:
copus %>%
  group_by(Broader) %>%          # group by Broader
  summarize(across(L:T_O, mean)) # take average of 25 variables

# using pivot:
copus.l <- copus %>% # define into new object
  select(Broader, CG:OG) %>%          # select only variables of interest
  pivot_longer(-Broader, "GroupWork") # pivot into long form

# plot: will discuss this in next topic
ggplot(copus.l, aes(x = GroupWork, y = value, color = Broader)) +
  geom_boxplot()

# II.5 Missing data -------------------------------------------------------

# Create some scores for 5 different tests
test1 <- tibble(ID = rep(1:2, each = 4),
                Test = c(1:3, 5, 1:2, 4:5),
                Score = c(50, NA, 80, 75, 60, 40, 80, NA))

test1 %>%
  complete(ID, Test) # fill in all unique values that are missing but present for both IDs

# II.6 Joining data ----------------------------------------

# create two test tibbles of repeat admin
test1 <- tibble(ID = 1:5,
                Test1 = c(50,65,80,90,75))

test2 <- tibble(ID = c(1:2,4:6),
                Test2 = c(65,60,80,85,100))

# Wrong way: do not use join functions:
Test <- test1 %>%
  mutate(Test2 = test2$Test2) # make a new variable with Test2 data
# Silent error! Not aligned!

# Joining data like this, "by index", is DANGEROUS! It is very easy to forget
# that you (intentionally or byproduct of a function) rearranaged your data and
# if you simply mutate another variable, you need to first ensure that the common
# variables are aligned. Using the join() family prevents this by checking it
# automatically.

test1 %>%
  right_join(test2) # test1 is LEFT; test2 is RIGHT; doing a RIGHT join

test1 %>%
  left_join(test2)  # test1 is LEFT; test2 is RIGHT; doing a LEFT join

test1 %>%
  inner_join(test2) # test1 is LEFT; test2 is RIGHT; doing an INNER join

test1 %>%
  full_join(test2)  # test1 is LEFT; test2 is RIGHT; doing a FULL join

test2 %>%
  right_join(test1) # test1 is RIGHT; test2 is LEFT; doing a RIGHT join

# create the dem object:
dem <- copus %>%
  select('Instructor ID':Layout) %>%
  filter(Broader != "Biological")

# create the res object:
res <- copus %>%
  select(`Instructor ID`:Year, L:Bcluster)

res %>%
  right_join(dem) # clearly, something very wrong happened here (79,234 observations?!)

# What happened? Consider a simpler dataset from: https://stackoverflow.com/questions/49256920/left-join-in-r-dplyr-too-many-observations
df1 <- data.frame(col1 = LETTERS[1:4],
                  col2 = 1:4)
df1
df2 <- data.frame(col1 = rep(LETTERS[1:2], 2),
                  col3 = 4:1)
df2
df1 %>%
  left_join(df2) # 6 rows instead of expected 4

# The purpose of this exercise was to get you to realize that you are asking for something
# that doesn't make sense: Recall that some instructors were observed multiple times for the 
# same class in the same semester and the same year, so all of these variables will not be unique
# and thus you will generate a lot duplicated rows. To fix this, you will need to make your by =
# argument completely unique by adding a variable that describes which observation it was. That
# variable doesn't currently exist in the data. There is a quick and dirty way to add this that
# works in this case, but more thought would need to be required before you assume that this would
# work in all cases:

copus.obs <- copus %>%
  mutate(Obs = 1:n())  # just add unique identifier for each row

# create the dem object:
dem <- copus.obs %>%
  select(Obs, 'Instructor ID':Layout) %>%
  filter(Broader != "Biological")

# create the res object:
res <- copus.obs %>%
  select(Obs, L:Bcluster)

# now I'm ready to join:

# 2,008 observations (if bio faculty aren't found, they get NA)
res %>%
  left_join(dem)

# 1,417 observations (no bio faculty present)
res %>%
  right_join(dem)

# 591 observations (no bio faculty present). None of our joins will work because
# the bio faculty aren't in the dem data set and aren't separated in the res data.
# We need to filter the res data to just keep the bio faculty, but Broader isn't 
# currently in that data. Join them to get the demographics, then filter just the
# bio faculty.
res %>%
  left_join(dem) %>%     # joins the data, adding the Broader variable
  filter(is.na(Broader)) # anyone with NA is a bio faculty here



# II.7 Strings -----------------------------------------------------------------

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
str_length(w1)   # alternative

paste(w1, w2, w3, w4, w5, w6) # combine multiple strings into 1
str_c(w1, w2, w3, w4, w5, w6) # alternative, except for how it handles NA
str_c(w1, w2, w3, w4, w5, sep = "/") # combine multiple strings into 1 with custom separator

paste(x, collapse = " ") # combine 1 vector of strings into 1 string
str_c(x, collapse = " ") #alternative, except how it handles NA

# PREDICT: Strings are still vectorized. What will this do?
str_c("Hey!", x)

x <- x[!is.na(x)] # get rid of all NA's

str_sub(x, 1, 3)   # subset first three letters of each index
str_sub(x, -3, -1) # subset last three letters of each index

str_to_lower(x) # all lowercase
str_to_upper(x) # all uppercase

str_sort(x) # alphabetize
str_sort(x, locale = "Haw") # alphabetize to the Hawaiian alphabet

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

# Instead of having all demographics spread across 8 variables, paste them all into 1.
# There is some wonkiness here though. The layout SHOULD be simple:
copus %>%
  mutate(Dem = str_c(`Instructor ID`:Layout, sep = "-")) # error

# This really stumped me when I ran it because it looks like it should run. Turns out,
# str_c was not designed be used in conjunction with the dyplyr select(), so it doesn't
# recognized the : indicates dplyr::select(). One way around this would be to hand-type
# all variables:

copus %>%
  mutate(Dem = str_c(`Instructor ID`, `Course ID`, Semester, Year, Broader, Level, Size, Layout, sep = "-")) %>%
  select(Dem)

# But this is still problematic; a lot of typing and if any NA are present, it provides
# NA for entire variable. Unite() is probably better as it understands select() and handles
# NA in the desired way:

copus %>%
  unite(Dem, `Instructor ID`:Layout, remove = FALSE, sep = "-") %>% # remove = T if you want
  select(Dem)

# II.8 Factors ------------------------------------------------------------

copus <- copus %>%
  mutate(Level = recode(Level, # instead of if_else(), this is great for bulk recoding
                        "100" = "Freshman",
                        "200" = "Sophomore",
                        "300" = "Junior",
                        "400" = "Senior"))
sort(unique(copus$Level)) # sort the unique values of Level

mod <- aov(Lec ~ Level, data = copus) # define anova model, Lec = DV; Level = IV
TukeyHSD(mod) # posthoc tests occur in alphabetical order

# make boxplot by Level, will discuss later
ggplot(copus, aes(x = Level, y = Lec)) +
  geom_boxplot()

copus <- copus %>%
  mutate(Level = factor(Level, levels = c("Freshman", "Sophomore", "Junior", "Senior", "Cross-listed", "Graduate")))

mod <- aov(Lec ~ Level, data = copus) # define anova model, Lec = DV; Level = IV
TukeyHSD(mod) # posthoc tests occur in order set by factor now

# make boxplot by Level, will discuss later
ggplot(copus, aes(x = Level, y = Lec)) +
  geom_boxplot()

copus$Level    # prints levels of the factor by default
copus$Level[1] # prints levels of the factor by default

# They are also locked, so if I try to rewrite over one of them, it has to be with one of
# the existing factors:

copus$Level[1] <- "Other" # generates NA because term is not a factor
copus$Level[1] # prove it
copus$Level[1] <- "Cross-listed" # set it back to original

levels(copus$Level) # tell me what levels of the factor are recognized
fct_relevel(copus$Level, "Sophomore", "Junior", "Senior", 
            "Cross-listed", "Graduate", "Freshman") # relevel a factor
fct_infreq(copus$Level) # reorder levels by most common
fct_inorder(copus$Level) # reorder levels by order they appear in the data
fct_rev(copus$Level) # reverse levels order
fct_expand(copus$Level, "Awesome R Courses") # add a level to factor
fct_drop(copus$Level) # drops any unused levels, like "Awesome R Course"

# II.9 Modeling -----------------------------------------------------------

# RQ: Does amount of lecture (Lec) predict the amount of listening (L)? 
mod1 <- lm(L ~ Lec, data = copus) # linear model (lm) between L by Lec
mod1 # provides limited information
summary(mod1) # provides suggested information you will need to interpret the model
names(mod1)   # all objects you can access now stored in mod1

mod1$coefficients # see just the coefficients; already printed in summary
mod1$residuals    # full list of residuals (error) for each observation, not printed in summary

# Here's a plot of the linear relationship we are modeling:
ggplot(copus, aes(x = Lec, y = L)) +
  geom_point() +
  geom_point(data = copus[1:2,], color = "red", size = 7) +
  geom_smooth(method = "lm")

# look at individual residuals:
copus %>%
  select(L, Lec) %>% # select only 2 modeled variables
  .[1:2, ]           # base way to return only the first two rows

# The slope-intercept equation is:
# L = (0.5514462)*Lec + 45.7570078
# So, for obs 1 & 2, the predicted L values should be:
(0.5514462 * 60.5) + 45.7570078 # = 79.1195 predicted L for Obs 1
(0.5514462 * 23.3) + 45.7570078 # = 58.6057 predicted L for Obs 2

# If that is the predicted, we can take the actual minus the predicted to find the residuals:
60.5 - 79.1195 # = -18.6195 residual for Obs 1
80 - 58.6057 # = 21.3943 residual for Obs 2
mod1$residuals[1:2] # these numbers have already been computed for us and stored in mod1
mod1$fitted.values[1:2]  # can also easily calculated predicted values

# The real power of R comes in the ease to incorporate this object back into the data frame
# for further manipulation and analysis. Let's look at the overall residual analysis, found
# in the base plot of the model:
plot(mod1)

# That's great, but is there any evidence that our model fits all disciplines equally?
# We have all the residuals at our disposal, so it's relatively easy to investigate this.
mod1.res <- copus %>%
  mutate(Residuals = mod1$residuals) # add in the residuals, which are in the same order

# plot results
ggplot(mod1.res, aes(x = Broader, y = Residuals)) +
  geom_boxplot()

# Seem to slightly under-predicting chemistry and biology while perhaps over-predicting
# math. Quite subjective, but helpful. 

# That was fun! What else is stored in mod1? See the documentation under "Values" to determine
# what is being presented to you in each of the commands:
?lm # see "Values" section which provides details about the values being provided
mod1$df.residual
mod1$call
mod1$model

# ANOVA context of modeling. First, look at a plot to get a sense of if the model will
# be significant or not:
ggplot(copus, aes(x = Size, y = Lec)) + 
  geom_boxplot() 

mod2 <- aov(Lec ~ Size, data = copus) # model anova between Lec (DV) and Size (IV)
summary(mod2) # all APA reporting needs
names(mod2)   # see what objects are available
?aov          # "Values" section is a bit sparse, so we're out of luck! found this online though:
              # https://docs.tibco.com/pub/enterprise-runtime-for-R/4.4.0/doc/html/Language_Reference/stats/aov.object.html

# Normally we think of anova as separate from linear models, but really they are the same.
mod3 <- lm(Lec ~ Size, data = copus) # define as linear model
summary(mod3)                        # print summary
mod2$coefficients # compare to the coefs of mod2
mod3$coefficients # same thing for mod3

# What is a residual in an anova? Plot to see predicted average per group:
pred.avg <- tibble(Size = c("Small", "Medium", "Large", NA),
                   Lec = mod2$fitted.values[c(1, 86, 94, 106)])
ggplot(copus, aes(x = Size, y = Lec)) + 
  geom_boxplot() +
  geom_jitter() + 
  geom_point(data = pred.avg, color = "red", size = 7)

# Let's copy the code above and replace it to see how the residuals line up across class sizes:
mod2.res <- copus %>%
  mutate(Residuals = mod2$residuals) # why didn't this work?

# ANOVA has to eliminate all missing values, it told us as much in the summary:
# "255 observations deleted due to missingness"
# We will have to do the same:
mod2.res <- copus %>%
  filter(!is.na(Size), !is.na(Lec)) %>%
  mutate(Residuals = mod2$residuals) # why didn't this work?

# plot results
ggplot(mod2.res, aes(x = Size, y = Residuals)) +
  geom_boxplot()

# Model is under-predicting across the board, but it's more prominent the smaller the class size.

# RQ: Does the interaction of Size and Layout of a classroom predict the amount of lecturing (Lec)?
# First, let's clean up Layout to get only categories of Fixed, Flexible, and NA:
copus.lay <- copus %>%
  mutate(Layout = if_else(Layout != "Fixed", "Flexible", Layout))

# Then, visualize results:
ggplot(copus.lay, aes(x = Size, y = Lec)) +
  geom_boxplot() +
  facet_wrap(~Layout)

# run the model:
mod4 <- aov(Lec ~ Size + Layout, data = copus.lay) # just want main effects, no interactions
mod5 <- aov(Lec ~ Size + Layout + Size:Layout, data = copus.lay) # want main effects and interactions
mod5 <- aov(Lec ~ Size*Layout, data = copus.lay) # shorthand for all main effects and interactions

# we'll just interpret mod5:
summary(mod5) # Results: main effects significant; interaction not significant


