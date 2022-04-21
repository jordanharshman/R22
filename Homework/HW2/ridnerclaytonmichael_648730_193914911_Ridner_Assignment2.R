# Clayton 
# Assignment 2 Introduction to R
# 1 II.3 ---------------------------------------------------------------
library(tidyverse) #load tidyverse
library(dplyr) #load dplyr
setwd("/Users/cridner/Documents") # makes Documents wd (mac)
df <- read_csv("df.csv") # selects df the tidy way

# #2 II.4 ---------------- 
df2 <- df %>%
  rename(ID = 1) %>% #rename column 1 as as ID
  mutate(across(c(V2,V3,V4,V5,V6), abs)) %>% #change column V2-V6 to positive values
  mutate(V7 = if_else(V7 < -.9, NA_real_, V7)) %>% #remove all that are less than -.9 and use logical vectors
  filter(V1 != 'D') %>% #use only items with values A B and C in column ID
  arrange(V1, V2) %>% #Sort the data by V1 alphabetically, Then in decreasing V2
  group_by(V1)
  summarise(df2, Avg = mean(V2), StdDV = sd(V2)) #Calculate the mean and SD for V2

  ## --- pH --- ## Why did you stop piping at line 16?

# #3 II.5 -----------------------------------------------------------------
df.1 <- df %>% #Create new vector named df.1
  select('V1', 'V2':'V11') %>% #select V1 and V2-V11 as separate selections
    
    ## --- pH --- ## Do not need to quote thing when inside of dplyr verbs
    
  pivot_longer('V2':'V11', 'Variable') %>% #Pivot items V2-V11 into a new column into variable
  rename('Score' = 'value') %>% #Rename value to score 
  mutate(SignScore = if_else(Score > 0, "+", "-")) #create the last column with the + and - values

  ## --- pH --- ## Can rename within pivot_longer, FYI: pivot_longer(-V1, "Variable", values_to = "Score")

# #4 II.6 -----------------------------------------------------------------
key <- inner_join(df.1, df) %>% #Join the two data frames 
    rename(NewValue = 5) %>% #Rename the 5th column to NewValue
    arrange(NewValue) #Arrange by NewValue

  ## --- pH --- ## key can be made without reference to df
  ## -0.5
  
# #5 II.7 -----------------------------------------------------------------
copus <- read_csv("COPUS.csv") #pull copus into our working directory
  df <- tibble(Variables = names(copus), #make df. Create it using copus 
               Type = rep(c("Demographic", "Behavior", "Cluster"), c(8,25,2))) #use variables from columns and assign numbers
  df %>%
    unite("NewVariable", Type:Variables, sep= ".", remove = FALSE) %>%  #Make a new variable separating the names by a period
    relocate("NewVariable", .after = "Type") #Move the new variables after Type


# 6 II.8 ------------------------------------------------------------------
ggplot(copus, aes(x = Bcluster, y = Lec)) + #Tell R where to pull data from and what variables to assign to each axis
  geom_boxplot() + #Choose boxplot geometry
  scale_x_discrete(labels = c("Mostly Lecture", "Transitioning", "High Engagement")) #Place the order of the variables from left to right
  
## --- pH --- ## Silent error! You swapped the labels, but not the data!
  ## -0.5



  