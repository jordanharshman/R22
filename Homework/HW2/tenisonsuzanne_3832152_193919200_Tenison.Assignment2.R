#Suzanne E. Tenison
#Assignment 2 Introduction to R

# 1 ------------------------------------------------------
#Imported df.csv data and called object "df"
library(tidyverse)
library(dplyr)

## --- pH --- ## I encourage you set your working directory and load in from there, good habits

#2--------------------------------------------------------
df2 <- df %>% #rename "df" to be "df2"
  
  #a.) Rename "X1" as "ID"
rename("ID" = "...1") %>% # There is no "X1" in this file 
  
  #b.)All negative values in Variables V2 - V6 should have been positive 
  #All values will be positive for these variables
  mutate(V2 = abs(V2)) %>% # Take absolute value of V2, make values positive
  mutate(V3 = abs(V3)) %>% # Take absolute value of V3, make values positive
  mutate(V4 = abs(V4)) %>% # Take absolute value of V4, make values positive
  mutate(V5 = abs(V5)) %>% # Take absolute value of V5, make values positive
  mutate(V6 = abs(V6)) %>% # Take absolute value of V6, make values positive
  
  #c.)Any obs with V7 < -0.09 is an outlier; replace with NA, not removing rest of data
mutate(V7 = replace(V7, which (V7 < -0.09), NA)) %>% #Any value less than -0.09 is an outlier, replaced with "NA"
  #Had to separate less than "<" from the negative sign because code thought was "<-" denoted as
  
  #d.) Get rid of all observations where V1 is "D"
  filter(V1 == 'A' | V1 == 'B' | V1 == 'C') %>% #Filtered out all observations that weren't "D"
group_by (V1) %>% #Grouped V1 excluding "D"
  
  #e.) Sort the data by V1 (A-C) and within each category, in decreasing V2
arrange(V1, desc(V2)) %>% #Arranged V1 in descending order specific to each V1 category

  #f.) Calculate the mean and standard deviation of V2 for each category of V1
  mutate(V2.M = mean(V2)) %>% #Created V2.M to calculate the mean of V2
mutate(V2.stdev = sd(V2)) #Created V2.stdev to calculate the mean of V2
#view new variables in table within environment of df2 to see the mean (V2.M) and standard deviations (V2.stdev) of V1   

## --- pH --- ## A few comments:
##  - lines 17 - 21 can be condensed: mutate(across(V2:V6, abs))
##  - line 26 can be condensed by considering what should be removed instead of what should stay: filter(V1 != "D")
##  - lines 29-30 Using mutate causes unnecessay repetition of the means. Use summarize() instead

#3---------------------------------------------------------
#Ignore all modifications in #2, fresh import of dr.csv, modify to fit photo on assignment
df.1 <- df %>% #Rename df to df.1
as_tibble(df.1) %>% #create tibble of df.1
  select(-...1) %>% #remove "...1" from the tibble
  pivot_longer(-V1, "Variable") %>% #pivot data to match screenshot 
  rename(Score = value) %>% #Rename the value to be set as "Score"
  mutate(SignScore = if_else(Score<0, "-" , "+")) #Create "SignScore" to show the positive and negative sign for each variable's score
  df.1 #run df.1 to see tibble and view scores and correlated sign scores
  
  ## --- pH --- ## Can rename within pivot_longer, FYI: pivot_longer(-V1, "Variable", values_to = "Score")

#4---------------------------------------------------------
  #Create new dataset in R called "key", join it to df.1 (from #3) 
  #Every obs in df.1 with V1=A and Variable=V2 should be assignmed as NewValue =1 
  #Every obs in df.1 with V1=A and Variable =V3 should be assigned a New Value =2
  #Do not used chained if_else statements
V1 <- rep(c("A", "B", "C", "D"), each = 10) #to match screenshot, each variable is assigned values in increments of 10 from V2-V11
NewValue <- 1:40 #New Value reaches 40 because A,B,C,D exist (increments of 10 with 4 values)
key <- data.frame(V1, NewValue)
key$Variable = c("V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10", "V11")
key.join <- inner_join(df.1, key) #Joining data
key.join #Observe table 
#5---------------------------------------------------------                                                         
                                                                                    
df.n <- tibble(Variables = names(COPUS),
      Type = rep(c("Demographic", "Behaviour", "Cluster"), c(8, 25, 2))) %>% #previous code given in assignment
mutate(NewVariable = str_c(Type, Variables, sep = ".")) #combines the "Variables" and "Types" and separates the two with a "." within a string

#6---------------------------------------------------------
library(readxl)
copus <- read_excel("~/Downloads/COPUS.xlsx") # Importing copus excel file 
copus <- copus %>% # Bcluster levels
  mutate(Bcluster = factor(Bcluster, levels = c("Mostly lecture", "Transitioning", "High engagement"))) #Mutating the data to be in the correct order 
ggplot(copus, aes(x = Bcluster, y = Lec)) + geom_boxplot() #Boxplot containing Bcluster (x) and Lec (y) with specific x values
                                               