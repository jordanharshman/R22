# REBECCA DUNTERMAN
# Assignment 2 Introduction to R

# Thank you for extending the deadline, and answering a ton of HW questions in class!!!!!!!!!!

# #1 ---------------- II.3

library(tidyverse)  #load the tidyverse
library(dplyr)      #load dplyr

setwd("C:/Users/rebdu/Documents/Foundations_of_R spring22") #set the working directory
 
df <- read_csv("df.csv")#load in / read df
copus <- read_csv("copus.csv")#load in / read copus for later

copus.csv <-read.csv("copus.csv") #a different format for loading in the data


# #2 ----------------------------------------------------------------------II.4

df2 <- df %>%
rename(ID = 1)%>% #call first variable ID
mutate(across(c(V2,V3,V4,V5,V6), abs)) %>% #changed V2 though V6 because they should have been positive 
  
  ## --- pH --- ## can use select() here: across(V2:V6)
  
mutate(V7 = if_else(V7 < -.9, NA_real_, V7)) %>% #replace than -.9 with na 
filter(V1 != 'D') %>% # get rid of D by selecting all but d
arrange(V1, V2) %>% #Sort the data by V1 first, Then in decreasing V2
group_by(V1) # group by v1 to do calculations
summarise(df2, Avg = mean(V2), StdDV = sd(V2)) #Calculate the mean and SD for V2

## --- pH --- ## Why stop the pipe at line 10? could just keep going 

## class notes code -df <- tibble(V1 = letters[1:4])%>%  # getting rid of d in 2
##  filter(V1 != "d")  # rename(df2,ID = X) %>% #rename column 1 as as ID
 
# #3  --------------------------------------------------------------II.5

df <- read_csv("df.csv") # re load
df.1= df # re name
df.1 %>%
select(V1, V2:V11) %>% #find where to pivot
pivot_longer(V2:V11, 'Variable') %>% #pivot and rename
rename(score = value) %>% #make naming match
  
  ## --- pH --- ## can rename within the pivot_longer() function:
  ## pivot_longer(V2:V11, 'Variable', values_to = "score")
  
mutate(SignScore = if_else(score > 0, "+","-")) #use score to assign signs 
# #4 ---------------------------------------------------------------II.6

#class notes -think about the join family, choose which is best for below 

key <- inner_join(df.1, df)# this creates the key by smooshing df.1 and df together
 ###I don't understand how to proceed , I'm sorry.

## --- pH --- ## All good; creat the key from scratch and then join the key to df
## -0.5

# II.7  -------------------------------------------------------------------
copus <- read_csv("copus.csv") #reload
df <- tibble(Variables = names(copus),  #create tibble from copus 
Type = rep(c("Demographic", "Behavior", "Cluster"), c(8,25,2))) #select variables ans quantities 
df %>%
unite("NewVariable", Type:Variables, sep= ".", remove = FALSE) %>%  #smoosh variables into same column .
relocate("NewVariable", .after = "Type") #re arrange

# 6 II8 -------------------------------------------------------------------

# class notes- should be a class example in powerpoint/class code

ggplot(copus, aes(x = Bcluster, y = Lec)) + #uses aesthetics to make x y, pick data
geom_boxplot() + # select type of graph 
scale_x_discrete(labels = c("Mostly Lecture", "Transitioning", "High Engagement")) # re order variables

## --- pH --- ## Silent error! You swapped the labels, but not the values!
## -0.5

  
  

 