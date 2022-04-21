# Adelia Grabowsky
# Assignment 2 Data Wrangling
library(tidyverse)

# Question 1, II.3 importing Data -----------------------------------------------------
#here's my code with adequate commenting

setwd("C:/Users/abg0011/Documents/CHEM_6450/datafiles") # makes wd my datafiles folder
df <- read_csv("df.csv") #reads in the df data

# Question 2, II.4 --------------------------------------------------------------------
#the first line creates a new object df2 and brings in the df data; 2nd line 
#renames the first column to ID; 3rd line makes all negative values of V2 
#to V6 positive by taking the absolute value; 4th line changes any occurrence of
#V7 less than .9 to NA_real; 5th line filters out any row with D; 6th line sorts
#the values first by V1 then by V2 (in descending order); 7th line groups by
#V1 (i.e. A, B, C); 8th line computes the mean and sd of each group (A, B, C) 
#9th line ungroups the data in case you need to do more code without that grouping

df2 <- df %>% 
  rename("ID" = "...1") %>% 
  mutate(V2 = abs(V2), V3 = abs(V3), V4=abs(V4), V5=abs(V5), V6=abs(V6)) %>%
  
  ## --- pH --- ## Anytime you get repetitive like this, you can likely shorten it:
  ## mutate(across(V2:V6, abs))
  
  mutate(V7 = ifelse(V7 < -0.9, NA_real_, V7)) %>% 
  filter(V1 != "D") %>% 
  arrange(V1, desc(V2)) %>% 
  group_by(V1) %>% 
  summarize(Mean = mean(V2), Stan_Dev = sd(V2)) %>% 
  ungroup() 
  

# Question 3, II.5 --------------------------------------------------------------------

#the first line creates a new object df.1 using the original df data; 2nd line
#selects the desired variables to include, V1 will have its own column, the values
#for V2 to V11 will all appear in a 2nd column; 3rd line pivots the values of 
#V2 to V11 so they appear in a column labeled Score, Values of V1 remain in a
#column labeled Variable; 4th line rounds the values in the Score column to 3
#decimal places then creates a new column in which the ifelse statement changes
#any instances less than 0 to "-" and the remaining values to "+".

df.1 <- df %>% 
  select(V1, V2:V11) %>%  
  pivot_longer(!V1, names_to = "Variable", values_to = "Score") %>%  
  mutate(SignScore = ifelse(Score < 0, "-", "+")) 

## --- pH --- ## Quick note in line 47: select() and pivot_longer() use a minus sign
## to select, not an exclamation mark. The ! could get you in trouble, so I would suggest -

         
# Question 4, II.6 ---------------------------------------------
# the 1st line reads in a dataset call Key; the 2nd line creates a new object
#called df.Key which pulls in the df.1 data (from Question 3); the 3rd line
#joins the Key data (which includes the NewValue column) to the df.1 data using
#full_join. Both V1 and Variable columns are used as 'keys' to join the data. 
#full_join was used so that every instance of df.1 would be matched to the Key 
#data, i.e. all 1000 observations would be matched to the appropriate new value.

Key <- read_csv("Key.csv") 
df.Key <- df.1 %>%
  full_join(Key, by = c("V1", "Variable"))

## --- pH --- ## Resourceful to import the data I provided, but I was hoping you would create it!
## -0.5

# Question 5 II.7 --------------------------------------------------------
#the 4th line (starting with mutate) is the one that was redacted. 
#It was used to create a new column (NewVariable) which unites the strings in
#the Variables column with the strings in the Type column using a "."

copus <- read_csv("COPUS.csv")
dfa <- tibble(Variables = names(copus), 
              Type = rep(c("Demographic", "Behavior", "Cluster"), c(8, 25, 2))) %>%
  mutate(NewVariable = str_c(Type, Variables, sep = "."))
dfa


             
# Question #6, II.8 -------------------------------------------------------
#the first line reads the copus data and saves it in a object called copus6
#the second line mutates the Bcluster variable using factor so that the strings
#appear in the desired order rather than the default order; the 3rd line
#creates a box plot with Bcluster on the x axis and Lec on the y axis

copus6 <- read_csv("COPUS.csv") %>%
  mutate(Bcluster = factor(Bcluster, levels = c("Mostly lecture", "Transitioning", 
                                                "High engagement"))) %>%
  ggplot(aes(x=Bcluster, y=Lec)) + 
  geom_boxplot()
copus6


