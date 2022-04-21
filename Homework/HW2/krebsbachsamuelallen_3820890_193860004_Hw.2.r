
# #1 ----------------------------------------------------------------------
#reads the df table out of my onedrive folder
library(readr)
df <- read_csv("OneDrive - Auburn University/Class/Fountations of R/R22-main/data/df.csv")
View(df)#prints the df table

#Sam krebsbach
#asignment 2 intro to R

library(tidyverse) #adds tidyverse so i can complete this assignment
library(dplyr) #dplyer so I can complete this assignment

## --- pH --- ## FYI loading tidyverse also loads dplyr

# #2----------------------------------------------------------------------

df2 <- df %>% #renames df as df2 so all the following code does not overwrite df
  rename("ID" = "...1") %>% #renames the ...1 cell as ID
  mutate(V2 = abs(V2)) %>% #takes the absolute vales of the V2 column overwrites them
  mutate(V3 = abs(V3)) %>% #takes the absolute vales of the V3 column overwrites them
  mutate(V4 = abs(V4)) %>% #takes the absolute vales of the V4 column overwrites them
  mutate(V5 = abs(V5)) %>% #takes the absolute vales of the V5 column overwrites them
  mutate(V6 = abs(V6)) %>% #takes the absolute vales of the V6 column overwrites them
  mutate(V7 = replace(V7, which(V7 < -0.9), NA)) %>% #all values in column 7 below -0.9 are now NA
  filter(V1 == 'A' |V1 == 'B' | V1 == 'C') %>% #filters column V1 and makes keeps all characters accept D
  group_by(V1) %>% #groups column V1 by individual character
  arrange(V1, desc(V2)) %>% #arranges column V2 in descending order
  mutate(V2m = mean(V2)) %>% #makes a column with the mean values from each group
  mutate(V2stdv = sd(V2)) #makes a cilumn witht he standard deviastion values from each group

## --- pH --- ## A few comments:
##  - lines 20 - 24 can be condensed: mutate(across(V2:V6, abs))
##  - line 26 can be condensed by considering what should be removed instead of what should stay: filter(V1 != "D")
##  - lines 29-30 Using mutate causes unnecessay repetition of the means. Use summarize() instead


# #3 ----------------------------------------------------------------------
df.1 <- df
df.1 <- df %>% #makes a new dataset called df.1 withthe data from df
  as_tibble(df.1) %>% #makes sure df.1 is a tibble
  select(-'...1') %>% #selects everything but ...1, so removes ...1
  pivot_longer(-V1, "Variable") %>% #pivots from wider to longer around the Variable column
  rename(Score = value) %>% #ranames the value column header to score
  mutate(SignScore = if_else(Score >0, "+", "-")) #makes a column called signscore with + or - based on scores column positive or negetive numbers

## --- pH --- ## Can rename within pivot_longer, FYI: pivot_longer(-V1, "Variable", values_to = "Score")

df.1 #prints new table

# #4 ----------------------------------------------------------------------

V1 <- c("A","B","C","D", each = 10) #makes a dataset with to letters of A, B, C, and D

NewValue <- c(1:40) #makes a dataset of numbers 1 through 40

key <- data.frame(V1, NewValue) #takes the two new datasets created and makes them a dataframe called key
key$Variable = c("V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10") #makes a new column in dataset key and labels each row with v1 all th eway to v40

df.4 <- inner_join(df.1, key) #joins the df.1 and key tables based on the new value column so every valye has its correct score signscore and new value
df.4 #prints new tibble

# #5 ----------------------------------------------------------------------

df <- tibble (Variables = names(copus), #part of the code from the picture
              type = rep(c("Depographic......")))

## --- pH --- ## It isn't running because you missed a pipe at the end of line 66

mutate(NewVariable = str_c(Type, Varaiables, sep ".")) #the line from the picture that was missing
#none of this will run because its not complete code and the tibble data is not imported

# #6 ----------------------------------------------------------------------

library(readxl) #reads copus data from my ondrive folder
COPUS <- read_excel("OneDrive - Auburn University/Class/Fountations of R/R22-main/data/COPUS.xlsx")
View(COPUS)


library(ggplot2) #allows ggplot to run on my computer

copus <- COPUS %>% #renames copus in small font
mutate(Bcluster = factor(Bcluster, levels= c("Mostly lecture", "Transitioning",
                                             "High engagement"))) #groups the characters in the bcluster column
  
  
  ggplot(copus, aes(x = Bcluster, y =Lec)) + geom_boxplot() #makes the box plot of the mutate we did previously

  