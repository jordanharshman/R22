#ANSLEY HAMID
#Assignment 2 Data Wrangling

# 1 -----------------------------------------------------------------------
library(tidyverse)
library(dplyr)

## --- pH --- ## FYI when you load tidyverse, that loads dplyr as well

library(readr)
df <- read_csv("C:/Users/akh0084/OneDrive - Auburn University/Desktop/Classes/Masters/Spring 2022/DBER/df.csv")
View(df)

## --- pH --- ## I encourage you set your working directory and load in from there, good habits

# 2 ---------------------------------------------------------------------

df2 <- df %>%
  rename("ID" = "...1") %>% #renames X1 as ID
  mutate(V2 = abs(V2)) %>% #changes all V2-V6 values to positive
  mutate(V3 = abs(V3)) %>%
  mutate(V4 = abs(V4)) %>%
  mutate(V5 = abs(V5)) %>%
  mutate(V6 = abs(V6)) %>%
  mutate(V7 = replace(V7, which (V7 < -0.9), NA)) %>% #Replace all V7 < -0.9 with NA
  filter(V1 == 'A' | V1 == 'B' | V1 =='C') %>% #Filter to only have where V1 is A, B, or C
  group_by(V1) %>% #group by the groups A, B, and C in V1
  arrange(V1, desc(V2)) %>% #arrange dataset so that each group is in descending V2 order
  mutate(V2.mean = mean(V2)) %>% #add a column that computes the mean of V2 for each V1 group
  mutate(V2.sd = sd(V2)) #add a column that computes the sd of V2 for each V1 group

## --- pH --- ## A few comments:
##  - lines 20 - 24 can be condensed: mutate(across(V2:V6, abs))
##  - line 26 can be condensed by considering what should be removed instead of what should stay: filter(V1 != "D")
##  - lines 29-30 Using mutate causes unnecessay repetition of the means. Use summarize() instead

# 3 ---------------------------------------------------------------------

df.1 <- df %>%
  as_tibble(df) %>% #converts dataset to tibble
  select(-...1) %>% #deletes column that starts with X1 (...1) that does not have meaning
  pivot_longer(-V1, "Variable") %>% #pivots the dataset to group by V1 variables A, B, and C
  rename(Score = value) %>% #rename column to Score
  
  ## --- pH --- ## Can rename within pivot_longer, FYI: pivot_longer(-V1, "Variable", values_to = "Score")
  
  mutate(SignScore = if_else(Score<0, "-", "+")) #add column called SignScore that produces + and - based on Score sign
df.1 #View df.1 to compare to goal tibble


# 4 ---------------------------------------------------------------------
V1 <- rep(c("A", "B", "C", "D"), each = 10) #create a vector called V1 with letters each repeating 10x
NewValue <- 1:40 #create vector called NewValue with values 1:40
key = data.frame(V1, NewValue) #create dataframe with V1, NewValue
key$Variable = c("V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10", "V11") #create new column called Variable that repeats V1:V11
#you now have a table that has the desired columns V1, Variable, and NewValue
#Now have to join with df.1 so that Score and SignScore are part of the table 

key.join <- inner_join(df.1, key) #joins to combine key V1, Variable, and NewValue as they appear in df.1
key.join #Confirm output table looks like goal table

# 5 ---------------------------------------------------------------------

previous code %>%
  mutate(NewVariable = str_c(Type, Variables, sep = ".")) #Creates a new column as a string that combines the elements in Type and Variables with a period as a separator

## --- pH --- ## Just couldn't copy/paste it?!

# 6 -----------------------------------------------------------------------

library(readxl)
copus <- read_excel("C:/Users/akh0084/OneDrive - Auburn University/Desktop/Classes/Masters/Spring 2022/DBER/copus.xlsx")

copus <- copus %>% #creates levels for the Bcluster column 
  mutate(Bcluster = factor(Bcluster, levels = c("Mostly lecture", "Transitioning", "High engagement")))

ggplot(copus, aes(x = Bcluster, y = Lec)) +
  geom_boxplot() #creates a boxplot of Bluster vs Lec based on the levels (order) specified in Bcluster

