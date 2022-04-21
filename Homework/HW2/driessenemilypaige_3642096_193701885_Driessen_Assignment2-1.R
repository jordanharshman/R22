 # Emily Driessen
 # Assignment #2 Topic 2 Data Wrangling

# 1 -----------------------------------------------------------------------
#1. II.3 Import the df.csv data to an object called “df”.
library(tidyverse)#load tidyverse
library(dplyr)

## --- pH --- ## loading tidyverse automatically loads dplyr, FYI

setwd("~/Box/Class Files/Intro to R/Assignment 2") #set my working directory
df <- read.csv("~/Box/Class Files/Intro to R/Assignment 2/df.csv", header=TRUE) # import dataset the tidy way

## --- pH --- ## If you've set your working directory, you don't need "~/Box/Class Files/Intro to R/Assignment 2/"

df #view df

# 2 -----------------------------------------------------------------------
#2. II.4 In one continuous statement connected by piping operators, making the following changes to df and store it as df2:
  #a. Rename “X1” as “ID”
    ?rename #check out rename function and read how it works
    df2<-df %>% #pipe takes the datasaet df and relabels it df2 after completing the second step of the pipe - rename
    rename(ID = X) 
    
  #b. All negative values in Variables V2 though V6 should have been positive (all values will be positive for these variables); change this.
    ?abs #learn about the absolute value function, only works if data is numeric. I kept getting error messages because it was saying there were non-numeric-alike variables in my data frame.
    df2 <- df2 %>% #using df2 dataset
    mutate(across(V2:V6, abs)) #take the absolute value of all numbers in columns V2, V3, V4, V5, and V6
    
  #c. Any obs with V7 less than -0.9 is an outlier; replace these instances with NA, but do not remove the rest of their data. 
       #Hint: If you are getting an error such as “`false` must be a logical vector, not a double vector,” check out the following and replace NA with NA_real_ (https://stackoverflow.com/questions/53636644/r-if-else-assign-na-value/53636776).
    df2 <- df2 %>% #using df2 dataset
      mutate(V7 = ifelse(V7< -0.9, NA, V7)) # if the value in column V7 in the df2 dataset is less than -0.9, then we will replace it with NA, BUT if the value is not less than -0.9, then we will leave it alone to say whatever it already said in the column V7
  
     #d. Get rid of all observations where V1 is “D”
    df2<-df2 %>% #using df2 dataset
    filter(V1 %in% c("A", "B", "C") ) #This filters for A, B, and C in column V1, leaving out D. 
 
    ## --- pH --- ## Consider filtering OUT "D" instead of keeping everything else (less typing)
    
  #e. Sort the data by V1 (A to C) and within each category, in decreasing V2 
    df2<-df2 %>% #take df2 and then...
      arrange(V1, desc(V2))# arrange sorts in increasing order, so I asked R to sort V1 in increasing order (a, B, and then C) and then added desc to make it arrange in decreasing V2 order as the prompt asked
    
  #f. Calculate the mean and standard deviation of V2 for each category of V1
    Mean.SD<-df2 %>% #take df2 and create a new object called Mean.SD
    group_by(V1) %>% #group the data by V1 so it will be ready for the summary and create a sd and mean for each of the categories in V1
    summarise(mean(V2), sd(V2)) # this calculates the mean and standard deviation for variable 2 for each of the categoires in V1
    Mean.SD #View the new object that has the mean and sd for each of the categories in V1
    
## --- pH --- ## All statements are correct, but the prompt asked for "In one continuous statement connected by piping operators"
## -0.5

# 3 -----------------------------------------------------------------------
#3. II.5 Ignoring all modifications in #2 and starting from a fresh import of df.csv, modify 
#the data into an object called df.l that matches the screenshot.
#basically, we want a column of V1, and then want a list of each variable and the score for that variable in the order with the sign score. We want to flip the table I think, at least for variables 2-11
df <- read.csv("~/Box/Class Files/Intro to R/Assignment 2/df.csv", header=TRUE) # import new, fresh df
df.1<-df %>%
  select(V1:V11)%>%  #select only V1 to V11 columns
  pivot_longer(-V1, "Variable")%>% #pivot, V1 is going to be its own column, and then all other columns aside from this one are named "Variable" and presented together in one column called variable. 
  rename("Score"="value") %>% #rename the default "value" column as "Score" 
  
  ## --- pH --- ## If you'd like, you rename the variable within the pivot_longer() function:
  ## pivot_long(-V1, "Variable", values_to = "Score")
  
  mutate(SignScore=if_else(Score<0,"-","+"))# make a variable call "SignScore" that marks all the negative values in "Variable" with "-" and positive ones with "+"
    
