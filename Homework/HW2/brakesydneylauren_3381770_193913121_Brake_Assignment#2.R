# SYDNEY BRAKE
# Assignment 2 Data Wrangling


# #1 ----------------------------------------------------------------------
library(tidyverse)
df=read.csv(file.choose()) 

## --- pH --- ## Always advice to spell out the exact filename instead of using the choose file option for reproducability

# #2 ----------------------------------------------------------------------
 df %>%
  rename(ID = X1) %>% #rename column X to ID
  mutate(across(c(V2,V3,V4,V5,V6), abs)) %>% #change column V2-V6 to positive values
  mutate(V7 = if_else(V7 < -.9, NA_real_, V7)) %>% #remove all that are less than -.9 
  filter(V1 != 'D') %>% #get rid of D
  arrange(V1, V2) %>% #Sort the data by V1 alphabetically, decreasing V2
  group_by(V1)
summarise(df, Avg = mean(V2), StdDV = sd(V2)) #Calculate the mean and SD for V2

## --- pH --- ## You are missing a pipe on line 18. Because of this, the summarize
## in line 19 is giving you the wrong solution
## -0.5
  
# #3 ----------------------------------------------------------------------
df.1=read.csv(file.choose())
df.1 %>%
  select(V1, V2:V11) %>% #choosing which to pivot
  pivot_longer(V2:V11, 'Variable') %>% #pivoting and giving new name
  rename(score = value) %>% #renaming the value column
  mutate(SignScore = if_else(score > 0, "+","-")) #adding the sign score based on scores
  
# #4 ----------------------------------------------------------------------
key <- inner_join(df.1, df) %>% #joining df and df.1
  rename(NewValue = 5) %>% #adding the new value column
  arrange(NewValue) #arranging them to match up with df and df.1 values

## --- pH --- ## The key variable could be made just by repeating patterns as opposed
## to an join function; join will be used to merge the two datasets together
## -0.5

# #5 ----------------------------------------------------------------------
copus=read.csv(file.choose())
df <- tibble(Variables = names(copus),
             Type = rep(c("Demographic", "Behavior", "Cluster"), c(8,25,2))) #given info #telling what variables and how many to list
df %>%
  unite("NewVariable", Type:Variables, sep= ".", remove = FALSE) %>%  #adding the two variables together in a new column by a .
  relocate("NewVariable", .after = "Type") #scooting the new column to the end

# #6 ----------------------------------------------------------------------
ggplot(copus, aes(x = Bcluster, y = Lec)) + #set x and y and tell what data to choose from
  geom_boxplot() + #choose boxplot geometry
  scale_x_discrete(labels = c("Mostly Lecture", "Transitioning", "High Engagement")) #manually input the order of the variables on the x axis

## --- pH --- ## Silent error! You have changed the labels, but not the data itself!
## -0.5
