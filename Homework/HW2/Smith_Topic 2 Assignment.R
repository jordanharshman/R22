# Libraries ---------------------------------------------------------------
library(tidyverse)
library(dplyr)
library(naniar)

setwd("//Users/april/Dropbox/R data") # makes Desktop wd (home mac)
setwd("//Users/ars0152/Dropbox/R data") # makes Desktop wd (laptop mac)

copus <- read.csv("COPUS.csv") # base R way

# APRIL SMITH
# Assignment 2 Data Wrangling


# 1 -----------------------------------------------------------------------

df <- read_csv("https://raw.githubusercontent.com/jordanharshman/R22/main/data/df.csv")



# 2 -----------------------------------------------------------------------


df2 <- rename(df, ID = ...1) %>% #Rename “V1” as “ID”
  mutate(V2 = abs(V2),
         V3 = abs(V3),
         V4 = abs(V4),
         V5 = abs (V5),
         V6 =abs (V6)) %>% # All negative values in Variables V2 though V6 should have been positive
  replace_with_na_at(.vars = c("V7"),
                     condition = ~ .x < -0.9) %>% #replacing values less than -.9 for V7 with NA
  filter(V1 !="D") %>%
  arrange(V1, desc(V2)) %>% #Sort the data by V1 (A to C) and within each category, in decreasing V2 
  group_by(V1) %>%
  summarize(mean=mean(V2), sd=sd(V2)) #Calculate the mean and standard deviation of V2 for each category of V1

## --- pH --- ## Correct answer, but a few suggestions:
##  - lines 25 - 29 can be condensed: mutate(across(V2:V6, abs))
##  - replace_with_na_at() is an interesting function; need to define .vars and a tilda expression which is nonintuitive; 
##    Consider: mutate(V7 = if_else(V7 < -0.9, NA_real_, V7))


# 3 -----------------------------------------------------------------------

df <- read_csv("https://raw.githubusercontent.com/jordanharshman/R22/main/data/df.csv")
  
df.1 <- df %>%
  select(V1, V2:V11) %>%          # select only variables of interest
  pivot_longer(-V1, "Score") %>% # pivot into long form
  rename(Variable = Score) %>%
  rename(Score = value) %>%
  mutate(SignScore = case_when(Score < 0 ~ '-',
                               Score > 0 ~ '+')) #creating the -/+ variable

## --- pH --- ## Can rename within pivot_longer, FYI: pivot_longer(-V1, "Variable", names_to = "Variable", values_to = "Score")
  
 # 4 -----------------------------------------------------------------------

#I was able to approximate what you asked for by creating my own "key" data file with 3 variables
#but not sure this was the solution you had in mind

key <- read.csv("key.csv") # base R way

keydf <- key %>%
  full_join(df.1) %>%
 
  ## --- pH --- ## Good, but I meant for you to create key, not import it
  ## -0.5


# 5 -----------------------------------------------------------------------

df5 <- tibble(Variables = names(copus),
              Type = rep(c("Demographic", "Behavior", "Cluster"), c(8, 25, 2))) %>%
   unite("NewVariable", Variables:Type, remove = FALSE) 

## --- pH --- ## Minor difference: the default seperator is "_" when I was looking for "."
              

# 6 -----------------------------------------------------------------------

copus <- read.csv("COPUS.csv") # base R way


copus %>%
  mutate(Bcluster = fct_relevel(Bcluster, "Mostly lecture", "Transitioning", "High Engagement",))  %>%
  ggplot(aes(x = Bcluster, y = Lec)) +
  geom_boxplot()

## --- pH --- ## Good use of fct_relevel; consider that this does NOT change the copus data, which you may or may not want