# 4 -----------------------------------------------------------------------
# 4. II.6 Create this dataset in R (call it “key”) and join it to df.l (from #3) so every obs in df.l 
          #that has V1 = “A” and Variable = “V2” should be assigned a NewValue = 1; every obs in 
          #df.l that has V1 = “A” and Variable = “V3” should be assigned a New Value = 2... and 
          #so on. Here is the desired, joined data. While you can do this with a LOT of chained 
          #if_else statements... do you really want to? No, no you don't.

  #We want to write code directing r to make A's in the 1-10 range, all of the B's 11-20 range, all of the C's in the 21-30 range, and all of the D's in the 31-40 range, with 1, 11, 21, and 31, prepresenting variable 2 for the respective letters, and so on. 
  key<-df%>%
  select(V1:V11)%>% #select only V1 to V11 columns
  pivot_longer(-V1, "Variable")%>% #pivot, using V1 as the key variable, and others are named as "Variable"
  rename("Score"="value") %>% #rename the default "value" column as "Score" these first 3 lines are the same used to create the table in the previous question. 
  mutate(V1_num_assign=recode(V1,"A"=(0)*10,"B"=(1)*10,"C"=(2)*10,"D"=(3)*10)) %>%# replace ABCD with the tens digit value they are supposed to be. 
  mutate(Variable_num_assign=rep(1:10,times=100,each=1))%>%#assign numbers for V2:V11, this makes 1000 rows, 100 each for each variable
  mutate(NewValue=V1_num_assign+Variable_num_assign)#make a NewValue variable by adding the tens digit of ABCD group corresponding values and V2:V11 corresponding values 

## --- pH --- ## Long walk for a short drink, but a drink nonetheless. Key does not have to be defined
## starting with df

  joined<-key%>% #create joined file to combine the df1 and the key data
  select(V1, Variable, Score, NewValue)%>% #select the columns that wanted to combined with df1. We do not need to select all of these columns, as df1 containsV1, variable, and score already, however, it doesn't seem to make redundant columns in the new dataset, so it's okay. 
  left_join(df.1)#it doesn't matter if we select left or right because we have the same amount of rows and they are all matched, however I picked left. 
  joined<-joined[,c("V1","Variable","Score", "SignScore","NewValue")]#rearrange the order of the columns

# 5 -----------------------------------------------------------------------
#***Question 5 is about a different df dataset (defined below)***:
#II.7 Study the code section below that has one line that has been redacted. What is the redacted line?
copus <- read_csv("https://raw.githubusercontent.com/jordanharshman/R22/main/data/COPUS.csv") #load copus
df<-tibble(Variables = names(copus), Type = rep(c("Demographic", "Behavior", "Cluster"), c(8,25,2))) %>%
  mutate(NewVariable = str_c(`Type`, Variables, sep = ".")) #This makes a new variable that has the type name for that row joined with the variable name for that row, separated by a period. 

# 6 -----------------------------------------------------------------------
#6.	II.8 One problem (of many) with the following plot is that the x-axis should be presented in the order of “Mostly lecture”, followed by “Transitioning”, and finally “High engagement”. 
#Modify the copus data (Bcluster is on the x-axis) so that this variable will show up correctly in the plot. 
copus <- read_csv("https://raw.githubusercontent.com/jordanharshman/R22/main/data/COPUS.csv") #load copus

copus %>% #using the copus dataset...
mutate(Bcluster=fct_relevel(Bcluster,"Mostly lecture","Transitioning","High engagement"))%>% #mutate the Bcluster column by releveling it to have the new order of Mostly lecture, Transitioning, and then High engagement...
  ggplot(aes(x=Bcluster,y=Lec))+geom_boxplot() #this plots Bcluster on the x-axis against lecture on the y-axis, with the new, desired order of the bcluster variable levels.

## --- pH --- ## Clever use to pipe into a ggplot(), but usually we will want to keep these separate.
## This is for the reason of storing things in objects; we likely want the data to live separately from the plot.
